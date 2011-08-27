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
  $network_mode,
  $priv_subnet,
  $priv_netmask,
  $dns_server,
  $addrs_per_net,
  $public_ip_range,
  $version = '2.0.3'
)
{
  include eucalyptus::ntp
  include eucalyptus::selinux

  $repourl = inline_template("http://www.eucalyptussoftware.com/downloads/repo/eucalyptus/<%= version %>/yum/<%= operatingsystem.downcase %>/${architecture}")
  yumrepo { 'eucalyptus':
    descr => 'Eucalyptus Software',
    enabled => 1,
    gpgcheck => 0,
    baseurl => $repourl,
  }
  case $version {
    '2.0': {
      $packages = [ 'java-1.6.0-openjdk',
                    'ant',
                    'ant-nodeps',
                    'dhcp',
                    'bridge-utils',
                    'scsi-target-utils',
                    'httpd',
					'sudo'] 
    }
    default: {
      $packages = 'UNSET'
    }
  }
  if $packages != 'UNSET' { 
    package { $packages: ensure => present }   
  }
  file {'/etc/eucalyptus':
    ensure => directory,
  }
  Eucalyptus_config { require => File['/etc/eucalyptus'] }
  eucalyptus_config {
    'VNET_MODE': value => $network_mode;
    'VNET_SUBNET': value => $priv_subnet;
    'VNET_NETMASK': value => $priv_netmask;
    'VNET_DNS': value => $dns_server;
    'VNET_ADDRSPERNET': value => $addrs_per_net;
    'VNET_PUBLICIPS': value => $public_ip_range;
  }
}
