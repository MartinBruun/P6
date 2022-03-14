from datetime import date
import json
import os
from flask import Flask, request
from matplotlib.font_manager import json_load
import data_models
import boxFunctionality
from washee_box.data_models.machine import Machine
from washee_box.use_cases.boxFunctionality import boxFunctionality
app = Flask(__name__)

machine_name = ['#1', '#2', '#3', '#4']


@app.route('/')
def menu():
    machine_name_string = ""
    for machineName in machine_name:
        machine_name_string = machine_name_string + \
            "\n  <a href='/unlock'>" + machineName + "</a>"

    return "<p> booking kalender</p> \n <p>oplås maskine:" + machine_name_string + "</p>"


@app.route('/getMachinesInfo')
def getMachinesInfo():
    # with open("data_models/machineList.json", "r") as file:
    #     mList = json.loads(file.read())
    return boxFunctionality.getMachinesInfo()

# recieves a json machine and a duration
##


@app.route('/unlock', methods=['GET', 'POST'])
def unlock():
    temp = request.get('machine')
    tempobj = json.loads(temp)
    duration = 120
    machine = Machine(**tempobj)

    # id = "l1"  # get machine id from GET req
    # duration = 30  # get duration from GET req
    # now = date()
    # endtime = now + duration
    # file = open(r'./use_cases/relay.py', 'r').read()
    # exec(file)
    boxFunctionality.unlockMachine(
        machine, duration)  # maybe leaveout duration
    # boxFunctionality.scheduleLocking(id, endtime)
    return "<a href='/'> Machine has been unlocked and scheduled to lock in </a>"


@app.route('/lock', methods=['GET', 'POST'])
def lock():
    id = "l1"
    # file = open(r'./use_cases/relay.py', 'r').read()
    # exec(file)
    boxFunctionality.lockMachine(id)

    return "<a href='/'> Machine id has been locked </a>"


@app.route('/scheduleBooking', methods=['GET', 'POST'])
def schedule():
    id = "l1"
    starttime = date()
    duration = 120
    endtime = starttime + duration
    boxFunctionality.scheduleUnLocking(id, starttime)
    boxFunctionality.scheduleLocking(id, endtime)
    return "<a href='/'> Machine has been unlocked </a>"


if __name__ == "__main__":
    debug = False if int(os.environ.get(
        "BOX_DEBUG", default="1")) == 0 else True
    port = int(os.environ.get("BOX_PORT"))
    host = os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')
