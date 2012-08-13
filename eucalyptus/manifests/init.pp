# This is the baseclass for Eucalyptus installs. This class sets up the yum repos
# for Eucalyptus and dependencies. 
#
# == Parameters
#
# [*version*] The version of Eucalyptus we are installing. Defaults to 3.1.
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
class eucalyptus 
{
  include eucalyptus::repo, eucalyptus::extrarepo
  include eucalyptus::security
}

