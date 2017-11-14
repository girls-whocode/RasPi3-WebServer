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
# Set mode for script [development, production]
environment="production"

# variables- Defines default variables                                 #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   "set" "unset"                                                      #
# Returns:                                                             #
#   None                                                               #
variables() {
	if [[ "$1" == "set" ]]; then
		# define and set the ANSI colors
		NOCOLOR="\033[0m"
		BLACK="\033[0;30m"
		RED="\033[0;31m"
		GREEN="\033[0;32m"
		BROWN="\033[0;33m"
		BLUE="\033[0;34m"
		MAGENTA="\033[0;35m"
		CYAN="\033[0;36m"
		GRAY="\033[0;37m"
		DARKGRAY="\033[1;30m"
		LIGHTRED="\033[1;31m"
		LIGHTGREEN="\033[1;32m"
		YELLOW="\033[1;33m"
		LIGHTBLUE="\033[1;34m"
		LIGHTMAGENTA="\033[1;35m"
		LIGHTCYAN="\033[1;36m"
		WHITE="\033[1;37m"

		DIALOGRC=./.dialogrc

		# Since this script was ran with sudo, it will always return root,
		# this method will look for the normal privileged user first, if it
		# does exists or is blank, then default to the current user which is
		# probably root. We'll ask later anyways.
		user="$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)"
		if [ -z $user ]; then
			user=$USER
		fi

		# Define paths and files
		hosts="/etc/hosts"
		logfolder="/var/log/"
		
		[[ $environment = 'development' ]] && logfile="${logfolder}"raspy3-install.log || logfile="${logfolder}"raspy3-install_`date +'%m-%d-%Y_%H%M%S'`.log
		
		if [ -f $logfile ]; then
			sudo rm $logfile
		fi
		configfile="raspconfig.ini"

		# Set program specific values
		version="2.0.0a"
		
		[[ $environment = 'development' ]] && verbose=true || verbose=false

		# Input error in dialog box.
		E_INPUT=65

		# Dimensions of display, input widgets.
		HEIGHT=50
		WIDTH=60

		# Output file name (constructed out of script name)
		OUTFILE=$0.output

		# Set spinner text for progress function
		spin[0]=$LIGHT_RED"-"
		spin[1]=$WHITE"\\"
		spin[2]=$YELLOW"|"
		spin[3]=$LIGHT_GREEN"/"

		# If CTRL-C, ESC, or any other quit key combination run the 
		# quitscript function
		trap_with_arg quitscript HUP INT QUIT ILL TRAP ABRT TSTP TERM EXIT

	elif [[ "$1" == "unset" ]]; then
		# Free up used memory for all of the variables created by this script
		for i in $(env | awk -F"=" '{print $1}'); do
			log "Unsetting : "$i
			unset $i
		done
	fi
}

# trap_with_arg- Capture exit signal and send value                    #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   None                                                               #
# Returns:                                                             #
#   Signal code of exit status                                         #
trap_with_arg() {
    func="$1" ; shift
    for sig ; do
        trap "$func $sig" "$sig"
    done
}

# evallog- Execute and send argument to the log file                   #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   Value to execute and record to log file                            #
# Returns:                                                             #
#   If verbose is true, return the argument to the screen              #
evallog() {
    if [ "$verbose" = true ]; then
        eval "$@"
    else
        eval "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
    fi
}

# log- Send argument to the log file                                   #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   Value to record to log file                                        #
# Returns:                                                             #
#   None                                                               #
log() {
	if [ "$verbose" = true ]; then
		echo "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
	else
		echo "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
	fi
}

# haveprog- Function to test if program is already installed on system #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   program name                                                       #
# Returns:                                                             #
#   true or false                                                      #
haveprog() {
    [ -x "$(which $1)" ]
}

# isalpha- Tests whether *entire string* is alphabetic.                #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   string to process                                                  #
# Returns:                                                             #
#   true or false                                                      #
isalpha () {
	[ $# -eq 1 ] || return $FAILURE

	case $1 in
		*[!a-zA-Z]*|"") 
			return false
			;;
		*)
			return true
			;;
		esac
}

