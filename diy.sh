#!/bin/bash

#
# Copyright (C) 2019 P3TERX
#

#==================================================================================================
# 设置更改默认编译主题为Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
#==================================================================================================



#==================================================================================================
# 以下为自定义拉取单个源（需要在.config填写编译配置）
#==================================================================================================
# 删除Argon主题旧码并拉取更新源码以及配置界面
rm -rf ./package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/mine/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/mine/luci-app-argon-config

# 科学
#--------------------------------------------------------------------------------------------------
# helloworld
# git clone https://github.com/fw876/helloworld.git package/mine/helloworld

# Hello World (A new luci app bese helloworld)
# git clone https://github.com/jerrykuku/lua-maxminddb.git package/mine/lua-maxminddb  # lua-maxminddb 依赖
# git clone https://github.com/jerrykuku/luci-app-vssr.git package/mine/luci-app-vssr

# A Clash Client For OpenWrt
# git clone https://github.com/vernesong/OpenClash.git package/mine/OpenClash
#-------------------------------------------------------------------------------------------------- 

# 主题
#-------------------------------------------------------------------------------------------------- 
# Advanced Tomato Material Theme
# git clone https://github.com/yangsongli/luci-theme-atmaterial.git package/mine/luci-theme-atmaterial
# Rosy主题
# git clone https://github.com/rosywrt/luci-theme-rosy.git package/mine/luci-theme-rosy
# LuCI Rosy Theme
# git clone https://github.com/rosywrt/luci-theme-purple.git package/mine/luci-theme-purple
# A theme for HomeLede and Openwrt
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/mine/luci-theme-infinityfreedom
# Edge is a clean HTML5 theme based on luci-theme-argon Template for Luci
# git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/mine/luci-theme-edge
#-------------------------------------------------------------------------------------------------- 

# 管控上网行为
# git clone https://github.com/destan19/OpenAppFilter.git package/mine/OpenAppFilter

# AdGuardHome的luci界面
# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/mine/luci-app-AdGuardHome

# 一个简单的磁盘管理 LuCI 插件，支持磁盘分区、格式化，支持 RAID / btrfs-raid / btrfs-快照管理
# git clone https://github.com/lisaac/luci-app-diskman.git package/mine/luci-app-diskman

# Luci for JD dailybonus Script for Openwrt 一个运行在openwrt下的京东签到插件。
# git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/mine/luci-app-jd-dailybonus
#==================================================================================================



# 模拟校园网认证客户端
#==================================================================================================
# Drcom6.0(p)
#-------------------------------------------------------------------------------------------------- 
# GDrcoms（Dr.com插件）
git clone https://github.com/Hey-Leo/GDrcoms.git package/mine/GDrcoms
# 缺少的权限
chmod 755 package/mine/GDrcoms/root/etc/init.d/gdut-drcom
chmod 755 package/mine/GDrcoms/root/usr/bin/gdut-drcom-patch
chmod 755 package/mine/GDrcoms/root/usr/bin/gdut-drcom-unpatch
# 更改wan接口
sed -i "s/network.wan_wan_dev.macaddr/network.wan_eth0_2_dev.macaddr/g" package/mine/GDrcoms/root/etc/init.d/gdut-drcom
# 内核修改UA
# git clone -b dev https://github.com/CHN-beta/xmurp-ua.git package/mine/xmurp-ua
#-------------------------------------------------------------------------------------------------- 

# 锐捷
#-------------------------------------------------------------------------------------------------- 
# minieap
# git clone https://github.com/BoringCat/luci-app-minieap.git package/mine/minieap/luci-app-minieap
# git clone https://github.com/BoringCat/minieap-openwrt.git package/mine/minieap/minieap-openwrt
# git clone https://github.com/updateing/minieap.git package/mine/minieap/minieap

# mentohust
# git clone https://github.com/BoringCat/luci-app-mentohust.git package/mine/mentohust
# git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/mine/mentohust
#-------------------------------------------------------------------------------------------------- 
#==================================================================================================



#==================================================================================================
# 编译说明增加
#==================================================================================================
# 增加说明版本号/编译时间
sed -i "s/OpenWrt /GDRST build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 增加说明核心编译作者
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="GDRST"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"GDRST"@' .config

# 增加说明核心编译环境
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config
#==================================================================================================



# 以下直接文件定义，默认不启用
#==================================================================================================
# 以下框内都可通过files文件自定义（以根目录files内文件为准）
#==================================================================================================
# 设置更改默认ip为192.168.199.1
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate

# 设置更改默认密码（需要提前SHA512加密）
# sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root::0:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# 设置更改默认主机名为MyHome
# sed -i 's/OpenWrt/GDRS/g' package/base-files/files/bin/config_generate

# 设置更改默认WiFi名
sed -i 's/OpenWrt/GDRS/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
### sed -i 's/OpenWrt/GDRS_$(cat /sys/class/ieee80211/${dev}/macaddress|awk -F ":" '{print $4""$5""$6 }'| tr a-z A-Z)/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh   # 语法错误，请直接修改文件
#==================================================================================================

# 再次更新feeds
./scripts/feeds update -a
./scripts/feeds install -a
