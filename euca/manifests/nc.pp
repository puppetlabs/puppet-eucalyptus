class euca::nc () {
  Class[euca] -> Class[euca::nc]
  package { 'eucalyptus-nc':
    ensure => present,
  }
}
