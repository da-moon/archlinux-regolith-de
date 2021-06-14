###############################################################################
# Session Management
###############################################################################

## Session // Exit App // <><Shift> q ##
set_from_resource $i3-wm.binding.exit_app i3-wm.binding.exit_app Shift+q
bindsym $mod+$i3-wm.binding.exit_app [con_id="__focused__"] kill

## Session // Terminate App // <><Alt> q ##
set_from_resource $i3-wm.binding.kill_app i3-wm.binding.kill_app Mod1+q
bindsym $mod+$i3-wm.binding.kill_app [con_id="__focused__"] exec --no-startup-id kill -9 $(xdotool getwindowfocus getwindowpid)

## Session // Reload i3 Config // <><Shift> c ##
set_from_resource $i3-wm.binding.reload i3-wm.binding.reload Shift+c
bindsym $mod+$i3-wm.binding.reload reload

## Session // Refresh Session // <><Shift> r ##
set_from_resource $i3-wm.binding.refresh i3-wm.binding.refresh Shift+r
set_from_resource $i3-wm.program.refresh_ui i3-wm.program.refresh_ui /usr/bin/regolith-look refresh
bindsym $mod+$i3-wm.binding.refresh exec --no-startup-id $i3-wm.program.refresh_ui