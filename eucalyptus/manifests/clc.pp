class eucalyptus::clc (
                    $network_mode,
                    $priv_subnet,
                    $priv_netmask,
                    $dns_server,
                    $addrs_per_net,
                    $public_ip_range
                  )
{
  Class[eucalyptus] -> Class[eucalyptus::clc]
  package { 'eucalyptus-cloud':
    ensure => present,
  }
  eucalyptus_config {
    'VNET_MODE': value => $network_mode;
    'VNET_SUBNET': value => $priv_subnet;
    'VNET_NETMASK': value => $priv_netmask;
    'VNET_DNS': value => $dns_server;
    'VNET_ADDRSPERNET': value => $addrs_per_net;
    'VNET_PUBLICIPS': value => $public_ip_range;
  }
}
