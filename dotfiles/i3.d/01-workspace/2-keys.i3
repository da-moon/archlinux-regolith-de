###############################################################################
# Workspace Keys
# These are the keys which will be used while binding workspace switching
###############################################################################
# -----------------------------------------------------------
# exec --no-startup-id                                          geary
# for_window [class="Geary" window_type="normal"]               move scratchpad
# bindsym $mod+m               [class="Geary"] scratchpad show, resize set 1200 700, move position center
# -----------------------------------------------------------
set_from_resource $ws1_key  i3-wm.workspace.01.key 1
set_from_resource $ws1  i3-wm.workspace.01.name "1"
# set $ws1 ""
assign [class="(?i)Alacritty"] $ws1
for_window [class=(?i)Alacritty] focus
assign [class="(?i)St"] $ws1
for_window [class=(?i)St] focus

workspace 1 output eDP-1
set_from_resource $ws2  i3-wm.workspace.02.name "2"
set_from_resource $ws2_key  i3-wm.workspace.02.key 2
# set $ws2 ""
assign [class="(?i)brave"] $ws2
for_window [class=(?i)brave] focus
workspace 2 output DP-1
# ----------------------------------------------------------------------------
set_from_resource $ws3  i3-wm.workspace.03.name "3"
set_from_resource $ws3_key  i3-wm.workspace.03.key 3
# set $ws3 ""
assign [class="Code"] $ws3
for_window [class=Code] focus
workspace 3 output eDP-1
# exec --no-startup-id                                          code
# for_window [class="Code" window_type="normal"]               move scratchpad
# bindsym $mod+m               [class="Code"] scratchpad show, resize set 1200 700, move position center


# ----------------------------------------------------------------------------
set_from_resource $ws4  i3-wm.workspace.04.name "4"
set_from_resource $ws4_key  i3-wm.workspace.04.key 4
# set $ws4 ""
assign [class="Notable"] $ws4
for_window [class=Notable] focus
workspace 4 output eDP-1
# ----------------------------------------------------------------------------
set_from_resource $ws5  i3-wm.workspace.05.name "5"
set_from_resource $ws5_key  i3-wm.workspace.05.key 5
# set $ws5 ""
assign [class="(?i)TelegramDesktop"] $ws5
for_window [class=(?i)TelegramDesktop] focus
workspace 5 output eDP-1
# ----------------------------------------------------------------------------
set_from_resource $ws6  i3-wm.workspace.06.name "6"
set_from_resource $ws6_key  i3-wm.workspace.06.key 6
assign [class="(?i)Slack"] $ws6
for_window [class=(?i)Slack] focus
# workspace 6 output DP-1
# ----------------------------------------------------------------------------
set_from_resource $ws7  i3-wm.workspace.07.name "7"
set_from_resource $ws7_key  i3-wm.workspace.07.key 7
# set $ws7 ""
assign [class="(?i)hiri"] $ws7
for_window [class=(?i)hiri] focus
workspace 7 output DP-1
# ----------------------------------------------------------------------------
set_from_resource $ws8  i3-wm.workspace.08.name "8"
set_from_resource $ws8_key  i3-wm.workspace.08.key 8
# set $ws8 ""
assign [class="(?i)Firefox"] $ws8
for_window [class=(?i)Firefox] focus
workspace 8 output DP-1
# ----------------------------------------------------------------------------
set_from_resource $ws9  i3-wm.workspace.09.name "9"
set_from_resource $ws9_key  i3-wm.workspace.09.key 9
assign [class="(?i)zoom"] $ws9
for_window [class=(?i)zoom] focus
workspace 9 output DP-1
# ----------------------------------------------------------------------------
set_from_resource $ws10 i3-wm.workspace.10.name "10"
set_from_resource $ws10_key i3-wm.workspace.10.key 0
assign [class="(?i)Vpnui"] $ws10
for_window [class=(?i)Vpnui] focus
workspace 10 output DP-1