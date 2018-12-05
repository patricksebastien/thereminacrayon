sudo service mysql stop
sudo service nginx stop
sudo service php7.2-fpm stop
sleep 1 &
flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
sleep 5
wmctrl -r tac.xcf -t 1 &
wmctrl -r tac.xcf -b toggle,fullscreen &
touchegg &
