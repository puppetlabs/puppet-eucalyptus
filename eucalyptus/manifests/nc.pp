class eucalyptus::nc ($cloud_name = "cloud1", $cluster_name = "cluster1") {
  include eucalyptus
  include eucalyptus::conf
  Class[eucalyptus] -> Class[eucalyptus::nc]
  Class[eucalyptus::repo] -> Package[eucalyptus-nc] -> Class[eucalyptus::nc_config] -> Eucalyptus_config<||> -> Service[eucalyptus-nc]

  class eucalyptus::nc_install {
    package { 'eucalyptus-nc':
      ensure => present,
    }
    service { 'eucalyptus-nc':
      ensure => running,
      enable => true,
    }
  }

  class eucalyptus::nc_config inherits eucalyptus::nc {
    File <<|title == "${cloud_name}_${cluster_name}_cluster_cert"|>>
    File <<|title == "${cloud_name}_${cluster_name}_node_cert"|>>
    File <<|title == "${cloud_name}_${cluster_name}_node_pk"|>>
    File <<|title == "${cloud_name}_cloud_cert"|>>
  }

  class eucalyptus::nc_reg inherits eucalyptus::nc {
    #Eucalyptus_config <||> { notify => Service["eucalyptus-nc"] }
    # Causes too many service refreshes
    Eucalyptus_config <||>
    @@exec { "${cluster_name}_reg_nc_${hostname}":
      command => "/usr/sbin/euca_conf --no-rsync --no-sync --no-scp --register-nodes $ipaddress",
      unless  => "/bin/grep -i '\b$ipaddress\b' /etc/eucalyptus/eucalyptus.conf",
      tag     => "${cloud_name}_${cluster_name}_reg_nc",
    }
  }

  include eucalyptus::nc_install, eucalyptus::nc_config, eucalyptus::nc_reg
}
