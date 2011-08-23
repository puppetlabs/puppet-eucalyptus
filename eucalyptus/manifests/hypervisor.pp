class eucalyptus::hypervisor {
  # yum install xen kernel-xen libvirt
  package { 'xen': ensure => present }
  package { 'kernel-xen': ensure => present }
  package { 'libvirt': ensure => present }

  # Edit /etc/grub.conf to boot Xen kernel (drop in new file)
  file { 'grub':
    name => '/etc/grub.conf',
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/grub.conf',
    require => Package['xen', 'kernel-xen'],
  }
  # Edit /etc/xen/xend-config.sxp (drop in new file)
  file { 'xend-config':
    name => '/etc/xen/xend-config.sxp',
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/xen/xend-config.sxp',
    require => Package['xen', 'kernel-xen'],
  }

  # Restart xend
  service { 'xend':
    enable => true,
    hasstatus => true,
    hasrestart => true,
    ensure => running,
    require => File['xend-config'],
  }

  # Edit /etc/libvirt/libvirtd.conf (drop in new file)
  file { '/etc/libvirt/libvirt.conf':
    owner => 'root',
    group => 'root',
    mode  => '0644',
    source => 'puppet:///modules/eucalyptus/libvirt/libvirt.conf',
    require => Package['libvirt'],
  }
}
