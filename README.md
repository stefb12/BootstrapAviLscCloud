# BootstrapAviLscCloud
Use the bash script to:
- Bootstrap the Avi controller with a new password
- copy the ssh keys to the SEs in order to allow the controller to connect
- configure a new Linux cloud with the new SEs

Example:
./BootstrapAviLscCloud.sh 192.168.17.151 Avi_2018 18.1.3 se.txt avi avi123

AviControllerIp=$1
AviPassword=$2
AviVersion=$3
AviSeListFile=$4
AviSeUsername=$5
AviSePassword=$6

The following parameters can be configured in the ./BootstrapAviLscCloud.sh file:
IdRsaFile="/home/avi/ssh/id_rsa"
AviSeCpu="1"
AviSeMem="1"
AviSeDpdk="No"
AviSeTenant="admin"

A file needs to be define with the IPs of the SE: One IP per line

more se.txt
192.168.17.152
192.168.17.153

