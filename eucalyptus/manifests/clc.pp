class eucalyptus::clc ($cloud_name = "cloud1") {
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
  @@file { "${cloud_name}-cluster1-nc-cert":
    path => '/var/lib/eucalyptus/keys/node-cert.pem',
    content => "$eucakeys_cluster1_node_cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster1-nc-pk":
    path => '/var/lib/eucalyptus/keys/node-pk.pem',
    content => "$eucakeys_cluster1_node_pk",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster1-cc-cert":
    path => '/var/lib/eucalyptus/keys/cluster-cert.pem',
    content => "$eucakeys_cluster1_cluster_cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cluster1-cc-pk":
    path => '/var/lib/eucalyptus/keys/cluster-pk.pem',
    content => "$eucakeys_cluster1_cluster_pk",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cloud-cert":
    path => '/var/lib/eucalyptus/keys/cloud-cert.pem',
    content => "$eucakeys_cloud_cert",
    tag => "${cloud_name}",
  }
  @@file { "${cloud_name}-cloud-pk":
    path => '/var/lib/eucalyptus/keys/cloud-pk.pem',
    content => "$eucakeys_cloud_pk",
    tag => "${cloud_name}",
  }
  Package[eucalyptus-cloud] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
  Eucalyptus_config <||>
  Exec <<|tag == "$cloud_name"|>>
}
