$network_mode = 'MANAGED-NOVLAN'
node default {
  class { 'eucalyptus':
  }
  class { 'eucalyptus::cc':
    network_mode => $network_mode,
  }
}
