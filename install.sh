#!/bin/bash
########################################################################
#                    Raspberry Pi 3 Web Server                         #
#                 Script created by Jessica Brown                      #
#                       jessica@jbrowns.com                            #
#                                                                      #
# DESCRIPTION: https://github.com/jessicakennedy1028/RasPi3-WebServer  #
#                                                                      #
# I used Geany IDE to create this script with tab stops at 4           #
# characters.                                                          #
#                                                                      #
# Feel free to modify, but please give credit where it's due. Thanks!  #
#                                                                      #
########################################################################
# Errors:                                                              #
#                                                                      #
#   100 - Package manager was not found                                #
#   110 - Early exit status from script                                #
#   111 - Log file failed to write                                     #
#   112 - Hangup signal received                                       #
#   113 - Script quit script was performed                             #
#   114 - Illegal instruction signal received                          #
#   115 - Trace trap not reset signal received                         #
#   116 - Abort signal received                                        #
#   117 - Pollable event [XSR] generated, not supported signal received#
#   118 - Floating point signal received                               #
#   119 - Kill signal received                                         #
#   125 - Internet connection issue                                    #
#   150 - xterm or rxvt was not detected                               #
#   151 - tputs column width is less than 150                          #
#   180 - Configuration file error                                     #
#   190 - Script requires to be run as su                              #
#	200 - Failed to write configuration file                           #
#	201 - Failed to verify the write of config value                   #
#	202 - Failed to remove parameter from configuration file           #
#   203 - Parameter may consist of A-Z, a-z, 0-9, underscores, and     #
#         dashes (no spaces or special characters)                     #
#                                                                      #
########################################################################

# Call the functions file
source ./bin/functions.sh

# Set the variables
variables "set"

# install.sh must be run from terminal
tty -s
status=$?

if [ $status -ne 0 ]; then
	log "$0 must run from terminal"
fi

# This script requires to be run as Super User. Check to see if it is 
# being run by user 0 and initalize the log file
if [ "$(id -u)" != "0" ]; then
        echo -e "${LIGHTRED}Error 113 ${BLUE}- ${WHITE}This script requires to be ran by sudo${COLORNONE}"
        echo -e "   ${YELLOW}Usage:${COLORNONE}"
        echo -e "      ${WHITE}sudo ./deploy.bash${COLOR_NONE}"
        exit 190 # Error 190 - script requires to be run as root

		if [ ! -e "$logfile" ] ; then
			sudo touch $logfile
		fi
		if [ ! -w "$logfile" ] ; then
			echo "cannot write to $logfile"
			exit 111
		fi
fi
log "Script started #############################################################"
log "Start installation script"

loadcfg

if haveprog dialog; then
	log "Dialog is already installed"
	if [ ! -f "./.dialogrc" ]; then
		evallog "dialog --create-rc ./.dialogrc"
	fi
else
	echo -e $LIGHTRED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Starting Application and checking dependancies "$LIGHTRED"==="$COLOR_NONE
	evallog "sudo apt install -y dialog" & pid=$!
	progress
fi

# Set the defaults for the dialog environment
SCREENTITLE="Raspberry Pi 3 Web Server Auto Configuration"
HEIGHT=18
WIDTH=45
CHOICE_HEIGHT=10
DIALOG_CANCEL=1
DIALOG_ESC=255
OKLABEL="Submit"
CANCELLABEL="Back"
CREDITS="Jessica Brown"

# Main Menu Options List
title="Main Menu"
instructions="Choose one of the following options:\n\Zn[\Zb\Z1*\Zn] - Item incomplete\n\Zn[\Zb\Z2*\Zn] - Item completed\n\n"

while true; do
	# Place the checkcfg here so it is rechecked on each menu load
	checkcfg

	# This line sets a path to tempfile. The $$ is the current shell ID.
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$

	# This line makes sure the tempfile is deleted
	trap "rm -f $tempfile" 0 1 2 5 15

	# So many things that could be done, but let's start with the basics
		# Additional items to add someday:
			# System configuration
			# git configuration
			# Let's Encrypt SSL config and status
			# USB drive mounting and configuration
			# Raid drive mounting and configuration
			# Uninstall different type of apps
		# Move the Drive information inside the Drive Configuration
	MainMenuOptions=(1 "\Zn[${opt1menuitem}] Web Server Configuration" 2 "\Zn[${opt6menuitem}] Email Server Configuration" 3 "\Zn[${opt6menuitem}] Database Server Configuration" 4 "\Zn[${opt6menuitem}] Drive Configuration" 5 "\Zn[${opt6menuitem}] Drive Information" 6 "\Zn[${opt6menuitem}] Installed Programs" "ESC" "Exit Configuration Utility")

	exec 3>&1
	CHOICE=$(dialog --clear --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${MainMenuOptions[@]}" 2>&1 1>&3)
	exit_status=$?

	case $exit_status in
		$DIALOG_CANCEL)
			clear
			echo "Program terminated."
			exit
			;;
		$DIALOG_ESC)
			clear
			echo "Program aborted." >&2
			exit 1
			;;
	esac

	case $CHOICE in
		0)
			clear
			exit 0
			;;
		1)
			webserverform
			;;
		2)
			echo "You chose Option 2"
			;;
		3)
			echo "You chose Option 3"
			;;
		4)
			echo "You chose Option 4"
			;;
		5)
			result=$(df -h)
			display_result "Disk Space"
			;;
		6)
			echo "You chose Option 6"
			;;
		255)
			echo "WTF"
			;;
	esac
done
