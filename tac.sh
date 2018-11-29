sudo service mysql stop
sudo service nginx stop
sudo service php7.2-fpm stop
sleep 5 &
bitwig-studio &
sleep 5
flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
sleep 5
pd -rt -jack -channels 2 -alsamidi -mididev 1 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
sleep 5
wmctrl -r main.pd -t 2 &
wmctrl -r main.pd -b toggle,fullscreen &
wmctrl -r tac.xcf -t 1 &
wmctrl -r tac.xcf -b toggle,fullscreen &
touchegg &
/home/psc/11h11/thereminacrayon/xinputOSC.sh &
/home/psc/11h11/thereminacrayon/spAccel.py &
