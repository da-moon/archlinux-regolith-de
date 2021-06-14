
###############################################################################
# Workspace Management
###############################################################################

# i3-snapshot for load/save current layout
## Modify // Save Window Layout // <> , ##
set_from_resource $i3-wm.binding.save_layout i3-wm.binding.save_layout comma
bindsym $mod+$i3-wm.binding.save_layout  exec /usr/bin/i3-snapshot -o > /tmp/i3-snapshot
## Modify // Load Window Layout // <> . ##
set_from_resource $i3-wm.binding.load_layout i3-wm.binding.load_layout period
bindsym $mod+$i3-wm.binding.load_layout exec /usr/bin/i3-snapshot -c < /tmp/i3-snapshot

# Toggle bar visibility
## Modify // Toggle Bar // <> i ##
set_from_resource $i3-wm.binding.bar_toggle i3-wm.binding.bar_toggle i
bindsym $mod+$i3-wm.binding.bar_toggle bar mode toggle

# Cause Settings app to float above tiled windows
floating_maximum_size -1 x -1
for_window [class="floating_window"] floating enable

set_from_resource $i3-wm.workspace.auto_back_and_forth i3-wm.workspace.auto_back_and_forth no
workspace_auto_back_and_forth $i3-wm.workspace.auto_back_and_forth
