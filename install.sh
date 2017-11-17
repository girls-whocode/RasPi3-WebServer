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
mainmenusystem

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

# Main Menu Options List
title="Main Menu"
instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"

while true; do
	# Place the loadcfg and checkcfg here so it is rechecked on each menu load
	loadcfg

	# So many things that could be done, but let's start with the basics
		# Additional items to add someday:
		# Move the Drive information inside the Drive Configuration

	exec 3>&1
	CHOICE=$(dialog --clear --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mainmenu[@]}" 2>&1 1>&3)
	exit_status=$?

	case $exit_status in
		255) # If back or ESC was pressed
			dialog --clear --backtitle "$SCREENTITLE" --yesno "Are you sure you want to quit?" 10 30
			case $? in
				0)
					# If Yes was pressed
					clear
					break
					;;
				1)
					# No was pressed, so return back to the form
					returncode=99
					;;
			esac
			;;
	esac
	case $CHOICE in
		1) # WebServer
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${webservermenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # Apache
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${apachemenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1)
							apacheconfigform
							;;
						2)
							apachectrlform "restart"
							;;
						3)
							apachectrlform "start"
							;;
						4)
							apachectrlform "stop"
							;;
					esac
					;;
				2) # nGinX
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${nginxmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1)
							nginxconfigform
							;;
						2)
							nginxctrlform "restart"
							;;
						3)
							nginxctrlform "start"
							;;
						4)
							nginxctrlform "stop"
							;;
					esac
					;;
				3) # Lightspeed
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>&1 1>&3)
					case $CHOICE in
						1)
							lightspeedconfigform
							;;
						2)
							lightspeedctrlform "restart"
							;;
						3)
							lightspeedctrlform "start"
							;;
						4)
							lightspeedctrlform "stop"
							;;
					esac
					;;
				4) # SSL
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${letsencryptmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1)
							echo "Let's Encrypt Settings"
							;;
						2)
							echo "Renew Certification"
							;;
						3)
							echo "Revoke Certification"
							;;
					esac
					;;
				5) # Disable Web Server
					echo "Disable Web Server"
					;;
			esac
			;;
		2) # Database
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${databaseservermenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # mySQL
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mysqlmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # mySQL Configuration
							echo "mySQL Configuration"
							;;
						2) # mySQL Restart
							echo "mySQL Restart"
							;;
						3) # mySQL Start
							echo "mySQL Start"
							;;
						4) # mySQL Stop
							echo "mySQL Stop"
							;;
					esac
					;;
				2) # MariaDB
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mariadbsqlmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # MariaDB Configuration
							echo "MariaDB Configuration"
							;;
						2) # MariaDB Restart
							echo "MariaDB Restart"
							;;
						3) # MariaDB Start
							echo "MariaDB Start"
							;;
						4) # MariaDB Stop
							echo "MariaDB Stop"
							;;
					esac
					;;
				3) # PostgreSQL
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${postgresqlmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # PostgreSQL Configuration
							echo "PostgreSQL Configuration"
							;;
						2) # PostgreSQL Restart
							echo "PostgreSQL Restart"
							;;
						3) # PostgreSQL Start
							echo "PostgreSQL Start"
							;;
						4) # PostgreSQL Stop
							echo "PostgreSQL Stop"
							;;
					esac
					;;
				4) # Disable Database Server
					echo "Disable Database Server"
					;;
			esac
			;;
		3) # Application
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${applicationservermenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # PHP
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${phpmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # PHP Configuration
							echo "PHP Configuration"
							;;
						2) # PHP Restart
							echo "PHP Restart"
							;;
						3) # PHP Start
							echo "PHP Start"
							;;
						4) # PHP Stop
							echo "PHP Stop"
							;;
					esac
					;;
				2) # Java
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${javamenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Java Configuration
							echo "Java Configuration"
							;;
						2) # Java Restart
							echo "Java Restart"
							;;
						3) # Java Start
							echo "Java Start"
							;;
						4) # Java Stop
							echo "Java Stop"
							;;
					esac
					;;
				3) # Tomcat
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${tomcatmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Tomcat Configuration
							echo "Tomcat Configuration"
							;;
						2) # Tomcat Restart
							echo "Tomcat Restart"
							;;
						3) # Tomcat Start
							echo "Tomcat Start"
							;;
						4) # Tomcat Stop
							echo "Tomcat Stop"
							;;
					esac
					;;
				4) # Open Source
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${opensourcemenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Open Source Configuration
							echo "Open Source Configuration"
							;;
						2) # Open Source Restart
							echo "Open Source Restart"
							;;
						3) # Open Source Start
							echo "Open Source Start"
							;;
						4) # Open Source Stop
							echo "Open Source Stop"
							;;
					esac
					;;
				5) # Open Source
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mobilemenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Open Source Configuration
							echo "Mobile App Configuration"
							;;
						2) # Open Source Restart
							echo "Mobile App Restart"
							;;
						3) # Open Source Start
							echo "Mobile App Start"
							;;
						4) # Open Source Stop
							echo "Mobile App Stop"
							;;
					esac
					;;
				6) # BBS Applications
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${bbsappsmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Mystic 
							CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mysticmenu[@]}" 2>&1 1>&3)
							case $CHOICE in
								1) # Mystic Configuration
									echo "Mystic Configuration"
									;;
								2) # Mystic Local Mode
									echo "Mystic Local Mode"
									;;
							esac
							;;
						2) # WWIV
							CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${wwivmenu[@]}" 2>&1 1>&3)
							case $CHOICE in
								1) # WWIV Configuration
									echo "WWIV Configuration"
									;;
								2) # WWIV Local Mode
									echo "WWIV Local Mode"
									;;
							esac
							;;
					esac
					;;
				7) # Disable Application Server
					echo "Disable Application Server"
					;;
			esac
			;;
		4) # Email
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${emailservermenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # Postfix
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${postfixmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Postfix Configuration
							echo "Postfix Configuration"
							;;
						2) # Postfix Restart
							echo "Postfix Restart"
							;;
						3) # Postfix Start
							echo "Postfix Start"
							;;
						4) # Postfix Stop
							echo "Postfix Stop"
							;;
					esac
					;;
				2) # Citadel
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${citadelmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Citadel Configuration
							echo "Citadel Configuration"
							;;
						2) # Citadel Restart
							echo "Citadel Restart"
							;;
						3) # Citadel Start
							echo "Citadel Start"
							;;
						4) # Citadel Stop
							echo "Citadel Stop"
							;;
					esac
					;;
				3) # Sendmail
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${sendmailmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Sendmail Configuration
							echo "Sendmail Configuration"
							;;
						2) # Sendmail Restart
							echo "Sendmail Restart"
							;;
						3) # Sendmail Start
							echo "Sendmail Start"
							;;
						4) # Sendmail Stop
							echo "Sendmail Stop"
							;;
					esac
					;;
				4) # Exim
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${eximmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Exim Configuration
							echo "Exim Configuration"
							;;
						2) # Exim Restart
							echo "Exim Restart"
							;;
						3) # Exim Start
							echo "Exim Start"
							;;
						4) # Exim Stop
							echo "Exim Stop"
							;;
					esac
					;;
				5) # Sendmail
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${couriermenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Courier Configuration
							echo "Courier Configuration"
							;;
						2) # Courier Restart
							echo "Courier Restart"
							;;
						3) # Courier Start
							echo "Courier Start"
							;;
						4) # Courier Stop
							echo "Courier Stop"
							;;
					esac
					;;
				6) # Disable Email Server
					echo "Disable Email Server"
					;;
			esac
			;;
		5) # File
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${fileservermenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # FTP
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${ftpmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # FTP Configuration
							echo "FTP Configuration"
							;;
						2) # FTP Restart
							echo "FTP Restart"
							;;
						3) # FTP Start
							echo "FTP Start"
							;;
						4) # FTP Stop
							echo "FTP Stop"
							;;
					esac
					;;
				2) # NSF
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${nfsmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # NFS Configuration
							echo "NFS Configuration"
							;;
						2) # NFS Restart
							echo "NFS Restart"
							;;
						3) # NFS Start
							echo "NFS Start"
							;;
						4) # NFS Stop
							echo "NFS Stop"
							;;
					esac
					;;
				3) # Samba
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${sambamenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Samba Configuration
							echo "Samba Configuration"
							;;
						2) # Samba Restart
							echo "Samba Restart"
							;;
						3) # Samba Start
							echo "Samba Start"
							;;
						4) # Samba Stop
							echo "Samba Stop"
							;;
					esac
					;;
				4) # Disable File Server
					echo "Disable File Server"
					;;
			esac
			;;
		6) # Message
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${messageservermenu[@]}" 2>&1 1>&3)
			;;
		7) # Proxy
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${proxyservermenu[@]}" 2>&1 1>&3)
			;;
		8) # System Configuration
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${systemconfigmenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # System Information
					echo "System Information"
					;;
				2) # File System
					CHOICE=$(dialog --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${filesystemmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Drive Information
							echo "Drive Information"
							;;
						2) # Mount Points
							echo "Mount Points"
							;;
						3) # Raid Configuration
							echo "Raid Configuration"
							;;
						4) # USB Drive Configuration
							echo "USB Drive Configuration"
							;;
					esac
					;;
				3) # Memory
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${memorymenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Free Memory
							echo "Free Memory"
							;;
						2) # Swap Memory
							echo "Swap Memory"
							;;
					esac
					;;
				4) # File Editor
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${fileeditormenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Host file
							echo "Host file"
							;;
						2) # Hostnames file
							echo "Hostnames file"
							;;
					esac
					;;
				5) # Network Configuration
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${networkconfigmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Exim Configuration
							echo "Wireless Configuration"
							;;
						2) # Exim Restart
							echo "Network Configuration"
							;;
					esac
					;;
				6) # Application Configuration
					CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${applicationmenu[@]}" 2>&1 1>&3)
					case $CHOICE in
						1) # Git Configuration
							echo "Git Configuration"
							;;
						2) # Uninstall Applications
							echo "Uninstall Applications"
							;;
					esac
					;;
			esac
			;;
		9) # Logs
			CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${logsmenu[@]}" 2>&1 1>&3)
			case $CHOICE in
				1) # Apache Logs
					echo "Apache Logs"
					;;
				2) # PHP Logs
					echo "PHP Logs"
					;;
				3) # Access Logs
					echo "Access Logs"
					;;
				4) # Error Logs
					echo "Error Logs"
					;;
				5) # Installation Logs
					echo "Installation Logs"
					;;
			esac
			;;
	esac
done
