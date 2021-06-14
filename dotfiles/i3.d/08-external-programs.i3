
###############################################################################
# External programs launched with i3
###############################################################################

# Start the installed regolith-compositor
set_from_resource $i3-wm.program.compositor i3-wm.program.compositor /usr/share/regolith-compositor/init
exec_always --no-startup-id $i3-wm.program.compositor

exec --no-startup-id $i3-wm.program.notifications

# Launch first time user experience script
set_from_resource $i3-wm.program.ftui i3-wm.program.ftui /usr/bin/regolith-ftue
exec --no-startup-id $i3-wm.program.ftui

# Hide the mouse pointer if unused for a duration
set_from_resource $i3-wm.program.unclutter i3-wm.program.unclutter /usr/bin/unclutter -b
exec --no-startup-id $i3-wm.program.unclutter

# Load nm-applet to provide auth dialogs for network access
set_from_resource $i3-wm.program.nm-applet i3-wm.program.nm-applet /usr/bin/nm-applet
exec --no-startup-id $i3-wm.program.nm-applet

#set_from_resource $i3-wm.program.slack i3-wm.program.slack /snap/bin/slack
#exec --no-startup-id $i3-wm.program.slack
#for_window [class="(?i)Slack" window_type="normal"] move scratchpad
#bindsym $mod+shift+s [class="(?i)Slack"] scratchpad show, resize set 1200 700, move position center

# User programs from Xresources
# To use, define an Xresource key i3-wm.program.[1-3] with the value of the program to launch.
# See https://regolith-linux.org/docs/howto/override-xres/ for details.
set_from_resource $i3-wm.program.1 i3-wm.program.1 :
exec --no-startup-id $i3-wm.program.1
set_from_resource $i3-wm.program.2 i3-wm.program.2 :
exec --no-startup-id $i3-wm.program.2
set_from_resource $i3-wm.program.3 i3-wm.program.3 :
exec --no-startup-id $i3-wm.program.3
