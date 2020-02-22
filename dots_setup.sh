#!/bin/bash -i

curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.tmux.conf
curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.vimrc
# curl -O https://raw.githubusercontent.com/wmconnolly/cka-dots/master/.bashrc


### bashrc should already exist, and likely has specifics we don't want to lose.
### running the echo commands below to append to bashrc instead!

echo 'alias e="exit"' >>~/.bashrc
echo 'alias c="clear"' >>~/.bashrc
echo 'alias ..="cd ../"' >>~/.bashrc
echo 'alias ...="cd ../../"' >>~/.bashrc
echo 'set -o vi' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

source ~/.bashrc

exit
