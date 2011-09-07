$network_mode = 'MANAGED-NOVLAN'
node default {
  class { 'eucalyptus':
    network_mode => $network_mode,
  }
  class { 'eucalyptus::walrus':
  }
}
