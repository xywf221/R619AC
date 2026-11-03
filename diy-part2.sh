#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# ===== 基础设置：默认 IP 与主机名 =====
# Modify default IP
sed -i 's/192.168.1.1/192.168.7.1/g' package/base-files/files/bin/config_generate

# Modify hostname
sed -i 's/OpenWrt/R619ac/g' package/base-files/files/bin/config_generate

# ===== 主题处理 =====
# 取消 bootstrap 为默认主题（删除它的首启默认设置行）
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 删除 lean 里的 argon 主题包（改用 feeds 版本，避免重复）
rm -rf package/lean/luci-theme-argon

# 克隆额外主题与插件到 lean
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat
git clone https://github.com/garypang13/luci-theme-edge.git package/lean/luci-theme-edge
git clone https://github.com/selfcan/luci-app-tailscale package/lean/luci-app-tailscale

# ===== 版本号与默认主题 =====
# Modify the version number
sed -i "s/OpenWrt /Leopard build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Modify default theme（集合包的默认主题依赖改为 vantage）
sed -i 's/luci-theme-bootstrap/luci-theme-vantage/g' feeds/luci/collections/luci/Makefile feeds/luci/collections/luci-light/Makefile

# ===== 内核构建信息 =====
# Add kernel build user
[ -z $(grep "CONFIG_KERNEL_BUILD_USER=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_USER="Leopard"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_USER=\).*@\1$"Leopard"@' .config

# Add kernel build domain
[ -z $(grep "CONFIG_KERNEL_BUILD_DOMAIN=" .config) ] &&
    echo 'CONFIG_KERNEL_BUILD_DOMAIN="GitHub Actions"' >>.config ||
    sed -i 's@\(CONFIG_KERNEL_BUILD_DOMAIN=\).*@\1$"GitHub Actions"@' .config
