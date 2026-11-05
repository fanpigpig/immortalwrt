#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Clean up sed truncation of opkg (deprecated)
#sed -i '/option check_signature/d' package/system/opkg/Makefile

############## Additional software installation ##############
# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Modify default host name
sed -i 's/OpenWrt/dailook/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/dailook/g' package/base-files/files/etc/hostname

# Modify default password
sed -i "s/root:::0:99999:7:::/root:\$1\$V4UetPzk\$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g" package/base-files/files/etc/shadow

mkdir -p files/etc/config files/etc/sysctl.conf
#}}}}} Install custom script for network sharing and 4G/5G USB support
#echo "Modifying dhcp"
#sed -i 's/option lease  '/12h/'/option leasetime '12h'/g' package/network/services/dnsmasq/files/dhcp.conf
#sed -i 's/option leasetime '12h'/option leasetime '12h'/g' package/network/services/dnsmasq/files/dhcp.conf

# Add usb serial support
# mkdir -p files/etc/modules.d
# echo "usbserial" > files/etc/modules.d/60-usb-serial
# echo "option" >> files/etc/modules.d/60-usb-serial
# echo "usb_wwan" >> files/etc/modules.d/60-usb-serial
# echo "qcserial" >> files/etc/modules.d/60-usb-serial

# Add 4G and 5G modem compatibility
# echo "kmod-usb-net-qmi-wwan" > /dev/null 2>&1
# echo "usb-modeswitch" > /dev/null 2>&1

# Rename OpenWrt host name as "dailook"
#sed -i "s/hostname='OpenWrt'/hostname='dailook'/g" package/base-files/files/bin/config_generate

# Fix Luci default password
#sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# Modify default theme to Argon (if available)
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Replace default banner with custom text
#echo " -----------------------------------------------------" > package/base-files/files/etc/banner
#echo "|   dailook Custom OpenWrt Firmware (Hanwckf Ver)   |" >> package/base-files/files/etc/banner
#echo " -----------------------------------------------------" >> package/base-files/files/etc/banner

