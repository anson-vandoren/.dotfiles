#!/bin/sh

DROPDOWN_CLASS="quakitty"

_show_kitty() {
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] scratchpad show, [class=\"$DROPDOWN_CLASS\"] move window to position 3370 px 800 px, [class=\"$DROPDOWN_CLASS\"] resize set 1900px 800px"
  return $?
}

_hide_kitty() {
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] move scratchpad"
}

_focus_kitty() {
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] focus"
}

# Get the window ID of the currently focused window
FOCUSED_WINDOW_ID=$(xdotool getwindowfocus)

# Get the window ID of the kitty window (if it exists)
KITTY_WINDOW_ID=$(xdotool search --limit 1 --class "$DROPDOWN_CLASS")

if [ -n "$KITTY_WINDOW_ID" ]; then
  # If the kitty window exists
  if [ "$FOCUSED_WINDOW_ID" = "$KITTY_WINDOW_ID" ]; then
    # If the kitty window is already focused, hide it
    _hide_kitty
  else
    # If the kitty window is not focused, focus it
    _focus_kitty
  fi
else
  # If the kitty window doesn't exist, launch it
  kitty --config $HOME/.config/kitty/kitty-floating.conf --single-instance --class $DROPDOWN_CLASS 1>/dev/null 2>/dev/null &
  if [ "$1" = "--startup" ]; then
    # Wait until kitty window is ready
    xdotool search --sync --onlyvisible --class "$DROPDOWN_CLASS"
    _hide_kitty
  fi
fi
