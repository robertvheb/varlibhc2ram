#!/usr/bin/env sh

systemctl -q is-active varlibhc2ram  && { echo "ERROR: varlibhc2ram service is still running. Please run \"sudo service varlibhc2ram stop\" to stop it."; exit 1; }
[ "$(id -u)" -eq 0 ] || { echo "You need to be ROOT (sudo can be used)"; exit 1; }

# varlibhc2ram
mkdir -p /usr/local/bin/
install -m 644 varlibhc2ram.service /etc/systemd/system/varlibhc2ram.service
install -m 755 varlibhc2ram /usr/local/bin/varlibhc2ram
install -m 644 varlibhc2ram.conf /etc/varlibhc2ram.conf
install -m 644 uninstall.sh /usr/local/bin/uninstall-varlibhc2ram.sh
systemctl enable varlibhc2ram

# cron
install -m 755 varlibhc2ram.hourly /etc/cron.hourly/varlibhc2ram
install -m 644 varlibhc2ram.logrotate /etc/logrotate.d/varlibhc2ram

# Remove a previous varlibhc2ram version
  rm -rf /var/lib/hc.hdd

# Make sure we start clean
rm -rf /var/lib/hdd.hc

echo "#####         Reboot to activate varlibhc2ram         #####"
echo "##### edit /etc/varlibhc2ram.conf to configure options ####"
