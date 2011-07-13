
class euca-sc {
  package { 'eucalyptus-cc':
    ensure => present,
    require => Package['euca-deps'],
  }
}
