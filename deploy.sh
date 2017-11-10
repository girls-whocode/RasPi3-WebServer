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
#   112 - Script requires to be run as su                              #
#   125 - Internet connection issue                                    #
#   150 - xterm or rxvt was not detected                               #
#   151 - tputs column width is less than 150                          #
#   180 - Configuration file error                                     #
#	200 - Failed to write configuration file                           #
#	201 - Failed to verify the write of config value                   #
#	202 - Failed to remove parameter from configuration file           #
#   203 - Parameter may consist of A-Z, a-z, 0-9, underscores, and     #
#         dashes (no spaces or special characters)                     #
#                                                                      #
########################################################################

# Make sure the display gets updated when the terminal window is resized
shopt -s checkwinsize
# If available in terminal, clear the screen
clear

# This script requires to be run as Super User. Check to see if it is being run by user 0
if [ "$(id -u)" != "0" ]; then
        echo -e "${LIGHT_RED}Error 113 ${BLUE}- ${WHITE}This script requires to be ran by sudo${COLOR_NONE}"
        echo -e "   ${YELLOW}Usage:${COLOR_NONE}"
        echo -e "      ${WHITE}sudo ./deploy.bash${COLOR_NONE}"
        exit 112 # Error 112 - script requires to be run as root
fi

# Test the terminal for xterm
case $TERM in
    xterm*|rxvt*)
		unset COLUMNS
		# Reset terminal size to 150x45 if allowed.
		echo -ne '\e[8;45;150t'
		COLS=$(tput cols)
		printf %b '\033[?7l'
		# The columns are less than 150, and forcewidth was not used
		if [ $COLS -lt 150 ] && [ "$1" != "--forcewidth" ]; then
			echo "Your terminal column width is set to $COLS"
			echo "which is less then 150 characters wide, the"
			echo "attempt of auto adjusting failed. You may"
			echo "force run with the --forcewidth argument"
			echo "although you may have screen distortion."
			echo ""
			echo "If you screen resized and you are still seeing"
			echo "this message, the escape sequence did not update"
			echo "the columns variable. Just run the script again"
			echo "without the --forcewidth option"
			echo ""
			echo "To run with the forcewidth argument use:"
			echo "sudo ./deploy.sh --forcewidth"
			exit 151
		fi
		;;
    *)
		tput rmam
		echo "This script needs to be run from xterm or rxvt"
		exit 150
		;;
esac

