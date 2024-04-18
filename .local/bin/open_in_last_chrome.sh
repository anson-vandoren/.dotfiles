#!/bin/bash
window_file="/tmp/last_chrome_window_id"

if [ -f "$window_file" ]; then
  window_id=$(cat "$window_file")
  xdotool windowactivate $window_id
fi

# Open the URL in Chrome
google-chrome "$@"

