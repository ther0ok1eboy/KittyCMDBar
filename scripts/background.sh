#!/bin/bash

# 切换壁纸
wallpapers_path="/home/sorria/Pictures/Wallpapers/backgrounds"
wallpaper_name=$(find $wallpapers_path -type f | shuf -n 1)
swww img $wallpaper_name --transition-fps 60 --transition-type grow --transition-duration 2 --transition-pos 'top-left'
