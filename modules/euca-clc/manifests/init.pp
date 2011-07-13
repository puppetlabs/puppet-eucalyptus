
class euca-clc {
  package { 'eucalyptus-cloud':
    ensure => present,
    require => Package['euca-deps'],
  }
}
