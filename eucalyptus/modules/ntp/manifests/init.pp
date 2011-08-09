class eucalyptus::ntp {
  # yum install –y ntp
  package { 'ntp': ensure => present }

  # ntpdate pool.ntp.org
  file { '/etc/ntp.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/ntp/ntp.conf',
    require => Package['ntp'],
  }
}
