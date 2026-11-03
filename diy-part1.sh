#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# ===== 额外包仓库（克隆到 package/，随固件一起编译） =====
# kenzok8 的 openwrt-packages（插件）与 small（passwall/ssr-plus 等组件）
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small

# ===== 主题与仪表盘 =====
# anothaDev/luci-theme-vantage 仓库同时含默认主题 luci-theme-vantage 与仪表盘 luci-app-vantage
git clone https://github.com/anothaDev/luci-theme-vantage.git package/luci-theme-vantage
