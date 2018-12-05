#!/bin/bash


var="$(cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device2/in_illuminance_raw)"
re='^[0-9]+$'
if ! [[ $var =~ $re ]] ; then
while [ 1 ]
do
    als="$(cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device4/in_illuminance_raw)"
    echo $als\; | pdsend 9001
    sleep 0.5
done
else
while [ 1 ]
do
    als="$(cat /sys/devices/pci0000\:00/INT33C2\:00/i2c-0/i2c-MSHW0030\:00/0018\:045E\:07C4.0001/HID-SENSOR-200041.4.auto/iio\:device2/in_illuminance_raw)"
    echo $als\; | pdsend 9001
    sleep 0.5
done
fi
