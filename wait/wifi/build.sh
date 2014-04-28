#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

interface="wlan0"
essid="TANG"
ap="8C:21:0A:69:7C:80"
rate="54M"
freq="2.4g"
channel="11"
key="1234554321"

sudo apt-get install --force-yes --yes wpasupplicant

[ -d $HOME/.config/wifi ] || { mkdir -p $HOME/.config/wifi && wpa_passphrase $essid $key > $HOME/.config/wifi/wpa_supplicant.conf; } 

sudo ifconfig $interface up && sudo wpa_supplicant -B -i $interface -Dnl80211 -c $HOME/.config/wifi/wpa_supplicant.conf

sudo iwconfig $interface power on && sudo iwlist wlan0  power && sudo iwconfig $interface essid $essid ap $ap rate $rate freq $freq channel $channel key $key
