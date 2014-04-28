#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

sudo apt-get install --force-yes --yes git python-minimal

[ -d $HOME/.config/dns ] || git clone git://github.com/henices/Tcp-DNS-proxy.git $HOME/.config/dns

grep "tcpdns.py" $HOME/.profile || sed -i "/clear/i\[ -z \$TMUX ] && python $HOME/.config/dns/tcpdns.py &" $HOME/.profile
