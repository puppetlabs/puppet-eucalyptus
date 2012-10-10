class eucalyptus::clc ($cloud_name = "cloud1") {
  include eucalyptus
  include eucalyptus::conf
  Class[eucalyptus] -> Class[eucalyptus::clc]

  class eucalyptus::clc_install {
    package { 'eucalyptus-cloud':
      ensure => present,
    }
    service { 'eucalyptus-cloud':
      ensure => running,
      enable => true,
    }
    
  }
  class eucalyptus::clc_config inherits eucalyptus::clc {
    Class[eucalyptus::repo] -> Package['eucalyptus-cloud'] -> Class[eucalyptus::conf] -> Exec['init-db'] ->  Service['eucalyptus-cloud'] -> Class[eucalyptus::clc_reg] 
    
    exec { 'init-db':
      command => "/usr/sbin/euca_conf --initialize",
      creates => "/var/lib/eucalyptus/db/data",
      timeout => "0",
    }

    # Cloud-wide
    @@file { "${cloud_name}_cloud_cert":
      path    => '/var/lib/eucalyptus/keys/cloud-cert.pem',
      content => "$eucakeys_cloud_cert",
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}_cloud_cert",
    }
    @@file { "${cloud_name}_cloud_pk":
      path    => '/var/lib/eucalyptus/keys/cloud-pk.pem',
      content => "$eucakeys_cloud_pk",
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}_cloud_pk",
    }
    @@file { "${cloud_name}_euca.p12":
      path    => '/var/lib/eucalyptus/keys/euca.p12',
      content => "$eucakeys_euca_p12",
      owner   => 'eucalyptus',
      group   => 'eucalyptus',
      mode    => '0700',
      tag     => "${cloud_name}_euca.p12",
    }
    
    Eucalyptus_config <||>
  }
  class eucalyptus::clc_reg inherits eucalyptus::clc {
    Class[eucalyptus::clc_config] -> Class[eucalyptus::clc_reg] 
    Exec <<|tag == "$cloud_name"|>>
  }
  
  include eucalyptus::clc_install, eucalyptus::clc_config, eucalyptus::clc_reg
}
