#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -f $curdir/toolbox ] || sed "s%#BUILDDIR#%$BUILDDIR%" $BUILDDIR/templates/tools/toolbox > $curdir/toolbox
[ -f $curdir/gentags ] || cp $BUILDDIR/templates/tools/gentags $curdir/gentags

toollist="toolbox gentags"
for tool in $toollist; do
  [ -f /usr/local/bin/$tool ] || { sudo mv $curdir/$tool /usr/local/bin/$tool && sudo chmod a+x /usr/local/bin/$tool; }
done

exit 0
