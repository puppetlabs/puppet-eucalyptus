class eucalyptus::ntp {
  # yum install –y ntp
  package { 'ntp': ensure => present }

  # ntpdate pool.ntp.org
  file { '/etc/ntp.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/ntp.conf',
    require => Package['ntp'],
  }
  exec { "/sbin/ntpdate pool.ntp.org":
    require => File['/etc/ntp.conf'],
  }
}