# Add custom package
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# Add custom shell script for quick configuration
#mkdir -p package/base-files/files/etc/uci-defaults
#cat > package/base-files/files/etc/uci-defaults/99-dailook-set <<'EOF'
#uci set system.@system[0].hostname='dailook'
#uci set system.@system[0].zonename='Asia/Shanghai'
#uci set system.@system[0].timezone='CST-8'
#uci set system.@system[0].log_size='64'
#uci set system.@system[0].log_file='/tmp/log.txt'
#uci set network.lan.ipaddr='192.168.2.1'
#uci set network.lan.netmask='255.255.255.0'
#uci set network.lan.proto='static'
#uci set network.wan.proto='dhcp'
#uci set network.wan6.proto='dhcpv6'
#uci commit system
#uci commit network
#EOF
#
## 增加截图说明
#cat > /tmp/dailook-user-info.txt <<'EOF'
#Custom user info
#EOF
#
## Add extend modules
#mkdir -p files/etc
#echo "config system" > files/etc/sysctl.conf
#echo "    option hostname 'dailook'" >> files/etc/sysctl.conf
#
## Modify network config
#mkdir -p files/etc/config
#cat > files/etc/config/network <<'EOF'
#config interface 'loopback'
#    option device 'lo'
#    option proto 'static'
#    option ipaddr '127.0.0.1'
#    option netmask '255.0.0.0'
#config globals 'globals'
#    option ula_prefix 'fd57:c8fd:9fe4::/48'
#config interface 'lan'
#    option device 'br-lan'
#    option proto 'static'
#    option ipaddr '192.168.2.1'
#    option netmask '255.255.255.0'
#    option ip6assign '60'
#    list dns '223.5.5.5'
#    list dns '223.6.6.6'
#    list dns '114.114.114.114'
#config interface 'wan'
#    option device 'eth1'
#    option proto 'dhcp'
#config interface 'wan6'
#    option device 'eth1'
#    option proto 'dhcpv6'
#    option reqaddress 'try'
#    option reqprefix 'auto'
#config device
#    option name 'br-lan'
#    option type 'bridge'
#    list ports 'eth0'
#EOF
#
## Modify system config
#cat > files/etc/config/system <<'EOF'
#config system
#    option hostname 'dailook'
#    option timezone 'CST-8'
#    option zonename 'Asia/Shanghai'
#    option ttylogin '0'
#    option log_size '64'
#    option urandom_seed '0'
#config timeserver 'ntp'
#    list server 'ntp.aliyun.com'
#    list server 'ntp1.aliyun.com'
#    list server 'ntp2.aliyun.com'
#    list server 'ntp3.aliyun.com'
#    option enabled '1'
#    option enable_server '0'
#EOF
#
#
## Modify wireless config
#cat > files/etc/config/wireless <<'EOF'
#config wifi-device 'radio0'
#    option type 'mac80211'
#    option path 'platform/soc/18000000.wifi'
#    option channel 'auto'
#    option band '2g'
#    option htmode 'HE40'
#    option cell_density '0'
#    option txpower '20'
#config wifi-iface 'default_radio0'
#    option device 'radio0'
#    option network 'lan'
#    option mode 'ap'
#    option ssid 'dailook-2.4G'
#    option encryption 'psk2'
#    option key 'dailook1234'
#config wifi-device 'radio1'
#    option type 'mac80211'
#    option path 'platform/soc/18000000.wifi+1'
#    option channel 'auto'
#    option band '5g'
#    option htmode 'HE160'
#    option cell_density '0'
#    option txpower '20'
#config wifi-iface 'default_radio1'
#    option device 'radio1'
#    option network 'lan'
#    option mode 'ap'
#    option ssid 'dailook-5G'
#    option encryption 'psk2'
#    option key 'dailook1234'
#EOF
#
## Modify DHCP config to share network
#cat > files/etc/config/dhcp <<'EOF'
#config dnsmasq
#    option domainneeded '1'
#    option localise_queries '1'
#    option rebind_protection '1'
#    option rebind_localhost '1'
#    option local '/lan/'
#    option domain 'lan'
#    option expandhosts '1'
#    option cachesize '1000'
#    option authoritative '1'
#    option readethers '1'
#    option leasefile '/tmp/dhcp.leases'
#    option resolvfile '/tmp/resolv.conf.d/resolv.conf.auto'
#    option localservice '1'
#    option ednspacket_max '1232'
#    option rebind_domain 'pingcap.com'
#config dhcp 'lan'
#    option interface 'lan'
#    option start '100'
#    option limit '150'
#    option leasetime '12h'
#    option dhcpv4 'server'
#    option dhcpv6 'server'
#    option ra 'server'
#    list ra_flags 'managed-config'
#    list ra_flags 'other-config'
#config dhcp 'wan'
#    option interface 'wan'
#    option ignore '1'
#config odhcpd 'odhcpd'
#    option maindhcp '0'
#    option leasefile '/tmp/hosts/odhcpd'
#    option leasetrigger '/usr/sbin/odhcpd-update'
#    option loglevel '4'
#EOF
#
## Modify firewall to allow network sharing
#cat > files/etc/config/firewall <<'EOF'
#config defaults
#    option output 'ACCEPT'
#    option synflood_protect '1'
#    option input 'ACCEPT'
#    option forward 'ACCEPT'
#config zone
#    option name 'lan'
#    list network 'lan'
#    option input 'ACCEPT'
#    option output 'ACCEPT'
#    option forward 'ACCEPT'
#config zone
#    option name 'wan'
#    list network 'wan'
#    list network 'wan6'
#    option input 'REJECT'
#    option output 'ACCEPT'
#    option forward 'REJECT'
#    option masq '1'
#    option mtu_fix '1'
#config rule
#    option name 'Allow-DHCP-Renew'
#    option src 'wan'
#    option proto 'udp'
#    option dest_port '68'
#    option target 'ACCEPT'
#    option family 'ipv4'
#config rule
#    option name 'Allow-Ping'
#    option src 'wan'
#    option proto 'icmp'
#    option icmp_type 'echo-request'
#    option family 'ipv4'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-IGMP'
#    option src 'wan'
#    option proto 'igmp'
#    option family 'ipv4'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-DHCPv6'
#    option src 'wan'
#    option proto 'udp'
#    option dest_port '546'
#    option family 'ipv6'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-MLD'
#    option src 'wan'
#    option proto 'icmp'
#    option src_ip 'fe80::/10'
#    list icmp_type '130/0'
#    list icmp_type '131/0'
#    list icmp_type '132/0'
#    list icmp_type '143/0'
#    option family 'ipv6'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-ICMPv6-Input'
#    option src 'wan'
#    option proto 'icmp'
#    list icmp_type 'echo-request'
#    list icmp_type 'echo-reply'
#    list icmp_type 'destination-unreachable'
#    list icmp_type 'packet-too-big'
#    list icmp_type 'time-exceeded'
#    list icmp_type 'bad-header'
#    list icmp_type 'unknown-header-type'
#    list icmp_type 'router-solicitation'
#    list icmp_type 'neighbour-solicitation'
#    list icmp_type 'router-advertisement'
#    list icmp_type 'neighbour-advertisement'
#    option limit '1000/sec'
#    option family 'ipv6'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-ICMPv6-Forward'
#    option src 'wan'
#    option dest '*'
#    option proto 'icmp'
#    list icmp_type 'echo-request'
#    list icmp_type 'echo-reply'
#    list icmp_type 'destination-unreachable'
#    list icmp_type 'packet-too-big'
#    list icmp_type 'time-exceeded'
#    list icmp_type 'bad-header'
#    list icmp_type 'unknown-header-type'
#    option limit '1000/sec'
#    option family 'ipv6'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-IPSec-ESP'
#    option src 'wan'
#    option dest 'lan'
#    option proto 'esp'
#    option target 'ACCEPT'
#config rule
#    option name 'Allow-ISAKMP'
#    option src 'wan'
#    option dest 'lan'
#    option proto 'udp'
#    option dest_port '500'
#    option target 'ACCEPT'
#config forwarding
#    option src 'lan'
#    option dest 'wan'
#EOF
#
## Add auto mount for USB devices
#mkdir -p files/etc/uci-defaults
#cat > files/etc/uci-defaults/99-usb-mount <<'EOF'
#uci set fstab.@mount[0].enabled='1'
#uci set fstab.@mount[0].target='/mnt/usb'
#uci set fstab.@mount[0].device='/dev/sda1'
#uci set fstab.@mount[0].fstype='auto'
#uci set fstab.@mount[0].options='rw,sync'
#uci commit fstab
#EOF
#
## Enable IPV6 (if needed)
#echo "net.ipv6.conf.all.disable_ipv6=0" >> files/etc/sysctl.conf
#echo "net.ipv6.conf.default.disable_ipv6=0" >> files/etc/sysctl.conf
#echo "net.ipv4.ip_forward=1" >> files/etc/sysctl.conf
#echo "net.ipv6.conf.all.forwarding=1" >> files/etc/sysctl.conf
#
## Add auto update script
#mkdir -p files/usr/bin
#cat > files/usr/bin/dailook-update.sh <<'EOF'
##!/bin/sh
#echo "Starting firmware update..."
#sysupgrade -v /tmp/firmware.bin
#EOF
#
## Add system service
#cat > files/etc/init.d/dailook-init <<'EOF'
##!/bin/sh /etc/rc.common
#START=99
#start() {
#    echo "dailook init service started"
#}
#stop() {
#    echo "dailook init service stopped"
#}
#EOF
#chmod +x files/etc/init.d/dailook-init
#
## Add custom startup script
#cat > files/etc/rc.local <<'EOF'
##!/bin/sh
## Put your custom commands here that should be executed once
## the system init finished. By default this file does nothing.
#exit 0
#EOF
#chmod +x files/etc/rc.local

