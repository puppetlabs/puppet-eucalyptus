define euca_cert($file) {
  file { "/var/lib/eucalyptus/keys/$file":
    source => "puppet:///varlibeuca/keys/$file",
    owner => 'root',
    group => 'root',
  }
}

class certs {
  file { '/var/lib/eucalyptus/keys':
    ensure => directory,
    owner => 'root',
    group => 'root',
  }
  euca_cert { cloud_cert: file => 'cloud-cert.pem' }
  euca_cert { node_cert: file => 'node-cert.pem' }
  euca_cert { node_pk: file => 'node-pk.pem' }
}
