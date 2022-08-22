#!/bin/sh

# Start new instances of alacritty in the same working directory as
# the currently focused window, if it's another instance of alacritty.

TERMINAL_CMD="alacritty"

FOCUSED_PID=""
if [ !type jq 2>/dev/null  ]; then
    echo "jq not found. Please install jq." >&2
    exit 1
fi
FOCUSED_PID="$(swaymsg -t get_tree | jq '.. | select(.type?) |
    select(.type =="con") | select(.focused==true).pid')"

FOCUSED_PWD=""
# check if $FOCUSED_PID is an integer
if [ "$FOCUSED_PID" -eq "$FOCUSED_PID" 2>/dev/null ]; then
    FOCUSED_PPID="$(ps -o pid= --ppid "$FOCUSED_PID" | awk '{print $1}')"
    if [ "$FOCUSED_PPID" -eq "$FOCUSED_PPID" 2>/dev/null ]; then
        FOCUSED_PWD="$(readlink "/proc/$FOCUSED_PPID/cwd")"
    fi
fi

if [ -d "$FOCUSED_PWD" ]; then
    $TERMINAL_CMD --working-directory="$FOCUSED_PWD" $@ &
else
    $TERMINAL_CMD $@ &
fi
