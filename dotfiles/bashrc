#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"
[ -d ~/.env.d ] && while read i; do source "$i" ; done < <(find ~/.env.d/ -name '*.sh')
[ -d ~/.alias.d ] && while read i; do source "$i" ; done < <(find ~/.alias.d/ -name '*.sh')
[ -d ~/.Xresources.d ] && ( rm -f ~/.Xresources && while read i; do echo "#include \"$i\"" >> ~/.Xresources ; done < <(find ~/.Xresources.d -name '*.Xresources') && xrdb -merge ~/.Xresources) 
[ -d ~/.i3.d ] && ( mkdir -p ~/.config/regolith/i3 && rm -f ~/.config/regolith/i3/config && while read i; do cat $i >> ~/.config/regolith/i3/config ; done < <(find ~/.i3.d -name '*.i3')) 
