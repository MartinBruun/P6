class Machine:

    def __init__(self, machineID, name, machineType, startTime=None, endTime=None):
        self.id = machineID
        self.name = name
        self.machineType = machineType
        self.startTime = startTime
        self.endTime = endTime
