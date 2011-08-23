class eucalyptus::selinux {
  file { '/etc/sysconfig/system-config-securitylevel':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/system-config-securitylevel',
  }
  # edit /etc/sysconfig/selinux
  # sed --in-place=.bak 's/enforcing/disabled/g' /etc/sysconfig/selinux 
}
