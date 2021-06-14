
## Modify // Move to Scratchpad // <><Ctrl> m ##
set_from_resource $i3-wm.binding.move_scratchpad i3-wm.binding.move_scratchpad Ctrl+m
bindsym $mod+$i3-wm.binding.move_scratchpad move to scratchpad

## Modify // Move Window to Workspace 1 - 10 // <><Shift> 0..9 ##
bindsym $mod+Shift+$ws1_key move container to workspace number $ws1
bindsym $mod+Shift+$ws2_key move container to workspace number $ws2
bindsym $mod+Shift+$ws3_key move container to workspace number $ws3
bindsym $mod+Shift+$ws4_key move container to workspace number $ws4
bindsym $mod+Shift+$ws5_key move container to workspace number $ws5
bindsym $mod+Shift+$ws6_key move container to workspace number $ws6
bindsym $mod+Shift+$ws7_key move container to workspace number $ws7
bindsym $mod+Shift+$ws8_key move container to workspace number $ws8
bindsym $mod+Shift+$ws9_key move container to workspace number $ws9
bindsym $mod+Shift+$ws10_key move container to workspace number $ws10

## Modify // Move Window to Workspace 11 - 19// <><Ctrl><Shift> 1..9 ##
bindsym $mod+Shift+Ctrl+$ws1_key move container to workspace number $ws11
bindsym $mod+Shift+Ctrl+$ws2_key move container to workspace number $ws12
bindsym $mod+Shift+Ctrl+$ws3_key move container to workspace number $ws13
bindsym $mod+Shift+Ctrl+$ws4_key move container to workspace number $ws14
bindsym $mod+Shift+Ctrl+$ws5_key move container to workspace number $ws15
bindsym $mod+Shift+Ctrl+$ws6_key move container to workspace number $ws16
bindsym $mod+Shift+Ctrl+$ws7_key move container to workspace number $ws17
bindsym $mod+Shift+Ctrl+$ws8_key move container to workspace number $ws18
bindsym $mod+Shift+Ctrl+$ws9_key move container to workspace number $ws19


# move focused container to workspace, move to workspace
## Modify // Carry Window to Workspace 1 - 10// <><Alt> 0..9 ##
bindsym $mod+$alt+$ws1_key move container to workspace number $ws1; workspace number $ws1
bindsym $mod+$alt+$ws2_key move container to workspace number $ws2; workspace number $ws2
bindsym $mod+$alt+$ws3_key move container to workspace number $ws3; workspace number $ws3
bindsym $mod+$alt+$ws4_key move container to workspace number $ws4; workspace number $ws4
bindsym $mod+$alt+$ws5_key move container to workspace number $ws5; workspace number $ws5
bindsym $mod+$alt+$ws6_key move container to workspace number $ws6; workspace number $ws6
bindsym $mod+$alt+$ws7_key move container to workspace number $ws7; workspace number $ws7
bindsym $mod+$alt+$ws8_key move container to workspace number $ws8; workspace number $ws8
bindsym $mod+$alt+$ws9_key move container to workspace number $ws9; workspace number $ws9
bindsym $mod+$alt+$ws10_key move container to workspace number $ws10; workspace number $ws10

## Modify // Carry Window to Workspace 11 - 19 // <><Alt><Ctrl> 1..9 ##
bindsym $mod+$alt+Ctrl+$ws1_key move container to workspace number $ws11; workspace number $ws11
bindsym $mod+$alt+Ctrl+$ws2_key move container to workspace number $ws12; workspace number $ws12
bindsym $mod+$alt+Ctrl+$ws3_key move container to workspace number $ws13; workspace number $ws13
bindsym $mod+$alt+Ctrl+$ws4_key move container to workspace number $ws14; workspace number $ws14
bindsym $mod+$alt+Ctrl+$ws5_key move container to workspace number $ws15; workspace number $ws15
bindsym $mod+$alt+Ctrl+$ws6_key move container to workspace number $ws16; workspace number $ws16
bindsym $mod+$alt+Ctrl+$ws7_key move container to workspace number $ws17; workspace number $ws17
bindsym $mod+$alt+Ctrl+$ws8_key move container to workspace number $ws18; workspace number $ws18
bindsym $mod+$alt+Ctrl+$ws9_key move container to workspace number $ws19; workspace number $ws19


## Modify // Move Window to Next Free Workspace // <><Shift> ` ##
set_from_resource $i3-wm.binding.move_next_free i3-wm.binding.move_next_free Shift+grave
bindsym $mod+$i3-wm.binding.move_next_free exec --no-startup-id /usr/bin/i3-next-workspace --move-window

## Modify // Carry Window to Next Free Workspace // <><Alt> ` ##
set_from_resource $i3-wm.binding.take_next_free i3-wm.binding.take_next_free Mod1+grave
bindsym $mod+$i3-wm.binding.take_next_free exec --no-startup-id /usr/bin/i3-next-workspace --move-window-and-follow