#######################################
# haveProg - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
haveProg() {
    [ -x "$(which $1)" ]
}
#######################################
# variables - assign variables for script
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
variables() {
	trap quitscript SIGINT SIGQUIT SIGTSTP
	trap finish EXIT
	if [[ "$1" == "set" ]]; then
		# Set the variables for this script
		BLACK="\033[0;30m"
		RED="\033[0;31m"
		GREEN="\033[0;32m"
		ORANGE="\033[0;33m"
		BLUE="\033[0;34m"
		PURPLE="\033[0;35m"
		CYAN="\033[0;36m"
		GREY="\033[0;37m"
		DARK_GREY="\033[1;30m"
		LIGHT_RED="\033[1;31m"
		LIGHT_GREEN="\033[1;32m"
		LIGHT_BLUE="\033[1;34m"
		YELLOW="\033[1;33m"
		LIGHT_PURPLE="\033[1;35m"
		LIGHT_CYAN="\033[1;36m"
		WHITE="\033[1;37m"
		LIGHT_GRAY="\033[0;37m"
		COLOR_NONE="\e[0m"
		spin[0]=$LIGHT_RED"-"
		spin[1]=$WHITE"\\"
		spin[2]=$YELLOW"|"
		spin[3]=$LIGHT_GREEN"/"
		ETC_HOSTS=/etc/hosts
		hosts=/etc/hosts
		version="1.0a"
		verbose="false"
		logfile=/var/log/raspy3-install_`date +'%m-%d-%Y_%H%M%S'`.log
		steplogdir=/home/pi/.config/raspi/
		steplogfile=raspconfig.dat
		configfile=raspconfig.ini
	elif [[ "$1" == "unset" ]]; then
		# Free up used memory for all of the variables created by this script
		for i in $(env | awk -F"=" '{print $1}') ; do
		unset $i ; done
	fi
}
#######################################
# Output - Output header and menu system
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
output() {
	if [ "$1" == "header" ]; then
		echo -e "		  $RED██████$DARK_GREY╗  $RED█████$DARK_GREY╗ $RED███████$DARK_GREY╗$RED██████$DARK_GREY╗ $RED██████$DARK_GREY╗ $RED███████$DARK_GREY╗$RED██████$DARK_GREY╗ $RED██████$DARK_GREY╗ $RED██$DARK_GREY╗   $RED██$DARK_GREY╗    $RED██████$DARK_GREY╗ $RED██$DARK_GREY╗    $RED██████$DARK_GREY╗"                   
		echo -e "		  $RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔════╝$RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔════╝$RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══$RED██$DARK_GREY╗╚$RED██$DARK_GREY╗ $RED██$DARK_GREY╔╝    $RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY║    ╚════$RED██$DARK_GREY╗"                  
		echo -e "		  $RED██████$DARK_GREY╔╝$RED███████$DARK_GREY║$RED███████$DARK_GREY╗$RED██████$DARK_GREY╔╝$RED██████$DARK_GREY╔╝$RED█████$DARK_GREY╗  $RED██████$DARK_GREY╔╝$RED██████$DARK_GREY╔╝ ╚$RED████$DARK_GREY╔╝     $RED██████$DARK_GREY╔╝$RED██$DARK_GREY║     $RED█████$DARK_GREY╔╝"
		echo -e "		  $RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══$RED██$DARK_GREY║╚════$RED██$DARK_GREY║$RED██$DARK_GREY╔═══╝ $RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══╝  $RED██$DARK_GREY╔══$RED██$DARK_GREY╗$RED██$DARK_GREY╔══$RED██$DARK_GREY╗  $DARK_GREY╚$RED██$DARK_GREY╔╝      $RED██$DARK_GREY╔═══╝ $RED██$DARK_GREY║     ╚═══$RED██$DARK_GREY╗"                  
		echo -e "		  $RED██$DARK_GREY║  $RED██$DARK_GREY║$RED██$DARK_GREY║  $RED██$DARK_GREY║$RED███████$DARK_GREY║$RED██$DARK_GREY║     $RED██████$DARK_GREY╔╝$RED███████$DARK_GREY╗$RED██$DARK_GREY║  $RED██$DARK_GREY║$RED██$DARK_GREY║  $RED██$DARK_GREY║   $RED██$DARK_GREY║       $RED██$DARK_GREY║     $RED██$DARK_GREY║    $RED██████$DARK_GREY╔╝"                  
		echo -e "		  $DARK_GREY╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝    ╚═════╝"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY╗    $LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██████$DARK_GREY╗     $LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██████$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY╗   $LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██████$DARK_GREY╗      $LIGHT_BLUE█████$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY╗   $LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE████████$DARK_GREY╗ $LIGHT_BLUE██████$DARK_GREY╗"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY║    $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗    $LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗    $LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║╚══$LIGHT_BLUE██$DARK_GREY╔══╝$LIGHT_BLUE██$DARK_GREY╔═══$LIGHT_BLUE██$DARK_GREY╗"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY║ $LIGHT_BLUE█$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE█████$DARK_GREY╗  $LIGHT_BLUE██████$DARK_GREY╔╝    $LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE█████$DARK_GREY╗  $LIGHT_BLUE██████$DARK_GREY╔╝$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE█████$DARK_GREY╗  $LIGHT_BLUE██████$DARK_GREY╔╝    $LIGHT_BLUE███████$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE███$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔══╝  $LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗    ╚════$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔══╝  $LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗╚$LIGHT_BLUE██$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY╔╝$LIGHT_BLUE██$DARK_GREY╔══╝  $LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗    $LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║"
		echo -e "		  $DARK_GREY╚$LIGHT_BLUE███$DARK_GREY╔$LIGHT_BLUE███$DARK_GREY╔╝$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██████$DARK_GREY╔╝    $LIGHT_BLUE███████$DARK_GREY║$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE██$DARK_GREY║ ╚$LIGHT_BLUE████$DARK_GREY╔╝ $LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE██$DARK_GREY║    $LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE██$DARK_GREY║╚$LIGHT_BLUE██████$DARK_GREY╔╝   $LIGHT_BLUE██$DARK_GREY║   ╚$LIGHT_BLUE██████$DARK_GREY╔╝"
		echo -e "		  $DARK_GREY ╚══╝╚══╝ ╚══════╝╚═════╝     ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝"
		echo -e "		  $LIGHT_BLUE ██████$DARK_GREY╗ $LIGHT_BLUE██████$DARK_GREY╗ $LIGHT_BLUE███$DARK_GREY╗   $LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE███████$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY╗ $LIGHT_BLUE██████$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY╗   $LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██████$DARK_GREY╗  $LIGHT_BLUE█████$DARK_GREY╗ $LIGHT_BLUE████████$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY╗ $LIGHT_BLUE██████$DARK_GREY╗ $LIGHT_BLUE███$DARK_GREY╗   $LIGHT_BLUE██$DARK_GREY╗"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY╔═══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE████$DARK_GREY╗  $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔════╝$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔════╝ $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗╚══$LIGHT_BLUE██$DARK_GREY╔══╝$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔═══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE████$DARK_GREY╗  $LIGHT_BLUE██$DARK_GREY║"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY║     $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔$LIGHT_BLUE██$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE█████$DARK_GREY╗  $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE███$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE ██$DARK_GREY║$LIGHT_BLUE██████$DARK_GREY╔╝$LIGHT_BLUE███████$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔$LIGHT_BLUE██$DARK_GREY╗ $LIGHT_BLUE██$DARK_GREY║"
		echo -e "		  $LIGHT_BLUE██$DARK_GREY║     $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║╚$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔══╝  $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY╔══$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║╚$LIGHT_BLUE██$DARK_GREY╗$LIGHT_BLUE██$DARK_GREY║"
		echo -e "		  $DARK_GREY╚$LIGHT_BLUE██████$DARK_GREY╗╚$LIGHT_BLUE██████$DARK_GREY╔╝$LIGHT_BLUE██$DARK_GREY║ ╚$LIGHT_BLUE████$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║     $LIGHT_BLUE██$DARK_GREY║╚$LIGHT_BLUE██████$DARK_GREY╔╝╚$LIGHT_BLUE██████$DARK_GREY╔╝$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE██$DARK_GREY║$LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE██$DARK_GREY║   $LIGHT_BLUE██$DARK_GREY║  $LIGHT_BLUE ██$DARK_GREY║╚$LIGHT_BLUE██████$DARK_GREY╔╝$LIGHT_BLUE██$DARK_GREY║ ╚$LIGHT_BLUE████$DARK_GREY║"
		echo -e "		  $DARK_GREY ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝"
		echo -e $LIGHT_GREEN"		                                                                                 +-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+"
		echo -e $LIGHT_GREEN"		                                                                                 |${YELLOW}b$LIGHT_GREEN|${YELLOW}y$LIGHT_GREEN| |${YELLOW}J$LIGHT_GREEN|${YELLOW}e$LIGHT_GREEN|${YELLOW}s$LIGHT_GREEN|${YELLOW}s$LIGHT_GREEN|${YELLOW}i$LIGHT_GREEN|${YELLOW}c$LIGHT_GREEN|${YELLOW}a$LIGHT_GREEN| |${YELLOW}B$LIGHT_GREEN|${YELLOW}r$LIGHT_GREEN|${YELLOW}o$LIGHT_GREEN|${YELLOW}w$LIGHT_GREEN|${YELLOW}n$LIGHT_GREEN| |${YELLOW}2$LIGHT_GREEN|${YELLOW}0$LIGHT_GREEN|${YELLOW}1$LIGHT_GREEN|${YELLOW}7$LIGHT_GREEN|"
		echo -e $LIGHT_GREEN"		                                                                                 +-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+ +-+-+-+-+"
		echo -e $COLOR_NONE""
		echo -e $WHITE"  Welcome to ${LIGHT_GREEN}Web Server Inventory Installer ${WHITE}and"
		echo -e $WHITE"  ${LIGHT_GREEN}Auto Config System ${WHITE}for ${RED}Raspberry Pi 3."
		echo ""
		echo -e $COLOR_NONE"  This script will attempt to install and"
		echo -e $COLOR_NONE"  configure ${LIGHT_RED}Apache 2${COLOR_NONE}, ${LIGHT_RED}PHP 7${COLOR_NONE}, ${LIGHT_RED}MariaDB ${COLOR_NONE}and"
		echo -e $COLOR_NONE"  ${LIGHT_RED}Let's Encrypt ${COLOR_NONE}automatically"
		echo ""
		echo -e $LIGHT_RED"   WARNING:${WHITE} THIS SCRIPT IS INTENDED FOR A FRESHLY INSTALLED "
		echo -e $WHITE"   SYSTEM! DO NOT USE THIS ON A SYSTEM THAT IS NOT A FRESH INSTALL!"
		echo -e $WHITE"   IT WILL CHANGE SETTINGS THAT HAVE BEEN CONFIGURED BY OTHER "
		echo -e $WHITE"   APPLICATIONS"
		echo ""
		# FIND WAYS TO CHECK TO SEE IF THIS IS A NEW SYSTEM, THEN GIVE THE USER TO ABORT
	fi
	if [ "$1" == "instructions" ]; then
		echo -e $COLOR_NONE"  Please answer the questions below to configure your"
		echo -e $COLOR_NONE"  web server to your specific needs. Some defaults are"
		echo -e $COLOR_NONE"  assumed from system variables."
		echo ""
		echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Creating Installation Log File: $logfile "$LIGHT_RED"==="$COLOR_NONE
		echo -e $YELLOW"(you may watch the progress by running 'tail -f $logfile')"$COLOR_NONE
	fi
	if [ "$1" == "questions" ]; then
		echo ""
	fi
}
#######################################
# Progress - creates a spinner for script
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
progress() {
    echo -n " "
    tput civis
    while kill -0 "$pid" > /dev/null 2>&1; do
        for i in "${spin[@]}"; do
            echo -ne "\b$i"
            sleep .1
        done
    done
    echo -ne $LIGHT_RED"\r=== $LIGHT_GREEN Completed $LIGHT_RED ==="$COLOR_NONE
    echo ""
    tput cnorm
}
#######################################
# Steps - Write a file to determine
#    where the user left off and tell
#    the menu what has been completed
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
steps() {
	step="$1"
    # An internal step counter and error checking
    # Create the file if it doesn't exist
    # If the file does exist, show menu which shows successful and error indicators
}
#######################################
# evallog - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
evallog() {
    if [ "$verbose" = true ]; then
        eval "$@"
    else
        eval "$@" |& tee -a $logfile >/dev/null 2>&1
    fi
}
#######################################
# log - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
log() {
    if [ "$verbose" = true ]; then
        echo "$@"
    else
        echo "$@" |& tee -a $logfile >/dev/null 2>&1
    fi
}
#######################################
# checkinet - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
checkinet() {
    case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
	[23]) true;;
	5) inet="The web proxy won't let us through";;
	*) inet="The network is down or very slow";;
    esac
}
#######################################
# checkversion - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
checkversion() {
	[[ -d $steplogdir ]] || sudo mkdir -p $steplogdir
	log "#### CHECKING FOR INTERNET `date '+%m-%d-%Y %I:%M:%S'` ####"

	# Check for Internet Connection
	if checkinet; then
		log "#### INTERNET CONNECTION OK `date '+%m-%d-%Y %I:%M:%S'` ####"
	else
		log "#### INTERNET DOWN THE ERROR MESSAGE SENT: $inet `date '+%m-%d-%Y %I:%M:%S'` ####"
		echo -e "It seems that internet is not available, this script requires internet to update, upgrade and install packages"
		echo -e "Please resolve internet issue and rerun this script"
		exit 125
	fi

	# Check to see if this is the latest version of the script, notice the $version variable in the URL
	# Download location: https://github.com/jessicakennedy1028/RasPi3-WebServer/releases/download/$version/deploy.sh
}
#######################################
# setvhdebian - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
setvhdebian() {
    find /etc/apache2/mods-enabled -maxdepth 1 -name 'rewrite.load' >/dev/null 2>&1
    apachefile=/etc/apache2/sites-available/$fqdn.conf

    if [ -f $apachefile ]; then
	sudo mv $apachefile $apachefile.BAK_`date +'%m-%d-%Y_%I%M%S'`.conf
	evallog "a2dissite $fqdn.conf"
    fi

    {
        echo "<VirtualHost *:80>"
        echo "ServerAdmin $email"
        echo "<Directory $phfolder>"
        echo "        Require all granted"
        echo "        AllowOverride All"
        echo "   </Directory>"
        echo "    DocumentRoot $phfolder"
        echo "    ServerName $fqdn"
        echo "        ErrorLog /var/log/apache2/$fqdn.error.log"
        echo "        CustomLog /var/log/apache2/access.log combined"
        echo "</VirtualHost>"
    } > $apachefile
    evallog "a2ensite $fqdn.conf"
    echo '<?php echo "Your site is configured. Today is ".date("m-d-Y");' > ~/index.php
    evallog "sudo chown -R nobody:root $webserverdir"
    evallog "sudo chmod -R a=r,a+x,u+w $webserverdir"
    evallog "sudo mv ~/index.php $phfolder"
    evallog "sudo replace '/var/www/' '$webserverdir' -- /etc/apache2/apache2.conf"
    evallog "service apache2 restart"
}
#######################################
# setvhcentos - 
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
setvhcentos () {
    apachefile=/etc/httpd/conf.d/$name.conf
    {
        echo "<VirtualHost *:80>"
        echo "ServerAdmin webmaster@localhost"
        echo "    <Directory $webdir/$user/public>"
        echo "        Allow From All"
        echo "        AllowOverride All"
        echo "        Options +Indexes"
        echo "   </Directory>"
        echo "    DocumentRoot $webdir/$user/public"
        echo "    ServerName $fqdn"
        echo "        ErrorLog /var/log/httpd/snipeIT.error.log"
        echo "        CustomLog /var/log/access.log combined"
        echo "</VirtualHost>"
    } >> "$apachefile"
}
#######################################
# quitscript - If CTRL-C is pressed
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
quitscript() {
	tput cnorm
	log "Exit script was performed, attempting cleanup"
	echo -en $RED"\n\nScript was aborted\n\n"$COLOR_NONE
	echo -en "Cleaning up please wait\n"
	# Honestly, currently there is nothing to clean up since pretty much
	# what was done, is already done. But if any temp files are made, or
	# any changes we want to revert back could be done here.
	progress
	exit 0
}
#######################################
# finish - End of script was detected
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
finish() {
	echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Installation Script has Completed "$LIGHT_RED"==="$COLOR_NONE
	log "################################################################################################################"
	echo -e $YELLOW"(visit $fqdn to see if your site is active. errors may be found in $logfile)"$COLOR_NONE
	tput cnorm
	variables "unset"
	exit 0
}
#######################################
# managehost - Manage hostnames
#     to the /etc/hosts file
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
managehost() {
	OPTION=$1
	HOSTNAME=$2
	
	# Remove IP and Hostname from file
	if [ "$1" == "remove" ]; then
		if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
		then
			log "$HOSTNAME was found, removing from $ETC_HOSTS"
			evallog 'sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS'
		else
			log "$HOSTNAME was not found in your $ETC_HOSTS"
		fi
	# Add IP and Hostname to file
	elif [ "$1" == "add" ]; then
		HOSTS_LINE="$IP\t$HOSTNAME"
		if [ -n "$(grep -P "[[:space:]]$HOSTNAME" $ETC_HOSTS)" ]; then
			log "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
		else
			log "Adding $HOSTNAME to your $ETC_HOSTS";
			evallog 'printf "%s\t%s\n" "$IP" "$HOSTNAME" | sudo tee -a "$ETC_HOSTS" > /dev/null'
			# Old method below new version is line above
			# sudo -- sh -c -e "echo '$HOSTS_LINE' >> $ETC_HOSTS";

			if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]; then
				log "$HOSTNAME was added succesfully $(grep $HOSTNAME /etc/hosts)"
			else
				log "#### Failed to Add $HOSTNAME ####"
				log "#### Manually open /etc/hosts and add $IP    $HOSTNAME"
				echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $WHITE" === "$LIGHT_RED"ERROR UPDATING HOSTS FILE SEE LOG FILE"$WHITE"==="$COLOR_NONE
			fi
		fi
	# Find the Hostname in the file
	elif [ "$1" == "find" ]; then
		if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]; then
			true
		fi
	fi
}
#######################################
# config - read and write config file
#
# Globals:
#   
#   
# Arguments:
#   None
# Returns:
#   None
#######################################
config() {
	option=$1
	option_mode=ini
	SEPARATOR_INI='='

	case $option in
		"change_value")
			parameter=$2
			separator=$SEPARATOR_INI
			value=$3
			
			if [[ -f $configfile ]]; then
				line_number=$(config "get_line" $parameter $separator)
				if [[ -n $line_number ]]; then
					# Since the parameter was found, remove it, then add it again
					config "remove_value" $parameter
					config "write_value" $parameter $value
					
					# I debated long and hard rather I wanted to sort the ini file
					# it is still a debate, but it makes it easier to find and verify
					# the config parameter was written successfully. JMO
					sort -o "$configfile" "$configfile"
				else
					# In case the parameter is not there, just write it to the config file
					echo "${parameter}${separator}${value}" >> "${configfile}"
					sort -o "$configfile" "$configfile"
				fi
			fi
			config "verify_write" $parameter $value
			;;
		"get_line")
			parameter=$2
			separator=$SEPARATOR_INI

			config "set_mode"
			output=$(sed -n "/^${parameter}${separator}/=" "$configfile" 2>/dev/null)
			[[ ! -z ${output##*[!0-9]*} ]] && echo $output
			;;
		"read_value")
			parameter=$2
			separator=$SEPARATOR_INI
			
			config "set_mode"
			output=$(sed -n "s/^${parameter}${separator}//p" "$configfile" 2>/dev/null)
			
			if [[ -n $output ]]; then
				log "${parameter} found"
				echo "${output}"
			else
				if grep -q "^${parameter}${separator}$" "$configfile" 2>/dev/null; then
					log "${parameter} null"
					echo "null"
				else
					log "${parameter} false"
					echo "false"
				fi
			fi
			;;
		"remove_config")
			rm -f "$2" &>/dev/null
			config_return=true
			
			if [[ -f $configfile ]]; then
				exit 200
			fi
			;;
		"remove_value")
			parameter=$2
			separator=$SEPARATOR_INI

			line_number=$(config "get_line" $parameter $separator)

			[[ -n $line_number ]] && sed -i "${line_number}d" "$configfile" 2>/dev/null
			if grep -q "^${parameter}${separator}" "$configfile" 2>/dev/null; then
				exit 202
			elif [[ -f $configfile && ! -s $configfile ]]; then  # remove config if empty
				config "remove_config" $configfile
			fi
			;;
		"sanitize_value")
			parameter=$2
 
			if ! echo "$parameter" | grep -q '^[A-Za-z0-9_-]\+$'; then
				exit 203
			fi
			;;
		"set_mode")
			grep -q "^[A-Za-z0-9_-]\+${SEPARATOR_INI}" "$configfile" &>/dev/null && mode+=(ini)

			if (( ${#mode[@]} > 1 )); then
				config_return="Unable to determine a consistent configuration file format."
			fi
			
			if [[ -n $option_mode ]]; then
				if [[ -n ${mode[0]} && ( ${mode[0]} != $option_mode ) ]]; then
					# use detected mode in the event of a conflicting option
					echo "WARNING: '$configfile' was intified as ${mode[0]} mode (ignoring $option_mode option)" >&2
					mode=${mode[0]}
				else
					# use optioned mode
					mode=$option_mode
				fi

			# NO OPTION IS SET and we have detected mode
			elif [[ -n ${mode[0]} ]]; then
				# use detected mode
				mode=${mode[0]}
			fi

			separator=$SEPARATOR_INI
			;;
		"verify_write")
			fullstring="${2}${SEPARATOR_INI}${3}"

			if ! grep -q "^${fullstring}$" "$configfile" &>/dev/null; then
				exit 201
			fi
			;;
		"write_value")
			parameter=$2
			separator=$SEPARATOR_INI
			value=$3

			if [[ -f $configfile ]]; then
				line_number=$(config "get_line" $parameter $separator)
				if [[ -n $line_number ]]; then
					sed -i "${line_number}c${parameter}${separator}${value}" "$configfile" 2>/dev/null
				else
					echo "${parameter}${separator}${value}" >> "${configfile}"
					sort -o "$configfile" "$configfile"
				fi
			else
				echo "${parameter}${separator}${value}" >> "${configfile}"
			fi
			config "verify_write" $parameter $value
			;;
		*)
			exit 180
			;;
	esac
}

