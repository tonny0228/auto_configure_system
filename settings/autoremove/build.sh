#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

echo "#######################################################################"
echo "#######################$(date)  BEGIN:AUTO CLEAN#######################"

for app in $(grep -v "^#" $curdir/build.cfg); do
  echo "#####################################################################"
  echo "#############################BEGIN:$app##############################"
  sudo apt-get --force-yes --yes purge $app
  echo "#############################END:$app################################"
  echo "#####################################################################"
done

sudo apt-get --force-yes --yes autoremove
sudo apt-get --force-yes --yes autoclean
sudo apt-get --force-yes --yes clean

echo "#######################$(date)  END:AUTO CLEAN#########################"
echo "#######################################################################"

exit 0
