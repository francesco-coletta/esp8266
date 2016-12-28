#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive
echo ">>>> Update system ..."
#sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "skipped\n"
echo -e "done\n"

echo ">>>> Installing Desktop manager xfce4"
sudo apt-get -y -q install xfce4 
sudo apt-get install gnome-icon-theme-full tango-icon-theme
echo -e "done\n"

echo ">>>> Permit anyone to start the GUI"
sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
echo -e "done\n"

