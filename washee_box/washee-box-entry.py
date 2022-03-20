from datetime import datetime
import json
import os
from flask import Flask, request

from gpiozero import LED
from gpiozero.pins.pigpio import PiGPIOFactory
from time import sleep
import dateutil.parser
import threading
from pprint import pprint

# import data_models
# from use_cases.boxFunctionality import unlockMachine
machinefactory = PiGPIOFactory(host='192.168.88.32')
app = Flask(__name__)

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
    return getMachinesInfo()

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
    pin = getPin(id)
    machine = data
    machine["pin"]=pin
    pprint(machine)

    t = threading.Thread(name="powering_machine", target=unlockMachineInThread, args=(machine,duration))
    t.start()
   
    return "<a href='/'> Machine has been unlocked and scheduled to lock at "+ str(machine["endTime"]) + " </a>"
    # else :
    #     return "<a href='/'> Machine cold not be unlocked </a>"



@app.route('/lock', methods=['GET', 'POST'])
def lockEndPoint():
    machineJson = request.get_json()
    id = machineJson["machineID"]
    machineJson["pin"] = getPin(id)
    # file = open(r'./use_cases/relay.py', 'r').read()
    # exec(file)
    lockMachine(machineJson)

    return "<a href='/'> Machine id has been locked </a>"

@app.route('/getlog', methods=['GET', 'POST'])
def getLogEndPoint():
    
    return getLogFile()
    

@app.route('/allon', methods=['GET', 'POST'])
def allPinsOnEndPoint():
    allOn()
    return "<a href='/'> all on relay test performed </a>"


@app.route('/resetpins', methods=['GET', 'POST'])
def resetEndPoint():
    resetAllPins()
    return "<a href='/'>all reset relay test performed </a>"

@app.route('/factoryreset', methods=['GET', 'POST'])
def reset():
    reset_factory_setup()
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
for i in range(1,28) :
    print("reset pin:" + str(i))
  
    led = LED(i)
    led.close()
    sleep(0.05)
    




if __name__ == "__main__":
    debug = False if int(os.environ.get(
        "BOX_DEBUG", default="1")) == 0 else True
    port = int(os.environ.get("BOX_PORT"))
    host = os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')





###################################
#flyt til anden fil

def lockMachine(machine):
        # pin = getPin(machine["id"])
        LED(machine["pin"]).close()

def unlockMachineInThread(*arg):
        unlockMachine(arg[0],arg[1])
   

def unlockMachine(machine, duration,user = "user??", account = "account??"):
    now = datetime.now()


    #update machine so that users get notified of the changed machine status when fetching the machine list
    #the update should write to the machinelist file
    machine["startTime"] = now
    logmessage = "startTime:"+str(now)+ " ; endTime:" + str(machine["endTime"])  +"; duration:" +str(duration).format(
        "hh:mm")
    writeToLog(account, user , machine, logmessage)

    #TODO: this should be optimized so that the max_wash_time value is fetched when this file is loaded
    max_wash_time = getWashTimeLimit()
    timeLeft = min(max_wash_time, duration)
    relayport = LED(machine["pin"]) #power on relay
    while timeLeft > 0:
        print(machine["machineID"],  timeLeft)
        sleep(1)
        timeLeft -= 1
    relayport.close() #make relay available for other functioncalls
    
    #update machine so that users get notified of the changed machine status when fetching the machine list
    #the update should write to the machinelist file
    machine["endTime"] = datetime.now()
    logmessage = "machine turned off ; endTime:" + str(machine["endTime"])
    writeToLog(account, user , machine, logmessage)

    if duration > 0 :
        return True
    else :
        return False


def scheduleLocking(id, endtime):

    raise Exception("not implemented")


def scheduleUnLocking(id, starttime):

    raise Exception("not implemented")


def getMachinesInfo():
    with open("data_setup_files/machine_list.json", "r") as file:
        machines = json.loads(file.read())
        machines["last_fetched"]=datetime.now()

    return machines

def getUserssInfo():
     with open("data_setup_files/allowed_users.json", "r") as file:
        users = json.loads(file.read())
        users["last_fetched"]=datetime.now()