# tolower- Converts string(s) passed as argument(s) to lowercase       #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   string to process                                                  #
# Returns:                                                             #
#   string in all lowercase                                            #
tolower () {
	if [ -z "$1" ]; then
		echo "(null)"
		return
	fi

	# Translate all passed arguments ($@).
	echo "$@" | tr A-Z a-z
	return
}

# checkinet- Checks for internet connection                            #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   None                                                               #
# Returns:                                                             #
#   true or false                                                      #
checkinet() {
    case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
	[23]) 
		log "CHECKING FOR INTERNET - The network connection passed"
		true
		;;
	5) 
		log "CHECKING FOR INTERNET - The web proxy won't let us through"
		false
		;;
	*) 
		log "CHECKING FOR INTERNET - The network is down or very slow"
		false
		;;
    esac
}

# checkversion- Checks for the latest version of this script           #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   None                                                               #
# Returns:                                                             #
#   If new version is found, download and re-run                       #
checkversion() {
	# Check for Internet Connection
	if checkinet; then
		log "CHECKING FOR THE LATEST VERSION"
	else
		log "INTERNET DOWN THE ERROR MESSAGE SENT"
		echo -e "It seems that internet is not available, this script requires internet to update, upgrade and install packages"
		echo -e "Please resolve internet issue and rerun this script"
		exit 125
	fi

	# Check to see if this is the latest version of the script, notice the $version variable in the URL
	# Download location: https://github.com/jessicakennedy1028/RasPi3-WebServer/releases/download/$version/deploy.sh
}

# progress- Creates a spinner effeect for processing the script        #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   None                                                               #
# Returns:                                                             #
#   None                                                               #
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

# quitscript- Finalize script on all types of exit                     #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   "abort" "complete"                                                 #
# Returns:                                                             #
#   None                                                               #
quitscript() {
	tput cnorm
	log "quit signal: $1"

	case "$1" in
		"HUP")
			# When the terminal is closed
			log "Hangup signal received"
			log "[112] Script ended ###############################################################"
			variables "unset"
			exit 112
			;;
		"INT")
			# When Ctrl-C is pressed
			log "[110] Abort signal received"
			if [ -f $configfile ]; then
				log "Config file was found, removing config file"
				rm -f $configfile
			fi

			echo -en $RED"\n\nScript was aborted\n\n"$COLOR_NONE
			echo -en "Cleaning up please wait\n"

			# Honestly, currently there is nothing to clean up since pretty much
			# what was done, is already done. But if any temp files are made, or
			# any changes we want to revert back could be done here.
			log "Script ended ###############################################################"
			variables "unset"
			exit 110
			;;
		"QUIT")
			# When Ctrl-\ is pressed
			logfile=$logfile
			echo "`date '+%m-%d-%Y [%I:%M:%S]'` | [113] - Script quit script was performed, attempting cleanup" |& tee -a $logfile >/dev/null 2>&1
			echo "`date '+%m-%d-%Y [%I:%M:%S]'` | Script ended ###############################################################" |& tee -a $logfile >/dev/null 2>&1
			variables "unset"
			exit 113
			;;
		"EXIT")
			# Standard Exit from script
			echo "`date '+%m-%d-%Y [%I:%M:%S]'` | [113] - Script quit script was performed, attempting cleanup" |& tee -a $logfile >/dev/null 2>&1
			echo "`date '+%m-%d-%Y [%I:%M:%S]'` | Script ended ###############################################################" |& tee -a $logfile >/dev/null 2>&1
			variables "unset"
			;;
		"ILL")
			# When Illegal instruction is sent
			log "[114] Illegal instruction signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 114
			;;
		"TRAP")
			# When trap is not reset
			log "[115] Trace trap not reset signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 115
			;;
		"ABRT")
			log "[116] Abort signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 116
			;;
		"POLL")
			log "[117] Pollable event ([XSR] generated, not supported) signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 117
			;;
		"FPE")
			log "[118] Floating point signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 118
			;;
		"KILL")
			log "[119] Kill signal received"
			log "Script ended ###############################################################"
			variables "unset"
			exit 119
			;;
	esac
}

