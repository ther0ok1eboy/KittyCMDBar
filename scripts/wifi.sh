# WIFI面板

declare -a lines_array
option=$1

# 使用管道处理终端输出，并将每一行存储到数组中
while IFS= read -r line; do
    lines_array+=("$line")  # 将每一行存储到数组
done < <(nmcli device wifi list)

# 打印数组中的每一行
for line in "${lines_array[@]}"; do
    bssid=$(echo $line | awk '{print$1}')
    echo -e "\e]8;;$bssid.bar\e\\$line\e]8;;\e\\"
    ((option++))
done

