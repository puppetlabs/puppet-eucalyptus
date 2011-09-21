class eucalyptus::sudo {
  # confirm that requiretty is disabled
  exec { "/bin/sed --in-place=.bak 's/^Defaults[ ]*requiretty/#&/g' /etc/sudoers":
    require => Package['sudo'],
  }
}
