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
	flask run --host=0.0.0.0 --port=8001
}
activate &

#cd $home/home/pi/code/P6/washee_box
#./$home/home/pi/code/P6/washee_box/start-box.sh &

exit 0

