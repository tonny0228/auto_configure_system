#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes wget

[ -f /usr/local/bin/btsync ] || { wget http://btsync.s3-website-us-east-1.amazonaws.com/btsync_x64.tar.gz -O- | sudo tar -xvzf - -C /usr/local/bin && sudo chown $USER:$GROUP /usr/local/bin/btsync; }

[ -f $curdir/sync.conf ] || { sed "s%#USERNAME#%$(echo $USER)%" $BUILDDIR/templates/sync.conf > $curdir/sync.conf && sed -i "s%#HOME#%$HOME%" $curdir/sync.conf; } 

[ -f $HOME/.sync.conf ] || mv $curdir/sync.conf $HOME/.sync.conf

grep "btsync" $HOME/.profile || sed -i "/clear/i\[ -z \$TMUX ] && /usr/local/bin/btsync --config $HOME/.sync.conf" $HOME/.profile
