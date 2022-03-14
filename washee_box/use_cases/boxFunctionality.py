

import datetime
import json
from gpiozero import LED
from time import sleep


class boxFunctionality:

    def __init__(self) -> None:
        pass

    # public methods

    def unlockMachine(machine, duration):
        tempmachine = machine
        tempmachine.startTime = datetime.utcnow()
        tempmachine.endTime = datetime.utcnow()+duration

        led = LED(21)
        led.on()

        #scheduleLocking(tempmachine.id, tempmachine.endTime)
        logmessage = 'f{machine.id} machine started by ; duration: {duration}'.format(
            "hh:mm")
        boxFunctionality.writeToLog("user?", tempmachine.id, logmessage)
        # raise Exception("not implemented")

        return tempmachine
    # maybe leaveout duration

    def scheduleLocking(id, endtime):

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
