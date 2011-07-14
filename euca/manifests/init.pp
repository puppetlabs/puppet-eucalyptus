class euca (
  $version = '2.0',
  $repourl = 'http://www.eucalyptussoftware.com/downloads/repo/eucalyptus/2.0.2/yum/centos/'
)
{
  yumrepo { 'eucalyptus':
    descr => 'Eucalyptus Software',
    enabled => 1,
    gpgcheck => 0,
    baseurl => $repourl,
  }
  case $version {
    '2.0': {
      $packages = [ 'java-1.6.0-openjdk',
                    'ant',
                    'ant-nodeps',
                    'dhcp',
                    'bridge-utils',
                    'scsi-target-utils',
                    'httpd'] 
    }
  }  
  default: {
    $packages = 'UNSET'
  }
  if $packages != 'UNSET' { 
    package { $packages: ensure => present }   
  }
}
