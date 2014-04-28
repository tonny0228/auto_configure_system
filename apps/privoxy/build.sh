#!/bin/bash

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -z $(which git) ] && sudo apt-get install --force-yes --yes git
[ -z $(which privoxy) ] && sudo apt-get install --force-yes --yes privoxy

export PROXY_ADDR="127.0.0.1:8087"
export PROXY_TYPE="http"

gfwlist=https://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt
wget -qO- "${gfwlist}" | base64 -d > /tmp/gfwlist.txt

[ -d $curdir/autoproxy2privoxy/.git ] || git clone https://github.com/cckpg/autoproxy2privoxy.git $curdir/autoproxy2privoxy
$curdir/autoproxy2privoxy/autoproxy2privoxy /tmp/gfwlist.txt > /tmp/gfw.action

sudo mv /tmp/gfw.action /etc/privoxy/gfw.action
sudo chown root:root /etc/privoxy/gfw.action
sudo chmod 644 /etc/privoxy/gfw.action

sudo chmod o+w /etc/privoxy/config
grep "gfw.action" /etc/privoxy/config || echo "actionsfile gfw.action" >> /etc/privoxy/config
sudo sed -i "s/listen-address  localhost:8118/listen-address  0.0.0.0:8118/" /etc/privoxy/config
sudo chmod o-w /etc/privoxy/config

sudo chmod o+w /etc/resolvconf/resolv.conf.d/head
grep "nameserver 8.8.8.8" /etc/resolvconf/resolv.conf.d/head || echo "nameserver 8.8.8.8" >> /etc/resolvconf/resolv.conf.d/head
grep "nameserver 8.8.4.4" /etc/resolvconf/resolv.conf.d/head || echo "nameserver 8.8.4.4" >> /etc/resolvconf/resolv.conf.d/head
sudo chmod o-w /etc/resolvconf/resolv.conf.d/head

[ -d $curdir/privoxy-blocklist/.git ] || git clone https://github.com/Andrwe/privoxy-blocklist.git $curdir/privoxy-blocklist

sed -i "s%SCRIPTCONF=/etc/conf.d/privoxy-blacklist%SCRIPTCONF=$BUILDDIR/templates/privoxy/privoxy-blacklist%" $curdir/privoxy-blocklist/privoxy-blocklist.sh
sed -i "s%\(\$(grep \$(basename \${filterfile}) \${PRIVOXY_CONF})\)%[ \"\1\" == \"\" ]%" $curdir/privoxy-blocklist/privoxy-blocklist.sh
sed -i "s%\^\\\(\#\*\\\)filterfile user\\\.filter\(.*\)\\\1\(.*\)%^filterfile user\\\.filter\1\2%" $curdir/privoxy-blocklist/privoxy-blocklist.sh

sudo $curdir/privoxy-blocklist/privoxy-blocklist.sh

[ -d $curdir/autoproxy2privoxy/.git ] && rm -rf $curdir/autoproxy2privoxy
[ -d $curdir/privoxy-blocklist/.git ] && rm -rf $curdir/privoxy-blocklist
