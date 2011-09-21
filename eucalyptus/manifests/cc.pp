class eucalyptus::cc {
  Class['eucalyptus'] -> Class[eucalyptus::cc]
  package { 'eucalyptus-cc':
    ensure => present,
	before => File['cc-cert'],
	before => File['nc-cert'],
  }
  File <<|name = 'cc-cert'||>
  File <<|name = 'nc-cert'||>
  service { 'eucalyptus-cc':
    ensure => running,
    enable => true,
    require => File['cc-cert'],
    require => File['nc-cert'],
	subscribe => Eucalyptus_config['VNET_MODE']
  }
  Eucalyptus_config <||>
}
