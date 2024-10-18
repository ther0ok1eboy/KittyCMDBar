#!/bin/bash

source ~/KittyCMDBar/src/utils.sh
source ~/KittyCMDBar/src/module.sh

# 左、中、右 三个区域
left_char=" $workspace_char\\ $weather_icon \\ $cava_char \\ $music_char \\"
middle_char="$time_char"
right_char="/ $battery_char / $tray_char"

left_char1=" $home_char\\ $cpu_char \\ $light_char \\"
right_char1="/ $volume_char / $network_char / $power_char"

# 三个区域的长度
left_char_len=${#left_char}
left_char1_len=${#left_char1}
middle_char_len=${#middle_char}
right_char_len=${#right_char}
right_char1_len=${#right_char1}

# 计算字符的位置
middle_pos=$((cols / 2 - left_char_len + (middle_char_len / 2) + 2))
right_pos=$((cols - ((cols / 2) + (middle_char_len / 2)) + (tray_char_offset) * 3 - 2))

# 打印第一行
printf "%s" "$left_char"
printf "%*s%*s\n" "$middle_pos" "$middle_char" "$right_pos" "$right_char" 
echo ""
# 打印第二行(20为一个超链接额外占用的长度)
printf "%s" "$left_char1"
# 左边字符的原始长度
left_origin_len=$(origin_len $left_char1)
# 右边超链接的个数
right_hyperlink_count=$(echo $right_char1 | grep -o "bar" | wc -l)
printf "%*s\n" "$((cols + right_hyperlink_count * 20 - left_origin_len))" "$right_char1"
