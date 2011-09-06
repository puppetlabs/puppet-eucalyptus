class eucalyptus::walrus ($network_mode) {
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  eucalyptus_config {
    'VNET_MODE': value => $network_mode;
  }
}
