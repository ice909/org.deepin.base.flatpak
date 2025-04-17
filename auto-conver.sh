#!/bin/bash

# 读取./need-convert
convert_list=$(grep -v '^#' ./need-convert)

for ref in $convert_list; do
    # 获取id 和 version
    id=$(echo "$ref" | awk -F'/' '{print $(NF-2)}')
    version=$(echo "$ref" | awk -F'/' '{print $NF}')
    echo "ID: $id, Version: $version"
    ./mkbase.bash $id $version
    # 如果执行失败，记录到error.log
    if [ $? -ne 0 ]; then
        echo "Failed to convert $id $version" >> error.log
        continue
    fi
    # 保存到 success
    echo $ref >> success
done