# managehost- Modify the /etc/hosts file automagically                 #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   "remove" "add" "find"                                              #
# Returns:                                                             #
#   None                                                               #
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

# managehost- Modify the /etc/hosts file automagically                 #
# Globals:                                                             #
#                                                                      #
# Arguments:                                                           #
#   "change_value" "get_line" "read_value" "remove_config" 	           #
#   "remove_value" "sanitize_value" "verify_write" "write_value"       #
# Returns:                                                             #
#   None                                                               #
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


loadcfg() {
	if [[ -f $configfile ]]; then
		# The configuration file exists, now let test to make sure the parameter exists
		# Had to make a decision here, if the config file exists and there are missing
		# items, do I decide to fix it or just delete it and force it to recreate?
		
		# For now, let's try to fix it, if this turns to be a problem, we'll delete it
		# and then rebuild it.
		inifileexists=true
		log "$configfile exist"

		if [ $(config "read_value" "servetype") == 'false' ]; then
			SERVETYPE=$(config "read_value" "servetype")
			log "DISTRO parameter does not exist - set to default value"
			config "write_value" "servetype" "none"
		else
			SERVETYPE=$(config "read_value" "servetype")
		fi
		if [ $(config "read_value" "distro") == 'false' ]; then
			DISTRO=$( lsb_release -is )
			log "DISTRO parameter does not exist - set to default value"
			config "write_value" "distro" $DISTRO
		else
			DISTRO=$(config "read_value" "distro")
		fi
		if [ $(config "read_value" "codename") == 'false' ]; then
			CODENAME=$( lsb_release -cs )
			log "CODENAME parameter does not exist - set to default value"
			config "write_value" "codename" $CODENAME
		else
			CODENAME=$(config "read_value" "codename")
		fi
		if [ $(config "read_value" "distro_version") == 'false' ]; then
			DISTVERSION=$( lsb_release -rs )
			log "DISTVERSION parameter does not exist - set to default value"
			config "write_value" "distro_version" $DISTVERSION
		else
			DISTVERSION=$(config "read_value" "distro_version")
		fi
		if [ $(config "read_value" "ip") == 'false' ]; then
			IP="127.0.0.1"
			log "CODENAME parameter does not exist - set to default value"
			config "write_value" "ip" $IP
		else
			IP=$(config "read_value" "ip")
		fi
		if [ $(config "read_value" "ownergroup") == 'false' ]; then
			ownergroup="www-data:www-data"
			log "CODENAME parameter does not exist - set to default value"
			config "write_value" "ownergroup" $ownergroup
		else
			ownergroup=$(config "read_value" "ownergroup")
		fi
		if [ $(config "read_value" "tzone") == 'false' ]; then
			tzone="$(cat /etc/timezone)"
			log "CODENAME parameter does not exist - set to default value"
			config "write_value" "tzone" $tzone
		else
			tzone=$(config "read_value" "tzone")
		fi
		if [ $(config "read_value" "webserverdir") == 'false' ]; then
			webserverdir="/var/www/"
			log "CODENAME parameter does not exist - set to default value"
			config "write_value" "webserverdir" $webserverdir
		else
			webserverdir=$(config "read_value" "webserverdir")
		fi
		if [ $(config "read_value" "pkgmgr") == 'false' ]; then
			log "CODENAME parameter does not exist - set to default value"
			if haveProg apt-get; then
				log "Package manager set to APT"
				pkginstall='DEBIAN_FRONTEND=noninteractive sudo apt -y'
				config "write_value" "pkgmgr" "apt"
			elif haveProg dnf; then
				log "Package manager set to DNF"
				pkginstall='sudo dnf -y'
				config "write_value" "pkgmgr" "dnf"
			elif haveProg yum; then
				log "Package manager set to YUM"
				pkginstall='sudo yum -y'
				config "write_value" "pkgmgr" "yum"
			elif haveProg up2date; then
				log "Package manager set to UP2DATE"
				pkginstall='sudo up2date -y'
				config "write_value" "pkgmgr" "up2date"
			else
				log "Package manager set to NONE"
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
		# Config does not exist, let's create it here with default values.
		log "$configfile does not exist - creating default values"
		inifileexists=false

		# Need to have Distro testing here.
		DISTRO=$( lsb_release -is ) # Reports Raspbian
		CODENAME=$( lsb_release -cs ) # Reports stretch
		DISTVERSION=$( lsb_release -rs ) # Reports 9.1

		# Set custom default variables
		IP="127.0.0.1"
		fqdn="$(hostname --fqdn)"
		
		# Since this script was ran with sudo, it will always return root,
		# this method will look for the normal privileged user first, if it
		# does exists or is blank, then default to the current user which is
		# probably root. We'll ask later anyways.
		user="$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)"
		if [ -z $user ]; then
			user=$USER
		fi

		ownergroup="www-data:www-data"
		tzone="$(cat /etc/timezone)"
		webserverdir="/var/www/"
		email=""
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
		if haveprog apt-get; then
			log "Package manager set to APT"
			pkginstall='DEBIAN_FRONTEND=noninteractive sudo apt -y'
			config "write_value" "pkgmgr" "apt"
		elif haveprog dnf; then
			log "Package manager set to DNF"
			pkginstall='sudo dnf -y'
			config "write_value" "pkgmgr" "dnf"
		elif haveprog yum; then
			log "Package manager set to YUM"
			pkginstall='sudo yum -y'
			config "write_value" "pkgmgr" "yum"
		elif haveprog up2date; then
			log "Package manager set to UP2DATE"
			pkginstall='sudo up2date -y'
			config "write_value" "pkgmgr" "up2date"
		else
			log "Package manager set to NONE"
			config "write_value" "pkgmgr" "none"
			# Consider installing and configuring everything without a package manager
			exit 100
		fi
	fi
}


