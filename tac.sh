killall /opt/bitwig-studio/bin/BitwigStudio
killall pd
killall bitwig
killall krita
killall /usr/lib/open-stage-control/open-stage-control
killall /home/psc/11h11/thereminacrayon/xinputOSC/xinputOSC
killall ttymidi
killall /home/psc/11h11/thereminacrayon/ttymidi/ttymidi
killall /usr/bin/python
killall touchegg
sudo service mysql stop
sudo service nginx stop
sudo service php7.2-fpm stop
sudo modprobe snd_virmidi midi_devs=1 &
a2jmidid &
bitwig-studio &
#flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
krita --nosplash /home/psc/11h11/thereminacrayon/krita/tac.kra &
pd -rt -jack -channels 4 -alsamidi -mididev 1 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
open-stage-control --send 127.0.0.1:8000 --osc-port 9000 --theme dark alt-buttons responsive-fonts --load /home/psc/11h11/thereminacrayon/openstagecontrol/pd_ostagec.json --fullscreen &
touchegg &
/home/psc/11h11/thereminacrayon/xinputOSC.sh &
#/home/psc/11h11/thereminacrayon/spAccel.py &
sleep 15
#GIMP
#wmctrl -r tac.xcf -t 1 &
#wmctrl -r tac.xcf -b toggle,fullscreen &
wmctrl -r main.pd -t 3 &
wmctrl -r tac.kra -t 1 &
#wmctrl -r main.pd -b toggle,fullscreen &
wmctrl -r "Open Stage Control v0.40.3" -t 2 &
xinput set-prop "NTRG0001:01 1B96:1B05 Pen Pen (0)" 'Coordinate Transformation Matrix' 1.0, 0.0, 0.0, 0.0, 1.222815534, -0.11821359, 0.0, 0.0, 1.0 &
xrandr -s 1920x1080
/home/psc/11h11/thereminacrayon/ttymidi/ttymidi -s /dev/ttyACM1 &
sleep 2
aconnect 130:0 129:0 &
aconnect UA-25EX:0 Virtual Raw MIDI 4-0:0
aconnect UA-25EX:0 Pure Data:0
aconnect ttymidi:0 Pure Data:0
