#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes git python-minimal

[ -d $HOME/.xunlei.lixian/.git ] || git clone git://github.com/iambus/xunlei-lixian.git $HOME/.xunlei.lixian

[ -f $curdir/xunlei.lixian.config ] || sed "s%#DOWNLOADDIR#%$HOME/Downloads%" $BUILDDIR/templates/xunlei.lixian.config > $curdir/xunlei.lixian.config
[ -f $HOME/.xunlei.lixian.config ] || mv $curdir/xunlei.lixian.config $HOME/.xunlei.lixian.config

[ -L /usr/local/bin/thunder ] || sudo ln -sf $HOME/.xunlei.lixian/lixian_cli.py /usr/local/bin/thunder
