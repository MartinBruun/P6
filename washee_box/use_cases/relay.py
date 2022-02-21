from gpiozero import LED
from time import sleep


led = LED(21)
count = 10

while count > 0:
    led.on()
    sleep(0.2)
    led.off()
    sleep(0.2)
    print("Hello World from Jakob"+ str(count))
    count -= 1