# Setup all the variables to be used, "unset" is called in the finish function
variables "set"

if [[ -f $configfile ]]; then
	# The configuration file exists, now let test to make sure the parameter exists
	# Had to make a decision here, if the config file exists and there are missing
	# items, do I decide to fix it or just delete it and force it to recreate?
	
	# For now, let's try to fix it, if this turns to be a problem, we'll delete it
	# and then rebuild it.
	if [ $(config "read_value" "distro") == 'false' ]; then
		DISTRO=$( lsb_release -is )
		config "write_value" "distro" $DISTRO
	else
		DISTRO=$(config "read_value" "distro")
	fi
	if [ $(config "read_value" "codename") == 'false' ]; then
		CODENAME=$( lsb_release -cs )
		config "write_value" "codename" $CODENAME
	else
		CODENAME=$(config "read_value" "codename")
	fi
	if [ $(config "read_value" "distro_version") == 'false' ]; then
		DISTVERSION=$( lsb_release -rs )
		config "write_value" "distro_version" $DISTVERSION
	else
		DISTVERSION=$(config "read_value" "distro_version")
	fi
	if [ $(config "read_value" "ip") == 'false' ]; then
		IP="127.0.0.1"
		config "write_value" "ip" $IP
	else
		IP=$(config "read_value" "ip")
	fi
	if [ $(config "read_value" "ownergroup") == 'false' ]; then
		ownergroup="www-data:www-data"
		config "write_value" "ownergroup" $ownergroup
	else
		ownergroup=$(config "read_value" "ownergroup")
	fi
	if [ $(config "read_value" "tzone") == 'false' ]; then
		tzone="$(cat /etc/timezone)"
		config "write_value" "tzone" $tzone
	else
		tzone=$(config "read_value" "tzone")
	fi
	if [ $(config "read_value" "webserverdir") == 'false' ]; then
		webserverdir="/var/www/"
		config "write_value" "webserverdir" $webserverdir
	else
		webserverdir=$(config "read_value" "webserverdir")
	fi
	if [ $(config "read_value" "pkgmgr") == 'false' ]; then
		if haveProg apt-get; then
			log "#### CHECKING FOR PACKAGE MANAGER: APT INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
			pkginstall='DEBIAN_FRONTEND=noninteractive sudo apt -y'
			config "write_value" "pkgmgr" "apt"
		elif haveProg dnf; then
			log "#### CHECKING FOR PACKAGE MANAGER: DNF INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
			pkginstall='sudo dnf -y'
			config "write_value" "pkgmgr" "dnf"
		elif haveProg yum; then
			log "#### CHECKING FOR PACKAGE MANAGER: YUM INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
			pkginstall='sudo yum -y'
			config "write_value" "pkgmgr" "yum"
		elif haveProg up2date; then
			log "#### CHECKING FOR PACKAGE MANAGER: UP2DATE INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
			pkginstall='sudo up2date -y'
			config "write_value" "pkgmgr" "up2date"
		else
			log "#### CHECKING FOR PACKAGE MANAGER: NO PACKAGE MANAGER FOUND `date '+%m-%d-%Y %I:%M:%S'` ####"
			config "write_value" "pkgmgr" "none"
			# Consider installing and configuring everything without a package manager
			exit 100
		fi
	else
		pkgmgr=$(config "read_value" "pkgmgr")
		if [ $pkgmgr == "apt" ]; then
			pkginstall='DEBIAN_FRONTEND=noninteractive sudo apt -y'
		elif [ $pkgmgr == "dnf" ]; then
			pkginstall='sudo dnf -y'
		elif [ $pkgmgr == "yum" ]; then
			pkginstall='sudo yum -y'
		elif [ $pkgmgr == "up2date" ]; then
			pkginstall='sudo up2date -y'
		fi
	fi

	# If false then the questions were never answered, so now what to do?
	if [ $(config "read_value" "fqdn") == "false" ]; then
		fqdn="$(hostname --fqdn)"
	else
		fqdn=$(config "read_value" "fqdn")
	fi
	if [ $(config "read_value" "user") == 'false' ]; then
		user=$USER
	else
		user=$(config "read_value" "user")
	fi
	if [ $(config "read_value" "webserverdir") == 'false' ]; then
		webserverdir="/var/www/"
	else
		webserverdir=$(config "read_value" "webserverdir")
	fi
	if [ $(config "read_value" "email") == 'false' ]; then
		email="noone@nowhere.com"
	else
		email=$(config "read_value" "email")
	fi
	if [ $(config "read_value" "usbdrv") == 'false' ]; then
		usbdrv="false"
	else
		usbdrv=$(config "read_value" "usbdrv")
	fi
	if [ $(config "read_value" "mountpoint") == 'false' ]; then
		mountpoint="false"
	else
		mountpoint=$(config "read_value" "mountpoint")
	fi
