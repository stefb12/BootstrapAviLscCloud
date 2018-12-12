# BootstrapAviLscCloud
Use the bash script to:
- Bootstrap the Avi controller with a new password
- copy the ssh keys to the SEs in order to allow the controller to connect
- configure a new Linux cloud with the new SEs

Example:
./BootstrapAviLscCloud.sh 192.168.17.151 Avi_2018 18.1.3 se.txt avi avi123

A file needs to be define with the IPs of the SE: One IP per line
