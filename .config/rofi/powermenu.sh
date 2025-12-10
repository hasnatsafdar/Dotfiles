#!/usr/bin/env bash

options="    Lock
󰍃   Logout
   Reboot
   Shutdown
   Suspend"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu")

case "$chosen" in
"    Lock")
  i3lock-fancy
  ;;
"󰍃    Logout")
  i3-msg exit
  ;;
"    Reboot")
  systemctl reboot
  ;;
"    Shutdown")
  systemctl poweroff
  ;;
"    Suspend")
  systemctl suspend
  ;;
esac
