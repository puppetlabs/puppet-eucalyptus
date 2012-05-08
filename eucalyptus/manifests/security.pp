class eucalyptus::security {
  exec { "/bin/sed --in-place=.bak 's/enforcing/disabled/g' /etc/selinux/config":
  }
  exec { "/bin/sed --in-place=.bak 's/enforcing/disabled/g' /etc/sysconfig/system-config-firewall":
  }
  exec { "/bin/grep -v 'reject-with' /etc/sysconfig/iptables >/tmp/iptables; /bin/cp /tmp/iptables /etc/sysconfig":
  }
}
