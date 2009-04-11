#!/bin/bash

version_checker() {
	local ver1=$1
	while [ `echo $ver1 | egrep -c [^0123456789.]` -gt 0 ]; do
		char=`echo $ver1 | sed 's/.*\([^0123456789.]\).*/\1/'`
		char_dec=`echo -n "$char" | od -b | head -1 | awk {'print $2'}`
		ver1=`echo $ver1 | sed "s/$char/.$char_dec/g"`
	done	
	local ver2=$2
	while [ `echo $ver2 | egrep -c [^0123456789.]` -gt 0 ]; do
		char=`echo $ver2 | sed 's/.*\([^0123456789.]\).*/\1/'`
		char_dec=`echo -n "$char" | od -b | head -1 | awk {'print $2'}`
		ver2=`echo $ver2 | sed "s/$char/.$char_dec/g"`
	done	

	ver1=`echo $ver1 | sed 's/\.\./.0/g'`
	ver2=`echo $ver2 | sed 's/\.\./.0/g'`

	do_version_check "$ver1" "$ver2"
}

do_version_check() {
	
	[ "$1" == "$2" ] && return 10

	ver1front=`echo $1 | cut -d "." -f -1`
	ver1back=`echo $1 | cut -d "." -f 2-`
	ver2front=`echo $2 | cut -d "." -f -1`
	ver2back=`echo $2 | cut -d "." -f 2-`

	if [ "$ver1front" != "$1" ] || [ "$ver2front" != "$2" ]; then
		[ "$ver1front" -gt "$ver2front" ] && return 11
		[ "$ver1front" -lt "$ver2front" ] && return 9

		[ "$ver1front" == "$1" ] || [ -z "$ver1back" ] && ver1back=0
		[ "$ver2front" == "$2" ] || [ -z "$ver2back" ] && ver2back=0
		do_version_check "$ver1back" "$ver2back"
		return $?
	else
		[ "$1" -gt "$2" ] && return 11 || return 9
	fi
}

CURRENT_VERSION="$(cat /etc/link-version)"
NEW_VERSION="1.2.2"
version_checker "$CURRENT_VERSION" "$NEW_VERSION"

if [[ $? -eq 9 ]]; then

	echo "Cleaning up the version!!!!"

# Not removing pidgin, pidgin-otr, totem, or totem-mozilla for now
# even though they are no longer depended on my neuroslink-desktop
# They should be removed later.
	aptitude markauto mythtv mythvideo mythmusic mythgallery mythtv-theme-neuroslink pcmciautils foomatic-db-hpijs hplip xsane gimp libdeskbar-tracker tracker tracker-search-tool mythtv-frontend mythtv-common mythtv-theme-blootubelite-wide mythtv-theme-retro-osd mythtv-theme-retro mythtv-theme-titivillus-osd mythtv-theme-mythbuntu mythtv-theme-mythcenter-wide mythtv-theme-projectgrayhem-osd libmyth-0.21-0 mythtv-theme-blootube-wide mythtv-theme-iulius-osd mythtv-theme-glass-wide mythtv-theme-gray-osd mythtv-theme-blootube mythtv-theme-iulius mythtv-theme-blootube-osd mythtv-theme-titivillus mythtv-theme-projectgrayhem-wide mythtv-theme-projectgrayhem mythtv-theme-mythcenter mythtv-theme-isthmus mythtv-theme-minimalist-wide mythtv-theme-neon-wide --allow-untrusted -y

	su neurostv -c /usr/sbin/cleanup-userhome.sh

	echo "1.2.2" > /etc/link-version
fi

echo "Cleanup Done"