checkcfg() {
	# Option number 1
	# Default the fail test to false
	opt1menufailtest="false"
	faileditems1=""
	
	if [ $(config "read_value" "fqdn") == "false" ] || [ $(config "read_value" "fqdn") == "null" ]; then
		log "tested fqdn returned "$fqdn
		# Activate the fail test since fqdn was false or null
		opt1menufailtest="true"
		faileditems1="$faileditems1 \Zb\Z1Domain Name\Zn - Is not read from the configuration file\n"
		opt1menuitem="\Zb\Z1*\Zn"
		domainchk="\Zb\Z1*\Zn"
	else
		# Test if FQDN really works
		whois "$fqdn" | egrep -q '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
		if [ $? -eq 0 ]; then
			# The whois test came back with NOT FOUND
			opt1menufailtest="true"
			faileditems1="$faileditems1 \Zb\Z1Domain Name\Zn - Can not be resolved\n"
			opt1menuitem="\Zb\Z1*\Zn"
			domainchk="\Zb\Z1*\Zn"
		else
			if [ $opt1menufailtest != "true" ]; then
				opt1menuitem="\Zb\Z1*\Zn"
				domainchk="\Zb\Z1*\Zn"
			else
				opt1menufailtest="false"
				opt1menuitem="\Zb\Z2*\Zn"
				domainchk="\Zb\Z2*\Zn"
			fi
		fi
	fi
	if [ $(config "read_value" "user") == "false" ] || [ $(config "read_value" "user") == "null" ]; then
		log "tested user returned "config "read_value" "user"
		# Activate the fail test since user was false or null
		# Next we need to create the user and set a password
		opt1menufailtest="true"
		opt1menuitem="\Zb\Z1*\Zn"
	else
		if [ $opt1menufailtest != "true" ]; then
			opt1menuitem="\Zb\Z2*\Zn"
		fi
	fi
	if [ $(config "read_value" "webserverdir") == "false" ] || [ $(config "read_value" "webserverdir") == "null" ]; then
		log "tested webserverdir returned "config "read_value" "webserverdir"
		# Activate the fail test since webserverdir was false or null
		opt1menufailtest="true"
		opt1menuitem="\Zb\Z1*\Zn"
	else
		# Detecting the Apache web root folder may deem more difficult then anticipated, we also have to consider nGinX
		if [ $opt1menufailtest != "true" ]; then
			opt1menufailtest="false"
			opt1menuitem="\Zb\Z2*\Zn"
		fi
	fi
	if [ $(config "read_value" "email") == "false" ] || [ $(config "read_value" "email") == "null" ] || [ $(config "read_value" "email") == "noone@nowhere.com" ]; then
		log "tested email returned "config "read_value" "email"
		faileditems1="$faileditems1 \Zb\Z1Email\Zn - Is not read from the configuration file\n"
		# Activate the fail test since email was false or null or invalid
		# Next we will actually do a test on the email to make sure the email is valid
		
		opt1menufailtest="true"
		opt1menuitem="\Zb\Z1*\Zn"
	else
		echo "$email" | egrep -q "^([A-Za-z]+[A-Za-z0-9]*((\.|\-|\_)?[A-Za-z]+[A-Za-z0-9]*){1,})@(([A-Za-z]+[A-Za-z0-9]*)+((\.|\-|\_)?([A-Za-z]+[A-Za-z0-9]*)+){1,})+\.([A-Za-z]{2,})+"
		if [ $? -eq 0 ]; then
			# Email regex check passed
			if [ $opt1menufailtest != "true" ]; then
				opt1menufailtest="false"
				opt1menuitem="\Zb\Z2*\Zn"
			fi
		else
			# Email regex check failed
			faileditems1="$faileditems1 \Zb\Z1Email\Zn - Is not valid\n"
			opt1menufailtest="true"
			opt1menuitem="\Zb\Z1*\Zn"
		fi
	fi
	if [ $(config "read_value" "ownergroup") == "false" ] || [ $(config "read_value" "ownergroup") == "null" ]; then
		log "tested ownergroup returned "config "read_value" "ownergroup"
		# Activate the fail test since ownergroup was false or null
		# Add the user to the ownergroup
		opt1menufailtest="true"
		opt1menuitem="\Zb\Z1*\Zn"
	else
		if [ $opt1menufailtest != "true" ]; then
			opt1menufailtest="false"
			opt1menuitem="\Zb\Z2*\Zn"
		fi
	fi
	if [ $(config "read_value" "ip") == "false" ] && [ $(config "read_value" "ip") == "null" ]; then
		log "tested ip returned "config "read_value" "ip"
		# Activate the fail test since ip was false or null
		opt1menufailtest="true"
		opt1menuitem="\Zb\Z1*\Zn"
	else
		if [ $opt1menufailtest != "true" ]; then
			opt1menufailtest="false"
			opt1menuitem="\Zb\Z2*\Zn"
		fi
	fi

	# Option number 2
	opt2menuitem="\Zb\Z1*\Zn"
	
	# Option number 3
	opt3menuitem="\Zb\Z1*\Zn"

	# Option number 4
	opt4menuitem="\Zb\Z1*\Zn"

	# Option number 5
	opt5menuitem="\Zb\Z1*\Zn"
	programs="apache2 php certbot postfix dovecot telnet"
	for i in $programs; do
		if haveprog $i; then
			log "tested $i exist"
			opt5menufailtest="false"
			opt5menuitem="\Zb\Z2*\Zn"
		else
			log "tested $i doesn't exist"
			opt5menuitem="\Zb\Z1*\Zn"
		fi
	done
	
	# Option number 6
	opt6menuitem="\Zb\Z1*\Zn"
	if [ $(config "read_value" "servetype") == "false" ] || [ $(config "read_value" "servetype") == "null" ] || [ $(config "read_value" "servetype") == "none" ]; then
		log "tested servetype returned "config "read_value" "servetype"
		# Activate the fail test since servetype was false or null or none
		opt6menufailtest="true"
		opt6menuitem="\Zb\Z1*\Zn"
	else
		if [ $opt6menufailtest != "true" ]; then
			opt6menufailtest="false"
			opt6menuitem="\Zb\Z2*\Zn"
		fi
	fi

	# Option number 7
	opt7menuitem="\Zb\Z1*\Zn"
}


