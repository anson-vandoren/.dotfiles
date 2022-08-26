export PATH=$PATH:/usr/local/go/bin

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Added by Toolbox App
export PATH="$PATH:/home/anson/.local/share/JetBrains/Toolbox/scripts"

if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  QT_QPA_PLATFORM=wayland
  QT_WAYLAND_FORCE_DPI=physical
  QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  _JAVA_AWT_WM_NONREPARENTING=1
  exec sway
fi
