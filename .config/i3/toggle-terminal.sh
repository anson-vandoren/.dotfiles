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

_move_kitty_to_current_workspace() {
  # Get the current workspace
  CURRENT_WORKSPACE=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')
  # Move the kitty window to the current workspace
  i3-msg -q "[class=\"$DROPDOWN_CLASS\"] move workspace $CURRENT_WORKSPACE"
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
    # If the kitty window is not focused, check if it's on the current workspace
    KITTY_WORKSPACE=$(i3-msg -t get_tree | jq -r "recurse(.nodes[], .floating_nodes[]) | select(.window?==$KITTY_WINDOW_ID) | .workspace")
    CURRENT_WORKSPACE=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

    if [ "$KITTY_WORKSPACE" != "$CURRENT_WORKSPACE" ]; then
      # If the kitty window is on a different workspace, move it to the current workspace
      _move_kitty_to_current_workspace
    fi
    # Focus the kitty window
    _focus_kitty
  fi
else
  # If the kitty window doesn't exist, launch it
  kitty --config $HOME/.config/kitty/kitty-floating.conf --single-instance --class $DROPDOWN_CLASS 1>/dev/null 2>/dev/null &
  if [ "$1" = "--startup" ]; then
    # Wait until kitty window is ready
    xdotool search --sync --onlyvisible --class "$DROPDOWN_CLASS"
    i3-msg -q "[class=\"quakitty\"] resize set 1900px 800px"
    i3-msg -q "[class=\"quakitty\"] move window to position 3370px 800px"
    _hide_kitty
  fi
fi
