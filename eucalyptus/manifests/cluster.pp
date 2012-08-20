# Resource for the CLC, so we can iterate over cluster names and call this more than once
  define eucalyptus::cluster($cluster_name) {
    # One of these for each cluster
    @@file { "${cloud_name}-${cluster_name}-nc-cert":
      path => '/var/lib/eucalyptus/keys/node-cert.pem',
      content => "$eucakeys_${cluster_name}_node_cert",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-${cluster_name}-nc-pk":
      path => '/var/lib/eucalyptus/keys/node-pk.pem',
      content => "$eucakeys_${cluster_name}_node_pk",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-${cluster_name}-cc-cert":
      path => '/var/lib/eucalyptus/keys/cluster-cert.pem',
      content => "${eucakeys}_${cluster_name}_cluster_cert",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
    @@file { "${cloud_name}-${cluster_name}-cc-pk":
      path => '/var/lib/eucalyptus/keys/cluster-pk.pem',
      content => "${eucakeys}_${cluster_name}_cluster_pk",
      owner  => 'eucalyptus',
      group  => 'eucalyptus',
      mode   => '0700',
      tag => "${cloud_name}",
    }
  }