webserverform() {
	dialogtitle="Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from the system configuration."
	if [ $opt1menufailtest == "true" ]; then
		dialoginstructions="$dialoginstructions \Zb\Z1INVALID SETTINGS\Zn detected, please correct the following\n\n${faileditems1}"
	fi
	log "${dialogtitle} Dialog Form called"
	returncode=0

	while test $returncode != 1 && test $returncode != 250; do
		# Place the loadcfg and checkcfg here so it is rechecked on each menu load
		loadcfg
		checkcfg
	
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
	
		# Store data to $VALUES variable
		VALUES=$(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --backtitle "$SCREENTITLE" --title "$dialogtitle" --form "$dialoginstructions" 20 55 0 \
			"       Domain Name :"	1 1	"$fqdn"			1 22 27 0 \
			"         User Name :"	2 1	"$user"			2 22 27 0 \
			"Public HTML folder :"	3 1	"$webserverdir"	3 22 27 0 \
			"             Email :"	4 1	"$email"		4 22 27 0 \
			"    File ownership :"  5 1 "$ownergroup"	5 22 27 0 \
			"                IP :"	6 1	"$IP"			6 22 27 0 \
		2>&1 1>&3)
		
		returncode=$?
		
		# Close the stream
		exec 3>&-

		# Assign the variables to an array
		webservervars=($VALUES)
		show=`echo "$VALUES" |sed -e 's/^/ /'`

		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --clear --backtitle "$SCREENTITLE" --yesno "Return to Main Menu?" 10 30
				case $? in
					0)
						# If Yes was pressed
						break
						;;
					1)
						# No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
			0) # If submit or <ENTER> was pressed
				dialog --title "POST THIS RECORD ENTRY?" --yesno "$show" 15 40 
				case $? in
					0)
						# Check that all fields are filled before writing record, or give an error message
						# Create the record string from $value, deleting the last #
						NRECORD=`echo "$VALUES"|awk 'BEGIN{ORS="#"}{print $0}'|sed -e 's/#$//'`

						# Count the number of fields
						NUMFLDS=`echo "$NRECORD" | awk -F"#" 'END{print NF}'`

						if [ $NUMFLDS -lt 6 ]; then
							dialog --title "INPUT ERROR" --clear --msgbox "You must fill in all the fields.\nThis record will not be saved" 10 41
							case $? in
								0)
									return
									;;
								255)
									return
									;;
							esac
						else
							config "write_value" "fqdn" "${webservervars[0]}"
							config "write_value" "user" "${webservervars[1]}"
							config "write_value" "webserverdir" "${webservervars[2]}"
							config "write_value" "email" "${webservervars[3]}"
							config "write_value" "ownergroup" "${webservervars[4]}"
							config "write_value" "ip" "${webservervars[5]}"
						fi
						return
						;;
					1)
						return
						;;
					255)
						return
						;;
				esac
				;;
		esac
	done
}


