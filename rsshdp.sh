#!/bin/bash

## Set session variables
if [ -z $1 ] ; then
	SSH_USER=""
	SSH_IP=""
	SSH_PORT="22"
## Set the screen size for the nested window. (keep it smaller than your desktop's screen settings!)
	SCREEN_SIZE="800x600"
## Set xsession (Use startkde, openbox-session, gnome-desktop, startlxde, etc.. Using 'startx' might fail due to user permissions)
	DESKTOP="openbox-session"
else
## Read settings from file
	. "$@"
fi

## Quit if any variable is empty
set -e

## Quit if xephyr is not installed
if [ ! -f `which Xephyr` ] ; then
	echo 'Missing dependency: Xephyr'
	echo 'Please run: sudo apt-get install xserver-xephyr'
	exit 1
fi

## Start Xephyr window
Xephyr -ac -screen "$SCREEN_SIZE" -title "RSSHDP (CTRL+SHIFT grabs mouse and keyboard)" -reset :1 &

## Set display variable
DISPLAY=":1"

## Start remote Xserver via ssh
ssh -X -p "$SSH_PORT" "$SSH_USER"@"$SSH_IP" "$DESKTOP"

## Hide background process output and show fresh PS1
sleep 3
echo ""

exit $?
