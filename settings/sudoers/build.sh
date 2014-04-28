#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -f /etc/sudoers.d/sudoers ] && sudo rm /etc/sudoers.d/sudoers || { echo "$USER ALL=(ALL) NOPASSWD: ALL" > $curdir/sudoers && sudo mv $curdir/sudoers /etc/sudoers.d/sudoers && sudo chown root:root /etc/sudoers.d/sudoers && sudo chmod 0400 /etc/sudoers.d/sudoers; }

exit 0
