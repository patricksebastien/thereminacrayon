flatpak run org.gimp.GIMP//stable /home/psc/11h11/theremin.xcf &
sleep 5
pd -rt -jack -channels 2 -open /home/psc/11h11/tac/main.pd &
sleep 5
wmctrl -r test.pd -t 1 &
wmctrl -r test.pd -b toggle,fullscreen
wmctrl -r theremin.xcf -b toggle,fullscreen
