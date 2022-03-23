import json
from time import sleep
from datetime import datetime
from hardware.raspberryLED import RaspberryLED
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
        self.__writeToLog(account, user , machine, logmessage)

        #TODO: this should be optimized so that the max_wash_time value is fetched when this file is loaded
        max_wash_time = self.getWashTimeLimit()
        timeLeft = min(max_wash_time, duration)
        relayport = RaspberryLED(machine["pin"]) #power on relay
        while timeLeft > 0:
            print(machine["machineID"],  timeLeft)
            sleep(1)
            timeLeft -= 1
        relayport.close() #make relay available for other functioncalls
        
        #update machine so that users get notified of the changed machine status when fetching the machine list
        #the update should write to the machinelist file
        machine["endTime"] = datetime.now()
        logmessage = "machine turned off ; endTime:" + str(machine["endTime"])
        self.__writeToLog(account, user , machine, logmessage)

        if duration > 0 :
            return True
        else :
            return False
    
    def unlockMachineInThread(self, *arg):
            self.unlockMachine(arg[0],arg[1])

    def scheduleLocking(id, endtime):
        raise Exception("not implemented")

    def scheduleUnLocking(id, starttime):
        raise Exception("not implemented")

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
    
    def getMachinesInfo(self):
        with open("data_setup_files/machine_list.json", "r") as file:
            machines = json.loads(file.read())
            machines["last_fetched"]=datetime.now()

        return machines

    def getUserssInfo(self):
        with open("data_setup_files/allowed_users.json", "r") as file:
            users = json.loads(file.read())
            users["last_fetched"]=datetime.now()

    def getWashTimeLimit(self):
        with open("data_setup_files/max_washing_time.json", "r") as file:
            max_wash_time_json = json.loads(file.read())
            return max_wash_time_json["MAX_WASHINGTIME_IN_SEC"]


    def getLogFile(self):
        with open("data_collection/log.txt", "r") as file:
            logFile = file.read()

        return logFile
    
    def __writeToLog(self, account,user, machine, message):
        timestamp = datetime.now()
        machine["startTime"] = str(machine["startTime"])
        machine["endTime"] = str(machine["endTime"])

        with open("data_collection/log.txt", "a+") as f:
            string = f'{str(timestamp)};{account};{user};{machine["machineID"]};{machine["machineType"]};{machine}; {message}' + "\n"
            f.write(string)

    def __reset_factory_setup(self, user=None,password=None):
        if self.__allowedUser(user,password):
            print("DONE")
            with open("data_setup_files/setup_box.json", "r") as file:
                setup_data = json.loads(file.read())
                self.__newMachineList(user,password, setup_data["machines"])
                self.__newUserList(user,password,setup_data["users"])
                self.__newWashTimeLimit(user,password,setup_data["MAX_WASHINGTIME_IN_SEC"])
        

    def __newMachineList(self, user,password,machines):

        if self.__allowedUser(user,password):
            with open("data_setup_files/machine_list.json", "w") as file:
                # machines["setup_date"]=str(datetime.now())
                now = str(datetime.now())
                data = {
                    "last-edited":now,
                    "machines":machines
                }

                json.dump(data, file)
                print(data)
            

    def __newUserList(self, user,password,users):
        if self.__allowedUser(user,password):
            with open("data_setup_files/allowed_users.json", "w") as file:
                # users["setup_date"]=datetime.now()
                now = str(datetime.now())
                data = {
                    "last-edited":now,
                    "users":users
                }

                json.dump(data, file)
                print(data)


    def __newWashTimeLimit(self, user,password,timelimit_json):
        if self.__allowedUser(user,password):
            with open("data_setup_files/max_washing_time.json", "w") as file:
                # users["setup_date"]=datetime.now()
                now = str(datetime.now())
                data = {
                    "last-edited":now,
                    "MAX_WASHINGTIME_IN_SEC":timelimit_json
                }

                json.dump(data, file)
                print(data)

    def __allowedUser(self, user,password):
        return True




if __name__ == "__main__":
    controller = MainController()
    machineJson = {
        "machineID": "l1",
    }

    print(box_debug)
    #controller.lockMachine(machineJson, box_debug)
    