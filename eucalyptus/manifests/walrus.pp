class eucalyptus::walrus {
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  service { 'eucalyptus-walrus':
    ensure => running,
    enable => true
  }
}
