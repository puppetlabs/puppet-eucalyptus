
class euca-walrus {
  package { 'eucalyptus-walrus':
    ensure => present,
    require => Package['euca-deps'],
  }
}
