class eucalyptus::nc ($network_mode) {
  include eucalyptus::hypervisor
  Class[eucalyptus] -> Class[eucalyptus::nc]
  package { 'eucalyptus-nc':
    ensure => present,
  }
  eucalyptus_config {
    'VNET_MODE': value => $network_mode;
  }
}
