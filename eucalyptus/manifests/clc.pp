class eucalyptus::clc () {
  Class[eucalyptus] -> Class[eucalyptus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
}
