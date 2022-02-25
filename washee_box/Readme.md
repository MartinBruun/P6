# Washee-box
## This box handles: 
communication with the washingmachine locks.
local temp storing of transactions
logging errors
communication with washee-web (potentially)
communication with input devices like fingerprint scanner,nfc,wifi-to mobileapp, water sensor, maintennance sensors...

# install flask
## cd washee_box/
## python3 -m venv venv
## setup ipv4 forwarding
```sysctl net.ipv4.ip_forward=1```

```sudo nano  /etc/sysctl.conf````
remove uncommented from the line : sysctl net.ipv4.ip_forward=1

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install hostapd
sudo apt-get install dnsmasq
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq
```
## setup dhcp
```sudo nano /etc/dhcpcd.conf```
add the follewing to the end of the file:

```
interface wlan0
static ip_address=192.168.0.10/24
denyinterfaces eth0
denyinterfaces wlan0
```

## Remove dns DHCP, create new
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo nano /etc/dnsmasq.conf
```
add the following to the new file:
```
interface=wlan0
dhcp-range=192.168.0.11,192.168.0.30,255.255.255.0,24h
```

## Setup Accesspoint
```
sudo nano /etc/hostapd/hostapd.conf
```
add the following to the new file:
```
interface=wlan0
bridge=br0
hw_mode=g
channel=7
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
ssid=WASHEE_BOX
wpa_passphrase=WASHEEBOX
```

## tell system where the setup file is located
```
sudo nano /etc/default/hostapd
```
add the following to the file:
``` 
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

## dont do the forwarding, we want to keep the traffic on the box
sudo nano /etc/sysctl.conf
Now find this line:

#net.ipv4.ip_forward=1
…and keep/add the “#” – leaving the rest, so it just reads:

net.ipv4.ip_forward=0

## dont add ip tables
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
…and save the new iptables rule:

sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
To load the rule on boot, we need to edit the file /etc/rc.local and add the following
line just above the line exit 0:

iptables-restore < /etc/iptables.ipv4.nat

## install bridge
``` 
sudo apt-get install bridge-utils
sudo brctl addbr br0
sudo brctl addif br0 eth0
```

``` 
sudo nano /etc/network/interfaces
```

add to end of file:
``` 
auto br0
iface br0 inet manual
bridge_ports eth0 wlan0
```




## . venv/bin/activate
## stat venv #to check that the folder is owned by the washee-user (pi)
## pip install -r requirements.txt
## touch washee-box-entry.py
## opret flask route file kommandoer
## export FLASK_APP=washee-box-entry.py
## flask run --host=0.0.0.0
## sudo shutdown


## Backup the pi:
```ssh pi@raspberrypi.local “sudo dd if=/dev/mmcblk0 bs=1M | gzip -” | dd of=~/Desktop/backup_2022_02_24.gz````
change the ip and the backupname

## Restore the pi:
Open the terminal session and fire the following line, adjusting the red parts (target disk {SD card} and file name of the backup):
 
```
diskutil unmountDisk /dev/disk1
gzip -dc ~/Desktop/backup_2017-11-14.gz | sudo dd of=/dev/rdisk1 bs=1m conv=noerror,sync
```

