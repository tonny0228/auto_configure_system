#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -d /$HOME/workspace ] || mkdir /$HOME/workspace

cat $curdir/build.cfg | while read line
do
  line=$(eval echo $line)

  grep "$line" /etc/rc.local || sudo sed -i "/^exit 0$/i $line" /etc/rc.local
done

exit 0
