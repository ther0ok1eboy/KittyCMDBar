#!/bin/bash

# 依赖项
# nerd-font
# kitty
# tput
# hyprctl
# brightnessctl
# pactl
# upower
# nmcli
# playerctl

read -p "是否开始初始化...(y/n) " option
if [ $option == "y" ]; then

    cp ~/KittyCMDBar/config/open-actions.conf ~/.config/kitty
    cp ~/KittyCMDBar/icon/* ~/KittyCMDBar/tmp
    chmod +x * -R

    # 定义需要检查的命令列表
    commands=("kitty" "tput" "hyprctl" "brightnessctl" "pactl" "upower" "nmcli" "playerctl")
    
    # 标志变量，记录是否缺少命令
    missing_cmds=()
    
    # 遍历命令列表
    for cmd in "${commands[@]}"; do
        # 使用 command -v 检查命令是否存在
        if ! command -v $cmd &> /dev/null; then
            missing_cmds+=($cmd)
        fi
    done
    
    # 检查是否有缺少的命令
    if [ ${#missing_cmds[@]} -eq 0 ]; then
        echo "初始化完成"
    else
        echo "系统中缺少以下命令，请安装它们："
        for cmd in "${missing_cmds[@]}"; do
            echo "- $cmd"
        done
    fi

else
    echo "Fail:("
fi
