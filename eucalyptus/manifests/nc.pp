class eucalyptus::nc {
  include eucalyptus::hypervisor
  Class[eucalyptus] -> Class[eucalyptus::nc]
  package { 'eucalyptus-nc':
    ensure => present,
  }
  service { 'eucalyptus-nc':
    ensure => running,
    enable => true,
    requires => Package['eucalyptus-nc']
  }
}
