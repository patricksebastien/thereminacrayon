flatpak run org.gimp.GIMP//stable /home/psc/11h11/thereminacrayon/gimp/tac.xcf &
sleep 5
pd -rt -jack -channels 2 -open /home/psc/11h11/thereminacrayon/puredata/main.pd &
sleep 5
wmctrl -r main.pd -t 1 &
wmctrl -r main.pd -b toggle,fullscreen &
wmctrl -r tac.xcf -b toggle,fullscreen &
touchegg &
