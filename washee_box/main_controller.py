import json
import pytz
from time import sleep
from datetime import datetime
from hardware.raspberryLED import RaspberryLED
from hardware.raspberry import Raspberry



class MainController:

    def __init__(self):
        return

    # hardware
    def lockMachine(self, machineJson):
        id = machineJson["machineID"]
        pins = self.getPin(id)
        machineJson["pin_a"] = pins[0]
        machineJson["pin_b"] = pins[1]

        RaspberryLED(machineJson["pin_a"]).close()
        RaspberryLED(machineJson["pin_b"]).close()

    def unlockMachineInThread(self, *arg):
        self.unlockMachine(arg[0], arg[1], arg[2], arg[3])

    def unlockMachine(self, machine, duration, user="user??", account="account??"):
        now = datetime.now(pytz.timezone('Europe/Copenhagen'))
        running = True
        max_wash_time = self.getWashTimeLimit()
        timeLeft = min(max_wash_time, duration)

        # update machine so that users get notified of the changed machine status when fetching the machine list
        # the update should write to the machinelist file
        # machine["startTime"] = now
        # machine["endTime"]= now + timedelta(seconds = timeLeft)
        # TODO:maybe move to the caller
        logmessage = "startTime:"+str(now) + " ; endTime:" + str(machine["endTime"]) + "; duration:" + str(duration).format(
            "hh:mm")
        self.writeToLog(account, user, machine, logmessage)
        machines = self.getMachinesInfo()["machines"]
        for i, stored_machine in enumerate(machines):
            if stored_machine['machineID'] == machine["machineID"]:
                machines[i] = machine
        self.newMachineList(user, None, machines)

        # TODO: this should be optimized so that the max_wash_time value is fetched when this file is loaded

        relayport_a = RaspberryLED(machine["pin_a"])  # power on relay
        relayport_b = RaspberryLED(machine["pin_b"])  # power on relay

        while (timeLeft > 0 and running == True):
            print(machine["machineID"],  timeLeft)
            sleep(1)
            timeLeft -= 1
        relayport_a.close()  # make relay available for other functioncalls
        relayport_b.close()  # make relay available for other functioncalls

        # update machine so that users get notified of the changed machine status when fetching the machine list
        # the update should write to the machinelist file
        machine["endTime"] = datetime.now(pytz.timezone('Europe/Copenhagen'))
        logmessage = "machine turned off ; endTime:" + str(machine["endTime"])
        self.writeToLog(account, user, machine, logmessage)

        if duration > 0:
            return True
        else:
            return False

    # scheduler?

    def scheduleLocking(id, endtime):
        raise Exception("not implemented")

    def scheduleUnLocking(id, starttime):
        raise Exception("not implemented")

    # machine controller?
    def getPin(self, machineID):
        machines = self.getMachinesInfo()
        machines = machines["machines"]
        for k in machines:
            if k["machineID"] == machineID:
                return([k["pin_a"], k["pin_b"]])

    def getMachinesInfo(self):
        with open("data_setup_files/machine_list.json", "r") as file:
            machines = json.loads(file.read())
            machines["last_fetched"] = datetime.now(pytz.timezone('Europe/Copenhagen'))

        return machines

    def getUsersInfo(self):
        with open("data_setup_files/allowed_users.json", "r") as file:
            users = json.loads(file.read())
            users["last_fetched"] = datetime.now(pytz.timezone('Europe/Copenhagen'))

        return users

    def getWashTimeLimit(self):
        with open("data_setup_files/max_washing_time.json", "r") as file:
            max_wash_time_json = json.loads(file.read())

        return max_wash_time_json["MAX_WASHINGTIME_IN_SEC"]

    # Logger
    def getLogFile(self):
        with open("data_collection/log.txt", "r") as file:
            logFile = file.read()

        return logFile

    def writeToLog(self, account, user, machine, message):
        timestamp = datetime.now(pytz.timezone('Europe/Copenhagen'))
        machine["startTime"] = str(machine["startTime"])
        machine["endTime"] = str(machine["endTime"])

        with open("data_collection/log.txt", "a+") as f:
            string = f'{str(timestamp)};{account};{user};{machine["machineID"]};{machine["machineType"]};{machine}; {message}' + "\n"
            f.write(string)

    def reset_factory_setup(self, user=None, password=None):
        if (self.allowedUser(user, password)):
            print("DONE")
            with open("data_setup_files/setup_box.json", "r") as file:
                setup_data = json.loads(file.read())
                self.newMachineList(user, password, setup_data["machines"])
                self.newUserList(user, password, setup_data["users"])
                self.newWashTimeLimit(
                    user, password, setup_data["MAX_WASHINGTIME_IN_SEC"])

    def newMachineList(self, user, password, machines):
        if self.allowedUser(user, password):
            with open("data_setup_files/machine_list.json", "w") as file:
                # machines["setup_date"]=str(datetime.now())
                now = str(datetime.now(pytz.timezone('Europe/Copenhagen')))
                data = {
                    "last-edited": now,
                    "machines": machines
                }

                json.dump(data, file)
                print(data)

    def newUserList(self, user, password, users):
        if self.allowedUser(user, password):
            with open("data_setup_files/allowed_users.json", "w") as file:
                # users["setup_date"]=datetime.now()
                now = str(datetime.now(pytz.timezone('Europe/Copenhagen')))
                data = {
                    "last-edited": now,
                    "users": users
                }

                json.dump(data, file)
                print(data)

    def newWashTimeLimit(self, user, password, timelimit_json):
        if self.allowedUser(user, password):
            with open("data_setup_files/max_washing_time.json", "w") as file:
                # users["setup_date"]=datetime.now()
                now = str(datetime.now(pytz.timezone('Europe/Copenhagen')))
                data = {
                    "last-edited": now,
                    "MAX_WASHINGTIME_IN_SEC": timelimit_json
                }

                json.dump(data, file)
                print(data)

    def allowedUser(self, user, password):
        return True


if __name__ == "__main__":
    controller = MainController()
    machineJson = {
        "machineID": "l1",
    }
    r = Raspberry()
    r.allOn()
