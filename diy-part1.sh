#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# ImmortalWrt 25.12 third-party feeds:
# - PassWall2 (main branch, supports 25.12)
# - mosdns v5 (default branch, supports apk / 25.12 and later;
#   do NOT use the openwrt-21.02 branch on the 25.12 base)
#
# NOTE: the old helloworld feed and the AdGuardHome source are intentionally
# NOT added here. This build ships luci-app-passwall2 (sing-box core) and
# mosdns / luci-app-mosdns only; AdGuardHome is excluded by design.

# Add PassWall2 feed
echo 'src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2' >>feeds.conf.default

# Add mosdns feed (v5 default branch)
echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
# Pin luci feed to the official v25.12.2 commit (d6167ea0).
# The fork's feeds.conf.default is unpinned, so the build pulled luci master,
# whose ucode-template precompilation (commit 0b6e4127de, 2026-08-25) requires
# ucode>=2026.02.27 while the 25.12 tree ships ucode 2026.01.16 (#6 failure).
# d6167ea0 is the luci commit ImmortalWrt v25.12.2 shipped with; its luci.mk
# has no LUCI_UT_MIN_UCODE requirement.
sed -i 's|^src-git luci https://github.com/immortalwrt/luci.git$|src-git luci https://github.com/immortalwrt/luci.git^d6167ea0645cbd1327708d85f94824f42d0eb872|' feeds.conf.default
grep -q '^src-git luci https://github.com/immortalwrt/luci.git^d6167ea0645cbd1327708d85f94824f42d0eb872$' feeds.conf.default || { echo "ERROR: luci feed pin not applied"; exit 1; }
