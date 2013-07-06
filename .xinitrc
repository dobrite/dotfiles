#!/usr/bin/env bash
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
autocutsel -fork
exec xmonad
