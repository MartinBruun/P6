from time import sleep
import os
debug = False if int(os.environ.get("BOX_DEBUG", default="0")) == 0 else True

if not debug:
    from hardware.raspberryLED import RaspberryLED


class Raspberry():

    # Test methods
    def testRelay(self, duration):
        if not debug:
            # led1 = RaspberryLED(1)
            # led2 = RaspberryLED(2)
            # led3 = RaspberryLED(3)
            RaspberryLED(4)
            RaspberryLED(5)
            RaspberryLED(6)
            RaspberryLED(7)
            RaspberryLED(8)
            RaspberryLED(9)
            RaspberryLED(10)
            RaspberryLED(11)
            relayport12 = RaspberryLED(12)
            RaspberryLED(13)
            RaspberryLED(14)
            RaspberryLED(15)
            RaspberryLED(16)
            relayport17 = RaspberryLED(17)
            RaspberryLED(18)
            RaspberryLED(19)
            RaspberryLED(20)
            RaspberryLED(21)
            RaspberryLED(22)
            relayport23 = RaspberryLED(23)
            RaspberryLED(24)
            RaspberryLED(25)
            RaspberryLED(26)
            relayport27 = RaspberryLED(27)

        count = 2

        while count > 0:

            print("Hello World from Jakob" + str(count))

            if not debug:
                relayport17.off()
                sleep(0.1)
                relayport27.off()
                sleep(0.1)
                relayport12.off()
                sleep(0.1)
                relayport23.off()

            count -= 1

        if not debug:
            relayport12.blink()
            sleep(duration)
            relayport27.close()
            relayport12.close()
            relayport23.close()
            relayport12.close()

    def resetAllPins(self):
        for i in range(1, 28):
            if not debug:
                RaspberryLED(i).close()
            print("reset pin:" + str(i))

    def allOn(self):
        for i in range(1, 28):
            if not debug:
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
