#!/bin/bash
#########################################################################
#                    Raspberry Pi 3 Web Server                          #
#                 Script created by Jessica Brown                       #
#                       jessica@jbrowns.com                             #
#                                                                       #
# DESCRIPTION: https://github.com/jessicakennedy1028/RasPi3-WebServer   #
#                                                                       #
# I used Kate to create this script with tab stops at 4 characters      #
#                                                                       #
# Feel free to modify, but please give credit where it's due. Thanks!   #
#                                                                       #
#########################################################################
# Errors:                                                               #
#                                                                       #
#   100 - Package manager was not found                                 #
#	105 - Program called from another file                              #
#   110 - Early exit status from script                                 #
#   111 - Log file failed to write                                      #
#   112 - Hangup signal received                                        #
#   113 - Script quit script was performed                              #
#   114 - Illegal instruction signal received                           #
#   115 - Trace trap not reset signal received                          #
#   116 - Abort signal received                                         #
#   117 - Pollable event [XSR] generated, not supported signal received #
#   118 - Floating point signal received                                #
#   119 - Kill signal received                                          #
#   125 - Internet connection issue                                     #
#   150 - xterm or rxvt was not detected                                #
#   151 - tputs column width is less than 150                           #
#   180 - Configuration file                                            #
#	185 - Dependency program installation failed						#
#   190 - Script requires to be run as su                               #
#	200 - Failed to write configuration file                            #
#	201 - Failed to verify the write of config value                    #
#	202 - Failed to remove parameter from configuration file            #
#   203 - Parameter may consist of A-Z, a-z, 0-9, underscores, and      #
#         dashes (no spaces or special characters)                      #
#                                                                       #
#########################################################################

if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi 

error=(
	["100"]="Package manager was not found"
	["105"]="Program called from another file"
	["110"]="Early exit status from script"
	["111"]="Log file failed to write"
	["112"]="Hangup signal received"
	["113"]="Script quit script was performed"
	["114"]="Illegal instruction signal received"
	["115"]="Trace trap not reset signal received"
	["116"]="Abort signal received"
	["117"]="Pollable event [XSR] generated, not supported signal received"
	["118"]="Floating point signal received"
	["119"]="Kill signal received"
	["125"]="Internet connection issue"
	["140"]="Bash version is not compatible with this script"
	["141"]="file is missing"
	["150"]="xterm or rxvt was not detected"
	["151"]="tputs column width is less than 150"
	["180"]="Configuration file "
	["185"]="Dependency program installation failed"
	["190"]="Script requires to be run as su"
	["200"]="Failed to write configuration file"
	["201"]="Failed to verify the write of config value"
	["202"]="Failed to remove parameter from configuration file"
	["203"]="Parameter may consist of A-Z, a-z, 0-9, underscores, and dashes (no spaces or special characters)"
)
