#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -f $HOME/.synergy.conf ] || cp $curdir/synergy.conf $HOME/.synergy.conf

sudo apt-get install --force-yes --yes synergy
