class eucalyptus::cc {

  Class['eucalyptus'] -> Class[eucalyptus::cc]

  include eucalyptus::conf

  package { 'eucalyptus-cc':
    ensure => present,
  }
  service { 'eucalyptus-cc':
    ensure => running,
    enable => true,
    subscribe => Eucalyptus_config['VNET_MODE']
  }
  Eucalyptus_config <||>
  @@exec { 'reg-cc':
## Hack warning! this ensures cc registered before sc, then exit code forced to 0 to make exec code happy
    command => "/usr/sbin/euca_conf --no-rsync --register-cluster cluster00 $ec2_public_hostname; /usr/sbin/euca_conf --no-rsync --register-cluster cluster00 $ec2_public_hostname; exit 0",
  }
  File <<|title == 'cloud-cert'|>>
  File <<|title == 'cloud-pk'|>>
  File <<|title == 'cluster00-cc-cert'|>>
  File <<|title == 'cluster00-cc-pk'|>>
  File <<|title == 'cluster00-nc-cert'|>>
}
