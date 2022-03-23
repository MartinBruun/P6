from datetime import datetime
import imp
import json
import os
from flask import Flask, request

from gpiozero import LED
# from gpiozero.pins.pigpio import PiGPIOFactory
from time import sleep
import dateutil.parser
import threading
from pprint import pprint

from main_controller import MainController
from config import box_debug

# import data_models
# from use_cases.boxFunctionality import unlockMachine
# machinefactory = PiGPIOFactory(host='192.168.88.32')
app = Flask(__name__)
controller = MainController()

machine_name = ['l1', 'l2', 't1', 't2']
machine_list = []
user_list = []
MAX_WASHINGTIME_IN_SEC = 9000 #2timer og 30 min

#format of a machine:

#     {
#     "machineID" : "l1",
#     "name" : "vaskemaskine1",
#     "machineType" : "laundryMachine",
#     "startTime" : "2022-02-27T13:27:00",
#     "endTime" : "2022-03-27T13:27:00"
# adds pin:xx in the code
# }


@app.route('/')
def menuEndPoint():
    machine_name_on_string = ""
    for machineName in machine_name:
        json_machine = {"id":machine_name}
        machine_name_on_string = machine_name_on_string + \
            "\n  <a href='/unlock'>" + machineName + "</a>"

    machine_name_off_string = ""
    for machineName in machine_name:
        machine_name_off_string = machine_name_off_string + \
            "\n  <a href='/lock'>" + machineName + "</a>"

    return "<p> booking kalender</p> \n <p>tænd strøm til maskine:" + machine_name_on_string + "</p>"+"<p>sluk strøm til maskine:" + machine_name_off_string + "</p>"+ "<p><a href='/resetpins'> reset pins</a></p>" + "<p><a href='/allon'> turn on all machines</a></p>"


@app.route('/getMachinesInfo')
def getMachinesInfoEndPoint():
    return controller.getMachinesInfo()

##Receives a json {user:xxx, machine:{xxxxxxxxxxx} }##
@app.route('/unlock', methods=['GET','POST'])
def unlockEndPoint():
    data = request.get_json()
    # if not data:
    #     return json.dumps("The url was called with no arguments")
    # machine = json.loads(data)
   
    id = data.get("machineID")
    name = data.get("name")
    machineType = data.get("machineType")
    if "startTime" in data:
        data["startTime"] = dateutil.parser.parse(data["startTime"])
    
    if "endTime" in data:
        data["endTime"] = dateutil.parser.parse(data["endTime"])

    startTime = data["startTime"]
    endTime = data["endTime"]

    duration = int((endTime-datetime.now()).total_seconds())
    pin = controller.getPin(id)
    machine = data
    machine["pin"]=pin
    pprint(machine)

    t = threading.Thread(name="powering_machine", target=controller.unlockMachineInThread, args=(machine,duration))
    t.start()
   
    return machine
    # else :
    #     return "<a href='/'> Machine cold not be unlocked </a>"

@app.route('/lock', methods=['GET', 'POST'])
def lockEndPoint():

    machineJson = request.get_json()
    # file = open(r'./use_cases/relay.py', 'r').read()
    # exec(file)
    controller.lockMachine(machineJson, )

    return "<a href='/'> Machine id has been locked </a>"

@app.route('/getlog', methods=['GET', 'POST'])
def getLogEndPoint():
    
    return controller.getLogFile()
    
@app.route('/allon', methods=['GET', 'POST'])
def allPinsOnEndPoint():
    controller.allOn()
    return "<a href='/'> all on relay test performed </a>"

@app.route('/resetpins', methods=['GET', 'POST'])
def resetEndPoint():
    controller.resetAllPins()
    return "<a href='/'>all reset relay test performed </a>"

@app.route('/factoryreset', methods=['GET', 'POST'])
def reset():
    controller.reset_factory_setup()
    return"<a href='/'>factory reset performed </a>"


# @app.route('/scheduleBooking', methods=['GET', 'POST'])
# def schedule():
#     id = "l1"
#     starttime = date()
#     duration = 120
#     endtime = starttime + duration
#     scheduleUnLocking(id, starttime)
#     scheduleLocking(id, endtime)
#     return "<a href='/'> Machine has been unlocked </a>"


#### Reset All pins when restarting ###
# for i in range(1,28) :
#     print("reset pin:" + str(i))
  
#     led = LED(i)
#     led.close()
#     sleep(0.05)
    




if __name__ == "__main__":
    debug = False if int(os.environ.get(
        "BOX_DEBUG", default="1")) == 0 else True
    port = int(os.environ.get("BOX_PORT"))
    host = os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')





###################################
#flyt til anden fil

# Machine

