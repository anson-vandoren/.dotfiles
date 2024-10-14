#!/bin/bash

# sleep 4

export DISPLAY=:1
export XAUTHORITY=/run/user/1000/gdm/Xauthority
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# echo "DISPLAY after: $DISPLAY" >> "$log_file"
# echo "XAUTHORITY after: $XAUTHORITY" >> "$log_file"
# echo "DBUS_SESSION_BUS_ADDRESS: $DBUS_SESSION_BUS_ADDRESS" >> "$log_file"

if /usr/bin/xset r rate 250 35; then
    logger "Moonlander: Keyboard repeat rate successfully set to 250 35"
else
    logger "Moonlander: Failed to set keyboard repeat rate. Error: $?"
fi
