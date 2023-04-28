#!/bin/bash
#coded by: zero-zoro
echo -e "\nEnter your desired UDP port (choose between 1-65535):"
read udpPort

if [[ $udpPort -gt 65535 || $udpPort -lt 1 ]]; then
  echo "error: your port value is out of range"
  exit 1;
fi
apt update -y
apt install git cmake -y
rm -rf /root/badvpn
git clone https://github.com/ambrop72/badvpn.git /root/badvpn
mkdir /root/badvpn/badvpn-build
cd  /root/badvpn/badvpn-build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1 
wait
make 
wait
cp udpgw/badvpn-udpgw /usr/local/bin/
systemctl disable ssh-udp.service
rm -rf /etc/systemd/system/ssh-udp.service
wait
cat >> /etc/systemd/system/ssh-udp.service <<EOF
[Unit]
Description=SSH-VPN for UDP

[Service]
User=root
Restart=always
Type=simple
ExecStart=/usr/local/bin/badvpn-udpgw --loglevel none --listen-addr 127.0.0.1:$udpPort

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
wait
systemctl enable ssh-udp.service
wait
service ssh-udp restart
clear
echo "your SSH-VPN UDP port: $udpPort"
