class eucalyptus::nc ($cloud_name = "cloud1", $cluster_name = "cluster1") {
  Class[eucalyptus] -> Class[eucalyptus::nc]

  include eucalyptus::conf

  package { 'eucalyptus-nc':
    ensure => present,
  }
  service { 'eucalyptus-nc':
    ensure => running,
    enable => true,
  }
  Package[eucalyptus-nc] -> Eucalyptus_config<||> -> Service[eucalyptus-nc]
  #Eucalyptus_config <||> { notify => Service["eucalyptus-nc"] }
   # Causes too many service refreshes
  Eucalyptus_config <||>
  @@exec { "${cluster_name}_reg_nc_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --no-sync --no-scp --register-nodes $ipaddress",
    unless  => "/bin/grep -i '\b$ipaddress\b' /etc/eucalyptus/eucalyptus.conf",
    tag     => "${cloud_name}_${cluster_name}_reg_nc",
  }
  File <<|title == "${cloud_name}_${cluster_name}_cluster_cert"|>>
  File <<|title == "${cloud_name}_${cluster_name}_node_cert"|>>
  File <<|title == "${cloud_name}_${cluster_name}_node_pk"|>>
  File <<|title == "${cloud_name}_cloud_cert"|>>
}
