# 工作区
workspace_func() {
    icon2="󰮯 " 
    icon1="󰊠 "
    #
    # 总个数
    total=$(hyprctl workspaces | grep "workspace ID" | wc -l) 
    # 获取当前下标位置
    index=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')
    
    # 如果下标大于等于总个数，则强制设为最后一位
    if [ "$index" -ge "$total" ]; then
        index=$total
    fi
    
    # 遍历每个位置并输出相应字符
    for ((i=1; i<=total; i++)); do
        if [ "$i" -eq "$index" ]; then
            printf "${icon2}"
            #printf "\033[33m${icon2}\033[0m"
        else
            printf "${icon1}"
            #printf "\033[31m${icon1}\033[0m"
        fi
    done
}
workspace_char=$(workspace_func)

# home 区
home_func() {
    icon="󰣇 "
    echo -e "\e]8;;2.bar\e\\$icon\e]8;;\e\\"

}
home_char=$(home_func)

# weather 区
weather_func() {

    text=$(cat ~/KittyCMDBar/tmp/weather.txt)
    curl -s "https://wttr.in/$1?format=%c+%f" > ~/KittyCMDBar/tmp/weather.txt &
    
    text=$(echo "$text" | sed -E "s/\s+/ /g")
    weather_icon=$(echo "$text" | sed -E "s/\s+/ /g" | awk '{print $1}')
    temperature=$(echo "$text" | tr -c '[:digit:]' ' ' | sed -E "s/\s+//g")

    # 转化为摄氏度
    if [[ $temperature -gt 40 ]] || [[ $temperature -lt 0 ]] 
    then
        temperature=$(echo "($temperature-32)/1.8" | bc)
    fi
    icon="$weather_icon$temperature°C"
    icon_format=$(format_len "$icon" 8)
    echo $icon_format
}
weather_icon="$(weather_func Shanghai)"

# 电脑亮度区
light_func() {
    
    light_vale=$(brightnessctl i | grep 'Current brightness' | awk -F '(' '{print$2}' | awk -F ')' '{print$1}' | awk -F '%' '{print$1}')
    icon=("󰃞 %" "󰃟 %" "󰃝 %" "󰃠 %")
    if (( $light_vale <=100 )) && (( $light_vale >= 75 )); then
        printf "\e]8;;3.bar\e\\+ \e]8;;\e\\"
        printf "%s%d" "${icon[3]}" "$light_vale"
        printf "\e]8;;4.bar\e\\ -\e]8;;\e\\"
    elif (( $light_vale < 75 )) && (($light_vale >= 50 )); then
        printf "\e]8;;3.bar\e\\+ \e]8;;\e\\"
        printf "%s%d" "${icon[2]}" "$light_vale"
        printf "\e]8;;4.bar\e\\ -\e]8;;\e\\"
    elif (( $light_vale < 50 )) && (($light_vale >= 25 )); then
        printf "\e]8;;3.bar\e\\+ \e]8;;\e\\"
        printf "%s%d" "${icon[1]}" "$light_vale"
        printf "\e]8;;4.bar\e\\ -\e]8;;\e\\"
    else
        printf "\e]8;;3.bar\e\\+ \e]8;;\e\\"
        printf "%s%d" "${icon[0]}" "$light_vale"
        printf "\e]8;;4.bar\e\\ -\e]8;;\e\\"
    fi
}
light_char=$(light_func)

