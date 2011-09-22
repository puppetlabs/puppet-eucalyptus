class eucalyptus::modprobe {
  # confirm that requiretty is disabled
  exec { "if `grep max_loop /etc/modprobe.conf` then echo \"options loop max_loop=256\" >> /etc/modprobe.conf; rmmod loop ; modprobe loop max_loop=256 fi":

    require => Package['sudo'],
  }
}