def getWashTimeLimit():
     with open("data_setup_files/max_washing_time.json", "r") as file:
        max_wash_time_json = json.loads(file.read())
        return max_wash_time_json["MAX_WASHINGTIME_IN_SEC"]


def getLogFile():
    with open("data_collection/log.txt", "r") as file:
        logFile = file.read()

    return logFile


       

    



## hardware

def testRelay(duration):
    from gpiozero import LED
    from time import sleep
    # led1 = LED(1)
    # led2 = LED(2)
    # led3 = LED(3)
    relayport4 = LED(4)
    relayport5 = LED(5)
    relayport6 = LED(6)
    relayport7 = LED(7)
    relayport8 = LED(8)
    relayport9 = LED(9)
    relayport10 = LED(10)
    relayport11 = LED(11)
    relayport12 = LED(12)
    relayport13 = LED(13)
    relayport14 = LED(14)
    relayport15 = LED(15)
    relayport16 = LED(16)
    relayport17 = LED(17)
    relayport18 = LED(18)
    relayport19 = LED(19)
    relayport20 = LED(20)
    relayport21 = LED(21)
    relayport22 = LED(22)

    relayport23 = LED(23)
    relayport24 = LED(24)
    relayport25 = LED(25)
    relayport26 = LED(26)
    relayport27 = LED(27)


    count = 2
        
    while count > 0:
    
        print("Hello World from Jakob"+ str(count))
        
        relayport17.off()
        sleep(0.1)
        relayport27.off()
        sleep(0.1)
        relayport12.off()
        sleep(0.1)
        relayport23.off()
        


        count -= 1
    relayport12.blink()
    sleep(duration)
    relayport27.close()
    relayport12.close()
    relayport23.close()
    relayport12.close()


def resetAllPins():
    from gpiozero import LED
    from time import sleep

    for i in range(1,28):
        LED(i).close()
        print("reset pin:" + str(i))


def allOn():
    from gpiozero import LED
    from time import sleep

    for i in range(1,28):
        led = LED(i)
        sleep(0.05)
        led.on()
        sleep(0.1)
        print("power On pin:" + str(i))

# private methods


def writeToLog(account,user, machine, message):
    timestamp = datetime.now()
    machine["startTime"] = str(machine["startTime"])
    machine["endTime"] = str(machine["endTime"])

    with open("data_collection/log.txt", "a+") as f:
        string = f'{str(timestamp)};{account};{user};{machine["machineID"]};{machine["machineType"]};{machine}; {message}' + "\n"
        f.write(string)


def getPin(machineID):

    pin = 21
    if machineID == "l1":
        pin = 17

    elif machineID == "l2":
        pin = 27

    elif machineID == "t1":
        pin = 23

    elif machineID == "t2":
        pin = 12

    return pin

def reset_factory_setup(user=None,password=None):
    if (allowedUser(user,password)):
        print("DONE")
        with open("data_setup_files/setup_box.json", "r") as file:
            setup_data = json.loads(file.read())
            newMachineList(user,password, setup_data["machines"])
            newUserList(user,password,setup_data["users"])
            newWashTimeLimit(user,password,setup_data["MAX_WASHINGTIME_IN_SEC"])
    

def newMachineList(user,password,machines):

    if allowedUser(user,password):
        with open("data_setup_files/machine_list.json", "w") as file:
            # machines["setup_date"]=str(datetime.now())
            now = str(datetime.now())
            data = {
                "last-edited":now,
                "machines":machines
            }

            json.dump(data, file)
            print(data)
        

def newUserList(user,password,users):
    if allowedUser(user,password):
        with open("data_setup_files/allowed_users.json", "w") as file:
            # users["setup_date"]=datetime.now()
            now = str(datetime.now())
            data = {
                "last-edited":now,
                "users":users
            }

            json.dump(data, file)
            print(data)


def newWashTimeLimit(user,password,timelimit_json):
    if allowedUser(user,password):
        with open("data_setup_files/max_washing_time.json", "w") as file:
            # users["setup_date"]=datetime.now()
            now = str(datetime.now())
            data = {
                "last-edited":now,
                "MAX_WASHINGTIME_IN_SEC":timelimit_json
            }

            json.dump(data, file)
            print(data)

def allowedUser(user,password):
    return True


