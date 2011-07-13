stage { [ "pre", "post" ]: }
Stage['pre'] -> Stage['main'] -> Stage['post']

class first {
  include ntp
  include euca-deps
  include euca-repo
  include selinux
  notify { "myrole":
    message => "my role is $role",
  }
}

class second {
  case $role {
    'clc': { include euca-clc, euca-walrus }
    'cc': { include euca-cc, euca-sc }
    'nc': { include hypervisor, euca-nc }
  }
}

class third {
  include certs
  # nc requires reboot to ensure hypervisor kernel is running
}

node default {
 class { 'first': stage => pre }
 class { 'second': stage => main }
 class { 'third': stage => post }
}










#3.       Disable Firewall and SELinux:
#a.       Edit /etc/selinux/conf (drop in new file)
#b.      Disable Firewall (TODO)

#Note: Might be a good time to do a reboot and then run a script to test the above steps. Fail and log if above steps are not set correctly.
#4.       Install Standard Dependencies on Node:
#a.       # yum install –y *.rpm --nogpgcheck (eucalyptus-deps* from NFS file server)

#5.       Install Eucalyptus Node Components:
#a.       # rpm –Uvh eucalyptus-2.X.X.eee-0.*.x86_64.rpm eucalyptus-nc-2.X.X.eee-0.*.x86_64.rpm eucalyptus-gl-2.X.X.eee-0.*.x86_64.rpm
#b.      Start NC service: /etc/init.d/eucalyptus-nc start

#6.       Register node with frontend:
#a.       # euca_conf --register-nodes {NODE-IP-ADDRESS}

