
## Modify // Vertical Window Orientation // <> v ##
set_from_resource $i3-wm.binding.split_v i3-wm.binding.split_v v
bindsym $mod+$i3-wm.binding.split_v split vertical

## Modify // Horizontal Window Orientation // <> g ##
set_from_resource $i3-wm.binding.split_h i3-wm.binding.split_h g
bindsym $mod+$i3-wm.binding.split_h split horizontal

## Modify // Toggle Window Orientation // <> Backspace ##
set_from_resource $i3-wm.binding.orientation_toggle i3-wm.binding.orientation_toggle BackSpace
bindsym $mod+$i3-wm.binding.orientation_toggle split toggle
