class euca::cc () {
  Class['euca'] -> Class[euca::cc]
  package { 'eucalyptus-cc':
    ensure => present,
  }
}
