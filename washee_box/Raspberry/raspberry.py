    ### THIS FILE IS NOT DONE
from raspberryLED import RaspberryLED
class raspberry():

    def testRelay(self, duration):
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