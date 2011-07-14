class euca::walrus () {
  Class[euca] -> Class[euca::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
}
