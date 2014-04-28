#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -f $HOME/.config/shell/bash_functions ] && . $HOME/.config/shell/bash_functions || exit 1

[ -z $(which lynx) ] && sudo apt-get install --force-yes --yes lynx-cur

country=$(mycountry)
host=$(sed -n "/<settings>/,/<\/settings>/p" $BUILDDIR/templates/apt/sources.list | sed -n "/<countrylist>/,/<\/countrylist>/p" | sed -n "/<$country>/,/<\/$country>/p" | grep -v "$country" | sed 's/^[ \t]*//;s/[ \t]*$//') 
case "$host" in
"jp" | "kr")
  host="$host".archive.ubuntu.com
  ;;
"cn")
  host="ftp.sjtu.edu.cn"
  ;;
esac

[ -f $curdir/sources.list ] || { sed -n "/<template>/,/<\/template>/p" $BUILDDIR/templates/apt/sources.list | grep -v "template" | sed 's/^[ \t]*//;s/[ \t]*$//' > $curdir/sources.list && sed -i "s/#HOST#/$host/" $curdir/sources.list && sed -i "s/#RELEASE#/$(lsb_release -sc)/" $curdir/sources.list && sudo mv $curdir/sources.list /etc/apt/sources.list; }

grep "## Run this command: " $BUILDDIR/templates/apt/sources.list | sed 's/## Run this command:[ \t]*\(.*\)/\1/' | while read cmd; do
  eval $cmd
done

sudo apt-get --force-yes --yes update

exit 0
