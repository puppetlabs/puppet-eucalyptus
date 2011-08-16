class eucalyptus::ntp {

  #
  # This class will be replaced by the official Puppet Labs NTP module
  #

  package { 'ntp': ensure => present }

  # ntpdate pool.ntp.org

  file { '/etc/ntp.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/ntp.conf',
    require => Package['ntp'],
  }

}
