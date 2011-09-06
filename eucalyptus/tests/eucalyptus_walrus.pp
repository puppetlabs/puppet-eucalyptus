$network_mode = 'MANAGED-NOVLAN'
node default {
  class { 'eucalyptus':
  }
  class { 'eucalyptus::walrus':
    network_mode => $network_mode,
  }
}
