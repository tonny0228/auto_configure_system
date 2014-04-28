#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

if [ X$BUILDTYPE = Xhost ]; then
  [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf > $curdir/apt.conf || touch $curdir/apt.conf
  [ -f /etc/environment ] && cat /etc/environment > $curdir/environment || touch $curdir/environment

  grep "$SERVIP:$SERVPORT" $curdir/apt.conf && rm $curdir/apt.conf || { echo "Acquire::http::proxy \"http://$SERVIP:$SERVPORT/\";" > $curdir/apt.conf && echo "Acquire::https::proxy \"https://$SERVIP:$SERVPORT/\";" >> $curdir/apt.conf && echo "Acquire::ftp::proxy \"ftp://$SERVIP:$SERVPORT/\";" >> $curdir/apt.conf && echo "Acquire::socks::proxy \"socks://$SERVIP:$SERVPORT/\";" >> $curdir/apt.conf; }
  grep "$SERVIP:$SERVPORT" $curdir/environment && rm $curdir/environment || { echo "http_proxy=\"http://$SERVIP:$SERVPORT/\"" >> $curdir/environment && echo "https_proxy=\"https://$SERVIP:$SERVPORT/\"" >> $curdir/environment && echo "ftp_proxy=\"ftp://$SERVIP:$SERVPORT/\"" >> $curdir/environment && echo "socks_proxy=\"socks://$SERVIP:$SERVPORT/\"" >> $curdir/environment; }

  [ -f $curdir/apt.conf ] && { sudo mv $curdir/apt.conf /etc/apt/apt.conf && sudo chown root:root /etc/apt/apt.conf && sudo chown 644 /etc/apt/apt.conf; }
  [ -f $curdir/environment ] && { sudo mv $curdir/environment /etc/environment && sudo chown root:root /etc/environment && sudo chown 644 /etc/environment; }

  [ -f $curdir/sources.list ] || { sed -n "/<default>/,/<\/default>/p" $BUILDDIR/templates/sources.list | grep -v "default" | sed 's/^[ \t]*//;s/[ \t]*$//' > $curdir/sources.list && sed -i "s/#RELEASE#/$(lsb_release -sc)/" $curdir/sources.list && sudo mv $curdir/sources.list /etc/apt/sources.list; }

  sudo apt-get --force-yes --yes update
elif [ X$BUILDTYPE = Xserver ]; then
  sudo chmod o+w /etc/network/interfaces
  grep "iface eth1 inet static" /etc/network/interfaces || { sudo sed -i "s/\(.*eth1.*\)/# \1/" /etc/network/interfaces && echo "\nauto eth1\niface eth1 inet static\naddress $SERVIP\nnetmask 255.255.255.0" >> /etc/network/interfaces; }
  sudo chmod o-w /etc/network/interfaces
fi

exit 0
