class eucalyptus::walrus {
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  @@exec { "reg-walrus":
    command => "/usr/sbin/euca_conf --no-rsync --register-walrus $ipaddress; exit 0",
    unless => "/usr/sbin/euca_conf --list-walruses | tail -n+2",
    tag => "${cloud_name}",
  }
}
