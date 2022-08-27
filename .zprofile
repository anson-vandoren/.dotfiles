# Set needed path variables before launching sway
. ~/.paths

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  QT_QPA_PLATFORM=wayland
  QT_WAYLAND_FORCE_DPI=physical
  QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  _JAVA_AWT_WM_NONREPARENTING=1
  exec sway
fi
