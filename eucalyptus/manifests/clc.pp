class eucalyptus::clc {
  include eucalyptus::conf

  Class[eucalyptus] -> Class[eucalyptus::clc]

  package { 'eucalyptus-cloud':
    ensure => present,
    notify => Eucalyptus_config['VNET_MODE'],
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => Package['eucalyptus-cloud'],
    subscribe => Eucalyptus_config['VNET_MODE'],
  }
  @@file { 'cluster00-nc-cert':
    path => '/var/lib/eucalyptus/keys/node-cert.pem',
    content => "$eucakeys_cluster00_node-cert",
  }
  @@file { 'cluster00-nc-pk':
    path => '/var/lib/eucalyptus/keys/node-pk.pem',
    content => "$eucakeys_cluster00_node-pk",
  }
  @@file { 'cluster00-cc-cert':
    path => '/var/lib/eucalyptus/keys/cluster-cert.pem',
    content => "$eucakeys_cluster00_cluster-cert",
  }
  @@file { 'cluster00-cc-pk':
    path => '/var/lib/eucalyptus/keys/cluster-pk.pem',
    content => "$eucakeys_cluster00_cluster-pk",
  }
  @@file { 'cloud-cert':
    path => '/var/lib/eucalyptus/keys/cloud-cert.pem',
    content => "$eucakeys_cloud-cert",
  }
  @@file { 'cloud-pk':
    path => '/var/lib/eucalyptus/keys/cloud-pk.pem',
    content => "$eucakeys_cloud-pk",
  }
  Eucalyptus_config <||>
  Exec <<||>>
}