else
	# Config does not exist, let's create it here with default values
	# Need to have Distro testing here
	DISTRO=$( lsb_release -is ) # Reports Raspbian
	CODENAME=$( lsb_release -cs ) # Reports stretch
	DISTVERSION=$( lsb_release -rs ) # Reports 9.1

	# Set custom variables
	IP="127.0.0.1"
	fqdn="$(hostname --fqdn)"
	user=$USER
	ownergroup=www-data:www-data
	tzone="$(cat /etc/timezone)"
	webserverdir="/var/www/"
	email="noone@nowhere.com"
	usbdrv="false"
	mountpoint="false"

	config "write_value" "distro" $DISTRO
	config "write_value" "codename" $CODENAME
	config "write_value" "distro_version" $DISTVERSION
	config "write_value" "ip" $IP
	config "write_value" "fqdn" $fqdn
	config "write_value" "user" $user
	config "write_value" "ownergroup" $ownergroup
	config "write_value" "tzone" $tzone
	config "write_value" "webserverdir" $webserverdir
	config "write_value" "usbdrv" $usbdrv

	# Check for Package Manager installation
	if haveProg apt-get; then
		log "#### CHECKING FOR PACKAGE MANAGER: APT INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
		pkginstall='DEBIAN_FRONTEND=noninteractive sudo apt -y'
		config "write_value" "pkgmgr" "apt"
	elif haveProg dnf; then
		log "#### CHECKING FOR PACKAGE MANAGER: DNF INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
		pkginstall='sudo dnf -y'
		config "write_value" "pkgmgr" "dnf"
	elif haveProg yum; then
		log "#### CHECKING FOR PACKAGE MANAGER: YUM INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
		pkginstall='sudo yum -y'
		config "write_value" "pkgmgr" "yum"
	elif haveProg up2date; then
		log "#### CHECKING FOR PACKAGE MANAGER: UP2DATE INSTALLED `date '+%m-%d-%Y %I:%M:%S'` ####"
		pkginstall='sudo up2date -y'
		config "write_value" "pkgmgr" "up2date"
	else
		log "#### CHECKING FOR PACKAGE MANAGER: NO PACKAGE MANAGER FOUND `date '+%m-%d-%Y %I:%M:%S'` ####"
		config "write_value" "pkgmgr" "none"
		# Consider installing and configuring everything without a package manager
		exit 100
	fi
