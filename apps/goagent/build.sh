#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))
 
[ -z $(which git) ] && sudo apt-get install --force-yes --yes git

[ -d $HOME/workspace ] || mkdir $HOME/workspace
 
[ -d $HOME/workspace/goagent/.git ] || { git clone https://github.com/goagent/goagent.git $HOME/workspace/goagent && sed -i 's/^\(appid = goagent\)/\14tonny/g' $HOME/workspace/goagent/local/proxy.ini; }

grep "proxy.py" /etc/rc.local || sudo sed -i "/^exit 0$/i python $HOME/workspace/goagent/local/proxy.py &" /etc/rc.local

exit 0
