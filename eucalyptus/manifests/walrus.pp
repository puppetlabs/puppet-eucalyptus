class eucalyptus::walrus ($cloud_name = "cloud1") {
  include eucalyptus
  Class[eucalyptus] -> Class[eucalyptus::walrus]
  package { 'eucalyptus-walrus':
    ensure => present,
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => Package['eucalyptus-walrus'],
  } 
  @@exec { "reg_walrus_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --no-scp --no-sync --register-walrus --partition walrus --host $ipaddress --component walrus_$hostname",
    unless => "/usr/sbin/euca_conf --list-walruses | /bin/grep '\b$ipaddress\b'",
    tag => "${cloud_name}",
  }
  File <<|title == "${cloud_name}_euca.p12"|>>
  Package[eucalyptus-walrus] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
}
