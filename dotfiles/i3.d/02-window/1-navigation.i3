
###############################################################################
# Window Navigation
###############################################################################
## Navigate // Relative Parent // <> a ##/
set_from_resource $i3-wm.binding.focus_parent i3-wm.binding.focus_parent a
bindsym $mod+$i3-wm.binding.focus_parent focus parent

## Navigate // Relative Child // <> z ##/
set_from_resource $i3-wm.binding.focus_child i3-wm.binding.focus_child z
bindsym $mod+$i3-wm.binding.focus_child focus child

## Navigate // Relative Window // <> ↑ ↓ ← → ##
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

## Navigate // Relative Window // <> k j h l ##
set_from_resource $i3-wm.binding.left i3-wm.binding.left h
set_from_resource $i3-wm.binding.right i3-wm.binding.right l
set_from_resource $i3-wm.binding.up i3-wm.binding.up k
set_from_resource $i3-wm.binding.down i3-wm.binding.down j
bindsym $mod+$i3-wm.binding.left focus left
bindsym $mod+$i3-wm.binding.down focus down
bindsym $mod+$i3-wm.binding.up focus up
bindsym $mod+$i3-wm.binding.right focus right

## Navigate // Scratchpad // <><Ctrl> a ##
set_from_resource $i3-wm.binding.scratchpad i3-wm.binding.scratchpad Ctrl+a
bindsym $mod+$i3-wm.binding.scratchpad scratchpad show
