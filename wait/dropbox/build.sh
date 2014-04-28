#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes wget

[ -d $HOME/.config/dropbox ] || { wget https://www.dropbox.com/download?plat=lnx.x86_64 -O- | tar -xvzf - -C $HOME/.config && mv $HOME/.config/.dropbox-dist $HOME/.config/dropbox; }

grep "dropboxd" $HOME/.profile || sed -i "/clear/i\[ -z \$TMUX ] && sh $HOME/.config/dropbox/dropboxd &" $HOME/.profile

#sudo apt-get install --force-yes --yes nautilus-dropbox
