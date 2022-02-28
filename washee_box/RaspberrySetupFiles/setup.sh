#/bin/sh
#
# Don't change the following lines unless you know what you are doing
# They execute the config options starting with 'do_' below
grep -E -v -e '^\s*#' -e '^\s*$' <<END | \
sed -e 's/$//' -e 's/^\s*/\/usr\/bin\/raspi-config nonint /' | bash -x -
#
############# INSTRUCTIONS ###########
#
# Change following options starting with 'do_' to suit your configuration
#
# Anything after a has '#' is ignored and used for comments
#
# If on Windows, edit using Notepad++ or another editor that can save the file
# using UNIX-style line endings
#
# macOS and GNU/Linux use UNIX-style line endings - use whatever editor you like
#
# Then drop the file into the boot partition of your SD card
#
# After booting the Raspberry Pi, login as user 'pi' and run following command:
#
# sudo /boot/raspi-config.txt
#
############# EDIT raspi-config SETTINGS BELOW ###########
# Hardware Configuration
do_boot_wait 0            # Turn off waiting for network before booting
do_boot_splash 1          # Disable the splash screen
do_overscan 1             # Disable overscan
do_camera 1               # Disable the camera
do_ssh 1                  # Enable remote ssh login
do_spi 1                  # Disable spi bus
do_memory_split 64        # Set the GPU memory limit to 64MB
do_i2c 1                  # Disable the i2c bus
do_serial 1               # Disable the RS232 serial bus
do_boot_behaviour B4      # Boot to Graphical & auto login as pi user
#                 B1      # Boot to CLI & require login
#                 B2      # Boot to CLI & auto login as pi user
#                 B3      # Boot to Graphical & require login
#                 B4      # Boot to Graphical & auto login as pi user
do_onewire 1              # Disable onewire on GPIO4
do_audio 0                # Auto select audio output device
#        1                # Force audio output through 3.5mm analogue jack
#        2                # Force audio output through HDMI digital interface
#do_gldriver G1           # Enable Full KMS Opengl Driver - must install deb package first
#            G2           # Enable Fake KMS Opengl Driver - must install deb package first
#            G3           # Disable opengl driver (default)
#do_rgpio 1               # Disable gpio server - must install deb package first
# System Configuration
do_configure_keyboard dk                     # Specify US Keyboard
do_hostname washeebox                         # Set hostname to 'rpi-test'
do_wifi_country DA                           # Set wifi country as Australia
do_wifi_ssid_passphrase washee-net washee-box   # Set wlan0 network to join 'wifi_name' network using 'password'
do_change_timezone Copenhagen               # Change timezone to Brisbane Australia
do_change_locale en_UK.UTF-8                 # Set language to  English
#Don't add any raspi-config configuration options after 'END' line below & don't remove 'END' line
END
############# CUSTOM COMMANDS ###########
# You may add your own custom GNU/Linux commands below this line
# These commands will execute as the root user
# Some examples - uncomment by removing '#' in front to test/experiment
#/usr/bin/raspi-config do_wifi_ssid_passphrase # Interactively configure the wifi network
#/usr/bin/aptitude update                      # Update the software package information
#/usr/bin/aptitude upgrade                     # Upgrade installed software to the latest versions
#/usr/bin/raspi-config do_change_pass          # Interactively set password for your login
#/sbin/shutdown -r now  
sudo apt-get update
sudo apt-get upgrade                       # Reboot after all changes above complete
cd $home/home/pi/code/P6/washee_box
python3 -m venv venv
pip install -r requirements.txt
. venv/bin/activate

sudo chmod +x /etc/rc.local