## Modify default shell (optional)
#sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd
#sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/shadow

# Add additional feed packages (if needed)
#echo 'src-git custom https://github.com/custom/repo' >> feeds.conf.default

# Enable Docker (optional)
#echo "CONFIG_PACKAGE_docker=y" >> .config

# Enable USB storage (optional)
#echo "CONFIG_PACKAGE_kmod-usb-storage=y" >> .config
#echo "CONFIG_PACKAGE_kmod-fs-ext4=y" >> .config
#echo "CONFIG_PACKAGE_block-mount=y" >> .config

# Reset ubus? no need for now
#echo "CONFIG_PACKAGE_ubus=y" >> .config

# Enable SMB (optional)
#echo "CONFIG_PACKAGE_samba4-server=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-samba4=y" >> .config

# Enable NFS (optional)
#echo "CONFIG_PACKAGE_kmod-fs-nfs=y" >> .config
#echo "CONFIG_PACKAGE_kmod-fs-nfs-common=y" >> .config
#echo "CONFIG_PACKAGE_nfs-utils=y" >> .config

# Enable upnp
#echo "CONFIG_PACKAGE_miniupnpd=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-upnp=y" >> .config

# Enable DDNS (optional)
#echo "CONFIG_PACKAGE_ddns-scripts=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-ddns=y" >> .config

