#!/bin/bash

  zenity --question --title="Switch Audio Output to Optical Output Port" --text="Setting default Audio output to Optical PCM Output, Continue? (This feature does not currently function and script exists just for documentation)"
  CONFIRMCONTINUE=1
  if [ "$CONFIRMCONTINUE" = "0" ]; then
    ### User confirmed

        asoundconf set-default-card SB

        #Mplayer config
        if [ ! -d ~/.mplayer ]; then
                mkdir ~/.mplayer
        fi

        echo ao=alsa:device=hw=0.0 > ~/.mplayer/config
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
