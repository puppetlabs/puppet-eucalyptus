# DRBD Resource to be used in conjunction with Eucalyptus Walrus HA
#
# == Parameters
# [host1] - primary walrus host
# [host2] - secondary walrus host
# [ip1] - IP address of primary walrus
# [ip2] - IP address of secondary walrus
# [disk_host1] - disk/partition to use for walrus on host1
# [disk_host2] - disk/partition to use for walrus on host2
#
# == Examples
# Define the resource in your node definition for your walrus server:
#  eucalyptus::drbd_resource { 'r0':
#    host1      => 'walrus1.example.com',
#    host2      => 'walrus2.example.com',
#    ip1        => '192.168.0.1',
#    ip2        => '192.168.0.2',
#    disk_host1 => '/dev/sda4',
#    disk_host2 => '/dev/sda4',
#  }
#
# Update properties in CLC node definition:
#  eucalyptus::cloud_properties { 'walrus blockdevice':
#    property_name  => 'walrus.blockdevice',
#    property_value => '/dev/drbd1',
#  }
#  eucalyptus::cloud_properties { 'walrus resource':
#    property_name  => 'walrus.resource',
#    property_value => 'r0'
#  }
#
# == Notes
# You must still run the following manually:
#  * Synchronize DRBD volumes
#  * Increase sync speed whilst doing initial sync
#  * Format the device
#
# Use these commands on the primary walrus:
#  drbdsetup /dev/drbd1 syncer -r 110M
#  drbdadm -- --overwrite-data-of-peer primary r0
#  mkfs.ext4 /dev/$device
#
# You can avoid doing a full sync in dev/test by running:
#  drbdadm -- --clear-bitmap new-current-uuid r0
#  drbdadm primary r0
#  mkfs.ext4 /dev/$device
#
# == Authors
# Tom Ellis <tom.ellis@eucalyptus.com\>
# Inspired by: https://github.com/camptocamp/puppet-drbd/

define eucalyptus::drbd_resource(
$host1, $host2, $ip1, $ip2, $port='7789', $disk_host1, $disk_host2, $device='/dev/drbd1', $rate='40M', $manage='true'
) {

  # Ensure drbd packages and config is ready
  include eucalyptus::drbd_config

  file { "eucalyptus_drbd_resource_${name}":
    content => template("eucalyptus/eucalyptus_drbd.drbd.conf.erb"),
    path    => '/etc/eucalyptus/drbd.conf',
    require => [ Package["drbd"], kern_module["drbd"], ],
  }

 if $manage == 'true' {
   # Determine which host we are running on and in turn which $disk_host parameter to use
   case $fqdn {
     $host1: { $disk = $disk_host1 }
     $host2: { $disk = $disk_host2 }
     default: { fail("Unrecognized host, make sure the fqdn matches the host defined in the drbd resource") }
   }
   # create metadata on device, except if resource seems already initalized.
   exec { "intialize DRBD metadata for $name":
     command => "/sbin/drbdmeta --force $device v08 $disk internal create-md",
     onlyif  => "/usr/bin/test -e $disk",
     # Don't try to init if syncing, connecting or if split-brain
     unless  => "/sbin/drbdadm cstate $name | /bin/egrep -q '^(Sync|Connected|WFConnection)'",
     require => [ kern_module["drbd"], File["eucalyptus_drbd_resource_${name}"], ],
     #eucalyptus::drbd_resource["eucalyptus_drbd_resource_${name}"], ],
   }
   exec { "enable DRBD resource $name":
     # bring device up (a shortcut for attach & connect)
     command => "/sbin/drbdadm up $name",
     onlyif  => "/sbin/drbdadm dstate $name | /bin/egrep -q '^Diskless/|^Unconfigured'",
     require => [ Exec["intialize DRBD metadata for $name"], kern_module["drbd"], ],
   }

 }
}
