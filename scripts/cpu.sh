#!/bin/bash

# 获取初始的 CPU 统计信息
cpu_stat1=($(head -n 1 /proc/stat | awk '{print $2, $3, $4, $5, $6, $7, $8}'))
idle1=${cpu_stat1[3]}
total1=0

# 计算 total1 值（所有 CPU 状态之和）
for val in "${cpu_stat1[@]}"; do
    total1=$((total1 + val))
done

# 等待 1 秒
sleep 1

# 获取第二次的 CPU 统计信息
cpu_stat2=($(head -n 1 /proc/stat | awk '{print $2, $3, $4, $5, $6, $7, $8}'))
idle2=${cpu_stat2[3]}
total2=0

# 计算 total2 值
for val in "${cpu_stat2[@]}"; do
    total2=$((total2 + val))
done

# 计算 CPU 使用率
idle_diff=$((idle2 - idle1))
total_diff=$((total2 - total1))
cpu_usage=$((100 * (total_diff - idle_diff) / total_diff))

echo "$cpu_usage%" > /tmp/cpu.txt
