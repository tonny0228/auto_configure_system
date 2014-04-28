#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

if [ X$1 = X"start" ]; then
  sudo sed -i "/^# Disable touchpad$/d" /etc/modprobe.d/blacklist.conf && sudo sed -i "/^blacklist psmouse$/d" /etc/modprobe.d/blacklist.conf
elif [ X$1 = X"stop" ]; then
  tempfile=$(mktemp /tmp/tempfile.XXXXXX)

  grep "^blacklist psmouse$" /etc/modprobe.d/blacklist.conf || { cp /etc/modprobe.d/blacklist.conf $tempfile && echo "\n# Disable touchpad\nblacklist psmouse" >> $tempfile && sudo cp $tempfile /etc/modprobe.d/blacklist.conf; }

  rm $tempfile
fi
