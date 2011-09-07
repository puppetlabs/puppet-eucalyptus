$network_mode = 'MANAGED-NOVLAN'
$priv_subnet = '10.10.0.0'
$priv_netmask = '255.255.0.0'
$dns_server = '10.20.30.1'
$addrs_per_net = '32'
$public_ip_range = '10.20.30.210-10.20.30.230'

node default {
  class { eucalyptus:
    network_mode => $network_mode,
    priv_subnet => $priv_subnet,
    priv_netmask => $priv_netmask,
    dns_server => $dns_server,
    addrs_per_net => $addrs_per_net,
    public_ip_range => $public_ip_range,
  }
  class {'eucalyptus::clc':
  }
}
