#!/bin/bash

##
## Pi Update / Make-Read-Only Script.
## 
## Download the script files from: https://github.com/cyoung/stratux/issues/78
## When unpacked, you will have a folder named "ropi"
## 
## In the folder downloaded from above, save this script starting from the #!/bin/bash as a text file and name the
## file "setup.sh" replacing the "setup.sh" in the "ropi" directory
## 
## With Filezilla copy "ropi" directory to the pi to /home/pi/ 
## 
## Connect pi to Ethernet for Internet access to install packages in script
##
## SSH to the pi and within the /home/pi/ropi directory and run: sudo bash setup.sh 
## 
## After installation: sudo reboot or sudo halt
##

# Replace the default DHCP server startup file
scp /home/pi/ropi/isc-dhcp-server /etc/init.d/isc-dhcp-server

# Remove the checkroot-bootclean.sh script
update-rc.d -f checkroot-bootclean.sh remove
rm -f /etc/init.d/checkroot-bootclean.sh

# Add the ro / rw commands
scp /home/pi/ropi/ro /usr/bin/ro
scp /home/pi/ropi/rw /usr/bin/rw

# Remove a bunch of stuff we don't need 
apt-get -y remove --purge triggerhappy cron logrotate dphys-swapfile fake-hwclock
apt-get -y autoremove --purge

# Install the busybox version of syslogd
apt-get -y install busybox-syslogd
dpkg --purge rsyslog

# Delete a bunch of stuff to make clean mount points
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/log/*
rm -rf /var/lib/dhcp/*

# Replace the /boot/cmdline.txt file with the RO, fastboot version
scp /home/pi/ropi/cmdline.txt /boot/cmdline.txt

# Replace the fstab with our RO version
scp /home/pi/ropi/fstab /etc/fstab
