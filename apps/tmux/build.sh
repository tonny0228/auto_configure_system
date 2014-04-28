#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -z $(which git) ] && sudo apt-get install --force-yes --yes git
[ -z $(which tmux) ] && sudo apt-get install --force-yes --yes tmux

[ -d $HOME/.config/tmux/.git ] || git clone https://github.com/erikw/tmux-powerline.git $HOME/.config/tmux

grep "#now_playing" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("now_playing.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh
grep "#mailcount" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("mailcount.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh
grep "#weather" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("weather.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh
grep "#date_day" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("date_day.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh
grep "#pwd" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("pwd.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh
grep "#vcs" $HOME/.config/tmux/themes/default.sh || sed -i 's/\("vcs.*\)/#\1/g' $HOME/.config/tmux/themes/default.sh

[ -f $HOME/.tmux-powerlinerc ] || { $HOME/.config/tmux/generate_rc.sh && mv $HOME/.tmux-powerlinerc.default $HOME/.tmux-powerlinerc; }
[ -f $HOME/.tmux.conf ] || cp $BUILDDIR/templates/tmux/tmux.conf $HOME/.tmux.conf

exit 0
