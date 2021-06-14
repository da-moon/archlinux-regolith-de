
###############################################################################
# i3 Bar
###############################################################################

# Create variables from Xresources for i3bars's look.
set_from_resource $i3-wm.bar.background.color i3-wm.bar.background.color "#002b36"
set_from_resource $i3-wm.bar.statusline.color i3-wm.bar.statusline.color "#93a1a1"
set_from_resource $i3-wm.bar.separator.color i3-wm.bar.separator.color "#268bd2"

set_from_resource $i3-wm.bar.workspace.focused.border.color i3-wm.bar.workspace.focused.border.color "#073642"
set_from_resource $i3-wm.bar.workspace.focused.background.color i3-wm.bar.workspace.focused.background.color "#073642"
set_from_resource $i3-wm.bar.workspace.focused.text.color i3-wm.bar.workspace.focused.text.color "#eee8d5"

set_from_resource $i3-wm.bar.workspace.active.border.color i3-wm.bar.workspace.active.border.color "#073642"
set_from_resource $i3-wm.bar.workspace.active.background.color i3-wm.bar.workspace.active.background.color "#073642"
set_from_resource $i3-wm.bar.workspace.active.text.color i3-wm.bar.workspace.active.text.color "#586e75"

set_from_resource $i3-wm.bar.workspace.inactive.border.color i3-wm.bar.workspace.inactive.border.color "#002b36"
set_from_resource $i3-wm.bar.workspace.inactive.background.color i3-wm.bar.workspace.inactive.background.color "#002b36"
set_from_resource $i3-wm.bar.workspace.inactive.text.color i3-wm.bar.workspace.inactive.text.color "#586e75"

set_from_resource $i3-wm.bar.workspace.urgent.border.color i3-wm.bar.workspace.urgent.border.color "#dc322f"
set_from_resource $i3-wm.bar.workspace.urgent.background.color i3-wm.bar.workspace.urgent.background.color "#dc322f"
set_from_resource $i3-wm.bar.workspace.urgent.text.color i3-wm.bar.workspace.urgent.text.color "#fdf6e3"


#set_from_resource $i3-wm.bar.position i3-wm.bar.position bottom
set_from_resource $i3-wm.bar.font i3-wm.bar.font pango:Source Code Pro Medium 13, Material Design Icons 13
# set_from_resource $i3-wm.bar.separator i3-wm.bar.separator " "
set_from_resource $i3-wm.bar.separator i3-wm.bar.separator ":|:"
set_from_resource $i3-wm.bar.trayoutput i3-wm.bar.trayoutput primary
set_from_resource $i3-wm.bar.stripworkspacenumbers i3-wm.bar.stripworkspacenumbers yes
set_from_resource $i3-wm.bar.mode i3-wm.bar.mode dock

# i3xrocks config file. Override this for a custom status bar generator.
# -d /etc/regolith/i3xrocks/conf.d
set_from_resource $i3-wm.bar.top_status_command i3-wm.bar.top_status_command i3xrocks -vvv -u ~/.config/regolith/i3xrocks/conf.d/top | tee /tmp/i3xrocks-top.log
set_from_resource $i3-wm.bar.bottom_status_command i3-wm.bar.bottom_status_command i3xrocks -vvv -u ~/.config/regolith/i3xrocks/conf.d/bottom  | tee /tmp/i3xrocks-bottom.log

# The bar configuration
bar {
  position top
  mode $i3-wm.bar.mode
  font $i3-wm.bar.font
  separator_symbol $i3-wm.bar.separator
  status_command $i3-wm.bar.top_status_command
  tray_output $i3-wm.bar.trayoutput
  workspace_buttons no
  strip_workspace_numbers $i3-wm.bar.stripworkspacenumbers
  # output HDMI2
  # output DP2
  colors {
      background $i3-wm.bar.background.color
      statusline $i3-wm.bar.statusline.color
      separator  $i3-wm.bar.separator.color
      focused_workspace  $i3-wm.bar.workspace.focused.border.color      $i3-wm.bar.workspace.focused.background.color   $i3-wm.bar.workspace.focused.text.color
      active_workspace   $i3-wm.bar.workspace.active.border.color       $i3-wm.bar.workspace.active.background.color    $i3-wm.bar.workspace.active.text.color
      inactive_workspace $i3-wm.bar.workspace.inactive.border.color     $i3-wm.bar.workspace.inactive.background.color  $i3-wm.bar.workspace.inactive.text.color
      urgent_workspace   $i3-wm.bar.workspace.urgent.border.color       $i3-wm.bar.workspace.urgent.background.color    $i3-wm.bar.workspace.urgent.text.color
  }
}
bar {
  position bottom
  mode $i3-wm.bar.mode
  font $i3-wm.bar.font
  separator_symbol $i3-wm.bar.separator
  status_command $i3-wm.bar.bottom_status_command
  strip_workspace_numbers yes
  colors {
      background $i3-wm.bar.background.color
      statusline $i3-wm.bar.statusline.color
      separator  $i3-wm.bar.separator.color
      focused_workspace  $i3-wm.bar.workspace.focused.border.color      $i3-wm.bar.workspace.focused.background.color   $i3-wm.bar.workspace.focused.text.color
      active_workspace   $i3-wm.bar.workspace.active.border.color       $i3-wm.bar.workspace.active.background.color    $i3-wm.bar.workspace.active.text.color
      inactive_workspace $i3-wm.bar.workspace.inactive.border.color     $i3-wm.bar.workspace.inactive.background.color  $i3-wm.bar.workspace.inactive.text.color
      urgent_workspace   $i3-wm.bar.workspace.urgent.border.color       $i3-wm.bar.workspace.urgent.background.color    $i3-wm.bar.workspace.urgent.text.color
  }
}