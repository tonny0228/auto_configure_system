#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -f $curdir/aria2.conf ] || sed "s%#HOME#%$HOME%" $BUILDDIR/templates/aria2.conf > $curdir/aria2.conf

[ -d $HOME/.aria2 ] || { mkdir $HOME/.aria2 && touch $HOME/.aria2/links.txt && mv $curdir/aria2.conf $HOME/.aria2/aria2.conf; }

sudo apt-get install --force-yes --yes aria2
