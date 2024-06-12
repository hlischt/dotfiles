#!/bin/sh
# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
# . /etc/X11/Xsession

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

my_wm=i3

if command -v "$my_wm" > /dev/null
then
	exec "$my_wm"
else
	>&2 printf 'Error: Preferred window manager (%s) not found\n' "$my_wm"
fi
