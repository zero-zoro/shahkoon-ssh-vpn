#!/bin/bash
#coded by: zero-zoro
if [[ $1 -gt 65535 || $1 -lt 1 ]]; then
  echo "your port value is out of range"
  exit 1;
fi
apt update -y
apt install git cmake -y
git clone https://github.com/ambrop72/badvpn.git /root/badvpn
mkdir /root/badvpn/badvpn-build
cd  /root/badvpn/badvpn-build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 
wait
make 
wait
cp udpgw/badvpn-udpgw /usr/local/bin/
cat >> /etc/systemd/system/ssh-udp.service <<EOF
[Unit]
Description=SSH-VPN for UDP

[Service]
User=root
Restart=always
Type=simple
ExecStart=/usr/local/bin/badvpn-udpgw --loglevel none --listen-addr 127.0.0.1:$udp_port

[Install]
WantedBy=multi-user.target
service ssh-udp start
EOF
wait
systemctl enable ssh-udp.service
clear
echo "your SSH-VPN UDP port: $udp_port "
