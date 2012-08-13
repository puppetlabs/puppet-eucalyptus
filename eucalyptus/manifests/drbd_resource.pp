# DRBD Configuration, to be used in conjunction with Walrus HA
# 
# == Parameters
# 
# == Examples
#
#  eucalyptus::drbd_resource { 'r0':
#    host1      => 'walrus1.example.com',
#    host2      => 'walrus2.example.com',
#    ip1        => '192.168.0.1',
#    ip2        => '192.168.0.2',
#    disk_host1 => '/dev/sda4',
#    disk_host2 => '/dev/sda4',
#  }
#
# == Authors
#
# Tom Ellis <tom.ellis@eucalyptus.com\>
# Inspired by: https://github.com/camptocamp/puppet-drbd/
#
# == Copyright
#
# Copyright 2012 Eucalyptus INC under the Apache 2.0 license

define eucalyptus::drbd_resource(
$host1, $host2, $ip1, $ip2, $port='7789', $disk_host1, $disk_host2, $device='/dev/drbd1', $rate='40M'
) {

  file { "eucalyptus_drbd_resource-${name}":
    content => template("eucalyptus/eucalyptus_drbd.drbd.conf.erb"),
    path => '/etc/eucalyptus/drbd.conf',
  }

}


#  if $manage == 'true' {
#
#    # create metadata on device, except if resource seems already initalized.
#    exec { "intialize DRBD metadata for $name":
#      command => "drbdadm create-md $name",
#      onlyif  => "test -e $disk",
#      unless  => "drbdadm dump-md $name || (drbdadm cstate $name | egrep -q '^(Sync|Connected)')",
#      before  => Service["drbd"],
#      require => [
#        Exec["load drbd module"],
#        Drbd::Config["ZZZ-resource-${name}"],
#      ],
#    }
#
#    exec { "enable DRBD resource $name":
#      command => "drbdadm up $name",
#      onlyif  => "drbdadm dstate $name | egrep -q '^Diskless/|^Unconfigured'",
#      before  => Service["drbd"],
#      require => [
#        Exec["intialize DRBD metadata for $name"],
#        Exec["load drbd module"],
#      ],
#    }
#
#  }
