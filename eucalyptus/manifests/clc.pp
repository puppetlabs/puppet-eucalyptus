class eucalyptus::clc {
  Class[eucalyptus] -> Class[eucalyptus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => Package['eucalyptus-cloud']
  }
}
