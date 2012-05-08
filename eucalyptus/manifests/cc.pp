class eucalyptus::cc {

  Class['eucalyptus'] -> Class[eucalyptus::cc]

  include eucalyptus::conf

  package { 'eucalyptus-cc':
    ensure => present,
  }
  service { 'eucalyptus-cc':
    ensure => running,
    enable => true,
  }
  Package[eucalyptus-cc] -> Eucalyptus_config<||> -> Service[eucalyptus-cc]
  Eucalyptus_config <||>
  @@exec { 'reg-cc':
## Hack warning! this ensures cc registered before sc, then exit code forced to 0 to make exec code happy
    command => "/usr/sbin/euca_conf --no-rsync --register-cluster cluster00 $ec2_public_hostname; /usr/sbin/euca_conf --no-rsync --register-sc cluster00 $ec2_public_hostname; exit 0",
    tag => "${cloud_name}",
  }
  File <<|title == "${cloud_name}-cloud-cert"|>>
  File <<|title == "${cloud_name}-cloud-pk"|>>
  File <<|title == "${cloud_name}-cluster00-cc-cert"|>>
  File <<|title == "${cloud_name}-cluster00-cc-pk"|>>
  File <<|title == "${cloud_name}-cluster00-nc-cert"|>>
}
