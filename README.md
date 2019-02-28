# Theremin à crayon

A theremin with a Surface Pro (custom instrument to draw and play music simultaneously).

# TODO
- how long on battery (surface pro when doing krita and pd)
- how long on battery for the projector (even built-in)
- calculate the consommation of the projector
- add 4 pots of theremin
- portable roadcase + amp ?
- develop patch (music and krita)
- krita black screen on clean
- document setup
- 


## SETUP
### JACK
44100 - 128 - 2 (hw:UA25EX)\
Latency: 21.0884ms round-trip\
Deadline: 2.902ms
qjackctl load patchbay (bitwig to pd)

### STARTUP
./tac.sh

### LIMITATION
Bitwig drums are CPU hungry causing glitch if using gimp, krita, open stage control... The final setup should be pd + krita + open stage control and loading bitwig only for jamming with friends.

## GUIDE
- install ubuntu-studio
- %sudo  ALL=(ALL) NOPASSWD:ALL
- compile pd with jack
- sudo pip install cython
- sudo apt install pip
- sudo apt install easystroke
- sudo apt install wmctrl
- setup easystroke (ie: python easystroke_2osc.py 5904 /fx volume 3)
- install appimage krita
- install open stage control
- sudo apt install touchegg
- sudo apt install xdotool
- autostart everything via tac.sh
- add 4 workspaces
- nano /etc/default/rtirq (remove snd)
- nano /etc/default/grub (add GRUB_CMDLINE_LINUX="threadirqs")


## FCB1010 (midi pedal)
Using the UNO firmware with the dedicated software to setup the pedal. Using the stompbox mode (upper row is boolean), Here's the current config:

Preset 01:
@TODO

## TTYMIDI
The open theremin is configured in MIDI mode. Not using the hardware rx/tx connection, we need a way to send the serial midi to pd. The included ttymidi (fixed a problem of linkage to pthread) is doing exactly this job (read midi serial -> alsa midi -> pd).

Debug:
./ttymidi -s /dev/ttyACM1 -v

In this case the open theremin is booting on ttyACM1, ttyACM0 is the IO (arduino with the buttons and pots).

## XINPUTOSC

I modified xinput source to add liblo for sending x11 event to pd (via OSC). The modification are located in test.c - right now hardcoded for surface pro 3 pen. It is possible also to send the sp3 button (Surface Pro 3/4 Buttons).

xinputOSC.sh wait for the pen to be listed in xinput and then launch the custom xinputOSC binary (xinputOSC test deviceID).

## ACCELEROMETER

The value of the accelerometer is sent to pd via OSC. The python script that do this job is spAccel.py

## AMBIANT LIGHT
cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device2/in_illuminance_raw
cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device4/in_illuminance_raw
udevadm info --export-db

There's a script to send this info to pd, but a bit cpu hungry.

## Easystroke

Easystoke is configured for gesture recognition with the pencil, but it's very hard to have good result because we need to hold button 2 (second button on the SP3 pencil) while drawing the gesture but NOT touching the screen and NOT going too far from it. Looking for an alternative (maybe reconfirguring the first button of the pencil?)

Script doing this job is: easystrokje_2osc.py

## KRITA
Krita is better for painting, look in the folder krita README.md for information on the python API. Sadly it is also more CPU intensive (depends on the brush AFAIK).

### CONFIGURATION
Disable touch painting (general)

## GIMP

Using the flatpak version of Gimp (not used, krita is better see below).

Shortcut:
- Ctrl+Shift+k = symmetry painting
- tool option (mode, size...)
- mypaint brush window
Questions:
- how to disable touch (using only pencil), if not possible then how to assign touch to unuseful tool?
- how long on battery with projector?



## OPEN STAGE CONTROL

Open stage control is a neat electron app that you can use to create UI (fader, toggle, buttons, etc). Using OSC to send and receive it also create a server that you can access with your phone or other computers... Using this software instead of the lacking PD UI (no multitouch support only basic ui). Start it like this:

open-stage-control --send 127.0.0.1:8000 --osc-port 9000 --theme light alt-buttons responsive-fonts --load pd.json --fullscreen

## PD TRICKS

- [declare -path ./]

## NOTES

- read serial in pd from uno theremin - prefering the midi firmware of uno + serial to midi
- using rx-tx pin on arduino with open theremin (only pinb 0 is available) - meh
- start pd with basic patch (sending osc xinput - serial comport etc)
- configure midi in with foot pedal
- use tof - tats to send to pd (https://github.com/SofaPirate/AsciiMassage)
- pd sampler (mtl) doesnt work, try with pd048 or simply use .coll text file

## CALIBRATION

Pen will need calibration when using another ratio (16:9)

xinput_calibrator -v
DEBUG: Adding click 0 (X=232, Y=146)
DEBUG: Adding click 1 (X=1661, Y=146)
DEBUG: Adding click 2 (X=247, Y=661)
DEBUG: Adding click 3 (X=1662, Y=661)

a = (screen_width * 6 / 8) / (click_3_X - click_0_X)
c = ((screen_width / 8) - (a * click_0_X)) / screen_width
e = (screen_height * 6 / 8) / (click_3_Y - click_0_Y)
f = ((screen_height / 8) - (e * click_0_Y)) / screen_height

a (left) - should be alright
c (right) - """
e (top)
f (bottom)

xinput set-prop "NTRG0001:01 1B96:1B05 Pen Pen (0)" 'Coordinate Transformation Matrix' a, 0.0, c, 0.0, e, f, 0.0, 0.0, 1.0

Example 1080p:
xinput set-prop "NTRG0001:01 1B96:1B05 Pen Pen (0)" 'Coordinate Transformation Matrix' 1.0, 0.0, 0.0, 0.0, 1.222815534, -0.11821359, 0.0, 0.0, 1.0

Reset:
xinput set-prop "16" 'Coordinate Transformation Matrix' 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000


/usr/share/libwacom/n-trig-pen.tablet

 8 [Device]
 9 Name=N-Trig Pen
10 DeviceMatch=usb:1b96:0001;i2c:1b96:1b05;
11 Class=ISDV4
12 Width=10
13 Height=6
14 IntegratedIn=Display;System
15
16 [Features]
17 Stylus=true
18 Touch=true
19 Buttons=1

And /usr/share/X11/xorg.conf.d/70-wacom.conf to (scroll down to the N-trig Part):

 96 # N-Trig Duosense Electromagnetic Digitizer
 97 Section "InputClass"
 98         Identifier "Wacom N-Trig class"
 99         MatchProduct "HID 1b96:0001|N-Trig Pen|N-Trig DuoSense|NTRG0001:01 1B96:1B05 Pen"
100         MatchDevicePath "/dev/input/event*"
101         Driver "wacom"
102         Option "Button2" "3"
103 EndSection



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
