# This is the baseclass for Eucalyptus installs. This class sets up the yum repos
# for Eucalyptus and dependencies. 
#
# == Parameters
#
# [*version*] The version of Eucalyptus we are installing. Defaults to 3.1.
# [*repourl*] The uri for the package repo that is being used for this install. This is user configurable. 
# [*servers*]
#   Description of servers class parameter.  e.g. "Specify one or more
#   upstream ntp servers as an array."
#
# == Examples
#
# class { eucalyptus: version => '3.1' }  
#
#
# == Authors
#
# Teyo Tyree <teyo@puppetlabs.com\>
# David Kavanagh <david.kavanagh@eucalyptus.com\>
# Tom Ellis <tom.ellis@eucalyptus.com\>
#
# == Copyright
#
# Copyright 2012 Eucalyptus INC under the Apache 2.0 license
#

class eucalyptus (
  $version = '3.1'
)
{
  include eucalyptus::ntp
  include eucalyptus::security

  file {'/etc/eucalyptus':
    ensure => directory,
  }

  # ELRepo: Required for DRBD packages
  exec { "elrepo.file":
    command => "/bin/rpm -Uvh http://elrepo.org/elrepo-release-6-4.el6.elrepo.noarch.rpm",
    creates => "/etc/yum.repos.d/elrepo.repo"
  }

  # EPEL: Additional dependencies
  # You may need to update this as the epel-release package version changes, see:
  # http://download.fedoraproject.org/pub/epel/6/i386/repoview/epel-release.html
  exec { "epel.file":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo"
  }

  # PGRPMS: Postgres 9.1 - required for Eucalyptus < 3.1 
  exec { "pgrpms.file":
    command => "/bin/rpm -Uvh http://yum.pgrpms.org/9.1/redhat/rhel-6-i386/pgdg-centos91-9.1-4.noarch.rpm",
    creates => "/etc/yum.repos.d/pgdg-91-centos.repo",
  } 

  exec { "eucalyptus-devel.file":
    command => "/bin/rpm -Uvh http://downloads.eucalyptus.com/devel/packages/3-devel/nightly/centos/6/x86_64/eucalyptus-nightly-release-3-1.el.noarch.rpm",
    creates => "/etc/yum.repos.d/eucalyptus-nightly-release.repo",
  }

}

