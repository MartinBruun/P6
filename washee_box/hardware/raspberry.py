from time import sleep
from raspberryLED import RaspberryLED

class Raspberry():

    def testRelay(self, duration):
        # led1 = RaspberryLED(1)
        # led2 = RaspberryLED(2)
        # led3 = RaspberryLED(3)
        relayport4 = RaspberryLED(4)
        relayport5 = RaspberryLED(5)
        relayport6 = RaspberryLED(6)
        relayport7 = RaspberryLED(7)
        relayport8 = RaspberryLED(8)
        relayport9 = RaspberryLED(9)
        relayport10 = RaspberryLED(10)
        relayport11 = RaspberryLED(11)
        relayport12 = RaspberryLED(12)
        relayport13 = RaspberryLED(13)
        relayport14 = RaspberryLED(14)
        relayport15 = RaspberryLED(15)
        relayport16 = RaspberryLED(16)
        relayport17 = RaspberryLED(17)
        relayport18 = RaspberryLED(18)
        relayport19 = RaspberryLED(19)
        relayport20 = RaspberryLED(20)
        relayport21 = RaspberryLED(21)
        relayport22 = RaspberryLED(22)
        relayport23 = RaspberryLED(23)
        relayport24 = RaspberryLED(24)
        relayport25 = RaspberryLED(25)
        relayport26 = RaspberryLED(26)
        relayport27 = RaspberryLED(27)

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


    def resetAllPins(self):
        for i in range(1,28):
            RaspberryLED(i).close()
            print("reset pin:" + str(i))


    def allOn(self):
        for i in range(1,28):
            led = RaspberryLED(i)
            sleep(0.05)
            led.on()
            sleep(0.1)
            print("power On pin:" + str(i))

if __name__ == "__main__":
    rp = Raspberry()

    rp.allOn()
    rp.resetAllPins()
    rp.testRelay(1)