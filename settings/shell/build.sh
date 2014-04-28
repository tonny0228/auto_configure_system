#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))

[ -z $(which git) ] && sudo apt-get install --force-yes --yes git

[ -d $HOME/.fonts/.git ] || { git clone https://gist.github.com/1695735.git $HOME/.fonts && fc-cache $HOME/.fonts; }
[ -d $HOME/.config/shell/.git ] || { git clone https://github.com/milkbikis/powerline-shell.git $HOME/.config/shell && cd $HOME/.config/shell && python $HOME/.config/shell/install.py && cd -; }

[ -f $curdir/bashrc ] || { sed "s%#WORKSPACE#%$(readlink -f $BUILDDIR/../)%" $BUILDDIR/templates/shell/bashrc > $curdir/bashrc && sed -i "s%#USERNAME#%$(echo $USER | sed 's/\b[a-z]/\U&/g')%" $curdir/bashrc; }

[ -f $HOME/.config/shell/bash_functions ] || cp $BUILDDIR/templates/shell/bash_functions $HOME/.config/shell/
[ -f $HOME/.config/shell/bashrc ] || mv $curdir/bashrc $HOME/.config/shell/
[ -f $HOME/.bash_aliases ] || cp $BUILDDIR/templates/shell/bash_aliases $HOME/.bash_aliases

grep "^    . $HOME/.config/shell/bash_functions" $HOME/.bashrc || echo "\n# User-defined function\nif [ -f $HOME/.config/shell/bash_functions ]; then\n    . $HOME/.config/shell/bash_functions\nfi" >> $HOME/.bashrc
grep "^    . $HOME/.config/shell/bashrc$" $HOME/.bashrc || echo "\n# User-defined bashrc\nif [ -f $HOME/.config/shell/bashrc ]; then\n    . $HOME/.config/shell/bashrc\nfi" >> $HOME/.bashrc

grep "clear" $HOME/.profile || echo "clear" >> $HOME/.profile

exit 0
