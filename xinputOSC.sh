#!/bin/bash

XID=$(xinput list --id-only 'NTRG0001:01 1B96:1B05 Pen Pen (0)')

re='^[0-9]+$'
while ! [[ $XID =~ $re ]]
do
    echo "touch the screen with the pen"
    sleep 1
    XID=$(xinput list --id-only 'NTRG0001:01 1B96:1B05 Pen Pen (0)')
done
/home/psc/11h11/xinputOSC/src/xinput test $XID
