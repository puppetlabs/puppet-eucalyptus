$network_mode = 'MANAGED-NOVLAN'
node default {
  class { 'eucalyptus':
  }
  class { 'eucalyptus::sc':
    network_mode => $network_mode,
  }
}
