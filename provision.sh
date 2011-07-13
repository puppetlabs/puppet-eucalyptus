#!/bin/bash

if [ "$#" -eq 0 ];
then
  echo "Usage: "$0" <target-host> <nc|cc>"
  exit -1;
fi

# assign role to target
echo "yes" | ssh -i .ssh/id_rsa root@$1 "echo $2 >/etc/role"

# start the puppet agent
echo "yes" | ssh -i .ssh/id_rsa root@$1 "echo puppet agent >> /etc/rc.local; puppet agent"

