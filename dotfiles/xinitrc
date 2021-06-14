#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
[ -d ~/.Xresources.d ] && ( rm -f ~/.Xresources && while read i; do echo "#include \"$i\"" >> ~/.Xresources ; done < <(find ~/.Xresources.d -name '*.Xresources') && xrdb -merge ~/.Xresources) 
[ -d ~/.i3.d ] && ( mkdir -p ~/.config/regolith/i3 && rm -f ~/.config/regolith/i3/config && while read i; do cat $i >> ~/.config/regolith/i3/config ; done < <(find ~/.i3.d -name '*.i3')) 
# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export SSH_AUTH_SOCK
export $(dbus-launch)
exec regolith-session
