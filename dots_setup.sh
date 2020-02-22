#!/bin/bash -i

### bashrc should already exist, and likely has specifics we don't want to lose.
### running the echo commands below to append to bashrc instead!
### if bashrc doesn't exist, uncomment the curl to pull yours


cp ~/.bashrc ~/.bashrc.orig

# curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.bashrc
curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.tmux.conf
curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.vimrc

# Create dirs for custom Vim colorscheme
mkdir ~/.vim/
mkdir ~/.vim/colors/
# be sure to name the file the same as what's specified in your vimrc
curl -o ~/.vim/colors/vim.nord https://raw.githubusercontent.com/arcticicestudio/nord-vim/develop/colors/nord.vim


echo 'alias e="exit"' >>~/.bashrc
echo 'alias c="clear"' >>~/.bashrc
echo 'alias ..="cd ../"' >>~/.bashrc
echo 'alias ...="cd ../../"' >>~/.bashrc
echo 'set -o vi' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

# Force reload of bashrc
exec bash

exit
