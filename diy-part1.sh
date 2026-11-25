#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# ===== 锁定 lede 源码版本 =====
# 上游 3bf60af8（2026-11-24 kernel: bump 6.18 to 6.18.65）后，mac80211 backports 6.18.39
# 在 net/wireless/sysfs.c 编译失败（ns_common 指针类型不兼容）。先固定到它之前的提交，
# 上游修复后删掉这一行即可。
git reset --hard 7810b38c

# ===== 额外包仓库（克隆到 package/，随固件一起编译） =====
# kenzok8 的 openwrt-packages（插件）与 small（passwall/ssr-plus 等组件）
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
git clone https://github.com/kenzok8/small.git package/small

# ===== 主题与仪表盘 =====
# anothaDev/luci-theme-vantage 仓库同时含默认主题 luci-theme-vantage 与仪表盘 luci-app-vantage
git clone https://github.com/anothaDev/luci-theme-vantage.git package/luci-theme-vantage
