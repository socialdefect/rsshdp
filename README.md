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
