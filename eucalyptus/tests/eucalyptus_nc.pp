$network_mode = 'MANAGED-NOVLAN'
node default {
  class { 'eucalyptus':
  }
  class { 'eucalyptus::nc':
    network_mode => $network_mode,
  }
}
