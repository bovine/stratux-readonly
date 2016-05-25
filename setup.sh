#!/bin/bash

##
## Pi Update / Make-Read-Only Script
## 
## RUN THIS ON YOUR Linux / Mac / Windows SYSTEM - NOT THE PI!!!!
##
## This script assumes you have valid keys in /etc/ssh/authorized_keys/root
## Make sure to set the "PIIP" variable for the Pi to update.
##


# check the $PIIP var
if [ -z "$PIIP" ]; then
    echo "PIIP var must be set with the IP of the Pi to update"
    exit 1
fi

# Replace the default DHCP server startup file
scp isc-dhcp-server root@$PIIP:/etc/init.d/isc-dhcp-server

# Remove the checkroot-bootclean.sh script
ssh root@$PIIP 'update-rc.d -f checkroot-bootclean.sh remove'
ssh root@$PIIP 'rm -f /etc/init.d/checkroot-bootclean.sh'

# Add the ro / rw commands
scp ro root@$PIIP:/usr/bin/ro
scp rw root@$PIIP:/usr/bin/rw

# Remove a bunch of stuff we don't need 
ssh root@$PIIP 'apt-get -y remove --purge triggerhappy cron logrotate dphys-swapfile fake-hwclock'
ssh root@$PIIP 'apt-get -y autoremove --purge'

# Install the busybox version of syslogd
ssh root@$PIIP 'apt-get -y install busybox-syslogd'
ssh root@$PIIP 'dpkg --purge rsyslog'

# Delete a bunch of stuff to make clean mount points
ssh root@$PIIP 'rm -rf /tmp/*'
ssh root@$PIIP 'rm -rf /var/tmp/*'
ssh root@$PIIP 'rm -rf /var/log/*'
ssh root@$PIIP 'rm -rf /var/lib/dhcp/*'

# Replace the /boot/cmdline.txt file with the RO, fastboot version
scp cmdline.txt root@$PIIP:/boot/cmdline.txt

# Replace the fstab with our RO version
scp fstab root@$PIIP:/etc/fstab



