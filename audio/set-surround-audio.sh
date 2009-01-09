#!/bin/sh

asoundconf set-default-card SB


#Mplayer config
if [ ! -d ~/.mplayer ]; then
	mkdir ~/.mplayer
fi

echo ao=alsa:device=hw=0.0 > ~/.mplayer/config
echo vo=xv > ~/.mplayer/config
echo double=yes > ~/.mplayer/config
echo framedrop=1 > ~/.mplayer/config
echo ontop=1 > ~/.mplayer/config
echo stop-xscreensaver=yes > ~/.mplayer/config