# Enable QoS (optional)
#echo "CONFIG_PACKAGE_luci-app-sqm=y" >> .config
#echo "CONFIG_PACKAGE_sqm-scripts=y" >> .config

# Enable VPN (optional)
#echo "CONFIG_PACKAGE_luci-app-openvpn=y" >> .config
#echo "CONFIG_PACKAGE_openvpn-openssl=y" >> .config

# Enable WireGuard (optional)
#echo "CONFIG_PACKAGE_luci-app-wireguard=y" >> .config
#echo "CONFIG_PACKAGE_kmod-wireguard=y" >> .config
#echo "CONFIG_PACKAGE_wireguard-tools=y" >> .config

# Enable Adblock (optional)
#echo "CONFIG_PACKAGE_luci-app-adblock=y" >> .config
#echo "CONFIG_PACKAGE_adblock=y" >> .config

# Enable USB Printer (optional)
#echo "CONFIG_PACKAGE_kmod-usb-printer=y" >> .config
#echo "CONFIG_PACKAGE_p910nd=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-p910nd=y" >> .config

# Enable FTP (optional)
#echo "CONFIG_PACKAGE_vsftpd=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-vsftpd=y" >> .config

# Enable file browser (optional)
#echo "CONFIG_PACKAGE_luci-app-filebrowser=y" >> .config

# Enable transmission (optional)
#echo "CONFIG_PACKAGE_transmission-daemon=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-transmission=y" >> .config

# Add custom config patch for netcore_n60pro 512rom ROM profile (8821CU?)
#mkdir -p package/kernel/mt76/patches
#cat > package/kernel/mt76/patches/100-mt7986-n60pro-512rom.patch <<'EOF'
#!!!此补丁需根据官方 MT7986 芯片资料自行编写!!!
#EOF

# Replace default firewall rules (optional)
#cat > files/etc/config/firewall <<'EOF'
#config defaults
#    option input 'ACCEPT'
#    option output 'ACCEPT'
#    option forward 'ACCEPT'
#config zone
#    option name 'lan'
#    list network 'lan'
#    option input 'ACCEPT'
#    option output 'ACCEPT'
#    option forward 'ACCEPT'
#config zone
#    option name 'wan'
#    list network 'wan'
#    list network 'wan6'
#    option input 'REJECT'
#    option output 'ACCEPT'
#    option forward 'REJECT'
#    option masq '1'
#    option mtu_fix '1'
#config forwarding
#    option src 'lan'
#    option dest 'wan'
#EOF

# Modify default NTP server (optional)
#sed -i 's/0.openwrt.pool.ntp.org/ntp.aliyun.com/g' feeds/packages/net/ntpd/files/ntpd.init
#sed -i 's/1.openwrt.pool.ntp.org/ntp1.aliyun.com/g' feeds/packages/net/ntpd/files/ntpd.init
#sed -i 's/2.openwrt.pool.ntp.org/ntp2.aliyun.com/g' feeds/packages/net/ntpd/files/ntpd.init
#sed -i 's/3.openwrt.pool.ntp.org/ntp3.aliyun.com/g' feeds/packages/net/ntpd/files/ntpd.init

# Modify default DNS (optional)
#sed -i 's/nameserver 114.114.114.114/nameserver 223.5.5.5/g' package/base-files/files/etc/resolv.conf

# Custom modification of luci menu (optional)
#sed -i 's/"admin"/"root"/g' feeds/luci/modules/luci-base/luasrc/controller/admin/index.lua

# Apply additional configurations for N60 Pro (MT7986 platform) if needed.
#Follow the official doc for the mt7986 target board config...
#sed -i 's/mt7986/mt7986a/g' target/linux/mediatek/image/mt7986.mk 2>/dev/null || true

# Apply additional configurations for N60 Pro (MT7986 platform) if needed.
#Follow the official doc for the mt7986 target board config...
#sed -i 's/mt7986/mt7986a/g' target/linux/mediatek/image/mt7986.mk 2>/dev/null || true

