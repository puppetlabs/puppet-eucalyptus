class eucalyptus::sc () {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-cc':
    ensure => present,
  }
}
