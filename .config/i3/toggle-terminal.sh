#!/bin/sh

DROPDOWN_CLASS="quakitty"

_show_kitty() {
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] scratchpad show, [class=\"$DROPDOWN_CLASS\"] move window to position 3370 px 800 px, [class=\"$DROPDOWN_CLASS\"] resize set 1900px 800px"
  return $?
}

_hide_kitty() {
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] move scratchpad"
}

if xdotool search --limit 1 --class $DROPDOWN_CLASS 1>/dev/null 2>/dev/null; then
  if ! _show_kitty; then
    _hide_kitty
  fi
else
  kitty --config $HOME/.config/kitty/kitty-floating.conf --single-instance --class $DROPDOWN_CLASS 1>/dev/null 2>/dev/null &
  if [ "$1" = "--startup" ]; then
    # Wait until kitty window is ready
    xdotool search --sync --onlyvisible --class "$DROPDOWN_CLASS"
    _hide_kitty
  fi
fi
