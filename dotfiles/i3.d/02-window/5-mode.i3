
## Modify // Window Layout Mode // <> t ##
set_from_resource $i3-wm.binding.layout_mode i3-wm.binding.layout_mode t
bindsym $mod+$i3-wm.binding.layout_mode layout toggle tabbed splith splitv

## Modify // Window Fullscreen Toggle // <> f ##
set_from_resource $i3-wm.binding.fullscreen_toggle i3-wm.binding.fullscreen_toggle f
bindsym $mod+$i3-wm.binding.fullscreen_toggle fullscreen toggle

## Modify // Window Floating Toggle // <><Shift> f ##
set_from_resource $i3-wm.binding.float_toggle i3-wm.binding.float_toggle Shift+f
bindsym $mod+Shift+$i3-wm.binding.float_toggle floating toggle

## Modify // Tile/Float Focus Toggle // <><Shift> t ##
set_from_resource $i3-wm.binding.focus_toggle i3-wm.binding.focus_toggle Shift+t
bindsym $mod+$i3-wm.binding.focus_toggle focus mode_toggle