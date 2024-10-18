
# 获取终端的宽度
cols=$(tput cols)

# 设置区间长度
format_len() {

    local input_string=$1  # 第一个参数：字符串
    local length=$2        # 第二个参数：长度

    # 如果字符串长度大于指定长度，则进行截取
    if [ ${#input_string} -gt $length ]; then
        echo "${input_string:0:$length}"
    # 如果字符串长度小于指定长度，则添加井号填充
    elif [ ${#input_string} -lt $length ]; then
        local padding=$(printf '%*s' $(($length - ${#input_string})) '' | tr ' ' '_')
        echo "${input_string}${padding}"
    else
        echo "$input_string"
    fi
}

# 计算加入超链接后，字符串的原始长度
origin_len() {
    #count=$(echo $1 | grep -o 'bar' | wc -l)
    len=${#1}
    org_len=$(( len + 10 ))
    echo $org_len
}
