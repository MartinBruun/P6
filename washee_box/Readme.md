# Washee-box
## This box handles: 
communication with the washingmachine locks.
local temp storing of transactions
logging errors
communication with washee-web (potentially)
communication with input devices like fingerprint scanner,nfc,wifi-to mobileapp, water sensor, maintennance sensors...


Access raspberry from VSC:
install remote ssh
F1, 
    ssh pi@washeebox.local 
    raspberry
select the folder you want to work from in VSC, retype password when prompted
some files has to be edited using nano, due to restrictions.


washee-box wifi is setup to use 10.10.80.0/24 network
the washee-box is 10.10.80.1 

eth0 gets a dynamic DHCP address

When flask has been started it is availlable on <eth0 IP>:8001, or wifi 10.10.80.1:8001, or washeebox.local:8001
the availlable endpoints can be seen in washee_box_entry.py

To use the washee-box as standalone accesspoint, is not advised for now, it floods the eth0 with DHCP.



# Startup procedure on hardware
## if not created create virtual environment
python3 -m venv venv
## start virtual environment
. venv/bin/activate
## to check that the folder is owned by the washee-user (pi)
stat venv
## pip install -r requirements.txt
### (touch washee_box_entry.py)
### (opret flask route file kommandoer)
flask starts automatically (because of a command saved in etc/rc.local)
else run 
sudo /home/pi/code/P6/washee_box/start-box.sh  (it it will not run you need to ```sudo chmod +x '/home/pi/code/P6/washee_box/start-box.sh'```)
## (export FLASK_APP=washee_box_entry.py)
## (flask run --host=0.0.0.0 --port=8001)
## (sudo shutdown)

## washeebox can now be accessed on ipaddress:8001

##Stop flask: ```sudo kill $(pgrep -f flask)```









##########
this needs cleaning!!!!!



# Setup:
without accesspoint functionality

sudo raspi-config
    activate ssh
    maybe connect to network

cd home/pi/
git clone https://github.com/MartinBruun/P6.git
cd P6
#//git checkout box_ap

new  image copy files :
sudo cp washee_box/RaspberrySetupFiles/etc/rc.local /etc/
sudo cp washee_box/RaspberrySetupFiles/etc/dhcpcd.conf /etc/
sudo cp washee_box/RaspberrySetupFiles/etc/dnsmasq.conf. /etc/
sudo cp /media/pi/rootfs/etc/hosts /etc/
sudo cp /media/pi/rootfs/etc/hostname /etc/


sudo chmod +x /etc/rc.local

cd washee_box
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt

check that flask can be started:
sudo ./start-box.sh






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
## touch washee_box_entry.py
## opret flask route file kommandoer
## update etc/rc.local
        #!/bin/sh -e
        #
        # rc.local
        #
        # This script is executed at the end of each multiuser runlevel.
        # Make sure that the script will "exit 0" on success or any other
        # value on error.
        #
        # In order to enable or disable this script just change the execution
        # bits.
        #
        # By default this script does nothing.

        # Print the IP address
        _IP=$(hostname -I) || true
        if [ "$_IP" ]; then
        printf "My IP address is %s\n" "$_IP"
        fi

        echo "starting up the washee box flask server" > $home/home/pi/Desktop/washee_log.log
        PWD='pwd'

        echo $PWD
        activate () {
            cd $home/home/pi/code/P6/washee_box
            . venv/bin/activate
            export FLASK_APP=washee_box_entry.py
            flask run --host=0.0.0.0
        }
        activate &



        exit 0
## make etc/rc.local executable
    sudo chmod +x etc/rc.local
## export FLASK_APP=washee_box_entry.py
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

