#!/usr/bin/env bash
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
autocutsel -fork
autocutsel -selection PRIMARY -fork
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
   --expand true --width 5 --transparent true --tint 0x002b36 --height 12 &
xsetroot -solid "#002b36"
exec xmonad
