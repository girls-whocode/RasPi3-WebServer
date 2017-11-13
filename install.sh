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

if haveprog dialog; then
	log "Dialog is already installed"
else
	echo -e $LIGHTRED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Starting Application and checking dependancies "$LIGHTRED"==="$COLOR_NONE
	evallog "sudo apt install -y dialog" & pid=$!
	progress
fi

readcfg
dialogmenu
