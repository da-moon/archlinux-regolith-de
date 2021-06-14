
###############################################################################
# Launcher dialogs
###############################################################################

## Launch // Terminal // <> Enter ##

set_from_resource $i3-wm.binding.terminal i3-wm.binding.terminal Return

bindsym $mod+$i3-wm.binding.terminal exec $i3-wm.program.terminal


## Launch // Browser // <><Shift> Enter ##
set_from_resource $i3-wm.binding.browser i3-wm.binding.browser Shift+Return
bindsym $mod+$i3-wm.binding.browser exec gtk-launch $(xdg-settings get default-web-browser)
set_from_resource $rofiTheme rofi.theme /etc/regolith/styles/lascaille/rofi.rasi

## Launch // Application // <> Space ##
set_from_resource $i3-wm.binding.launcher.app i3-wm.binding.launcher.app space
bindsym $mod+$i3-wm.binding.launcher.app exec $i3-wm.program.launcher.app

## Launch // Command // <><Shift> Space ##
set_from_resource $i3-wm.binding.launcher.cmd i3-wm.binding.launcher.cmd Shift+space
bindsym $mod+$i3-wm.binding.launcher.cmd exec $i3-wm.program.launcher.cmd

## Navigate // Window by Name // <><Ctrl> Space ##
set_from_resource $i3-wm.binding.launcher.window i3-wm.binding.launcher.window Ctrl+space

bindsym $mod+$i3-wm.binding.launcher.window exec $i3-wm.program.launcher.window

## Launch // This Dialog // <><Shift> ? ##
set_from_resource $i3-wm.binding.help i3-wm.binding.help Shift+question
bindsym $mod+$i3-wm.binding.help exec --no-startup-id $i3-wm.program.help

## Launch // File Search // <><Alt> Space ##
set_from_resource $i3-wm.binding.file_search i3-wm.binding.file_search Mod1+space
bindsym $mod+$i3-wm.binding.file_search exec $i3-wm.program.file_search

## Launch // Look Selector // <><Alt> l ##
set_from_resource $i3-wm.binding.look_selector i3-wm.binding.look_selector Mod1+l
bindsym $mod+$i3-wm.binding.look_selector exec $i3-wm.program.look_selector
