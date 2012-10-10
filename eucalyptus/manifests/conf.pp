class eucalyptus::conf(
    # Default values for parameters not overriden in node definitions, try to stick to eucalyptus.conf defaults
    $vnet_mode = "SYSTEM",
    $vnet_subnet = "127.0.0.1",
    $vnet_netmask = "255.255.255.0",
    $vnet_dns = "8.8.8.8",
    $vnet_addrspernet = "32",
    $vnet_publicips = "192.168.0.50-192.168.0.250",
    $vnet_privinterface = "eth1",
    $vnet_pubinterface = "eth0",
    $eucalyptus_dir = "/",
    $eucalyptus_user = "eucalyptus",
    $disable_iscsi = "N",
    $disable_dns = "Y",
    $enable_ws_security = "Y",
    $cloud_opts = "",
    $eucalyptus_loglevel = "DEBUG",
    $cc_port = "8774",
    $schedpolicy = "ROUNDROBIN",
    $power_idlethresh = "0",
    $power_wakethresh = "0",
    $nc_service = "axis2/services/EucalyptusNC",
    $nc_port = "8775",
    $hypervisor = "kvm",    
    $use_virtio_disk = "1",
    $use_virtio_root = "1",
    $use_virtio_net = "0",
    $instance_path = "/var/lib/eucalyptus/instances",
    $vnet_bridge = "br0",
    $vnet_dhcpdaemon = "/usr/sbin/dhcpd41",
    $vnet_disable_tunneling = "y",
    $cc_arbitrators = "none",
)
{
  @eucalyptus_config {
    'VNET_MODE': value => $vnet_mode;
    'VNET_SUBNET': value => $vnet_subnet;
    'VNET_NETMASK': value => $vnet_netmask;
    'VNET_DNS': value => $vnet_dns;
    'VNET_ADDRSPERNET': value => $vnet_addrspernet;
    'VNET_PUBLICIPS': value => $vnet_publicips;
    'VNET_PRIVINTERFACE': value => $vnet_privinterface;
    'VNET_PUBINTERFACE': value => $vnet_pubinterface;
    'EUCALYPTUS': value => $eucalyptus_dir;
    'EUCA_USER': value => $eucalyptus_user;
    'DISABLE_ISCSI': value => $disable_iscsi;
    'DISABLE_DNS': value => $disable_dns;
    'ENABLE_WS_SECURITY': value => $enable_ws_security;
    'CLOUD_OPTS': value => $cloud_opts;
    'LOGLEVEL': value => $eucalyptus_loglevel;
    'CC_PORT': value => $cc_port;
    'SCHEDPOLICY': value => $schedpolicy;
    'POWER_IDLETHRESH': value => $power_idlethresh;
    'POWER_WAKETHRESH': value => $power_wakethresh;
    'NC_SERVICE': value => $nc_service;
    'NC_PORT': value => $nc_port;
    'HYPERVISOR': value => $hypervisor;
    'USE_VIRTIO_DISK': value => $use_virtio_disk;
    'USE_VIRTIO_ROOT': value => $use_virtio_root;
    'USE_VIRTIO_NET': value => $use_virtio_net;
    'INSTANCE_PATH': value => $instance_path;
    'VNET_BRIDGE': value => $vnet_bridge;
    'VNET_DHCPDAEMON': value => $vnet_dhcpdaemon;
    'DISABLE_TUNNELING': value => $vnet_disable_tunneling;
    'CC_ARBITRATORS': value => $cc_arbitrators;
  }
}
