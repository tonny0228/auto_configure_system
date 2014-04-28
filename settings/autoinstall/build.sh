#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

echo "#######################################################################"
echo "######################$(date)  BEGIN:AUTO INSTALL######################"

for app in $(grep -v "^#" $curdir/build.cfg); do
  echo "#####################################################################"
  echo "#############################BEGIN:$app##############################"
  sudo apt-get --force-yes --yes install $app
  echo "#############################END:$app################################"
  echo "#####################################################################"
done

echo "######################$(date)  END:AUTO INSTALL########################"
echo "#######################################################################"

exit 0
