class eucalyptus::cc ($cloud_name = "cloud1") {

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
  @@exec { "reg_cc_${hostname}":
    command => "/usr/sbin/euca_conf --no-rsync --register-cluster cluster1 $ipaddress; exit 0",
    tag => "${cloud_name}",
  }
  File <<|title == "${cloud_name}-cloud-cert"|>>
  File <<|title == "${cloud_name}-cloud-pk"|>>
  File <<|title == "${cloud_name}-cluster1-cc-cert"|>>
  File <<|title == "${cloud_name}-cluster1-cc-pk"|>>
  File <<|title == "${cloud_name}-cluster1-nc-cert"|>>
}
