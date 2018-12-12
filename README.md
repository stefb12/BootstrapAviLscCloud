# BootstrapAviLscCloud
Prerequisites:
- Make sure Ansible is installed
- Make sure the Avi SDK is installed:
	++ pip install avisdk --upgrade
        ++ ansible-galaxy install -f avinetworks.avisdk
- Make sure Avi Controller is installed

Use the bash script to:
- create a hosts file (for Ansible)
- create a vars/creds.yml file (to connect to the Avi Controller REST API via Ansible)
- create a vars/se.yml file (it creates a list of SE to feed the Cloud config based of the file in $4)
- Wait for the Avi Controller to be available
- Bootstrap the Avi controller with a new password ($2)
- copy the ssh keys to the SEs in order to allow the controller to connect
- modified the default cloud as a Linux cloud with the new SEs

Example:
./BootstrapAviLscCloud.sh 192.168.17.151 Avi_2018 18.1.3 se.txt avi avi123

The script accepts the following customized parameters:
- AviControllerIp=$1
- AviPassword=$2
- AviVersion=$3
- AviSeListFile=$4
- AviSeUsername=$5
- AviSePassword=$6

The following parameters can be configured within the ./BootstrapAviLscCloud.sh file:
- IdRsaFile="/home/avi/ssh/id_rsa"
- AviSeCpu="1"
- AviSeMem="1"
- AviSeDpdk="No"
- AviSeTenant="admin"

A file ($4) needs to be define with the IPs of the SE: One IP per line

more se.txt
192.168.17.152
192.168.17.153

Script has been tested against:
- Avi 18.1.3
- Ansible 2.7.0