fi

# Output the header of the script to the screen. I put this in a function for
# future use, this may be used to have different outputs depending on screen
# size, or to send other output to the terminal. But for now it is just the
# really large header that I spent allot of time on to make it look pretty!
output 'header'

# Start the output to the /var/log/rasp* log file and add distro information
log "################### INSTALLATION STARTED ON `date '+%m-%d-%Y %I:%M:%S'` ###################"
log "#### DISTRO: $DISTRO CODENAME: $CODENAME VERSION: $VERSION ####"

# Update, Auto Remove, and Upgrade System and check to see if the latest 
# version is being used of the script since I moved everything to GitHub, 
# I will probably check there to see if the version is the latest.
log "#### CHECKING THE INSTALLER FOR LATEST VERSIONS `date '+%m-%d-%Y %I:%M:%S'` ####"
checkversion

log "#### UPDATING SYSTEM TO LATEST VERSIONS `date '+%m-%d-%Y %I:%M:%S'` ####"
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Updating system to latest versions "$LIGHT_RED"==="$COLOR_NONE
echo -e $YELLOW"(this may take a long time)"$COLOR_NONE
evallog "$pkginstall autoremove" & pid=$!
evallog "$pkginstall update && $pkginstall upgrade" & pid=$!
progress

# Output the instructions to the screen
output 'instructions'

