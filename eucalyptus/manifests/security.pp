# Disable selinux + firewall for RedHat based OS

class eucalyptus::security {
  case $operatingsystem {
    centos, rhel : {
      if $selinux == 'true' {
        exec { "/bin/sed --in-place=.bak 's/enforcing/disabled/g' /etc/selinux/config":
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
      exec { "/bin/grep -v 'reject-with' /etc/sysconfig/iptables >/tmp/iptables; /bin/cp /tmp/iptables /etc/sysconfig":
        unless  => "/usr/bin/test -f /tmp/iptables",
      }
    }
  }
}

