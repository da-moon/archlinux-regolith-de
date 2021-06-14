
###############################################################################
# i3 Colors and Fonts
###############################################################################

# Create variables from Xresources for i3's look.
set_from_resource $focused.color.border i3-wm.client.focused.color.border "#002b36"
set_from_resource $focused.color.background i3-wm.client.focused.color.background "#586e75"
set_from_resource $focused.color.text i3-wm.client.focused.color.text "#fdf6e3"
set_from_resource $focused.color.indicator i3-wm.client.focused.color.indicator "#268bd2"
set_from_resource $focused.color.child_border i3-wm.client.focused.color.child_border

set_from_resource $focused_inactive.color.border i3-wm.client.focused_inactive.color.border "#002b36"
set_from_resource $focused_inactive.color.background i3-wm.client.focused_inactive.color.background "#073642"
set_from_resource $focused_inactive.color.text i3-wm.client.focused_inactive.color.text "#839496"
set_from_resource $focused_inactive.color.indicator i3-wm.client.focused_inactive.color.indicator "#073642"
set_from_resource $focused_inactive.color.child_border i3-wm.client.focused_inactive.color.child_border

set_from_resource $unfocused.color.border i3-wm.client.unfocused.color.border "#002b36"
set_from_resource $unfocused.color.background i3-wm.client.unfocused.color.background "#073642"
set_from_resource $unfocused.color.text i3-wm.client.unfocused.color.text "#839496"
set_from_resource $unfocused.color.indicator i3-wm.client.unfocused.color.indicator "#073642"
set_from_resource $unfocused.color.child_border i3-wm.client.unfocused.color.child_border

set_from_resource $urgent.color.border i3-wm.client.urgent.color.border "#002b36"
set_from_resource $urgent.color.background i3-wm.client.urgent.color.background "#dc322f"
set_from_resource $urgent.color.text i3-wm.client.urgent.color.text "#fdf6e3"
set_from_resource $urgent.color.indicator i3-wm.client.urgent.color.indicator "#002b36"
set_from_resource $urgent.color.child_border i3-wm.client.urgent.color.child_border

# Sets i3 font for dialogs
set_from_resource $i3-wm.font i3-wm.font pango:Source Code Pro Medium 13
font $i3-wm.font
