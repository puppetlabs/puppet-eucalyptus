class eucalyptus::jvm{
	service { 'eucalyptus-cloud':
      ensure => running,
      enable => true,
    }
}