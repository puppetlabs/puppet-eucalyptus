class eucalyptus::conf
{
  @eucalyptus_config {
    'VNET_MODE': value => $network_mode;
    'VNET_SUBNET': value => $priv_subnet;
    'VNET_NETMASK': value => $priv_netmask;
    'VNET_DNS': value => $dns_server;
    'VNET_ADDRSPERNET': value => $addrs_per_net;
    'VNET_PUBLICIPS': value => $public_ip_range;
  }
}
