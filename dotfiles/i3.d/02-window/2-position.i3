
## Modify // Window Position // <><Shift> ↑ ↓ ← → ##
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

## Modify // Window Position // <><Shift> k j h l ##
set_from_resource $i3-wm.binding.move_left i3-wm.binding.move_left Shift+h
set_from_resource $i3-wm.binding.move_right i3-wm.binding.move_right Shift+l
set_from_resource $i3-wm.binding.move_up i3-wm.binding.move_up Shift+k
set_from_resource $i3-wm.binding.move_down i3-wm.binding.move_down Shift+j
bindsym $mod+$i3-wm.binding.move_left move left
bindsym $mod+$i3-wm.binding.move_down move down
bindsym $mod+$i3-wm.binding.move_up move up
bindsym $mod+$i3-wm.binding.move_right move right