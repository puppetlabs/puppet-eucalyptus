class eucalyptus::nc {
  include eucalyptus::hypervisor
  Class[eucalyptus] -> Class[eucalyptus::nc]
  package { 'eucalyptus-nc':
    ensure => present,
	before => File['node-cert'],
  }
  File <<|name = 'node-cert'||>
  File <<|name = 'node-pk'||>
  service { 'eucalyptus-nc':
    ensure => running,
    enable => true,
    require => File['node-pk'],
	subscribe => Eucalyptus_config['VNET_MODE']
  }
  Eucalyptus_config <||>
}