installedappsform() {
	dialogtitle="Installed Applications"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}


servertypeform() {
	ServerTypeMenuOptions=(1 "\Zn[${opt11menuitem}] Web Server" 2 "\Zn[${opt12menuitem}] Database Server" 3 "\Zn[${opt13menuitem}] Application Server" 4 "\Zn[${opt14menuitem}] File Server" 5 "\Zn[${opt15menuitem}] Email Server" 6 "\Zn[${opt16menuitem}] Message Server" 7 "\Zn[${opt17menuitem}] Proxy Server")
	WebChoices=(1 "Apache" "on" 2 "nGinX" "off" 3 "LightSpeed Web Server" "off")
	DatabaseChoices=(1 "MySQL" "off" 2 "MariaDB" "on" 3 "PostSQL" "off")
	ApplicationChoices=(1 "PHP" "on" 2 "Java" "on" 3 "Tomcat" "off" 4 "Open Source Application" "off" 5 "Mobile Application" "off")
	FileChoices=(1 "FTP" "on" 2 "NFS" "on" 3 "SMB" "off" 4 "NAS" "off")
	EmailChoices=(1 "Postfix" "on" 2 "Citadel" "off" 3 "Sendmail" "off" 4 "Exim" "off" 5 "Courier" "off")
}

systeminfodialog() {
	result=$(df -h)
	dialog --title "Disk Information" \
	--no-collapse \
	--msgbox "$result" 0 0
}

