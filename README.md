# Theremin à crayon

A theremin with a Surface Pro (custom instrument to draw and play music simultaneously.


## GUIDE
- install ubuntu-studio
- sudoers nopasswd
- compile pd with jack
- sudo pip install cython
- sudo apt install pip
- sudo apt install easystroke
- setup easystroke (ie: python easystroke_2osc.py 5904 /fx volume 3)
- flatpak gimp install
- sudo apt install touchegg
- sudo apt install xdotool
- autostart everything via tac.sh

## XINPUTOSC

I modified xinput source to add liblo for sending x11 event to pd (via OSC). The modification are located in test.c - right now hardcoded for surface pro 3 pen. It is possible also to send the windows button on the surface (Surface Pro 3/4 Buttons).

xinputOSC.sh wait for the pen to be listed in xinput and then launch the custom xinputOSC binary (xinputOSC test deviceID).

## ACCELEROMETER

The value of the accelerometer is sent to pd via OSC. The python script that do this job is spAccel.py

## AMBIANT LIGHT
cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device2/in_illuminance_raw
cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device4/in_illuminance_raw
udevadm info --export-db

## Easystroke

Easystoke is configured for gesture recognition with the pencil, but it's very hard to have good result because we need to hold button 2 (second button on the SP3 pencil) while drawing the gesture but NOT touching the screen and NOT going too far from it. Looking for an alternative.

The command to send value to pd via OSC is:
Script doing this job is: easystrokje_2osc.py

## GIMP

Using the flatpak version of Gimp.

Shortcut:
- Ctrl+Shift+k = symmetry painting
- tool option (mode, size...)
- mypaint brush window
Questions:
- how to disable touch (using only pencil), if not possible then how to assign touch to unuseful tool?
- how long on battery with projector?

## OPEN STAGE CONTROL

Open stage control is a neat electron app that you can use to create UI (fader, toggle, buttons, etc). Using OSC to sedn and receive it also create a server that you can access with your phone or other computers... Using this software instead of the lacking PD UI (no multitouch support only basic ui). Start it like this:

open-stage-control --send 127.0.0.1:8000 --osc-port 9000 --theme light alt-buttons responsive-fonts --load pd.json --fullscreen

## PD TRICKS

- [declare -path ./]

## NOTES

- read serial in pd from uno theremin
- using rx-tx pin on arduino with open theremin (only pinb 0 is available)
- start pd with basic patch (sending osc xinput - serial comport etc)
- configure midi in with foot pedal
- communicating with gimp 2.10
- check if open theremin output serial the volume antenna too
- use tof - tats to send to pd (https://github.com/SofaPirate/AsciiMassage)
- check if pen is available with gesture recognition (easystroke) - YES need to choose button (2)
- is the pen eraser doing something?
- control gimp from pd using osc (hacking gimp) or use xdotool?
- pd sampler (mtl) doesnt work, try with pd048 or simply use .coll text file

## BUG

.,.

## TOUCHEGG configuration

Right now only using 4 fingers slide to switch workspace. Also for showing toolbox in Gimp.

.config/touchegg
```xml
<touchégg>
    <settings>
        <property name="composed_gestures_time">0</property>
    </settings>
    <application name="All">
        <gesture type="DRAG" fingers="4" direction="LEFT">
            <action type="CHANGE_DESKTOP">NEXT</action>
        </gesture>
        <gesture type="DRAG" fingers="4" direction="RIGHT">
            <action type="CHANGE_DESKTOP">PREVIOUS</action>
        </gesture>
    </application>

    <application name="Gimp-2.10">
        <gesture type="DRAG" fingers="4" direction="UP">
            <action type="SEND_KEYS">Tab</action>
        </gesture>
    </application>
</touchégg>
```
