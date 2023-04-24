#!/bin/bash

if command -v apt-get >/dev/null; then
apt update -y
apt-get install build-essential libncurses5-dev libpcap-dev make zip unzip wget -y
elif command -v yum >/dev/null; then
yum update -y
yum install gcc-c++ libpcap-devel.x86_64 libpcap.x86_64 "ncurses*"
fi
sudo wget -O /root/nethogs.zip https://raw.githubusercontent.com/zero-zoro/free-ssh-vpn-panel/main/Nethogs-Json/Nethogs-Json-main.zip
unzip /root/nethogs.zip
mv -f /root/Nethogs-Json-main /root/nethogs
cd /root/nethogs/
chmod 744 /root/nethogs/determineVersion.sh
sudo make install
hash -r
cp /usr/local/sbin/nethogs /usr/sbin/nethogs -f
rm -fr /root/nethogs /root/nethogs.zip
sudo setcap "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe" /usr/local/sbin/nethogs
