class eucalyptus::ntp {
  package { 'ntp': ensure => present }

  file { '/etc/ntp.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/ntp.conf',
    require => Package['ntp'],
  }

#  exec { "stopntp":
#    command => "/etc/init.d/ntpd stop"
#  }

#  exec { "ntpdate":
#    command => "/usr/sbin/ntpdate pool.ntp.org",
#    require => [ File['/etc/ntp.conf'], Exec['stopntp'] ],
#  }

  service { 'ntpd':
    ensure => running,
    enable => true,
#    require => [ Package['ntp'], Exec['ntpdate'] ],
  }

}
