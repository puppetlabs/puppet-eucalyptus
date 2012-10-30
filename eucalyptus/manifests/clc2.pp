class eucalyptus::clc2 ($cloud_name = "cloud1") {
  include eucalyptus
  include eucalyptus::conf
  Class[eucalyptus] -> Class[eucalyptus::clc2]
  Class[eucalyptus::repo] -> Package[eucalyptus-cloud] -> Class[eucalyptus::clc2_config] -> Eucalyptus_config<||> -> Service[eucalyptus-cloud]

  class eucalyptus::clc2_install {
    package { 'eucalyptus-cloud':
      ensure => present,
    }
    service { 'eucalyptus-cloud':
      ensure => running,
      enable => true,
      require => Package['eucalyptus-cloud'],
    }
  }
  class eucalyptus::clc2_config inherits eucalyptus::clc2 {
    File <<|tag == "${cloud_name}_cloud_cert"|>>
    File <<|tag == "${cloud_name}_cloud_pk"|>>
    File <<|tag == "${cloud_name}_euca.p12"|>>
  }
  class eucalyptus::clc2_reg inherits eucalyptus::clc2 {
    @@exec { "reg_clc_${hostname}":
      command => "/usr/sbin/euca_conf --no-rsync --no-scp --no-sync --register-cloud --partition eucalyptus --host $ipaddress --component clc_$hostname",
      unless => "/usr/sbin/euca_conf --list-clouds | /bin/grep '\b$ipaddress\b'",
      tag => "${cloud_name}",
    }
  }

  include eucalyptus::clc2_install, eucalyptus::clc2_config, eucalyptus::clc2_reg
}
