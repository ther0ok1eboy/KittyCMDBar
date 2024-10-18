
#!/bin/bash

# 获取初始的 CPU 核心统计信息
cpu_stat1=($(grep '^cpu[0-9]' /proc/stat | awk '{print $1, $2, $3, $4, $5, $6, $7, $8}'))
num_cores=$(nproc)  # 获取 CPU 核心数量

# 初始化空数组来存储初始的 idle 和 total 值
idle1=()
total1=()

# 遍历每个 CPU 核心的数据
for ((i=0; i<num_cores; i++)); do
    cpu_data=(${cpu_stat1[@]:$((i*8)):8})  # 取出每个核心的数据
    idle1[$i]=${cpu_data[4]}  # 获取 idle 时间
    total1[$i]=0
    
    # 计算每个核心的 total 值
    for val in "${cpu_data[@]:1}"; do
        total1[$i]=$((total1[$i] + val))
    done
done

# 等待 1 秒
sleep 1

# 获取第二次的 CPU 核心统计信息
cpu_stat2=($(grep '^cpu[0-9]' /proc/stat | awk '{print $1, $2, $3, $4, $5, $6, $7, $8}'))

# 初始化空数组来存储第二次的 idle 和 total 值
idle2=()
total2=()

# 遍历每个 CPU 核心的数据
for ((i=0; i<num_cores; i++)); do
    cpu_data=(${cpu_stat2[@]:$((i*8)):8})
    idle2[$i]=${cpu_data[4]}
    total2[$i]=0
    
    # 计算每个核心的 total 值
    for val in "${cpu_data[@]:1}"; do
        total2[$i]=$((total2[$i] + val))
    done
done

# 计算每个 CPU 核心的使用率
for ((i=0; i<num_cores; i++)); do
    idle_diff=$((idle2[i] - idle1[i]))
    total_diff=$((total2[i] - total1[i]))
    cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))
    echo "core $i : $cpu_usage%"
done
