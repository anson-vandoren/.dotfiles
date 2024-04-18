#!/bin/bash

# Path to the file where the window ID is stored
window_file="/tmp/last_chrome_window_id"

# Function to update the window ID file
update_window_id() {
  xdotool getactivewindow > "$window_file"
}

# Subscribe to window focus and unfocus events for Chrome windows
i3-msg -t subscribe -m '[ "window" ]' | jq --unbuffered 'select(.change == "focus" or .change == "unfocus") | select(.container.window_properties.class == "Google-chrome")' | while read -r; do
  update_window_id
done
