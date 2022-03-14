from datetime import date
import datetime
import json
import os
from flask import Flask, request

from gpiozero import LED
from gpiozero.pins.pigpio import PiGPIOFactory
from time import sleep
# import data_models
# from use_cases.boxFunctionality import unlockMachine
# factory = PiGPIOFactory(host='192.168.88.32')

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
    with open("data_models/machineList.json", "r") as file:
        mList = json.loads(file.read())
    return mList  # boxFunctionality.getMachinesInfo()

# recieves a json machine and a duration
##


@app.route('/unlock', methods=['GET', 'POST'])
def unlock():
    data = json.dumps(request.json)
    if not data:
        return json.dumps("The url was called with no arguments")

    machine = json.loads(data)
    duration = 120
    # machine = Machine(**tempobj)

    # unlockMachine(
    #     machine, duration)  # maybe leaveout duration
    # boxFunctionality.scheduleLocking(id, endtime)
    return "<a href='/'> Machine has been unlocked and scheduled to lock in </a>"


@app.route('/lock', methods=['GET', 'POST'])
def lock():
    id = "l1"
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    # boxFunctionality.lockMachine(id)

    return "<a href='/'> Machine id has been locked </a>"


@app.route('/scheduleBooking', methods=['GET', 'POST'])
def schedule():
    id = "l1"
    starttime = date()
    duration = 120
    endtime = starttime + duration
    scheduleUnLocking(id, starttime)
    scheduleLocking(id, endtime)
    return "<a href='/'> Machine has been unlocked </a>"


def unlockMachine(machine, duration):
    tempmachine = machine
    tempmachine.startTime = datetime.utcnow()
    tempmachine.endTime = datetime.utcnow()+duration
    pin = getPin(machine.id)
    led = LED(pin, pin_factory=factory)
    led.on()

    #scheduleLocking(tempmachine.id, tempmachine.endTime)
    logmessage = 'f{machine.id} machine started by ; duration: {duration}'.format(
        "hh:mm")
    writeToLog("user?", tempmachine.id, logmessage)
    # raise Exception("not implemented")

    return tempmachine
    # maybe leaveout duration


def scheduleLocking(id, endtime):

    raise Exception("not implemented")


def scheduleUnLocking(id, starttime):

    raise Exception("not implemented")


def getMachinesInfo():
    with open("data_models/machineList.json", "r") as file:
        machines = json.loads(file.read())

    return machines

# private methods


def writeToLog(user, machineID, message):
    timestamp = datetime.now()
    with open("data_models/log.txt", "a+") as f:
        string = f'{str(timestamp)};{machineID}:{user}; {message}' + "\n"
        f.write(string)


def getPin(machineID):
    pin = 21
    if machineID == "l1":
        pin = 16

    elif machineID == "l2":
        pin = 19

    elif machineID == "l3":
        pin = 20

    elif machineID == "t1":
        pin = 26

    elif machineID == "t2":
        pin = 21

    return pin


if __name__ == "__main__":
    debug = False if int(os.environ.get(
        "BOX_DEBUG", default="1")) == 0 else True
    port = int(os.environ.get("BOX_PORT"))
    host = os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')
