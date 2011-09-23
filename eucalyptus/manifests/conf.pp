class eucalyptus::conf
{
  @eucalyptus_config {
    'VNET_MODE': value => $network_mode;
    'VNET_SUBNET': value => $priv_subnet;
    'VNET_NETMASK': value => $priv_netmask;
    'VNET_DNS': value => $dns_server;
    'VNET_ADDRSPERNET': value => $addrs_per_net;
    'VNET_PUBLICIPS': value => $public_ip_range;
    'EUCALYPTUS': value => "/";
    'EUCA_USER': value => "eucalyptus";
    'DISABLE_ISCSI': value => "N";
    'DISABLE_DNS': value => "Y";
    'ENABLE_WS_SECURITY': value => "Y";
#    'CLOUD_OPTS': value => "";
    'LOGLEVEL': value => "DEBUG";
    'CC_PORT': value => "8774";
    'SCHEDPOLICY': value => "ROUNDROBIN";
    'POWER_IDLETHRESH': value => "300";
    'POWER_WAKETHRESH': value => "300";
#    'NODES': value => "";
    'NC_SERVICE': value => "axis2/services/EucalyptusNC";
    'NC_PORT': value => "8775";
    'HYPERVISOR': value => "xen";
    'USE_VIRTIO_DISK': value => "0";
    'USE_VIRTIO_ROOT': value => "0";
    'USE_VIRTIO_NET': value => "0";
    'INSTANCE_PATH': value => "/usr/local/eucalyptus/";
    'VNET_BRIDGE': value => "xenbr0";
    'VNET_DHCPDAEMON': value => "/usr/sbin/dhcpd";
  }
}
