# Resource for the CLC, so we can iterate over cluster names and call this more than once
#  
#  - interpolating $cluster_name into $eucakeys_$cluster_name_node_cert (etc) with inline_templates
  define eucalyptus::cluster($cloud_name,$cluster_name) {
    # One of these for each cluster
    $node_cert = "eucakeys_${cluster_name}_node_cert"
    @@file { "${cloud_name}_${cluster_name}_node_cert":
      path    => '/var/lib/eucalyptus/keys/node-cert.pem',
      content => inline_template("<%= scope.lookupvar(node_cert) %>"),
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}",
    }
    $nc_pk = "eucakeys_${cluster_name}_node_pk"
    @@file { "${cloud_name}_${cluster_name}_node_pk":
      path    => '/var/lib/eucalyptus/keys/node-pk.pem',
      content => inline_template("<%= scope.lookupvar(nc_pk) %>"),
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}",
    }
    $cc_cert = "eucakeys_${cluster_name}_cluster_cert"
    @@file { "${cloud_name}_${cluster_name}_cluster_cert":
      path    => '/var/lib/eucalyptus/keys/cluster-cert.pem',
      content => inline_template("<%= scope.lookupvar(cc_cert) %>"),
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}",
    }
    $cc_pk = "eucakeys_${cluster_name}_cluster_pk"
    @@file { "${cloud_name}_${cluster_name}_cluster_pk":
      path    => '/var/lib/eucalyptus/keys/cluster-pk.pem',
      content => inline_template("<%= scope.lookupvar(cc_pk) %>"),
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}",
    }
    $cc_vtunpass = "eucakeys_${cluster_name}_vtunpass"
    @@file { "${cloud_name}_${cluster_name}_vtunpass":
      path    => '/var/lib/eucalyptus/keys/vtunpass',
      content => inline_template("<%= scope.lookupvar(cc_vtunpass) %>"),
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}",
    }
  }
