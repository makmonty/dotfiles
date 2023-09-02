#!/bin/sh
COLOR=white
echo -e "shutdown\0icon\x1f<span color='${COLOR}'></span>\nreboot\0icon\x1f<span color='${COLOR}'></span>\nlock\0icon\x1f<span color='${COLOR}'></span>\nsuspend\0icon\x1f<span color='${COLOR}'></span>\nclose session\0icon\x1f<span color='${COLOR}'></span>" | rofi -config power.rasi -dmenu
