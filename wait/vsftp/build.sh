#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))
rootdir=$HOME/Downloads/ftp
confdir=$HOME/.config/ftp

sudo apt-get install --force-yes --yes vsftpd

[ -d $rootdir ] || { mkdir -p $rootdir && chmod o-w $rootdir && cp $curdir/message $rootdir/.message; }
[ -d $rootdir/Uploads ] || mkdir $rootdir/Uploads && chmod o+w $rootdir/Uploads
[ -d $rootdir/Downloads ] || { mkdir $rootdir/Downloads && chmod o-w $rootdir/Downloads; }

[ -d $HOME/.config/ftp ] || { mkdir -p $HOME/.config/ftp && cp $curdir/vsftpd.user_list $HOME/.config/ftp/ && echo $USER > $HOME/.config/ftp/vsftpd.chroot_list; }

[ -f $curdir/vsftpd.conf ] || { sed "s%#USERNAME#%$(echo $USER | sed 's/\b[a-z]/\U&/g')%" $BUILDDIR/templates/vsftpd.conf > $curdir/vsftpd.conf && sed -i "s%#CHOWN#%$USER%" $curdir/vsftpd.conf && sed -i "s%#ROOTDIR#%$rootdir%" $curdir/vsftpd.conf && sed -i "s%#CONFDIR#%$confdir%" $curdir/vsftpd.conf; } 

sudo mv $curdir/vsftpd.conf /etc/vsftpd.conf && sudo chown root:root /etc/vsftpd.conf && sudo chmod 644 /etc/vsftpd.conf

sudo service vsftpd restart
