#!/bin/bash -x
PWD='pwd'

echo $PWD
activate () {
	. venv/bin/activate
	export FLASK_APP=washee-box-entry.py
	flask run --host=0.0.0.0
}
activate
