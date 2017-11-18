#!/bin/bash
########################################################################
#                    Raspberry Pi 3 Web Server                         #
#                 Script created by Jessica Brown                      #
#                       jessica@jbrowns.com                            #
#                                                                      #
# DESCRIPTION: https://github.com/jessicakennedy1028/RasPi3-WebServer  #
#                                                                      #
# I used Kate to create this script with tab stops at 4 characters     #
#                                                                      #
# Feel free to modify, but please give credit where it's due. Thanks!  #
#                                                                      #
########################################################################
# Errors:                                                              #
#                                                                      #
#   100 - Package manager was not found                                #
#	105 - Program called from another file                             #
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

SYSTEMKEY="3d430f9af713781b92af4a97fc2e6664be7ce8e0"
source ./bin/functions.sh # Call the functions file
source ./bin/menu.sh # Call the menu file

variables "set" # Set the variables
mainmenusystem # Load all of the menu items

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
fi

log "Script started #############################################################"
log "Start installation script"

loadcfg # Load the configuration file

# Test for ncurses dialog application
if haveprog dialog; then
	log "Dialog is already installed"
	if [ ! -f "./.dialogrc" ]; then
		evallog "dialog --create-rc ./.dialogrc"
	fi
else
	echo -e $LIGHTRED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Starting Application and checking dependancies "$LIGHTRED"==="$COLOR_NONE
	evallog "$pkginstall dialog" & pid=$!
	progress
fi

# Test for net-tools whois application
if haveprog whois; then
	log "Whois is already installed"
else
	evallog "$pkginstall whois" & pid=$!
	progress
fi

# Set the defaults for the dialog environment
SCREENTITLE="System Server Auto Configuration"
HEIGHT=23
WIDTH=40
CHOICE_HEIGHT=21
OKLABEL="Submit"
CANCELLABEL="Back"
CREDITS="Jessica Brown"

# Display the main dialog menu system
main
