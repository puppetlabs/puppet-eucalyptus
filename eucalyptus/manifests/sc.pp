class eucalyptus::sc ($network_mode) {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
  eucalyptus_config {
    'VNET_MODE': value => $network_mode;
  }
}
