#!/bin/bash
sleep 2
logger "Setting HFP profile"
sudo -u '#1000' XDG_RUNTIME_DIR=/run/user/1000 pactl set-card-profile bluez_card.70_BF_92_C9_F5_D0 handsfree_head_unit 2>&1
logger "Set HFP profile"
