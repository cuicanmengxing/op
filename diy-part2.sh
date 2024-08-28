#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

git pull

echo "src-git small8 https://github.com/kenzok8/small-package" >> feeds.conf.default

./scripts/feeds clean
./scripts/feeds update -a

\rm -rf ./feeds/luci/applications/{luci-app-passwall,luci-app-smartdns,luci-app-ddns-go,luci-app-rclone,luci-app-ssr-plus,luci-app-vssr}
\rm -rf ./feeds/luci/themes/luci-theme-argon
\rm -rf ./feeds/packages/net/{haproxy,xray-core,xray-plugin,mosdns,smartdns,ddns-go,dns2tcp,dns2socks}
\rm -rf ./feeds/small8/{ppp,firewall,dae,daed,daed-next,libnftnl,nftables,dnsmasq}

if [[ -d ./feeds/packages/lang/golang ]]; then
	\rm -rf ./feeds/packages/lang/golang
	git clone https://github.com/sbwml/packages_lang_golang -b 22.x ./feeds/packages/lang/golang
fi

./scripts/feeds update -i
./scripts/feeds install -f -ap packages
./scripts/feeds install -f -ap luci
./scripts/feeds install -f -ap routing
./scripts/feeds install -f -ap telephony

./scripts/feeds install -p small8 -f luci-app-adguardhome xray-core xray-plugin dns2tcp dns2socks haproxy \
luci-app-passwall luci-app-mosdns luci-app-smartdns luci-app-ddns-go luci-app-cloudflarespeedtest taskd \
luci-lib-xterm luci-lib-taskd luci-app-store quickstart luci-app-quickstart luci-app-istorex luci-theme-argon
