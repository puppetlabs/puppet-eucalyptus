# Arbitrator support (For use in HA mode)
#
# Eucalyptus uses a periodic ICMP echo / ping test to an external IP address.
# This test approximates an end user's ability to access the system. If Eucalyptus determines 
# that it cannot reach the host associated with a registered Arbitrator, all Eucalyptus
# services operating on that host attempt to failover to the alternate hosts running those services
#
# == Parameters
#
# [*partition_name*] Unique name for the arbitrator in the cloud
# [*service_host*] Host this arbitrator/ping will run from 
# [*gateway_host*] Host to ping to check for connectivity, could be the gateway
# 
# == Examples
#
#  eucalyptus::arbitrator { 'clc_arbitrator01':
#    partition_name  => 'clc_arbitrator01',
#    service_host    => '192.168.0.50',
#    gateway_host    => '192.168.0.1',
#  }
#
# == Authors
#
# Tom Ellis <tom.ellis@eucalyptus.com\>
#
# == Copyright
#
# Copyright 2012 Eucalyptus INC under the Apache 2.0 license

define eucalyptus::arbitrator(
  $partition_name,
  $service_host,
  $gateway_host,
) {
  # Exec using euca-register-arbitrator
  exec { "arbitrator_${partition_name}":
    command => "/usr/sbin/euca-register-arbitrator -P $partition_name -H $service_host $partition_name",
    unless  => "/usr/sbin/euca-describe-arbitrators | /bin/grep -i '$partition_name' | /bin/grep -qi '$service_host'",
  }
  # Use cloud_properties to set the gateway address
  # TODO: Get this to run after exec above, since property will not exist unless above has run.
  #       Can't wrap this in a class. Works at the moment after second puppet run.
  eucalyptus::cloud_properties { "arbitrator_gateway_${partition_name}":
    property_name  => "$partition_name.arbitrator.gatewayhost",
    property_value => "$gateway_host",
  }
}
