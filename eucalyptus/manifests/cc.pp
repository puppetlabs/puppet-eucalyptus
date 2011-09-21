class eucalyptus::cc {
  Class['eucalyptus'] -> Class[eucalyptus::cc]
  package { 'eucalyptus-cc':
    ensure => present,
	before => File['cc-cert'],
  }
  File <<|name = 'cc-cert'||>
  service { 'eucalyptus-cc':
    ensure => running,
    enable => true,
    require => File['cc-cert'],
  }
}
