import os
debug = False if int(os.environ.get("BOX_DEBUG", default="0")) == 0 else True

if not debug:
    from gpiozero import LED

class RaspberryLED:
    def __init__(self, machine_pin):
        self.debug = False if int(os.environ.get("BOX_DEBUG", default="0")) == 0 else True
        
        self.machine_pin = machine_pin
        
        if debug:
            self.led = None
            #self.close = self.__debug_close
            #self.on = self.__debug_on
            #self.off = self.__debug_off
            #self.blink = self.__debug_blink
            #print("Pin",self.machine_pin, "open")
        else:
            self.led = LED(machine_pin)

    
    def close(self):
        if not self.debug:
            self.led.close()
    
    def on(self):
        if not self.debug:
            self.led.on()
    
    def off(self):
        if not self.debug:
            self.led.off()

    def blink(self):
        if not self.debug:
            self.led.blink()

    """
    def __debug_close(self):
        msg = "Pin " + str(self.machine_pin) + " close"
        print(msg)
        return msg
    
    def __debug_on(self):
        msg = "Pin " + str(self.machine_pin) + " on"
        print(msg)
        return msg
        
    def __debug_off(self):
        msg = "Pin " + str(self.machine_pin) + " off"
        print(msg)
        return msg

    def __debug_blink(self):
        msg = "Pin " + str(self.machine_pin) + " blink"
        print(msg)
        return msg
    """

if __name__ == "__main__":
    BOX_DEBUG = True
    box = RaspberryLED(1).close()
