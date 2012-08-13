class eucalyptus::clc ($cloud_name = "cloud1") {
  include eucalyptus::conf

  Class[eucalyptus] -> Class[eucalyptus::clc]

  class eucalyptus::clc_install {
    package { 'eucalyptus-cloud':
      ensure => present,
    }
    service { 'eucalyptus-cloud':
      ensure => running,
      enable => true,
      require => Package['eucalyptus-cloud'],
    }
  }
  class eucalyptus::clc_config {
    Class[eucalyptus::clc_install] -> Class[eucalyptus::clc_config]
    exec { 'init-db':
      command => "/usr/sbin/euca_conf --initialize",
      creates => "/var/lib/eucalyptus/db/data",
      timeout => "0",
    }
    @@file { "${cloud_name}-cluster1-nc-cert":
      path => '/var/lib/eucalyptus/keys/node-cert.pem',
      content => "$eucakeys_cluster1_node_cert",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0644',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-cluster1-nc-pk":
      path => '/var/lib/eucalyptus/keys/node-pk.pem',
      content => "$eucakeys_cluster1_node_pk",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0644',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-cluster1-cc-cert":
      path => '/var/lib/eucalyptus/keys/cluster-cert.pem',
      content => "$eucakeys_cluster1_cluster_cert",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0644',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-cluster1-cc-pk":
      path => '/var/lib/eucalyptus/keys/cluster-pk.pem',
      content => "$eucakeys_cluster1_cluster_pk",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0644',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-cloud-cert":
      path => '/var/lib/eucalyptus/keys/cloud-cert.pem',
      content => "$eucakeys_cloud_cert",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-cloud-pk":
      path => '/var/lib/eucalyptus/keys/cloud-pk.pem',
      content => "$eucakeys_cloud_pk",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-euca.p12":
      path => '/var/lib/eucalyptus/keys/euca.p12',
      content => "$eucakeys_euca_p12",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    Package[eucalyptus-cloud] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
    Eucalyptus_config <||>
  }
  class eucalyptus::clc_reg {
    Class[eucalyptus::clc_reg] -> Class[eucalyptus::clc_config]
    Exec <<|tag == "$cloud_name"|>>
  }

  include eucalyptus::clc_install, eucalyptus::clc_config, eucalyptus::clc_reg
}
