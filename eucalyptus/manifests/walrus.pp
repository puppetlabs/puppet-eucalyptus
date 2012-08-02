class eucalyptus::walrus ($cloud_name = "cloud1") {
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  @@exec { "reg_walrus_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --register-walrus --partition walrus --host $ipaddress --component $hostname; exit 0",
    unless => "/usr/sbin/euca_conf --list-walruses | tail -n+2",
    tag => "${cloud_name}",
  }
}
