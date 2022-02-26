# Washee-box
## This box handles: 
communication with the washingmachine locks.
local temp storing of transactions
logging errors
communication with washee-web (potentially)
communication with input devices like fingerprint scanner,nfc,wifi-to mobileapp, water sensor, maintennance sensors...


# Startup procedure on hardware
## if not created create virtual environment
python3 -m venv venv
## start virtual environment
. venv/bin/activate
## to check that the folder is owned by the washee-user (pi)
stat venv
## pip install -r requirements.txt
### (touch washee-box-entry.py)
### (opret flask route file kommandoer)
## export FLASK_APP=washee-box-entry.py
## flask run --host=0.0.0.0
## (sudo shutdown)








# Setup:
## accesspoint:
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install hostapd
sudo systemctl unmask hostpad
sudo systemctl enable hostpad

sudo apt-get install dnsmasq

sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent
```

## setup router
```sudo nano /etc/dhcpcd.conf```
### add to file
```
inteface wlan0
	static ip_address=10.10.80.1/24
	nohook wpa_supplicant
```

## to enable routing via eth0 create a new file
```
sudo nano /etc/sysctl.d/routed-ap.conf
```
### add to file
```
# Enable IPv4 routing
net.ipv4.ip_forward=1
```
## create firewall rule that does nat translation
```
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
```
## copy the original dhcp/dns setup file and create a new
```
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo nano /etc/dnsmasq.conf
``` 
### add to file (it is important that the ip in dhcpcd.conf is in the same network as the dhcp pool)
```
#Listening interface for DHCP requests
interface=wlan0 
#DHCP pool
dhcp-range=10.10.80.20,10.10.80.30,255.255.255.0,24h
#Local wireless DNS domain
domain=wlan
#Alias for this router
address=/washee-box.wlan/10.10.80.1
```
## ensure wifi is not blocked:
```sudo rfkill unblock wlan``` 

## setup accesspoint
```sudo nano /etc/hostapd/hostapd.conf```

### add to file
```
country_code=DK
interface=wlan0
ssid=washee-box
wpa_passphrase=raspberry
hw_mode=g
channel=7
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
``` 
## restart accesspoint
```sudo systemctl reboot``` 



# setting up the washee app

## install flask
## cd washee_box/
## python3 -m venv venv

## start virtual environment
. venv/bin/activate
## to check that the folder is owned by the washee-user (pi)
stat venv
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

