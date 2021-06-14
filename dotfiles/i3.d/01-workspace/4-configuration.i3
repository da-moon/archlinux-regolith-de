
###############################################################################
# Workspace Configuration
###############################################################################


## Modify // Containing Workspace // <><Ctrl><Shift> ↑ ↓ ← → ##
bindsym $mod+Ctrl+Shift+Left move workspace to output left
bindsym $mod+Ctrl+Shift+Down move workspace to output down
bindsym $mod+Ctrl+Shift+Up move workspace to output up
bindsym $mod+Ctrl+Shift+Right move workspace to output right

## Modify // Containing Workspace // <><Ctrl><Shift> k j h l ##
set_from_resource $i3-wm.binding.take_left i3-wm.binding.take_left Ctrl+Shift+h
set_from_resource $i3-wm.binding.take_right i3-wm.binding.take_right Ctrl+Shift+l
set_from_resource $i3-wm.binding.take_up i3-wm.binding.take_up Ctrl+Shift+k
set_from_resource $i3-wm.binding.take_down i3-wm.binding.take_down Ctrl+Shift+j
bindsym $mod+$i3-wm.binding.take_left move workspace to output left
bindsym $mod+$i3-wm.binding.take_down move workspace to output down
bindsym $mod+$i3-wm.binding.take_up move workspace to output up
bindsym $mod+$i3-wm.binding.take_right move workspace to output right
