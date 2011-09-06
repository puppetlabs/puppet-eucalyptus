$network_mode = 'MANAGED-NOVLAN'
$priv_subnet = '10.10.0.0'
$priv_netmask = '255.255.0.0'
$dns_server = '10.20.30.1'
$addrs_per_net = '32'
$public_ip_range = '10.20.30.210-10.20.30.230'

node default {
  class {
    'eucalyptus':
  }
}

node type2 {
  class {
    'eucalyptus':
  }
  class {'eucalyptus::clc':
    network_mode => $network_mode,
    priv_subnet => $priv_subnet,
    priv_netmask => $priv_netmask,
    dns_server => $dns_server,
    addrs_per_net => $addrs_per_net,
    public_ip_range => $public_ip_range,
  }
}

node type3 {
  class {
    'eucalyptus':
  }
  class {'eucalyptus::walrus':
    network_mode => $network_mode,
  }
}

node type4 {
  class {
    'eucalyptus':
  }
  class {'eucalyptus:cc':
    network_mode => $network_mode,
  }
}

node type5 {
  class {
    'eucalyptus':
  }
  class {'eucalyptus:sc':
    network_mode => $network_mode,
  }
}

node nodecontroller {
  class {
    [ eucalyptus, eucalyptus::nc ]:
  }
}
