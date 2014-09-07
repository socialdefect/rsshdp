rsshdp
======

Simple script for running a remote desktop session via ssh in a nested window. 

Usage:

	On the client PC you need to install an ssh client and Xephyr (xserver-xephyr)
	On the remote PC you need to have an active ssh server with X11 forwarding enabled
	and a desktop-session like: kde, gnome, lxde, openbox

In the script:

	Set all empty variables
	Execute the script in a terminal

Using a config file:

	You can use multiple configurations by creating config files.
	Config files can be used by passing it's full path as an argument.

Example:

	./rsshdp.sh "/path/to/config/file"

Config file contents:

	## Set session variables
	SSH_USER=""
	SSH_IP=""
	SSH_PORT="22"
	## Set the screen size for the nested window. (keep it smaller than your desktop's screen settings!)
	SCREEN_SIZE="800x600"
	## Set xsession (Use startkde, openbox-session, gnome-desktop, startlxde, etc.. Using 'startx' might fail due to user permissions)
	DESKTOP="openbox-session"


If you are using password authentication you need to type the password in the terminal window before you can start the desktop session. 
The terminal window might be hidden behind the Xsession window.

For your ease of use I recommend you set-up ssh keys with empty password.


RSSHDP-CLIENT
-------------

The client application is used to set-up a reversed ssh tunnel to a server.
This can be used for connecting to clients that are behind a firewall.
The client will connect to a public server and forward it's ssh server to the
remote server from where you can connect to it using RSSHDP.

The client app depends on yad and xterm so make sure to install these befor
you try to execute it for without YAD it will not work.

Get YAD from the webupd8 PPA or from 
http://sourceforge.net/projects/yad-dialog


VPS
---

A VPS (Virtual Private Server) can be very handy when using rsshdp from behind a firewall.
By using a public VPS you can have both the client and the server connect to the VPS to
set-up the rsshdp session from there. 

I can recommend [DigitalOcean's](https://www.digitalocean.com/?refcode=c6c9d017f04a) VPS service
if you don't have one. They are easy to deploy (55sec) and can be payed by the hour so you only
get billed for what you use or just keep em running for $5 a month.
