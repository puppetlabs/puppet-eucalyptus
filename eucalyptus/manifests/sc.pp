class eucalyptus::sc ($cloud_name = "cloud1") {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
  @@exec { "reg_sc_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --register-sc cluster1 $ipaddress",
  }
}
