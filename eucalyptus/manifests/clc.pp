class eucalyptus::clc {
  Class[eucalyptus] -> Class[eucalyptus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
  service { 'eucalyptus-clc':
    ensure => running,
    enable => true
  }
}
