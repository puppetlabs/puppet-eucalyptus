class eucalyptus::clc {
  include eucalyptus::conf

  Class[eucalyptus] -> Class[eucalyptus::clc]

  package { 'eucalyptus-cloud':
    ensure => present,
  }
  exec { 'init-db':
    command => "/usr/sbin/euca_conf --initialize",
    creates => "/var/lib/eucalyptus/db/data"
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => [ Package['eucalyptus-cloud'], Exec['init-db'] ],
  }
  @@file { "${cloud_name}-cluster00-nc-cert":
    path => '/var/lib/eucalyptus/keys/node-cert.pem',
    content => "$eucakeys_cluster00_node-cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster00-nc-pk":
    path => '/var/lib/eucalyptus/keys/node-pk.pem',
    content => "$eucakeys_cluster00_node-pk",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster00-cc-cert":
    path => '/var/lib/eucalyptus/keys/cluster-cert.pem',
    content => "$eucakeys_cluster00_cluster-cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster00-cc-pk":
    path => '/var/lib/eucalyptus/keys/cluster-pk.pem',
    content => "$eucakeys_cluster00_cluster-pk",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cloud-cert":
    path => '/var/lib/eucalyptus/keys/cloud-cert.pem',
    content => "$eucakeys_cloud-cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cloud-pk":
    path => '/var/lib/eucalyptus/keys/cloud-pk.pem',
    content => "$eucakeys_cloud-pk",
    tag => "${cloud_name}",
  }
  Package[eucalyptus-cloud] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
  Eucalyptus_config <||>
  Exec <<|tag == "$cloud_name"|>>
}
