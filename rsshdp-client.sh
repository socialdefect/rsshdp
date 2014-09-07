#!/bin/bash

## Main Form
MainForm(){
    yad --title="RSSHDP Tunnel Setup 0.1" --form --field="Connection Type:CB" --field="Hostname/IP" --field="Forward Port" --field="Access Port" --field="SSH Key:FL" --field="Username" --field="In Terminal:CHK" 'Reverse Tunnel!SOCKS5 Proxy' "hostname.com" "22" "9999" "$HOME/.ssh/id_rsa" "sshuser" TRUE --button="About:2" --button="Start Tunneling:0" --button="gtk-cancel:1"   
}

## About dialog
about(){
    yad --title="About RSSHDP Tunnel Setup" --text="By Arjan van Lent 2014
                
License: GPLv3
http://www.gnu.org/licenses/gpl.html

Click the Free VPS button and get 10 dollars in free credits
at DigitalOcean.com" --button="Ok":0 --button="Get a free VPS":1
}

## Warning for enable autostart
Warning(){
    yad --title="WARNING" --text="Info text" --button="Ok": --button="Quit":1 
}

## Start the tunnel
Connect(){
    if [ "$TYPE" = "Reverse Tunnel" ] ; then
        COMMAND="ssh -R "$FORWARD_PORT":localhost:"$ACCESS_PORT" "$SSH_USER"@"$HOST""
        if [ $IN_TERM = TRUE ] ; then
            xterm -e $COMMAND
        else
            $COMMAND -N &
            PROCESS="$$"
            yad --title="RSSHDP Tunnel" --text="Close this window to terminate the tunnel." --button="Quit":1
            kill $PROCESS
            wait
        fi
    elif [ "$TYPE" = "SOCKS5 Proxy" ] ; then
        COMMAND="ssh -p "$FORWARD_PORT" -D "$ACCESS_PORT" -i "$PUBKEY" "$SSH_USER"@"$HOST""
        if [ $IN_TERM = TRUE ] ; then
            xterm -e $COMMAND
        else
            $COMMAND -N &
            PROCESS="$$"
            yad --title="RSSHDP Tunnel" --text="Close this window to terminate the tunnel." --button="Quit":1
            kill $PROCESS
            wait
        fi
    fi
}

loop(){
## Display Main Window
SETTINGS=`MainForm`
EXIT=$?

## Check exit code
if [ $EXIT = 1 ] ; then
    exit 1
elif [ $EXIT = 2 ] ; then
    about
    if [ $? = 1 ]; then
        xdg-open https://www.digitalocean.com/?refcode=c6c9d017f04
    fi
elif [ $EXIT = 0 ] ; then

## Get variables from main window
### Reverse Tunnel|hostname.com|22|9999|/home/adjemin/.ssh/id_rsa.pub|sshuser|TRUE|FALSE|
TYPE=`echo $SETTINGS | awk -F '|' '{ print $1 }'`
HOST=`echo $SETTINGS | awk -F '|' '{ print $2 }'`
ACCESS_PORT=`echo $SETTINGS | awk -F '|' '{ print $3 }'`
FORWARD_PORT=`echo $SETTINGS | awk -F '|' '{ print $4 }'`
PUBKEY=`echo $SETTINGS | awk -F '|' '{ print $5 }'`
SSH_USER=`echo $SETTINGS | awk -F '|' '{ print $6 }'`
IN_TERM=`echo $String | awk -F '|' '{ print $7 }'`


## Start Tunnel
Connect

fi
}

## Run the application in a loop
while true ; do
    loop
done

exit $?