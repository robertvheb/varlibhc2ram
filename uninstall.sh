#!/usr/bin/env sh

if [ "$(id -u)" -eq 0 ]
then
  service varlibhc2ram stop
  systemctl disable varlibhc2ram
  rm /etc/systemd/system/varlibhc2ram.service
  rm /usr/local/bin/varlibhc2ram
  rm /etc/varlibhc2ram.conf
  rm /etc/cron.hourly/varlibhc2ram
  rm /etc/logrotate.d/varlibhc2ram

  if [ -d /var/hdd.log ]; then
    rm -r /var/hdd.log
  fi
  echo "Log2Ram is uninstalled, removing the uninstaller in progress"
  rm /usr/local/bin/uninstall-varlibhc2ram.sh
  echo "##### Reboot isn't needed #####"
else
  echo "You need to be ROOT (sudo can be used)"
fi
