#!/usr/bin/env bash
stty -ixon # Disable ctrl-s and ctrl-q.

HISTSIZE=
HISTFILESIZE= 
# Infinite history.


[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# export PASSWORD_STORE_GPG_OPTS="--pinentry-mode loopback --passphrase YOUR_PASSPHRASE"

