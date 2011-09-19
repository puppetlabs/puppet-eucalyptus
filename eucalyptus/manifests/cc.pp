class eucalyptus::cc {
  Class['eucalyptus'] -> Class[eucalyptus::cc]
  package { 'eucalyptus-cc':
    ensure => present,
  }
  service { 'eucalyptus-cc':
    ensure => running,
    enable => true
  }
}
