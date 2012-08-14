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
# Note: 
#  * You must synchronize DRBD vols
#  * Format the device
#  *
# commands:
#  drbdadm -- --overwrite-data-of-peer primary r0
#  mkfs.ext3 /dev/$device
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
$host1, $host2, $ip1, $ip2, $port='7789', $disk_host1, $disk_host2, $device='/dev/drbd1', $rate='40M', $manage='true'
) {

  # Ensure drbd packages and config is ready
  include eucalyptus::drbd_config

  file { "eucalyptus_drbd_resource_${name}":
    content => template("eucalyptus/eucalyptus_drbd.drbd.conf.erb"),
    path    => '/etc/eucalyptus/drbd.conf',
    require => [ Package["drbd"], kern_module["drbd"], ],
#    notify  => [ Service["eucalyptus-cloud"], ],
  }

 if $manage == 'true' {
   # create metadata on device, except if resource seems already initalized.
   exec { "intialize DRBD metadata for $name":
     command => "/bin/echo '/sbin/drbdadm --force $device v08 $disk_host1 internal create-md' > /tmp/drbd",
    # onlyif  => "/usr/bin/test -e $disk_host1",
    # unless  => "/sbin/drbdadm dump-md $name || (/sbin/drbdadm cstate $name | egrep -q '^(Sync|Connected)')",
     require => [ kern_module["drbd"], ], 
     #eucalyptus::drbd_resource["eucalyptus_drbd_resource_${name}"], ],
   }
#   exec { "enable DRBD resource $name":
#     command => "drbdadm up $name",
#     onlyif  => "drbdadm dstate $name | egrep -q '^Diskless/|^Unconfigured'",
#     before  => Service["drbd"],
#     require => [ Exec["intialize DRBD metadata for $name"], Exec["load drbd module"], ],
#   }
 }
} 

# Bits to add:
#
# CLOUD_OPTS="-Dwalrus.storage.manager=DRBDStorageManager"
# service eucalyptus-cloud restart
#
# drbdmeta --force /dev/drbd1 v08 /dev/sdb1 internal create-md
# drbdadm attach r0
# drbdadm connect r0
#
# drbdsetup /dev/drbd1 syncer -r 110M
# drbdadm -- --overwrite-data-of-peer primary r0
# 
# drbdadm dstate r0
# mkfs.ext3 /dev/drbd1
# euca-modify-property -p walrus.blockdevice=/dev/drbd1
# euca-modify-property -p walrus.resource=r0

