from gpiozero import LED

class RaspberryLED:
    def __init__(self, machine_pin, debug):
        if debug:
            self.close = self.__debug_close
            self.on = self.__debug_on
            self.off = self.__debug_off
            print("Pin number one",self.machine_pin, "has been opened")
        else:
            self.led = LED(machine_pin)

        self.machine_pin = machine_pin
            
    
    def close(self):
       self.led.close()
    
    def on(self):
        self.led.on
    
    def off(self):
        self.led.off

    def __debug_close(self):
        print("Pin number",self.machine_pin, "has been closed")
    
    def __debug_on(self):
        print("The machine on pin",self.machine_pin, "has been turned on")
    
    def __debug_off(self):
        print("The machine on pin",self.machine_pin, "has been turned off")


if __name__ == "__main__":
    box_debug = True
    box = RaspberryLED(1, box_debug).close()
