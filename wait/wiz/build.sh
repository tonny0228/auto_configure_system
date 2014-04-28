#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes build-essential libqt4-dev git

workspace=/tmp/workspace
[ -d $workspace ] && rm -rf $workspace/* || mkdir $workspace
cd $workspace

link="git://github.com/WizTeam/WizQTClient.git"
filename=${link##*/}
dirname=${filename%%.git}

git clone git://github.com/WizTeam/WizQTClient.git && cd $dirname && cmake . && make && sudo make install

rm -rf $workspace
