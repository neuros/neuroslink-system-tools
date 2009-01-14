#!/bin/sh

  zenity --question --title="Switch Audio Output to HDMI" --text="Setting default Audio output to HDMI 1.3 port, Continue?"
  CONFIRMCONTINUE=$?
  if [ "$CONFIRMCONTINUE" = "0" ]; then
    ### User confirmed

	asoundconf set-default-card HDMI


	#Mplayer config
	if [ ! -d ~/.mplayer ]; then
		mkdir ~/.mplayer
	fi

	echo ao=alsa:device=hw=1.3 > ~/.mplayer/config
	echo vo=xv >> ~/.mplayer/config
	echo double=yes >> ~/.mplayer/config
	echo framedrop=1 >> ~/.mplayer/config
	echo ontop=1 >> ~/.mplayer/config
	echo stop-xscreensaver=yes >> ~/.mplayer/config

    sleep 4
  else
    ### User canceled - stop script
    echo "Aborting"
    exit 0;
  fi
fi





