class eucalyptus::sc ($cloud_name = "cloud1") {
  
  Class[eucalyptus] -> Class[eucalyptus::sc]

  class eucalyptus::sc_install {
    package { 'eucalyptus-sc':
      ensure => present,
    }
    service { 'eucalyptus-cloud':
      ensure => running,
      enable => true,
      require => Package['eucalyptus-sc'],
    } 
  }

  class eucalyptus::sc_config {
    Package[eucalyptus-sc] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]
    File <<|title == "${cloud_name}-euca.p12"|>>
  }

  class eucalyptus::sc_reg {
    Class[eucalyptus::sc_reg] -> Class[eucalyptus::sc_config]
    @@exec { "reg_sc_${hostname}":
      command => "/usr/sbin/euca_conf --no-rsync --no-scp --no-sync --register-sc --partition cluster1 --host $ipaddress --component sc_$hostname",
      unless => "/usr/sbin/euca_conf --list-scs | /bin/grep '\b$ipaddress\b'",
      tag => "${cloud_name}",
    }
  }

  include eucalyptus::sc_install, eucalyptus::sc_config, eucalyptus::sc_reg
}
