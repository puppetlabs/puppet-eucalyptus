class eucalyptus::cc () {
  Class['eucalyptus'] -> Class[eucalptus::cc]
  package { 'eucalyptus-cc':
    ensure => present,
  }
}
