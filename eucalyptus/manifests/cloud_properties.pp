# These configuration options can be passed to the Eucalyptus CLC and be applied
# without restarting sevices.
#
# See 'euca-describe-properties' for all the options you can set.
#
# == Parameters
#
# [*property_name*] The name of the property to modify
# [*property_value*] The value to set the property to
# 
# == Examples
#
#  eucalyptus::cloud_properties { 'increasevolsize':
#    property_name  => 'cluster1.storage.maxvolumesizeingb',
#    property_value => '15',
#  }
#
# == Authors
#
# Tom Ellis <tom.ellis@eucalyptus.com\>
#
# == Copyright
#
# Copyright 2012 Eucalyptus INC under the Apache 2.0 license

define eucalyptus::cloud_properties(
  $property_name,
  $property_value
) {
  # Exec using euca-modify-property
  exec { "cloud_property_${property_name}":
    command   => "/usr/sbin/euca-modify-property -p $property_name=$property_value",
    unless    => "/usr/sbin/euca-describe-properties | /bin/grep -i '$property_name' | /bin/grep -qi '$property_value'",
    tries     => "3",
    try_sleep => "2",
  }
}
