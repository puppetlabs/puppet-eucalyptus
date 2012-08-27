# Disable selinux + firewall for RedHat based OS

class eucalyptus::security {
  case $operatingsystem {
    centos, rhel : {
      if $selinux == 'true' {
        exec { "Disable SELinux":
          onlyif  => "/usr/bin/test -f /etc/selinux/config",
          command => "/bin/sed --in-place=.bak 's/enforcing/disabled/g' /etc/selinux/config",
          unless  => "/usr/bin/test -f /etc/selinux/config.bak",
        }
      }
      exec {"disable-firewall":
        onlyif  => "/usr/bin/test -f /etc/sysconfig/system-config-firewall",
        command => "/bin/sed --in-place=.bak 's/enabled/disabled/g' /etc/sysconfig/system-config-firewall",
        unless  => "/usr/bin/test -f /etc/sysconfig/system-config-firewall.bak",
      }
      service {"iptables":
        enable  => false,
      }
      exec { "preserve reject-with rules":
        onlyif  => "/usr/bin/test -f /etc/sysconfig/iptables",
        command => "/bin/grep -v 'reject-with' /etc/sysconfig/iptables >/tmp/iptables; /bin/cp /tmp/iptables /etc/sysconfig",
        unless  => "/usr/bin/test -f /tmp/iptables",
      }
    }
  }
}

