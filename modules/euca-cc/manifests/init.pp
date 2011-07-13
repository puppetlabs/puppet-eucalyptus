
class euca-cc {
  package { 'eucalyptus-cc':
    ensure => present,
    require => Package['euca-deps'],
  }
}
