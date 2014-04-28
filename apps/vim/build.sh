#!/bin/sh

[ X$BUILDDIR = X ] && { echo "Wrong invocation from this script. Abort!!!"; exit 1; }

curdir=$(dirname $(readlink -f $0))
 
[ -d $HOME/.vim/bundle/.git ] || git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
[ -d $HOME/.vim/respository/ShowMarks/.git ] || git clone https://github.com/bootleq/ShowMarks.git $HOME/.vim/respository/ShowMarks 
[ -d $HOME/.vim/respository/vim-cycle/.git ] || git clone https://github.com/bootleq/vim-cycle.git $HOME/.vim/respository/vim-cycle
[ -d $HOME/.vim/respository/vim-ref-bingzh/.git ] || git clone https://github.com/bootleq/vim-ref-bingzh.git $HOME/.vim/respository/vim-ref-bingzh
[ -d $HOME/.vim/respository/LargeFile/.git ] || git clone https://github.com/bootleq/LargeFile.git $HOME/.vim/respository/LargeFile

[ -f $HOME/.vimrc ] || cp $BUILDDIR/templates/vim/vimrc $HOME/.vimrc

[ -z $(which git) ] && sudo apt-get install --force-yes --yes git
[ -z $(which vim) ] && sudo apt-get install --force-yes --yes vim 
[ -z $(which ctags) ] && sudo apt-get install --force-yes --yes exuberant-ctags
[ -z $(which cscope) ] && sudo apt-get install --force-yes --yes cscope

exit 0
