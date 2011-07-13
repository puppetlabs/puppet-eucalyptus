class euca-nc {
  package { 'eucalyptus-nc':
    ensure => present,
  }
  file { 'eucalyptus.conf':
#  MAX_CORES = $sp_number_processors
  }
}
