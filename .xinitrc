#!/usr/bin/env sh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile" ] && . "${XDG_CONFIG_HOME:-$HOME/.config}/xprofile"

while true; do
  /usr/local/bin/dwm 2> /dev/null
done
