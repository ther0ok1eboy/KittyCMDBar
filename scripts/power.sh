#!/bin/bash

option0=" Lock"
option1="󰗽 Logout"
option2=" Reboot"
option3=" Shutdown"

options="$option0\n$option1\n$option2\n$option3"
chosen="$(echo -e "$options" | fuzzel --lines 5 --dmenu)"
case $chosen in
    $option0)
	            swaylock --font "ComicShannsMono Nerd Font"
                ;;
    $option1)
                loginctl terminate-user $(whoami)
                ;;
    $option2)
	            reboot
                ;;
    $option3)
	        poweroff
            ;;
esac
