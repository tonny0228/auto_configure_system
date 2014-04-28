#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

if [ X$1 = X"start" ]; then
  sudo sed -i "/^# Disable swap partition$/d" /etc/sysctl.conf && sudo sed -i "/^vm.swappiness=0$/d" /etc/sysctl.conf
elif [ X$1 = X"stop" ]; then
  tempfile=$(mktemp /tmp/tempfile.XXXXXX)

  grep "^vm.swappiness=0$" /etc/sysctl.conf || { cp /etc/sysctl.conf $tempfile && echo "\n# Disable swap partition\nvm.swappiness=0" >> $tempfile && sudo cp $tempfile /etc/sysctl.conf; }

  rm $tempfile
fi
