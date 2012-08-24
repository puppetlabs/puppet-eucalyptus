class eucalyptus::drbd_config {
  # Ensure master drbd.conf refers to Eucalyptus config
  file_line { 'drbd master config entry':
    ensure  => present,
    line    => 'include "/etc/eucalyptus/drbd.conf";',
    path    => '/etc/drbd.conf',
    require => Package["drbd"],
  }
  # Packages on CentOS (refactor for multi-distro)
  package { "drbd83-utils":
    ensure => present,
    alias  => "drbd",
  }
  package { "kmod-drbd83":
    ensure => present,
    alias  => "drbd-kmod",
  }
  # Load kernel module, requires kern_module.pp
  kern_module { "drbd": ensure => present, require => Package["drbd-kmod"], }

# Tell Eucalyptus.conf that we're using DRBD  
# We can only declare eucalyptus::conf once, we need to split the provider so it can take separate options
#   class { 'eucalyptus::conf':
#    cloud_opts => '-Dwalrus.storage.manager=DRBDStorageManager',
#    }
# For now, I put it in the node definition under eucalyptus::conf
#
# Hacky way of doign ths same thing:
#   file_line { 'cloud opts drbd entry':
#   ensure  => present,
#    line    => 'CLOUD_OPTS="-Dwalrus.storage.manager=DRBDStorageManager"',
#    path    => '/etc/eucalyptus/eucalyptus.conf',
#    notify  => Service["eucalyptus-cloud"],
#    require => eucalyptus::clc_install["eucalyptus-cloud"],
#  }
}

