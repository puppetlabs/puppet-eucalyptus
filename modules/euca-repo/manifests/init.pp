class euca-repo {
# only works for yum. Can we do this generically, or simply detect yum vs apt
#  file { '/etc/yum.repos.d/euca.repo':
#    ensure => present,
#    owner => 'root',
#    group => 'root',
#    mode => '0644',
#    source => 'puppet:///modules/euca-deps/euca.repo',
#  }
# NOTE: replace 2.0.2 with a variable ($VERSION)
  yumrepo { 'eucarepo':
    descr => 'Eucalyptus Software',
    enabled => 1,
    gpgcheck => 0,
    baseurl => 'http://www.eucalyptussoftware.com/downloads/repo/eucalyptus/2.0.2/yum/centos/',
  }
}
