import os
from datetime import datetime
from datetime import timedelta
from flask import Flask, request
import dateutil.parser
import threading
from pprint import pprint

from washee_box.main_controller import MainController
from washee_box.hardware.raspberry import Raspberry

# import data_models
# from use_cases.boxFunctionality import unlockMachine
# machinefactory = PiGPIOFactory(host='192.168.88.32')
app = Flask(__name__)
controller = MainController()
raspberry = Raspberry()

# machine_name = ['l1', 'l2', 't1', 't2']
# machine_list = []
# user_list = []
MAX_WASHINGTIME_IN_SEC = 9000 #2timer og 30 min
running = True

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
    machines = controller.getMachinesInfo()
    machine_name_on_string = ""
    for machine in machines["machines"]:
        machine_name_on_string = machine_name_on_string + "\n  <p><a href='/unlock'>" + machine["name"] + " connected to pins "+ str(machine["pin_a"]) + "," + str(machine["pin_b"])  + "</a></p>"

    machine_name_off_string = ""
    for machine in machines["machines"]:
        machine_name_off_string = machine_name_off_string + "\n  <p><a href='/lock'>" + machine["name"] + " connected to pins "+ str(machine["pin_a"]) + "," + str(machine["pin_b"])+ "</a></p>"

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
   
    name = data["name"]
    machineType = data["machineType"]
    if "startTime" in data:
        data["startTime"] = dateutil.parser.parse(data["startTime"])
    
    if "endTime" in data:
        data["endTime"] = dateutil.parser.parse(data["endTime"])

    startTime = data["startTime"]
    endTime = data["endTime"]

    duration = min(controller.getWashTimeLimit(), int((endTime-datetime.now()).total_seconds()))
    
    
    id = data["machineID"]
    pin = controller.getPin(id)
    machine = data
    machine["pin_a"]=pin[0]
    machine["pin_b"]=pin[1]

    ###TODO: her resetter jeg det som brugeren har bedt om , det er nok ikke så smart. ellers så er det???

    now = datetime.now()
    machine["startTime"]= now
    machine["endTime"] = now + timedelta(seconds=duration)

    pprint(machine)

    t = threading.Thread(name="powering_machine", target=controller.unlockMachineInThread, args=(machine,duration))
    t.start()
   
    return machine
    # else :
    #     return "<a href='/'> Machine cold not be unlocked </a>"

@app.route('/lock', methods=['GET', 'POST'])
def lockEndPoint():

    machineJson = request.get_json()
    id = machineJson["machineID"]
    machineJson["pin_a"] = controller.getPin(id)
    # file = open(r'./use_cases/relay.py', 'r').read()
    # exec(file)
    controller.lockMachine(machineJson)

    return "<a href='/'> Machine id has been locked </a>"

@app.route('/getlog', methods=['GET', 'POST'])
def getLogEndPoint():
    
    return controller.getLogFile()
    
@app.route('/allon', methods=['GET', 'POST'])
def allPinsOnEndPoint():
    raspberry.allOn()
    return "<a href='/'> all on relay test performed </a>"

@app.route('/resetpins', methods=['GET', 'POST'])
def resetEndPoint():
    raspberry.resetAllPins()
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
#     sleep(0.2)
#     led.on()
#     sleep(0.1)
#     led.off()
#     sleep(0.1)
#     led.close()
    # sleep(0.05)
    

if __name__ == "__main__":
    debug = False if int(os.environ.get(
        "BOX_DEBUG", default="0")) == 0 else True
    port = int(os.environ.get("BOX_PORT", default="8001"))
    host = os.environ.get("BOX_HOST", default="0.0.0.0")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')




