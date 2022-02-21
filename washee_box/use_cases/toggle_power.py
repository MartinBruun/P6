from gpiozero import LED, Button
from signal import pause

machineLock1 = LED(18)

def turnOff():
    machineLock1.off()
    print("turnedOff")


def turnOn():
    machineLock1.on()
    print("turnedOn")



def handleButtonPress():
    if turnedOn is True:
        turnOff()
    else:
        turnOn()

activateButton = Button(21, hold_time=2)
turnedOn = True
activateButton.when_pressed = handleButtonPress

pause()
    
   





    



    



