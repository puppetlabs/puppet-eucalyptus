class euca-deps {
#  package { ['java-1.6.0-openjdk','ant','ant-nodeps','dhcp','bridge-utils','perl-Convert-ANS1.noarch','scsi-target-utils','httpd']: ensure => present }
  package { ['java-1.6.0-openjdk','ant','ant-nodeps','dhcp','bridge-utils','scsi-target-utils','httpd']: ensure => present }
}
