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

# 彻底删除 Argon / Argone 主题及其配置插件（lean、feeds、kenzok8 仓库里的所有副本）
rm -rf package/lean/luci-theme-argon*
rm -rf feeds/luci/themes/luci-theme-argon* feeds/luci/applications/luci-app-argon*-config
find package/ feeds/ -maxdepth 3 \( -name 'luci-theme-argon*' -o -name 'luci-app-argon*-config' \) -exec rm -rf {} + 2>/dev/null || true


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
