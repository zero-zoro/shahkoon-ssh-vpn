# shahkoon ssh vpn panel
a free ssh vpn panel

Telegram:
[@shahan_SSH_panel](https://t.me/shahan_SSH_panel)

## How to install? :)
```
bash <(curl -Ls https://raw.githubusercontent.com/zero-zoro/free-ssh-vpn-panel/main/ssh-vpn_install.sh)
```
## How to add UDP support for call and video calls? :)
```
bash <(curl -Ls https://raw.githubusercontent.com/zero-zoro/shahkoon-ssh-vpn-accounting-panel/main/ssh-vpn-UDP.sh 7300)
```
###### In the above line, you can replace the desired port with **7300**

for stop **ssh-udp** service use:
```service ssh-udp stop```

for unistall service use:
```systemctl disable ssh-udp```

for re install service use:
```systemctl enable ssh-udp```
