#!/bin/sh

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