shopt -u nocasematch

echo -ne " What is the domain name of your server ($fqdn): "
read -r readfqdn

if [ -z "$readfqdn" ]; then
    readfqdn=$fqdn
else
	readfqdn=$readfqdn
fi
log "#### SETTING FQDN TO $readfqdn `date '+%m-%d-%Y %I:%M:%S'` ####"
config "change_value" "fqdn" $readfqdn
echo -e $COLOR_NONE"     Setting host to $WHITE$readfqdn"
echo -e $COLOR_NONE""

echo -ne $COLOR_NONE" What is the username for your domain ($user): "
read -r readuser

if [ -z "$readuser" ]; then
    readuser=$user
else
	readuser=$readuser
fi
log "#### SETTING USER TO $readuser `date '+%m-%d-%Y %I:%M:%S'` ####"
config "change_value" "user" $readuser
echo -e $COLOR_NONE"     User is set to $WHITE$readuser"
echo -e $COLOR_NONE""

echo -ne $COLOR_NONE" Default public_html folder ($webserverdir): "
read -r readwebserverdir

if [ -z "$readwebserverdir" ]; then
    readwebserverdir=$webserverdir
else
	readwebserverdir=$readwebserverdir
fi
log "#### SETTING DEFAULT WEB FOLDER TO $readwevserverdir `date '+%m-%d-%Y %I:%M:%S'` ####"
config "change_value" "webserverdir" $readwebserverdir
echo -e $COLOR_NONE"     Public HTML folder is set to $WHITE$readwebserverdir"
echo -e $COLOR_NONE""

