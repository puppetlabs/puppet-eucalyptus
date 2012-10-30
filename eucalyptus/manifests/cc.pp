class eucalyptus::cc ($cloud_name = "cloud1", $cluster_name = "cluster1") {
  include eucalyptus
  include eucalyptus::conf
  Class[eucalyptus] -> Class[eucalyptus::cc]
  Class[eucalyptus::repo] -> Package[eucalyptus-cc] -> Class[eucalyptus::cc_config] -> Eucalyptus_config<||> -> Service[eucalyptus-cc]

  class eucalyptus::cc_install {
    package { 'eucalyptus-cc':
      ensure => present,
    }
    service { 'eucalyptus-cc':
      ensure => running,
      enable => true,
    }
  }

  class eucalyptus::cc_config inherits eucalyptus::cc {
    File <<|title == "${cloud_name}_cloud_cert"|>>
    File <<|title == "${cloud_name}_cloud_pk"|>>
    File <<|title == "${cloud_name}_${cluster_name}_cluster_cert"|>>
    File <<|title == "${cloud_name}_${cluster_name}_cluster_pk"|>>
    File <<|title == "${cloud_name}_${cluster_name}_node_cert"|>>
    File <<|title == "${cloud_name}_${cluster_name}_node_pk"|>>
  }

  class eucalyptus::cc_reg inherits eucalyptus::cc {
    Class[eucalyptus::cc_reg] -> Class[eucalyptus::cc_config]
    @@exec { "reg_cc_${hostname}":
      command => "/usr/sbin/euca_conf --no-rsync --no-scp --no-sync --register-cluster --partition $cluster_name --host $ipaddress --component cc_$hostname",
      unless  => "/usr/sbin/euca_conf --list-clusters | /bin/grep -q '\b$ipaddress\b'",
      tag => "${cloud_name}",
    }
    # Register NC's from CC
    Exec <<|tag == "${cloud_name}_${cluster_name}_reg_nc"|>>
  }

  include eucalyptus::cc_install, eucalyptus::cc_config, eucalyptus::cc_reg
}
