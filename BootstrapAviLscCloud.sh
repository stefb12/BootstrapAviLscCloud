#!/bin/bash
#
# ./BootstrapAviLscCloud.sh 192.168.17.151 Avi_2018 18.1.3 se.txt avi avi123
#
AviControllerIp=$1
AviPassword=$2
AviVersion=$3
AviSeListFile=$4
AviSeUsername=$5
AviSePassword=$6
IdRsaFile="/home/avi/ssh/id_rsa"
AviSeCpu="1"
AviSeMem="1"
AviSeDpdk="No"
AviSeTenant="admin"
#
#
#
mkdir vars 2>/dev/null
IdRsaFileBaseName=`basename /home/avi/ssh/id_rsa`
echo "# This file has been generated automatically
avi_credentials:
  controller: $AviControllerIp
  username: admin
  password: $AviPassword
  api_version: $AviVersion" > vars/creds.yml
echo "SeList:"  > vars/se.yml
echo "---
all:
  children:
    ubuntu:
      children:
        se:
          hosts:" > hosts
i=1
for ip in `cat $AviSeListFile`
  do
  echo "  - $ip" >> vars/se.yml
  echo "            se$i:
              ansible_host: $ip" >> hosts
  i=$((i+1))
  done
echo "
  vars:
    ansible_user: $AviSeUsername
    ansible_ssh_pass: $AviSePassword
    ansible_become_pass: $AviSePassword" >> hosts
while true
do nc -z -v -w5 $AviControllerIp 443 2>/dev/null
  if [ "$?" -eq 0 ]
  then
    echo 'controller is ready'
    break
    echo '#########################'
  fi
  echo 'controller is not ready, waiting for 20 seconds..'
  sleep 20
done

ansible-playbook --extra-vars="IdRsaFile=$IdRsaFile" BootstrapAviLscCloud.yml
ansible-playbook -i hosts --extra-vars="IdRsaFile=$IdRsaFile IdRsaFileBaseName=$IdRsaFileBaseName" SudoUser.yml
ansible-playbook --extra-vars="AviSeCpu=$AviSeCpu AviSeMem=$AviSeMem AviSeDpdk=$AviSeDpdk AviSeTenant=$AviSeTenant AviSeUsername=$AviSeUsername" ModifyDefaultCloud.yml
#ansible-playbook create_vs.yml
rm -f hosts
rm -f vars/creds.yml
rm -f vars/se.yml
rmdir vars
