class eucalyptus::sc ($cloud_name = "cloud1") {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
  service { 'eucalyptus-cloud':
    ensure => running,
    enable => true,
    require => Package['eucalyptus-sc'],
  } 
  @@exec { "reg_sc_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --no-scp --no-sync --register-sc --partition cluster1 --host $ipaddress --component sc_$hostname; exit 0",
    tag => "${cloud_name}",
  }
  File <<|title == "${cloud_name}-euca.p12"|>>
  Package[eucalyptus-sc] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
}
