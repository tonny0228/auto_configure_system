#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

[ -z $(which ibus-daemon) ] && sudo apt-get install --force-yes --yes ibus ibus-clutter ibus-gtk ibus-gtk3 ibus-qt4
im-switch -s ibus && ibus-daemon -drx

[ -d /usr/lib/ibus-rime ] || sudo apt-get install --force-yes --yes ibus-rime

exit 0
