#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -z $(which git) ] && sudo apt-get install --force-yes --yes git

[ -z $(which awesome) ] && sudo apt-get install --force-yes --yes awesome
[ -d /usr/share/doc/awesome-extra ] || sudo apt-get install --force-yes --yes awesome-extra
[ -z $(which i3lock) ] && sudo apt-get install --force-yes --yes i3lock
[ -z $(which xautolock) ] && sudo apt-get install --force-yes --yes xautolock
[ -z $(which notify-send) ] && sudo apt-get install --force-yes --yes libnotify-bin
[ -d /usr/share/doc/xfonts-terminus ] || sudo apt-get install --force-yes --yes xfonts-terminus
[ -d /usr/share/doc/ttf-dejavu ] || sudo apt-get install --force-yes --yes ttf-dejavu
[ -z $(which xcompmgr) ] && sudo apt-get install --force-yes --yes xcompmgr
[ -d /usr/share/doc/xpyb ] || sudo apt-get install --force-yes --yes python-xpyb
[ -z $(which pilfile.py) ] && sudo apt-get install --force-yes --yes python-imaging
[ -z $(which fvwm2) ] && sudo apt-get install --force-yes --yes fvwm
[ -z $(which fvwm-crystal) ] && sudo apt-get install --force-yes --yes fvwm-crystal
[ -d /usr/share/doc/gnome-themes-standard ] || sudo apt-get install --force-yes --yes gnome-themes-standard
[ -d /usr/share/doc/gnome-wine-icon-theme ] || sudo apt-get install --force-yes --yes gnome-wine-icon-theme
[ -z $(which alsactl) ] && sudo apt-get install --force-yes --yes alsa-utils
[ -z $(which pavucontrol) ] && sudo apt-get install --force-yes --yes pavucontrol
[ -z $(which pidgin) ] && sudo apt-get install --force-yes --yes pidgin
[ -z $(which bluetooth-wizard) ] && sudo apt-get install --force-yes --yes gnome-bluetooth
[ -z $(which pulseaudio) ] && sudo apt-get install --force-yes --yes pulseaudio
[ -z $(which numlockx) ] && sudo apt-get install --force-yes --yes numlockx
[ -z $(which urxvt) ] && sudo apt-get install --force-yes --yes rxvt-unicode-256color

[ -d $HOME/.config/awesome/.git ] || git clone https://github.com/vincentbernat/awesome-configuration.git $HOME/.config/awesome

sudo apt-get --force-yes --yes purge unity unity-common unity-services unity-lens-\* unity-scope-\* unity-webapps-\* gnome-control-center-unity hud libunity-core-6\* libunity-misc4 libunity-webapps\* appmenu-gtk appmenu-gtk3 appmenu-qt\* overlay-scrollbar\* activity-log-manager-control-center firefox-globalmenu thunderbird-globalmenu libufe-xidgetter0 xul-ext-unity xul-ext-webaccounts webaccounts-extension-common xul-ext-websites-integration gnome-control-center gnome-session
sudo apt-get --force-yes --yes purge compiz compiz-gnome compiz-plugins-default libcompizconfig0
sudo apt-get --force-yes --yes purge nautilus nautilus-sendto nautilus-sendto-empathy nautilus-share
zeitgeist-daemon --quit && sudo apt-get --force-yes --yes purge activity-log-manager-common python-zeitgeist rhythmbox-plugin-zeitgeist zeitgeist zeitgeist-core zeitgeist-datahub

exit 0
