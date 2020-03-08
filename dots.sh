#!/usr/bin/env bash

# Set script defaults below, otherwise replaced via flags
domain="https://raw.githubusercontent.com"
uname="wmconnolly"
repo="dots"
branch="master"

# Effective bools to flag which dotfiles to curl
brc=""
pro=""
vrc=""
tco=""

while getopts "d:k:u:r:Abptv" opt; do
	case $opt in
		A)
			echo "Curling bashrc, vimrc, & tmux.conf dotfiles :)"
			brc="true"
			pro="true"
			tco="true"
			vrc="true"
			;;
		d)
			domain=$OPTARG
			;;
		k)
			branch=$OPTARG
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
		p)
			pro="true"
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

base_url="$domain"/"$uname"/"$repo"/"$branch""/"

# Curl specified dotfiles
if [[ "$tco" == "true"  ]]; then
	mkdir ~/.tmux
	curl -o ~/.tmux/kube.tmux \
		https://raw.githubusercontent.com/jonmosco/kube-tmux/master/kube.tmux
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

if [[ "$pro" == "true" ]]; then
	if [[ -f ~/.profile ]]; then
		cp ~/.profile ~/.profile.orig
		curl -o ~/.helpers $base_url".profile"
		chmod +x ~/.helpers
		cat ~/.helpers >>~/.profile
	else
		curl -o ~/.profile $base_url".profile"
	fi
fi

if [[ "$brc" == "true"  ]]; then
	# Binary for tldr
	mkdir -p ~/bin
	curl -o ~/bin/tldr \
		https://raw.githubusercontent.com/raylee/tldr/master/tldr
	chmod +x ~/bin/tldr
	# Binary for bat
	curl -o ~/bin/bat \
		https://raw.githubusercontent.com/wmconnolly/dots/master/bat
	chmod +x ~/bin/bat
	# Deal with .bashrc, whether it exists
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
		echo 'export PATH=$PATH:~/bin' >>~/.bashrc
	else
		curl -o ~/.bashrc $base_url".bashrc"
	fi
	# Force reload of bash / source .profile
	exec bash
	source ~/.profile
fi
exit 0
