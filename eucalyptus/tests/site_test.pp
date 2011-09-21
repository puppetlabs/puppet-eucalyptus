$network_mode = 'MANAGED-NOVLAN'
$priv_subnet = '10.10.0.0'
$priv_netmask = '255.255.0.0'
$dns_server = '10.20.30.1'
$addrs_per_net = '32'
$public_ip_range = '10.20.30.210-10.20.30.230'

node default {
  class { 'eucalyptus': }
  class {
    [ eucalyptus::clc, eucalyptus::walrus, eucalyptus::cc, eucalyptus::sc ]:
  }
}

node nodecontroller {
  class { [ 'eucalyptus', 'eucalyptus:nc' ]: }
}
