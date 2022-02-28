#!/bin/bash -x
#this files content is copied to etc/rc.local to be executed at boot , it activates the python envitronment and starts flask on the network
#to access the box enter http://raspberrypi.local:5000

PWD='pwd'

echo $PWD
activate () {
	cd $home
	. venv/bin/activate
	export FLASK_APP=washee-box-entry.py
	flask run --host=0.0.0.0
}
activate
