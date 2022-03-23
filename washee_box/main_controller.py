import json
from datetime import datetime
from Raspberry.raspberryLED import RaspberryLED
from config import box_debug

class MainController:
    
    def __init__(self):
        return

    def lockMachine(self, machineJson, box_debug):
        id = machineJson["machineID"]
        machineJson["pin"] = self.__getPin(id)
        RaspberryLED(machineJson["pin"], box_debug).close()
    
    def unlockMachineInThread(self, *arg):
            self.unlockMachine(arg[0],arg[1])
    

    def unlockMachine(self, machine, duration,user = "user??", account = "account??"):
        now = datetime.now()


        #update machine so that users get notified of the changed machine status when fetching the machine list
        #the update should write to the machinelist file
        machine["startTime"] = now
        logmessage = "startTime:"+str(now)+ " ; endTime:" + str(machine["endTime"])  +"; duration:" +str(duration).format(
            "hh:mm")
        self.writeToLog(account, user , machine, logmessage)

        #TODO: this should be optimized so that the max_wash_time value is fetched when this file is loaded
        max_wash_time = self.getWashTimeLimit()
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
        self.writeToLog(account, user , machine, logmessage)

        if duration > 0 :
            return True
        else :
            return False

    def getWashTimeLimit():
        with open("data_setup_files/max_washing_time.json", "r") as file:
            max_wash_time_json = json.loads(file.read())
            return max_wash_time_json["MAX_WASHINGTIME_IN_SEC"]

    def __getPin(self, machineID):

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
    
    def getMachinesInfo(self):
        with open("data_setup_files/machine_list.json", "r") as file:
            machines = json.loads(file.read())
            machines["last_fetched"]=datetime.now()

        return machines

    def scheduleLocking(self, id, endtime):

        raise Exception("not implemented")


    def scheduleUnLocking(self, id, starttime):

        raise Exception("not implemented")
    
    def getUsersInfo(self):
        with open("data_setup_files/allowed_users.json", "r") as file:
            users = json.loads(file.read())
            users["last_fetched"]=datetime.now()
            return users

    def getLogFile(self):
        with open("data_collection/log.txt", "r") as file:
            logFile = file.read()

        return logFile

if __name__ == "__main__":
    controller = MainController()
    machineJson = {
        "machineID": "l1",
    }

    print(box_debug)
    #controller.lockMachine(machineJson, box_debug)
    