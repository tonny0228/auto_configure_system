#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo mount /dev/sr0 /media && sudo /media/autorun.sh

exit 0
