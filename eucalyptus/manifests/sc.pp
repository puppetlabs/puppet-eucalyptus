class eucalyptus::sc {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
  service { 'eucalyptus-sc':
    ensure => running,
    enable => true
  }
}
