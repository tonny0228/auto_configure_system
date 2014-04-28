#!/bin/sh

export BUILDDIR=$(dirname $(readlink -f $0))
export BUILDLOG="$HOME/build.trc"
export BUILDTYPE="host"
export USER=tonny
export GROUP=tonny
export SERVIP="192.168.56.8"
export SERVPORT="8118"

curdir=$(dirname $(readlink -f $0))

export ftp_proxy="ftp://$SERVIP:$SERVPORT/"
export http_proxy="http://$SERVIP:$SERVPORT/"
export https_proxy="https://$SERVIP:$SERVPORT/"
export socks_proxy="socks://$SERVIP:$SERVPORT/"

echo > $BUILDLOG
echo "#######################################################################" >> $BUILDLOG
echo "#########################$(date)  BEGIN BUILD##########################" >> $BUILDLOG

for step in $(grep -v "^#" $curdir/build.cfg); do
  echo "#####################################################################" >> $BUILDLOG
  echo "#####################$(date)  BEGIN STEP: $step######################" >> $BUILDLOG

  $BUILDDIR/${step}/build.sh >> $BUILDLOG 2>&1 || exit 1

  echo "#####################$(date)  END STEP: $step########################" >> $BUILDLOG
  echo "#####################################################################" >> $BUILDLOG
done

echo "#########################$(date)  END BUILD############################" >> $BUILDLOG
echo "#######################################################################" >> $BUILDLOG
