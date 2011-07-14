class eucalyptus::clc () {
  Class[eucalyptus] -> Class[eucalytus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
}