# Enable K6C driver?? (maybe not available)
#sed -i 's/CONFIG_K6C=m/CONFIG_K6C=y/g' target/linux/mediatek/mt7986/config-default 2>/dev/null || true

# Enable temperature sensor support (N60 Pro features)
#echo "CONFIG_PACKAGE_kmod-thermal=y" >> .config
#echo "CONFIG_PACKAGE_kmod-hwmon-core=y" >> .config
#echo "CONFIG_PACKAGE_lm-sensors=y" >> .config

# Add kernel patch for Netcore N60 Pro 512M NAND (MT7986a) support
# cp files/

# Modify default TTL value to 64 for better network sharing (optional)
#echo "net.ipv4.ip_default_ttl=64" >> files/etc/sysctl.conf

# Add custom cron jobs (optional)
#mkdir -p files/etc/crontabs
#echo "0 3 * * * /sbin/reboot" > files/etc/crontabs/root

# Enable IPv6 NAT (optional)
#echo "CONFIG_PACKAGE_ip6tables-nft=y" >> .config

# Enable smartdns (optional)
#echo "CONFIG_PACKAGE_luci-app-smartdns=y" >> .config
#echo "CONFIG_PACKAGE_smartdns=y" >> .config

# Enable PassWall (optional)
#echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
#echo "CONFIG_PACKAGE_luci-app-passwall2=y" >> .config

# Enable OpenClash (optional)
#echo "CONFIG_PACKAGE_luci-app-openclash=y" >> .config

# Add luci-app-advancedplus plugin (optional)
#echo "CONFIG_PACKAGE_luci-app-advancedplus=y" >> .config

# Add scientific plugin (optional)
#echo "CONFIG_PACKAGE_luci-app-scientific=y" >> .config

# Add server chan (optional)
#echo "CONFIG_PACKAGE_luci-app-serverchan=y" >> .config

# Add file assistant (optional)
#echo "CONFIG_PACKAGE_luci-app-fileassistant=y" >> .config

# Add lucky (optional)
#echo "CONFIG_PACKAGE_luci-app-lucky=y" >> .config

# Enable mwan3 load balancing (optional)
#echo "CONFIG_PACKAGE_luci-app-mwan3=y" >> .config

# Enable nlbwmon traffic monitoring (optional)
#echo "CONFIG_PACKAGE_luci-app-nlbwmon=y" >> .config

# Modify nlbwmon default settings (optional)
#sed -i 's/option database_directory.*/option database_directory '\/tmp\/nlbwmon'/' feeds/luci/applications/luci-app-nlbwmon/root/etc/config/nlbwmon

# Enable uninstall packages (optional)
#echo "CONFIG_PACKAGE_luci-app-unblockmusic=y" >> .config

# Enable uninstall packages (optional)
#echo "CONFIG_PACKAGE_luci-app-unblockmusic=y" >> .config

# Enable Frps NAT (optional)
#echo "CONFIG_PACKAGE_luci-app-frps=y" >> .config
#echo "CONFIG_PACKAGE_frps=y" >> .config

# Enable AliDDNS (optional)
#echo "CONFIG_PACKAGE_luci-app-aliddns=y" >> .config
#echo "CONFIG_PACKAGE_ddns-scripts-aliyun=y" >> .config

# Additional customizations can be added below
# OpenWrt DIY script part 2 ends here

# Modify default WLAN settings for 5G (optional)
#sed -i 's/option channel 'auto'/option channel '36'/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default WLAN settings for 2.4G (optional)
#sed -i 's/option channel 'auto'/option channel '6'/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Enable wireless client mode (optional)
#echo "CONFIG_PACKAGE_kmod-mt7915e=y" >> .config

# Modify package list (optional)
#echo "CONFIG_PACKAGE_kmod-mt7915e=y" >> .config

# Modify default gateway address (if needed)
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# Add Chinese language support (optional)
#echo "CONFIG_PACKAGE_luci-i18n-base-zh-cn=y" >> .config
#echo "CONFIG_PACKAGE_luci-i18n-firewall-zh-cn=y" >> .config
#echo "CONFIG_PACKAGE_luci-i18n-opkg-zh-cn=y" >> .config

