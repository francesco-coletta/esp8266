#!/bin/bash

#
# Authors   : Francesco Coletta
#

export DEBIAN_FRONTEND=noninteractive

echo ">>>> Update system ..."
echo "IMP: riattivare"
#sudo apt-get -q update && sudo apt-get -y -q upgrade
echo -e "done\n"

echo ">>>> Create folder ${ESP8266}..."
HOME=/home/vagrant
ESP8266=${HOME}/esp8266
sudo mkdir -p ${ESP8266}
echo -e "done\n"


echo ">>>> Install Requirements and Dependencies for tollchains ..."
sudo apt-get install -y -q make unrar-free autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
    sed git unzip bash help2man wget bzip2
sudo apt-get install -y -q libtool-bin
echo -e "done\n"

echo ">>>> Clone esp-open-sdk ..."
cd ${ESP8266}
echo "IMP: riattivare"
#git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
cd esp-open-sdk
sudo git pull
echo -e "done\n"

echo ">>>> Clone FreeRTOS SDK ..."
cd ${ESP8266}
echo "IMP: riattivare"
#git clone https://github.com/espressif/ESP8266_RTOS_SDK.git
cd ESP8266_RTOS_SDK
sudo git pull
echo -e "done\n"

echo ">>>> Clone FreeRTOS IOT_PLATFORM ..."
cd ${ESP8266}
echo "IMP: riattivare"
#git clone https://github.com/espressif/ESP8266_IOT_PLATFORM.git
cd ESP8266_IOT_PLATFORM
sudo git pull
echo -e "done\n"

echo ">>>> Change permission ..."
sudo chown -R vagrant:vagrant ${ESP8266}
echo -e "done\n"


echo ">>>> Build the bare Xtensa toolchain and leave ESP8266 SDK separate ..."
cd ${ESP8266}/esp-open-sdk
echo "IMP: riattivare"
#sudo -su vagrant make STANDALONE=n
echo -e "done\n"

echo ">>>> Download and installa the ESP8266/ESP32 build helper tool ..."
rm -rf esptool-0.4.11-linux64*
sudo wget -O /tmp/esptool-0.4.11-linux64.tar.gz --progress=bar:force:noscroll --show-progress --quiet https://github.com/igrr/esptool-ck/releases/download/0.4.11/esptool-0.4.11-linux64.tar.gz

cd /tmp/ && sudo tar -zxvf esptool-0.4.11-linux64.tar.gz
cp /tmp/esptool-0.4.11-linux64/esptool  ${ESP8266}/esp-open-sdk/xtensa-lx106-elf/bin/
echo -e "done\n"

echo ">>>> Install and configure GtkTerm ..."
sudo apt-get install -y -q gtkTerm
sudo cp ${HOME}/ws/provision/gtktermrc ${HOME}/.gtktermrc
echo -e "done\n"

echo ">>>> Add the vagrant user to the group dialout ..."
sudo adduser vagrant dialout
echo -e "done\n"


echo ">>>> Configure PATH and user profile ..."
echo " " >> ${HOME}/.profile
echo "#------------------------------------------" >> ${HOME}/.profile
echo "#"$(date '+%Y-%m-%d %H:%M:%S') >> ${HOME}/.profile
PATH_01="PATH=${PATH}:"${ESP8266}/esp-open-sdk/xtensa-lx106-elf/bin/
echo ${PATH_01} >> ${HOME}/.profile

PATH_02="ESP8266_SDK_ROOT="${ESP8266}/ESP8266_RTOS_SDK
echo ${PATH_02} >> ${HOME}/.profile
echo "export ESP8266_SDK_ROOT" >> ${HOME}/.profile
source ${HOME}/.profile

echo -e "done\n"



