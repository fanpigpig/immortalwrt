#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
# echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
# echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
# echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default

# Add luci-theme-argon feed 
echo 'src-git argon https://github.com/jerrykuku/luci-theme-argon.git' >> feeds.conf.default
echo 'src-git argon-config https://github.com/jerrykuku/luci-app-argon-config.git' >> feeds.conf.default

# Add openwrt-frp? maybe not with opkg? (kept for reference)
# echo 'src-git frp https://github.com/kenzok8/openwrt-frp' >> feeds.conf.default

# Add custom script feeds
# echo 'src-git kr-uboot https://github.com/KokWind/kr-uboot' >> feeds.conf.default

# Add missing meta packages feed
# echo 'src-git meta https://github.com/openwrt-meta-packages' >> feeds.conf.default

# Remove duplicate comments
# sed -i '/^#/d' feeds.conf.default

# Add small feed (kenzok8)
# echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
# add third-party feed with required packages (kenzok8/openwrt-packages)
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default

# Add theme packages (kenzok8/small-package)
echo 'src-git small8 https://github.com/kenzok8/small-package' >> feeds.conf.default

# Add passshell
# echo 'src-git passshell https://github.com/xiaorouji/openwrt-passwall' >> feeds.conf.default
# Add passwall2
# echo 'src-git passshell2 https://github.com/xiaorouji/openwrt-passwall2' >> feeds.conf.default
# Add haiku
# echo 'src-git haiku https://github.com/haiibo/openwrt-packages' >> feeds.conf.default
# Add alist
# echo 'src-git alist https://github.com/sbwml/openwrt-alist' >> feeds.conf.default
# Add unblockneteasemusic
# echo 'src-git alist https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic' >> feeds.conf.default

# Add luci-app-store
# echo 'src-git store https://github.com/linkease/istore;main' >> feeds.conf.default
# echo 'src-git nas https://github.com/linkease/nas-packages;main' >> feeds.conf.default
# echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci;main' >> feeds.conf.default
