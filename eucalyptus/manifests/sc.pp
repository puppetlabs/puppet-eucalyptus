class eucalyptus::sc {
  Class[eucalyptus] -> Class[eucalyptus::sc]
  package { 'eucalyptus-sc':
    ensure => present,
  }
#  @@exec { 'reg-sc':
#    command => "/usr/sbin/euca_conf --no-rsync --register-sc cluster00 $ec2_public_hostname",
#  }
}
