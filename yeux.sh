#TODO
set intel turbo to 1
#cat /sys/devices/system/cpu/intel_pstate/no_turbo
#TRY with ^ 1 above and:
freq=3300000; for cpu_num in {0..3}; do sudo cpufreq-set --cpu "$cpu_num" --governor performance --max "$freq" --min "$freq"; done
#OR ^ 0 above and same freq...
#you can use ubuntustudio-controls to set no_turbo
# GO
sudo /usr/bin/nmcli networking on
sudo killall xfce4-volumed
sudo killall nm-applet
sudo killall /usr/bin/python3
sudo killall /usr/lib/gvfs/gvfs-udisks2-volume-monitor
sudo killall /usr/lib/gvfs/gvfs-afc-volume-monitor
sudo killall /usr/lib/policykit-1-gnome/polkit-gnome-authentication-age
sudo killall /usr/lib/gvfs/gvfs-mtp-volume-monitor
sudo killall /usr/lib/gvfs/gvfs-gphoto2-volume-monitor
sudo killall /usr/lib/gvfs/gvfs-goa-volume-monitor
sudo killall Thunar
sudo killall a2jmidid
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
sudo killall carla
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
#sudo modprobe snd_virmidi &
#bitwig-studio &
#flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
#krita --nosplash /home/psc/11h11/thereminacrayon/krita/tac.kra &
timemachine -f wav -p /home/psc/11h11/recording/ &
#carla /home/psc/11h11/thereminacrayon/carla/carla.carxp &
touchegg &
#/home/psc/11h11/thereminacrayon/xinputOSC.sh &
#/home/psc/11h11/thereminacrayon/spAccel.py &
#lingot &
#/home/psc/11h11/pd0502/bin/pd -rt -jack -channels 6 -alsamidi -mididev 1 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
#sleep 1
/home/psc/11h11/pd0502/bin/pd -rt -jack -channels 6 -alsamidi -mididev 1 -open /home/psc/11h11/vat/vatAudio.pd &
sleep 1
/home/psc/11h11/pd0502/bin/pd -nrt -noaudio /home/psc/11h11/vat/vatVideo.pd &
phasex &
sleep 10
#wmctrl -r "Open Stage Control" -t 1 &
wmctrl -r "TimeMachine" -t 1 &
#wmctrl -r "Gem" -t 4 &
#wmctrl -r "vatVideo.pd" -t 3 &
#wmctrl -r "main.pd" -t 2 &
wmctrl -r "phasex" -t 3 &
#wmctrl -r main.pd -b toggle,fullscreen &
#GIMP
#wmctrl -r tac.xcf -t 1 &
#wmctrl -r tac.xcf -b toggle,fullscreen &
#xinput set-prop "NTRG0001:01 1B96:1B05 Pen Pen (0)" 'Coordinate Transformation Matrix' 1.0, 0.0, 0.0, 0.0, 1.222815534, -0.11821359, 0.0, 0.0, 1.0 &
#xrandr -s 1920x1080
xrandr --auto --output HDMI-1 --mode 1440x900 --right-of eDP-1
XID=$(xinput list --id-only 'NTRG0001:01 1B96:1B05')
xinput map-to-output $XID eDP-1
