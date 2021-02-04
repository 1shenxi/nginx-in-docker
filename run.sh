#!/usr/bin/bash

# 配置文件路径
conf="$PWD/conf/$1.conf"

echo "conf: $conf"

# 如果不存在配置文件，则退出。
if [ ! -f "$conf" ];
then
    echo "$PWD/conf 目录下不存在 \n $1.conf 文件...退出"
    exit 0
fi

docker stop my-nginx-boy
docker rm my-nginx-boy

docker container run \
    -d \
    -p 9002:80 \
    -v $conf:/etc/nginx/nginx.conf \
    --name my-nginx-boy \
    boy-nginx
