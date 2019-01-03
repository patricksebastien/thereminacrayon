killall /opt/bitwig-studio/bin/BitwigStudio
killall pd
killall bitwig
killall krita
killall /usr/lib/open-stage-control/open-stage-control
killall /home/psc/11h11/thereminacrayon/xinputOSC/xinputOSC
killall /usr/bin/python
killall touchegg
sudo service mysql stop
sudo service nginx stop
sudo service php7.2-fpm stop
bitwig-studio &
#flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
krita --nosplash /home/psc/11h11/thereminacrayon/krita/tac.kra &
pd -rt -jack -channels 4 -alsamidi -mididev 1 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
open-stage-control --send 127.0.0.1:8000 --osc-port 9000 --theme light alt-buttons responsive-fonts --load /home/psc/11h11/thereminacrayon/openstagecontrol/pd_ostagec.json --fullscreen &
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



