#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes wu-ftpd

[ -d $HOME/.config/tmux ] || git clone git://github.com/erikw/tmux-powerline.git $HOME/.config/tmux

[ -f $HOME/.tmux-powerlinerc ] || { $HOME/.config/tmux/generate_rc.sh && mv $HOME/.tmux-powerlinerc.default $HOME/.tmux-powerlinerc; }

[ -L $HOME/.tmux ] || { ln -s $curdir/tmux.conf $HOME/.tmux.conf && chown -R $USER:$GROUP $HOME/.tmux.conf; }
