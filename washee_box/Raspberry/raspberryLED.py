from gpiozero import LED

class RaspberryLED:
    def __init__(self, machine_pin, debug):
        if debug:
            self.close = self.__debug_close

        self.machine_pin = machine_pin
            
    
    def close(self):
        LED(self.machine_pin).close()

    def __debug_close(self):
        print("The machine on pin",self.machine_pin, "has been closed")
    


if __name__ == "__main__":
    box_debug = True
    box = RaspberryLED(1, box_debug).close()
