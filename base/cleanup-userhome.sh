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

	echo "Cleaning up the user home dir!!!!"
	echo "Reboot REQUIRED!!!"
	echo "Reboot REQUIRED!!!"
	echo "Reboot REQUIRED!!!"

GCONF_FLAGS="--config-source=xml::/home/neurostv/.gconf";

# Iterate over panel objects
gconftool $GCONF_FLAGS --all-dirs /apps/panel/objects | 
while read object; do
	object_type="$(gconftool -g "$object/object_type")";
	if [[ "$object_type" == "launcher-object" ]]; then
		launcher_location="$(gconftool $GCONF_FLAGS -g "$object/launcher_location")";
		
		echo "Got launcher for $launcher_location";
		
		if [[ "$launcher_location" == *mythtv.desktop ]]; then
			echo "This is the MythTV launcher";
			gconftool $GCONF_FLAGS --recursive-unset "$object";
		fi
	fi
done
rm /home/neurostv/.local/share/applications/mythtv.desktop


fi
echo "Done Cleaning User Home"


