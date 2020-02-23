#!/bin/bash

# Set script defaults below, otherwise replaced via flags
domain="https://raw.githubusercontent.com"
uname="wmconnolly"
repo="dots"
brch="master"

# Effective bools to flag which dotfiles to curl
brc=""
vrc=""
tco=""

while getopts "d:k:u:r:btv" opt; do
	case $opt in
		d)
			domain=$OPTARG
			;;
		k)
			brch=$OPTARG
			;;
		u)
			uname=$OPTARG
			;;
		r)
			repo=$OPTARG
			;;
		b)
			brc="true"
			;;
		t)
			tco="true"
			;;
		v)
			vrc="true"
			;;
	esac
done
shift $((OPTIND -1))

username="$uname"
repository="$repo"
branch="$brch"
base_url="$domain"/"$username"/"$repository"/"$branch""/"

if [[ "$brc" == "true"  ]]; then
	if [[ -f ~/.bashrc ]] ; then
		cp ~/.bashrc ~/.bashrc.orig
		echo 'alias e="exit"' >>~/.bashrc
		echo 'alias c="clear"' >>~/.bashrc
		echo 'alias ..="cd ../"' >>~/.bashrc
		echo 'alias ...="cd ../../"' >>~/.bashrc
		echo 'set -o vi' >>~/.bashrc
		echo 'alias k=kubectl' >>~/.bashrc
		echo 'source <(kubectl completion bash)' >>~/.bashrc
		echo 'complete -F __start_kubectl k' >>~/.bashrc
	else
		curl -o ~/.bashrc $base_url".bashrc"
	fi
	# Force reload of bash
	exec bash
fi

if [[ "$tco" == "true"  ]]; then
	if [[ -f ~/.tmux.conf ]]; then
		cp ~/.tmux.conf ~/.tmux.conf.orig
	fi
	curl -o ~/.tmux.conf $base_url".tmux.conf"
fi

if [[ "$vrc" == "true"  ]]; then
	if [[ -f ~/.vimrc ]]; then
		cp ~/.vimrc ~/.vimrc.orig
	fi
	curl -o ~/.vimrc $base_url".vimrc"
	# Create dirs for custom Vim colorscheme
	# Note: colorscheme is hardcoded
	mkdir ~/.vim/
	mkdir ~/.vim/colors/
	curl -o ~/.vim/colors/nord.vim \
		https://raw.githubusercontent.com/arcticicestudio/nord-vim/develop/colors/nord.vim
fi

exit 0
