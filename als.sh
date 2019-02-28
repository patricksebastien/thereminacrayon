#!/bin/bash
while [ 1 ]
do
    als=$(cat $(find /sys/devices/pci0000\:00 | grep in_illuminance_raw))
    echo $als\; | pdsend 9001
    sleep 0.5
done
fi