echo -ne $COLOR_NONE" Working Email address ($email): "
read -r reademail

if [ -z "$reademail" ]; then
    reademail=$email
else
	reademail=$reademail
fi
log "#### SETTING EMAIL ADDRESS TO $reademail `date '+%m-%d-%Y %I:%M:%S'` ####"
config "change_value" "email" $reademail
echo -e $COLOR_NONE"     User email is set to $WHITE$reademail"
echo -e $COLOR_NONE""

log "#### ARE WE MOUNTING AN EXTERNAL DRIVE ####"
if [ "$usbdrv" == "true" ]; then
	usbdrvTF="Y/n"
else
	usbdrvTF="y/N"
fi
echo -ne "     Do you have an external USB drive installed? ($usbdrvTF) "
read -r readusbdrv

case $readusbdrv in
	[yY] | [yY][Ee][Ss] )
		log "#### EXTERNAL USB DRIVE SETUP SELECTED `date '+%m-%d-%Y %I:%M:%S'` ####"
		config "change_value" "usbdrv" "true"
		echo ""

		log "#### ENTER MOUNT POINT FOR THE DRIVE `date '+%m-%d-%Y %I:%M:%S'` ####"
		echo "Enter mount point for drive :"
		read -r readmountpoint
		config "change_value" "mountpoint" $readmountpoint
		;;
	*)
		config "change_value" "usbdrv" "false"
		echo ""
		;;
esac

echo -ne $COLOR_NONE" Do you want to install a database server? (Y/n) "
read -r readnewdb

