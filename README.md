# Theremin à crayon

A theremin with a Surface Pro (custom instrument to draw and play music simultaneously.

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

## PD TRICKS

- [declare -path ./]

## BUG

- slicejockey external crash pd...
