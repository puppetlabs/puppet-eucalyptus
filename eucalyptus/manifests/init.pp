# This is the baseclass for Eucalpytus installs. This class sets up the yumrepo 
# and for Eucalyptus version 2.0 installs dependencies. 
#
# == Parameters
#
# [*version*] The version of Eucalpytus we are installing. Defaults to 2.0.
# [*reporul*] The uri for the package repo that is being used for this install. This is user configurable. 
#
# [*servers*]
#   Description of servers class parameter.  e.g. "Specify one or more
#   upstream ntp servers as an array."
#
# == Examples
#
# class { eucalyptus: version => '3.0' }  
#
#
# == Authors
#
# Teyo Tyree <teyo@puppetlabs.com\>
# David Kavanagh <david.kavanagh@eucalyptus.com\>
#
# == Copyright
#
# Copyright 2011 Eucalyptus INC under the Apache 2.0 license
#

class eucalyptus (
  $version = '3-devel'
)
{
  include eucalyptus::ntp
  include eucalyptus::security

  file {'/etc/eucalyptus':
    ensure => directory,
  }
  exec { "elrepo.file":
    command => "/bin/rpm -Uvh http://elrepo.org/elrepo-release-6-4.el6.elrepo.noarch.rpm",
    creates => "/etc/yum.repos.d/elrepo.repo"
  }
  exec { "epel.file":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-5.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo"
  }
  file {'/etc/yum.repos.d/epel-testing.repo':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/epel-testing.repo',
  }
  file {'/etc/yum.repos.d/euca.repo':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/euca.repo',
  }
}