case $readnewdb in
    [nN] | [nN][O|o] )
		log "#### DATABASE SERVER INSTALLATION NOT SELECTED `date '+%m-%d-%Y %I:%M:%S'` ####"
		echo ""
		;;
    * )
		log "#### DATABASE SERVER INSTALLATION SELECTED `date '+%m-%d-%Y %I:%M:%S'` ####"
		echo -n " Do you want to automatically create the database user password? (y/N) "
		read -r readsetpw

		case $readsetpw in
			[yY] | [yY][Ee][Ss] )
				mysqluserpw="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo)"
			log "#### RANDOM PASSWORD FOR ROOT '$mysqluserpw' `date '+%m-%d-%Y %I:%M:%S'` ####"
				echo "Root password is set to '$mysqluserpw'"
				;;
			* )
			log "#### USER DEFINED PASSWORD FOR ROOT '$mysqluserpw' `date '+%m-%d-%Y %I:%M:%S'` ####"
				echo -n  " What do you want your password to be?"
				read -rs mysqluserpw
				echo ""
				;;
		esac

		echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Installing Database Server and Dependancies "$LIGHT_RED"==="$COLOR_NONE
		log "#### INSTALLING MYSQL SERVER AND DEPENDANCIES `date '+%m-%d-%Y %I:%M:%S'` ####"
		evallog "$pkginstall install mysql-server mysql-client mysql-common"
		progress

		echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Securing Database "$LIGHT_RED"==="$COLOR_NONE
		log "#### SECURING MYSQL INSTALLATION `date '+%m-%d-%Y %I:%M:%S'` ####"
		/usr/bin/mysql_secure_installation

		echo -n " Do you want to create a new database? (y/N) "
		read -r createdb

        case $createdb in
            [yY] | [yY][Ee][Ss] )
				echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Creating MariaDB Database and Default User "$LIGHT_RED"==="$COLOR_NONE
				echo -n " Give your new database a name :"
				read -r dbname
				echo ""

				echo -n " Give $dbname a new user name :"
				read -r dbuser
				echo ""

				echo -n " Enter the password for $dbuser "
				read -rs dbpass
				echo ""

				echo -ne "To create a new database, please enter the ROOT password from above "
				mysql -u root -p --execute="CREATE DATABASE $dbname;GRANT ALL PRIVILEGES ON $dbname.* TO $dbuser@localhost IDENTIFIED BY '$mysqluserpw';"
				log "#### CREATED NEW DATABASE: '$dbname' FOR USER '$dbuser' USING PASSWORD '$dbpass' `date '+%m-%d-%Y %I:%M:%S'` ####"
				;;
			* )
				echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Database not created, you may manually create a database using mysql -u root -p "$LIGHT_RED"==="$COLOR_NONE
				log "#### USER DATABASE WAS NOT CREATED `date '+%m-%d-%Y %I:%M:%S'` ####"
				echo ""
				;;
		esac
		;;
esac

exit 0

# Create the Hosts file with the FQDN
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Adding '127.0.0.1 ${DOMAIN}' to hosts file "$LIGHT_RED"==="$COLOR_NONE
log "#### CREATING HOSTNAME FILE `date '+%m-%d-%Y %I:%M:%S'` ####"
if managehost "find" "localhost"; then
	managehost "remove" "localhost"
fi
if managehost "find" "$fqdn"; then
	managehost "add" "$fqdn"
fi

# Install the required software - Database server was already installed, let's get the rest
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Installing required applications and dependencies "$LIGHT_RED"==="$COLOR_NONE
echo -e $YELLOW"(this may take a long time)"$COLOR_NONE
log "#### INSTALLING APACHE, PHP 7, AND DEPENDANCIES `date '+%m-%d-%Y %I:%M:%S'` ####"
evallog "$pkginstall install apache2 php7.0 php7.0-curl php7.0-gd php7.0-imap php7.0-json php7.0-mcrypt php7.0-mysql php7.0-opcache php7.0-xmlrpc libapache2-mod-php7.0 apache2-utils nfs-common python-certbot-apache postfix dovecot-common dovecot-imapd telnet" & pid=$!
progress

# Enable the modules
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Enabling Web Modules "$LIGHT_RED"==="$COLOR_NONE
log "#### ENABLING WEB MODULES `date '+%m-%d-%Y %I:%M:%S'` ####"
evallog "a2enmod rewrite"
evallog "phpenmod mcrypt"
evallog "phpenmod mbstring"

# Create a virtual host file
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Creating Virtual Host File "$LIGHT_RED"==="$COLOR_NONE
log "#### CREATING VIRTUAL HOST FILE '/etc/apache2/sites-available/$fqdn.conf `date '+%m-%d-%Y %I:%M:%S'` ####"
setvhdebian

# Install other packages after web server has been established
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Installing additional web applications and dependencies "$LIGHT_RED"==="$COLOR_NONE
log "#### INSTALLING Webalizer, RKHunter, phpMyAdmin, AND DEPENDANCIES `date '+%m-%d-%Y %I:%M:%S'` ####"
evallog "$pkginstall install webalizer rkhunter phpmyadmin"
progress

# Restart APACHE2
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Restarting Apache "$LIGHT_RED"==="$COLOR_NONE
log "#### RESTARTING APACHE2 `date '+%m-%d-%Y %I:%M:%S'` ####"
evallog "service apache2 restart"

# Clean up the system of any files needed
echo -e $LIGHT_RED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Cleaning System from unused files and folders "$LIGHT_RED"==="$COLOR_NONE

# Check for any errors generated
