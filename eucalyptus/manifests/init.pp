# This is the baseclass for Eucalyptus installs. This class the classes which 
# set up the yum repos for Eucalyptus and its dependencies. 
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
  include eucalyptus::repo, eucalyptus::extrarepo, eucalyptus::security
}
