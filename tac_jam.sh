#TODO
#set intel turbo to 1
#cat /sys/devices/system/cpu/intel_pstate/no_turbo
#TRY with ^ 1 above and:
freq=3300000; for cpu_num in {0..3}; do sudo cpufreq-set --cpu "$cpu_num" --governor performance --max "$freq" --min "$freq"; done
#OR ^ 0 above and same freq...
#you can use ubuntustudio-controls to set no_turbo
# GO
sudo killall /opt/bitwig-studio/bin/BitwigStudio
sudo killall pd
sudo killall bitwig
sudo killall krita
sudo killall /usr/lib/open-stage-control/open-stage-control
sudo killall /home/psc/11h11/thereminacrayon/xinputOSC/xinputOSC
sudo killall ttymidi
sudo killall /home/psc/11h11/thereminacrayon/ttymidi/ttymidi
sudo killall /usr/bin/python
sudo killall touchegg
sudo service cron stop
sudo service mysql stop
sudo service nginx stop
sudo service php7.2-fpm stop
sudo modprobe -r ppdev # I don't have a parallel port
sudo modprobe -r lp # I don't use a printer when making music
sudo modprobe -r uvcvideo # I don't use a webcam when making music
sudo modprobe -r videodev # Ditto
sudo modprobe -r ath9k # Wireless driver
sudo modprobe -r r8169 # NIC driver
sudo modprobe -r btusb # Bluetooth USB
sudo /etc/init.d/bluetooth stop & # Stop Bluetooth related processes
sudo /etc/init.d/cups stop & # Stop cups, I don't use a printer when making music
sudo killall modem-manager # I don't have a modem
sudo modprobe snd-hrtimer # Load the ALSA high res timer for my MIDI stuff
sudo modprobe snd_virmidi midi_devs=1 &
a2jmidid &
bitwig-studio &
#flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
krita --nosplash /home/psc/11h11/thereminacrayon/krita/tac.kra &
/home/psc/11h11/pd049/bin/pd -rt -jack -channels 4 -alsamidi -mididev 1 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
open-stage-control --send 127.0.0.1:8000 --osc-port 9000 --theme dark alt-buttons responsive-fonts --load /home/psc/11h11/thereminacrayon/openstagecontrol/pd_ostagec.json --fullscreen &
touchegg &
/home/psc/11h11/thereminacrayon/xinputOSC.sh &
#/home/psc/11h11/thereminacrayon/spAccel.py &
sleep 15
#GIMP
#wmctrl -r tac.xcf -t 1 &
#wmctrl -r tac.xcf -b toggle,fullscreen &
wmctrl -r main.pd -t 3 &
wmctrl -r "krita" -t 1 &
#wmctrl -r main.pd -b toggle,fullscreen &
wmctrl -r "Open Stage Control" -t 2 &
#xinput set-prop "NTRG0001:01 1B96:1B05 Pen Pen (0)" 'Coordinate Transformation Matrix' 1.0, 0.0, 0.0, 0.0, 1.222815534, -0.11821359, 0.0, 0.0, 1.0 &
#xrandr -s 1920x1080
/home/psc/11h11/thereminacrayon/ttymidi/ttymidi -s /dev/ttyACM1 &
sleep 2
aconnect 130:0 129:0 &
aconnect UA-25EX:0 Virtual Raw MIDI 4-0:0
aconnect UA-25EX:0 Pure Data:0
aconnect ttymidi:0 Pure Data:0