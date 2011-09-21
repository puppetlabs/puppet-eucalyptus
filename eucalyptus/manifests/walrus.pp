class eucalyptus::walrus {
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  @@exec { 'reg-walrus':
    command => "/usr/sbin/euca_conf --no-rsync --register-walrus $ec2_pub_dns",
    unless => "/usr/sbin/euca_conf --list-walruses | tail -n+2",
  }
}
