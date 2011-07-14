class euca::sc () {
  Class[euca] -> Class[euca::sc]
  package { 'eucalyptus-cc':
    ensure => present,
  }
}
