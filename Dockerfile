FROM nginx

# 安装 ps 和 vim
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean \
    && apt-get update \
    && apt-get update \
    && apt-get -y install procps \
    && apt-get -y install vim
