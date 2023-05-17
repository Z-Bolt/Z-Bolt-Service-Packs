#!/bin/bash
# First service pack:
# 1. Replacing MJPG-streamer with crowsnest
# 2. Optimizing autoshutdown function

### remove MJPG-Streamer service
    echo "Removing MJPG-Streamer service ..."
    sudo systemctl stop webcamd && sudo systemctl disable webcamd
    sudo rm -f "${SYSTEMD}/webcamd.service"
    ###reloading units
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
    echo "MJPG-Streamer Service removed!"

  ### remove webcamd from /usr/local/bin
    sudo rm -f "/usr/local/bin/webcamd"

  ### remove MJPG-Streamer directory
    echo "Removing MJPG-Streamer directory ..."
    rm -rf "${HOME}/mjpg-streamer"
    echo "MJPG-Streamer directory removed!"

  ### remove webcamd log and symlink
  [[ -f "/var/log/webcamd.log" ]] && sudo rm -f "/var/log/webcamd.log"
  [[ -L "${KLIPPER_LOGS}/webcamd.log" ]] && rm -f "${KLIPPER_LOGS}/webcamd.log"

  echo "MJPG-Streamer successfully removed!"

### install crownest
git clone https://github.com/zavodik/crowsnest.git
cd ~/crowsnest
sudo make install

### replacing power.cfg
cd ~
sudo rm ~/klipper_config/klipper-config/power.cfg
git clone https://github.com/Z-Bolt/Z-Bolt-Service-Packs/
cp ~/Z-Bolt-Service-Packs/16052023/power.cfg ~/klipper_config/klipper-config/

### remove PwerOFF.sh and rc-local.service
cd ~
sudo rm PowerOFF.sh
sudo rm /etc/systemd/system/rc-local.service

#reboot
sudo reboot