# Cava 区
cava_func() {

    bar="▂▄▆▇█▇▆▄▂▁"
    dict="s/;//g;"
    
    # creating "dictionary" to replace char with bar
    i=0
    while [ $i -lt ${#bar} ]
    do
        dict="${dict}s/$i/${bar:$i:1}/g;"
        i=$((i=i+1))
    done

    random=$(shuf -i 0-9 -n 18 | tr '\n' ';')
    echo $random | sed $dict

}
cava_char=$(cava_func)

# 时间区
time_func() {
    left=$(date +"%a %d %b")
    icon="🕑"
    right=$(date +"%I:%M %p")
    echo "$left $icon $right"
}
time_char=$(time_func)

# 系统托盘区
tray_func() {

    for i in $(cat ~/KittyCMDBar/tmp/icon.txt); do
        if (( ${#i} != 0 )) ; then
            ((count++))
            icon+="$i "
        fi
    done
    echo "" > ~/KittyCMDBar/tmp/icon.txt
    # 返回图标和图标数量
    printf "%s:%d" "$icon" "$count"
}
tray_func_return=$(tray_func)
tray_char=$(echo $tray_func_return | awk -F ':' '{print$1}')
tray_char_offset=$(echo $tray_func_return | awk -F ':' '{print$2}')

# 系统设置区
power_func() {
    # TODO
    icon=" "
    echo -e "\e]8;;7.bar\e\\$icon\e]8;;\e\\"
}
power_char=$(power_func)

# 音量区
volume_func() {

    #mute_switch="pactl set-sink-mute @DEFAULT_SINK@ toggle)"
    icon1=" "
    icon2=" "
    is_mute=$(pactl list sinks | grep 'Mute' | awk -F ':' '{print$2}'|tr -d \[:space:\])
    volume_value=$(pactl list sinks | grep -A 15 'Sink #' | grep 'Volume: front-left' | awk -F '/' '{print$2}' | tr -d \[:space:\])

    if [ $is_mute == "yes" ]; then
        printf "\e]8;;5.bar\e\\+ \e]8;;\e\\"
        printf "\e]8;;1.bar\e\\$icon1 $volume_value%\e]8;;\e\\"
        printf "\e]8;;6.bar\e\\ -\e]8;;\e\\"
    else
        printf "\e]8;;5.bar\e\\+ \e]8;;\e\\"
        printf "\e]8;;1.bar\e\\$icon2 $volume_value%\e]8;;\e\\"
        printf "\e]8;;6.bar\e\\ -\e]8;;\e\\"
    fi
}
volume_char=$(volume_func)

# 电量区
battery_func() {

    icon1="󱊦 "
    icon2="󱊣 "
    icon3="󱊢 "
    icon4="󱊡 "
    icon5=" "

    state=$(upower -i $(upower -e | grep battery) | grep state | awk -F ':' '{print$2}'|tr -d \[:space:\])
    percentage=$(upower -i $(upower -e | grep battery) | grep percentage | awk -F ':' '{print$2}'|tr -d \[:space:\] | awk -F '%' '{print$1}')
    if [ $state == "fully-charged" ]; then
        echo "$icon1$percentage%"
    elif [ $state == "discharging" ] || [ $state == "charging" ]; then
        if (( $percentage >= 75 )); then
            echo "$icon2$percentage%"
        elif (( $percentage >= 50 )) && (( $percentage < 75 )); then
            echo "$icon3$percentage%"
        elif (( $percentage >= 25 )) && (( $percentage < 50 )); then
            echo "$icon4$percentage%"
        else
            echo "$icon5$percentage%"
        fi
    else
        echo "$icon5"
    fi
}
battery_char=$(battery_func)

network_func() {
    
    icon1="󰖩 "
    icon2="󰤢 "
    icon3=" "
    icon4="󰯡 "
    
    wifi_name=$(ip addr show | grep UP | awk -F ':' '{print$2}' | grep '^[ \t]w' | tr -d \[:space:\])
    net_name=$(ip addr show | grep UP | awk -F ':' '{print$2}' | grep '^[ \t]e' | tr -d \[:space:\])

    if (( $(ip addr show | grep $wifi_name | wc -l) > 1 )) && (( $(ip addr show | grep $net_name | wc -l) == 1 )); then
        wifi_state="connect"
        net_state="disconnect"
        wifi_connect_name=$(nmcli device status | grep $wifi_name | awk '{print$4" "$5}')
        wifi_quantity=$(nmcli device wifi | grep "$wifi_connect_name" | awk -F '/' '{print$2}' | awk '{print$2}')
        
        if (( $wifi_quantity >= 90 )); then
            icon=$(format_len "$icon1$wifi_connect_name" 15)
            printf "\e]8;;9.bar\e\\$icon\e]8;;\e\\"
        else
            icon=$(format_len "$icon1$wifi_connect_name" 15)
            printf "\e]8;;9.bar\e\\$icon\e]8;;\e\\"
        fi

    elif (( $(ip addr show | grep $wifi_name | wc -l) == 1 )) && (( $(ip addr show | grep $net_name | wc -l) > 1 )); then
        wifi_state="disconnect"
        net_state="connect" 
        echo "$icon3$net_name"
    elif (( $(ip addr show | grep $wifi_name | wc -l) > 1 )) && (( $(ip addr show | grep $net_name | wc -l) > 1 )); then
        wifi_state="connect"
        net_state="connect"
        echo "$icon3$net_name"
    else
        wifi_state="disconnect"
        net_state="disconnect"
        printf "\e]8;;9.bar\e\\$icon4$net_name\e]8;;\e\\"
    fi

}
network_char=$(network_func)

# 音乐区
music_func() {

    icon1=" "
    icon2="󰫔 "
    icon3="󰝛 "
    icon4=" "

    player_status=$(playerctl status 2>/dev/null)
    [[ $player_status == "" ]] && echo $icon3 && exit 1
    player_name=$(playerctl metadata --format "{{ playerName }}" 2>/dev/null)
    
    artist=$(playerctl metadata --format "{{ artist }}" 2>/dev/null)
    title=$(playerctl metadata --format "{{ title }}" 2>/dev/null)
    duration=$(playerctl metadata --format "{{ duration(position) }}/{{ duration(mpris:length) }}" 2>/dev/null)
    
    if [ "$player_name" == "spotify" ]; then
        icon=$(format_len "$icon1$title" 15)
        echo $icon
    elif [ "$player_name" == "firefox" ]; then
        icon=$(format_len "$icon4$title" 7)
        echo $icon
    else
        icon=$(format_len "$icon2$title" 7)
        echo $icon
    fi
}
music_char=$(music_func)

# CPU 区
cpu_func() {
    icon1="󱑬 "
    icon2="󰈐 "

    value=$(cat ~/KittyCMDBar/tmp/cpu.txt | awk -F '%' '{print$1}')
    if (( $value < 50 )); then
        icon="$icon2$value%"
        echo -e "\e]8;;8.bar\e\\$icon\e]8;;\e\\"
    else
        icon="$icon1$value%"
        echo -e "\e]8;;8.bar\e\\$icon\e]8;;\e\\"
    fi
}
cpu_char=$(cpu_func)