# Add custom kernel modules (optional)
#echo "CONFIG_PACKAGE_kmod-usb-net=y" >> .config
#echo "CONFIG_PACKAGE_kmod-usb-net-rndis=y" >> .config
#echo "CONFIG_PACKAGE_kmod-usb-net-cdc-ether=y" >> .config
#echo "CONFIG_PACKAGE_kmod-usb-net-cdc-ncm=y" >> .config

# Modify default syslog settings (optional)
#sed -i 's/option log_size 64/option log_size 128/g' package/system/fstools/files/fstab.config

# Add default user configuration (optional)
#mkdir -p files/etc/uci-defaults
#cat > files/etc/uci-defaults/99-user-settings <<'EOF'
#uci set system.@system[0].hostname='dailook'
#uci set system.@system[0].timezone='CST-8'
#uci set system.@system[0].zonename='Asia/Shanghai'
#uci commit system
#EOF

# Add support for 4G/5G modem with QMI (optional)
#mkdir -p files/etc/config
#cat > files/etc/config/network <<'EOF'
#config interface 'wan'
#    option device 'eth1'
#    option proto 'qmi'
#    option device_type 'usb'
#    option apn 'internet'
#    option auth 'none'
#EOF

# Add support for USB tethering (optional)
#echo "CONFIG_PACKAGE_kmod-usb-net-rndis=y" >> .config

# Add custom feed source for additional packages (optional)
#echo 'src-git custom3 https://github.com/custom3/repo' >> feeds.conf.default

# Add custom package source for Luci app store (optional)
#echo 'src-git custom4 https://github.com/custom4/repo' >> feeds.conf.default

# Enable Wake-on-LAN (optional)
#echo "CONFIG_PACKAGE_luci-app-wol=y" >> .config
#echo "CONFIG_PACKAGE_etherwake=y" >> .config

# Enable scheduled tasks (optional)
#echo "CONFIG_PACKAGE_luci-app-scheduledtasks=y" >> .config

# Enable VPN server (optional)
#echo "CONFIG_PACKAGE_luci-app-vpnserver=y" >> .config

# Enable adguard home (optional)
#echo "CONFIG_PACKAGE_luci-app-adguardhome=y" >> .config
#echo "CONFIG_PACKAGE_adguardhome=y" >> .config

# Add custom package (optional)
#echo "CONFIG_PACKAGE_kmod-usb-acm=y" >> .config
#echo "CONFIG_PACKAGE_kmod-usb-serial=y" >> .config

# Enable USB audio (optional)
#echo "CONFIG_PACKAGE_kmod-sound-core=y" >> .config

# Enable USB camera (optional)
#echo "CONFIG_PACKAGE_kmod-video-core=y" >> .config

# Custom DIY part 2 script ends here
# If you have additional customizations, add them below.
# To verify the current OpenWrt version, use the command below (optional)
#cat /etc/openwrt_release
# End of DIY script

# Fix default interface name for N60 Pro (eth1 is WAN on this device)
sed -i 's/option device '\''eth0'\''/option device '\''eth1'\''/g' package/base-files/files/etc/board.d/02_network 2>/dev/null || true
# Fix default interface name for N60 Pro (eth1 is WAN on this device)
sed -i 's/option device '\''eth0'\''/option device '\''eth1'\''/g' package/base-files/files/etc/board.d/02_network 2>/dev/null || true
# Fix default interface name for N60 Pro (eth1 is WAN on this device)
sed -i 's/option device '\''eth0'\''/option device '\''eth1'\''/g' package/base-files/files/etc/board.d/02_network 2>/dev/null || true
# Fix default interface name for N60 Pro 5G (eth2 is 5G WAN)
sed -i 's/option device '\''eth0'\''/option device '\''eth2'\''/g' package/base-files/files/etc/board.d/02_network 2>/dev/null || true

# Add custom user script for OpenWrt startup
#cat > files/etc/uci-defaults/99-custom-init <<'EOF'
#uci set system.@system[0].hostname='dailook'
#uci set system.@system[0].timezone='CST-8'
#uci commit system
#EOF
#chmod +x files/etc/uci-defaults/99-custom-init

# Verify the build environment
#echo "Build environment verified."

# Verify package dependencies
#opkg list-installed | grep -E "luci|firewall|dnsmasq"

# Final checks before building
#echo "All customizations applied successfully."
#exit 0
