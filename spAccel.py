#!/usr/bin/python

#####CONFIGURATION#####
sensorname="accel_3d"
screenname="eDP1"

import pyudev
import re
import subprocess
import os.path
import signal
from gi.repository import Gtk, GdkPixbuf, GObject
import liblo

def twos_comp(val):
    if val & (1 << (16-1)) != 0:
        val = val - (1 << 16)
    return val

def checkRotation():

    device = pyudev.Device.from_path(context, path)
    accelX = twos_comp(device.attributes.asint("in_accel_x_raw"))
    accelY = twos_comp(device.attributes.asint("in_accel_y_raw"))
    accelZ = twos_comp(device.attributes.asint("in_accel_z_raw"))
    #print  accelX
    # send message "/foo/message1" with int, float and string arguments
    liblo.send(target, "/sp/accel", accelX, accelY, accelZ)
    GObject.timeout_add(10, checkRotation)

context = pyudev.Context()
for device in context.list_devices(subsystem="iio").match_attribute("name", sensorname): break
assert device

path = device.device_path

prevorientation = ""

if __name__ == "__main__":
    GObject.threads_init()
    signal.signal(signal.SIGINT, signal.SIG_DFL)

    # send all messages to port 1234 on the local machine
    try:
        target = liblo.Address(3339)
    except liblo.AddressError as err:
        print(err)
        sys.exit()

    GObject.idle_add(checkRotation)
    Gtk.main()
