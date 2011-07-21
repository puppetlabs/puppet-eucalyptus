class eucalyptus::sc () {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
}
