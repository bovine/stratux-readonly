#!/bin/bash

##
## Pi Update / Make-Read-Only Script.
## 

# Replace the default DHCP server startup file
cp isc-dhcp-server /etc/init.d/isc-dhcp-server

# Remove the checkroot-bootclean.sh script
update-rc.d -f checkroot-bootclean.sh remove
rm -f /etc/init.d/checkroot-bootclean.sh

# Add the ro / rw commands
cp ro /usr/bin/ro
cp rw /usr/bin/rw

# Remove a bunch of stuff we don't need 
apt-get -y remove --purge triggerhappy cron logrotate dphys-swapfile fake-hwclock
apt-get -y autoremove --purge

# Install the busybox version of syslogd
dpkg --install busybox-*.deb
dpkg --purge rsyslog

# Delete a bunch of stuff to make clean mount points
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/log/*
rm -rf /var/lib/dhcp/*

# Replace the /boot/cmdline.txt file with the RO, fastboot version
cp cmdline.txt /boot/cmdline.txt

# Replace the fstab with our RO version
cp fstab /etc/fstab
