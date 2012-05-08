class eucalyptus::nc {
  Class[eucalyptus] -> Class[eucalyptus::nc]

  include eucalyptus::conf

  package { 'eucalyptus-nc':
    ensure => present,
  }
  service { 'eucalyptus-nc':
    ensure => running,
    enable => true,
  }
  Package[eucalyptus-nc] -> Eucalyptus_config<||> -> Service[eucalyptus-nc]
  Eucalyptus_config <||>
  @@exec { 'reg-nc':
    command => "/usr/sbin/euca_conf --no-rsync --register-nodes $ec2_public_hostname; exit 0",
    tag => "${cloud_name}",
  }
  File <<|title == "${cloud_name}-cluster00-cc-cert"|>>
  File <<|title == "${cloud_name}-cluster00-nc-cert"|>>
  File <<|title == "${cloud_name}-cluster00-nc-pk"|>>
  File <<|title == "${cloud_name}-cloud-cert"|>>
}
