###############################################################################
# programs
###############################################################################
set_from_resource $i3-wm.program.terminal $i3-wm.program.terminal /usr/bin/alacritty
set_from_resource $i3-wm.program.launcher.app i3-wm.program.launcher.app rofi -show drun -theme $rofiTheme
set_from_resource $i3-wm.program.launcher.cmd i3-wm.program.launcher.cmd rofi -show run -theme $rofiTheme
set_from_resource $i3-wm.program.launcher.window i3-wm.program.launcher.window rofi -show window -theme $rofiTheme
set_from_resource $i3-wm.program.help i3-wm.program.help /usr/bin/remontoire-toggle
set_from_resource $i3-wm.program.file_search i3-wm.program.file_search rofi -show find -modi find:/usr/share/rofi/modi/finder.sh
set_from_resource $i3-wm.program.look_selector i3-wm.program.look_selector rofi -show look -modi look:/usr/share/rofi/modi/look-selector.sh
set_from_resource $i3-wm.program.files i3-wm.program.files /usr/bin/nautilus --new-window
set_from_resource $i3-wm.program.notification_ui i3-wm.program.notification_ui /usr/bin/rofication-gui
# Start Rofication for notifications
set_from_resource $i3-wm.program.notifications i3-wm.program.notifications /usr/bin/rofication-daemon
#set_from_resource $i3-wm.program.notifications i3-wm.program.notifications /usr/bin/dunst