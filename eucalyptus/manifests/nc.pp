class eucalyptus::nc () {
  Class[eucalyptus] -> Class[eucalyptus::nc]
  package { 'eucalyptus-nc':
    ensure => present,
  }
}
