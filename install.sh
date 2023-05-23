#!/bin/sh

# 更新软件包列表
opkg update

# 安装luci-app-mwan3
opkg install luci-app-mwan3

# 下载配置文件
wget -O /etc/config/mwan3 https://raw.githubusercontent.com/chinazyq123/ECUST-openwrt/main/mwan3

# 重新启动mwan3服务
/etc/init.d/mwan3 restart
