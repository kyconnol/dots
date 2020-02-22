#!/bin/bash -i

github_username="$2"/""
github_repo+="$3"/""
github_url="https://raw.githubusercontent.com/"
master="master/"
base_url="$github_url$github_username$github_repo$master"

# Note: the Vim colorscheme is hardcoded
while getopts "btv" opt; do
	case $opt in
		b)
			curl -o ~/.bashrc $base_url".bashrc"
			;;
		t)
			curl -o ~/.tmux.conf $base_url".tmux.conf"
			;;
		v)
			curl -o ~/.vimrc $base_url".vimrc"
			# Create dirs for custom Vim colorscheme
			mkdir ~/.vim/
			mkdir ~/.vim/colors/
			curl -o ~/.vim/colors/nord.vim \
				https://raw.githubusercontent.com/arcticicestudio/nord-vim/develop/colors/nord.vim
			;;
	esac
done

### bashrc should already exist, and likely has specifics we don't want to lose.
### running the echo commands below to append to bashrc instead!
### if bashrc doesn't exist, use the `b` flag option

cp ~/.bashrc ~/.bashrc.orig

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
