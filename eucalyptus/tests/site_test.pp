$network_mode = 'MANAGED-NOVLAN'
$priv_subnet = '10.10.0.0'
$priv_netmask = '255.255.0.0'
$dns_server = '10.20.30.1'
$addrs_per_net = '32'
$public_ip_range = '10.20.30.210-10.20.30.230'

@eucalyptus_config {
  'VNET_MODE': value => $network_mode;
  'VNET_SUBNET': value => $priv_subnet;
  'VNET_NETMASK': value => $priv_netmask;
  'VNET_DNS': value => $dns_server;
  'VNET_ADDRSPERNET': value => $addrs_per_net;
  'VNET_PUBLICIPS': value => $public_ip_range;
}

node default {
  class { 'eucalyptus': }
  class {
    [ eucalyptus::clc, eucalyptus::walrus, eucalyptus::cc, eucalyptus::sc ]:
  }
}

node nodecontroller {
  class { [ 'eucalyptus', 'eucalyptus:nc' ]: }
}
