#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi
# Set mode for script [development, production]
environment="production"

variables() {
	if [[ "$1" == "set" ]]; then
		# Set program specific values
		majversion="2.0.0a"
		minversion="0"
		subversion="0"
		codestatus="a"
		version="${majversion}.${minversion}.${subversion}${codestatus}"
		APPNAME="Server Auto Config ${majversion}"

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

		OKSYMB="\Z2✔\Zn"
		BADSYMB="\Zb\Z1x\Zn"
		DISABLEDSYMB="\Z3o\Zn"
		
		# Define paths and files
		hosts="/etc/hosts"
		meminfo="/proc/meminfo"
		cpuinfo="/proc/cpuinfo"
		logfolder="/var/log"
		logfile="${logfolder}/raspy3-install.log"
		
		# System information
		phymem=$(awk '/^MemTotal:/{print $2}' $meminfo)
		swpmem=$(awk '/^SwapTotal:/{print $2}' $meminfo)
		cpucore=$(grep -c 'processor' $cpuinfo)

		# [[ $environment = 'development' ]] && logfile="${logfolder}"raspy3-install.log || logfile="${logfolder}"raspy3-install_`date +'%m-%d-%Y_%H%M%S'`.log
		
		if [ -f $logfile ]; then
			sudo rm $logfile
		fi
		configfile="raspconfig.ini"

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
			# log "Unsetting : "$i
			unset $i
		done
	fi
}
trap_with_arg() {
    func="$1" ; shift
    for sig ; do
        trap "$func $sig" "$sig"
    done
}
evallog() {
	eval "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
}
log() {
	echo "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
}
systeminfodialog() {
	result=$(df -h)
	dialog --title "Disk Information" \
	--no-collapse \
	--msgbox "$result" 0 0
}
haveprog() {
    [ -x "$(which $1)" ]
}
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
tolower () {
	if [ -z "$1" ]; then
		echo "(null)"
		return
	fi

	# Translate all passed arguments ($@).
	echo "$@" | tr A-Z a-z
	return
}
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
	# The configuration file exists, now let test to make sure the parameter exists
	# Had to make a decision here, if the config file exists and there are missing
	# items, do I decide to fix it or just delete it and force it to recreate the
	# parameter and value?
	
	# Currently this is reading the ini file twice for each item being read, we
	# should probably move all of the variables here and read it once then check
	# against its return
	
	# loadcfg function will also assign what the menu active or inactive status
	# indicator will show
	
	# For now, let's try to fix it, if this turns to be a problem, we'll delete it
	# and then rebuild it.
	
	# Set the defaults for menu status disabled, false or true
	# Web Server Menu
	webservermenustatus="disabled"
	apachemenustatus="disabled"
	nginxmenustatus="disabled"
	lightspeedmenustatus="disabled"
	sslmenustatus="disabled"
	
	# Database Server Menu
	databasemenustatus="disabled"
	mysqlmenustatus="disabled"
	mariadbmenustatus="disabled"
	postgresqlmenustatus="disabled"
	
	# Application Server Menu
	applicationmenustatus="disabled"
	phpmenustatus="disabled"
	javamenustatus="disabled"
	tomcatmenustatus="disabled"
	osamenustatus="disabled"
	mobilemenustatus="disabled"
	phpappmenustatus="disabled"
	javaappmenustatus="disabled"
	tomcatappmenustatus="disabled"
	osaappmenustatus="disabled"
	mobileappmenustatus="disabled"
	bbsappmenustatus="disabled"

	# Email Server Menu
	emailmenustatus="disabled"
	postfixmenustatus="disabled"
	citadelmenustatus="disabled"
	sendmailmenustatus="disabled"
	eximmenustatus="disabled"
	couriermenustatus="disabled"

	# File Server Menu
	filemenustatus="disabled"
	ftpmenustatus="disabled"
	nfsmenustatus="disabled"
	sambamenustatus="disabled"
	
	# Message Server Menu
	messagemenustatus="disabled"
	
	# Proxy Server Menu
	proxymenustatus="disabled"
	
	# System Config Menu
	systemconfigmenustatus="false"
	systeminfomenustatus="false"
	filesystemmenustatus="false"
	drivespacemenustatus="false"
	mountpointmenustatus="disabled"
	raidconfigmenustatus="disabled"
	usbdrivemenustatus="disabled"
	memoryconfigmenustatus="false"
	memoryfreemenustataus="false"
	swapmemorymenustatus="disabled"
	fileeditormenustatus="false"
	hostsfilemenustatus="false"
	hostnamefilemenustatus="false"
	networkconfigmenustatus="false"
	wirelessconfigmenustatus="disabled"
	networkitemconfigmenustatus="disabled"
	applicationconfigmenustatus="false"
	gitconfigmenustatus="disabled"
	uninstallappmenustatus="false"
	
	# Logs Menu
	logsmenustatus="false"
	apachelogsmenustatus="disabled"
	phplogsmenustatus="disabled"
	accesslogsmenustatus="disabled"
	errorlogsmenustatus="disabled"
	installationlogmenustatus="disabled"
	systemlogsmenustatus="disabled"
	autoconfigmenustatus="true"

	faileditem=""

	# DISTRO sets the distribution information
	if [ $(config "read_value" "distro") == 'false' ] || [ $(config "read_value" "distro") == 'null' ]; then
		DISTRO=$( lsb_release -is )
		log "DISTRO parameter or value does not exist - set to default value"
		config "write_value" "distro" $DISTRO
	else
		DISTRO=$(config "read_value" "distro")
	fi
	# CODENAME sets the distribution codename
	if [ $(config "read_value" "codename") == 'false' ] || [ $(config "read_value" "codename") == 'null' ]; then
		CODENAME=$( lsb_release -cs )
		log "CODENAME parameter or value does not exist - set to default value"
		config "write_value" "codename" $CODENAME
	else
		CODENAME=$(config "read_value" "codename")
	fi
	# DISTVERSION sets the distribution codename
	if [ $(config "read_value" "distro_version") == 'false' ] || [ $(config "read_value" "distro_version") == 'null' ]; then
		DISTVERSION=$( lsb_release -rs )
		log "DISTVERSION parameter or value does not exist - set to default value"
		config "write_value" "distro_version" $DISTVERSION
	else
		DISTVERSION=$(config "read_value" "distro_version")
	fi
	# EMAIL set a default email value
	if [ $(config "read_value" "email") == 'false' ] || [ $(config "read_value" "email") == 'null' ]; then
		EMAIL="disabled"
		log "EMAIL parameter or value does not exist - set to default value"
		config "write_value" "EMAIL" $EMAIL
	else
		EMAIL=$(config "read_value" "email")
	fi
	# IP sets the IP address
	if [ $(config "read_value" "ip") == 'false' ] || [ $(config "read_value" "ip") == 'null' ]; then
		IP="127.0.0.1"
		log "IP parameter or value does not exist - set to default value"
		config "write_value" "ip" $IP
	else
		IP=$(config "read_value" "ip")
	fi
	# OWNERGROUP sets the default ower:group for webserver files and folders
	if [ $(config "read_value" "ownergroup") == 'false' ] || [ $(config "read_value" "ownergroup") == 'null' ]; then
		OWNERGROUP="www-data:www-data"
		log "OWNERGROUP parameter or value does not exist - set to default value"
		config "write_value" "ownergroup" $OWNERGROUP
	else
		OWNERGROUP=$(config "read_value" "ownergroup")
	fi
	# TZONE gets the default value for the current system timezone
	if [ $(config "read_value" "tzone") == 'false' ] || [ $(config "read_value" "tzone") == 'null' ]; then
		TZONE="$(cat /etc/timezone)"
		log "TZONE parameter or value does not exist - set to default value"
		config "write_value" "tzone" $TZONE
	else
		TZONE=$(config "read_value" "tzone")
	fi
	# WEBSERVERDIR sets the default web server directory
	if [ $(config "read_value" "webserverdir") == 'false' ] || [ $(config "read_value" "webserverdir") == 'null' ]; then
		WEBSERVERDIR="/var/www/"
		log "WEBSERVERDIR parameter or value does not exist - set to default value"
		config "write_value" "webserverdir" $WEBSERVERDIR
	else
		WEBSERVERDIR=$(config "read_value" "webserverdir")
		if [ -d $WEBSERVERDIR ]; then
			webservermenustatus="true"
			apachemenustatus="true"
			nginxmenustatus="true"
			lightspeedmenustatus="true"
		else
			webservermenustatus="false"
			apachemenustatus="false"
			nginxmenustatus="false"
			lightspeedmenustatus="false"
			faileditem="$faileditem \Zb\Z1Web Server Directory\Zn - does not exist\n"
		fi
	fi
	# PKGINSTALL finds what package manager is installed and allows the user to choose which one to use
	if [ $(config "read_value" "pkgmgr") == 'false' ] || [ $(config "read_value" "pkgmgr") == 'null' ]; then
		log "PKGINSTALL parameter or value does not exist - set to default value"
		if haveprog apt-get; then
			log "Package manager set to APT"
			PKGINSTALL='DEBIAN_FRONTEND=noninteractive sudo apt -y'
			config "write_value" "pkgmgr" "apt"
		elif haveprog dnf; then
			log "Package manager set to DNF"
			PKGINSTALL='sudo dnf -y'
			config "write_value" "pkgmgr" "dnf"
		elif haveprog yum; then
			log "Package manager set to YUM"
			PKGINSTALL='sudo yum -y'
			config "write_value" "pkgmgr" "yum"
		elif haveprog up2date; then
			log "Package manager set to UP2DATE"
			PKGINSTALL='sudo up2date -y'
			config "write_value" "pkgmgr" "up2date"
		else
			log "Package manager set to NONE"
			config "write_value" "pkgmgr" "none"
			# Consider installing and configuring everything without a package manager
			exit 100
		fi
	else
		PKGMGR=$(config "read_value" "pkgmgr")
		if [ $PKGMGR == "apt" ]; then
			PKGINSTALL='DEBIAN_FRONTEND=noninteractive sudo apt -y'
		elif [ $PKGMGR == "dnf" ]; then
			PKGINSTALL='sudo dnf -y'
		elif [ $PKGMGR == "yum" ]; then
			PKGINSTALL='sudo yum -y'
		elif [ $PKGMGR == "up2date" ]; then
			PKGINSTALL='sudo up2date -y'
		fi
	fi
	# FQDN sets the default domain of the server
	if [ $(config "read_value" "fqdn") == "false" ] || [ $(config "read_value" "fqdn") == "null" ]; then
		FQDN="$(hostname --fqdn)"
		log "FQDN parameter or value does not exist - set to default value"
		config "write_value" "fqdn" $FQDN
	else
		FQDN=$(config "read_value" "fqdn")
		# FQDN will make menu items Web Server, Apache, nGinX, Lightspeed, SSL all fail
		whois "$fqdn" | egrep -q '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'
		if [ $? -eq 0 ]; then
			fqdnstatus="false"
			webservermenustatus="false"
			apachemenustatus="false"
			nginxmenustatus="false"
			lightspeedmenustatus="false"
			faileditem="$faileditem \Zb\Z1Domain Name\Zn - cannot be resolved\n"
		else
			fqdnstatus="true"
			webservermenustatus="true"
			apachemenustatus="true"
			nginxmenustatus="true"
			lightspeedmenustatus="true"
		fi
	fi
	# SERVERUSER tries to resolve the non-root user if available, if not, then set from $USER
	if [ $(config "read_value" "user") == 'false' ]; then
		# Since this script was ran with sudo, it will always return root,
		# this method will look for the normal privileged user first, if it
		# does exists or is blank, then default to the current user which is
		# probably root. We'll ask later anyways.
		SERVERUSER="$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)"
		if [ -z $user ]; then
			SERVERUSER=$USER
		fi
		log "FQDN parameter or value does not exist - set to default value"
		config "write_value" "user" $SERVERUSER
	else
		SERVERUSER=$(config "read_value" "user")
		# SERVERUSER if does not exists will make menu items Web Server, Apache, nGinX, Lightspeed, 
		# Database Server, mySQL, MariaDB, PostgreSQL, Application, PHP, Java, Tomcat, Open Source, 
		# Mobile App, Email, Postfix, Citadel, Sendmail, Exim, Courier, File, FTP, NFS, Samba, 
		# Message all fail
		getent passwd $SERVERUSER > /dev/null
		if [ $? -eq 0 ]; then
			webservermenustatus="true"
			apachemenustatus="true"
			nginxmenustatus="true"
			lightspeedmenustatus="true"
			databasemenustatus="true"
			mysqlmenustatus="true"
			mariadbmenustatus="true"
			postgresqlmenustatus="true"
			applicationmenustatus="true"
			phpmenustatus="true"
			javamenustatus="true"
			tomcatmenustatus="true"
			osamenustatus="true"
			mobilemenustatus="true"
			emailmenustatus="true"
			postfixmenustatus="true"
			citadelmenustatus="true"
			sendmailmenustatus="true"
			eximmenustatus="true"
			couriermenustatus="true"
			filemenustatus="true"
			ftpmenustatus="true"
			nfsmenustatus="true"
			sambamenustatus="true"
			messagemenustatus="true"
		else
			webservermenustatus="false"
			apachemenustatus="false"
			nginxmenustatus="false"
			lightspeedmenustatus="false"
			databasemenustatus="false"
			mysqlmenustatus="false"
			mariadbmenustatus="false"
			postgresqlmenustatus="false"
			applicationmenustatus="false"
			phpmenustatus="false"
			javamenustatus="false"
			tomcatmenustatus="false"
			osamenustatus="false"
			mobilemenustatus="false"
			emailmenustatus="false"
			postfixmenustatus="false"
			citadelmenustatus="false"
			sendmailmenustatus="false"
			eximmenustatus="false"
			couriermenustatus="false"
			filemenustatus="false"
			ftpmenustatus="false"
			nfsmenustatus="false"
			sambamenustatus="false"
			messagemenustatus="false"
			faileditem="$faileditem \Zb\Z1User\Zn - does not exist\n"
		fi	
	fi
	# WEBSERVERTYPE apache, nginx, lightspeed, false, disabled, null
	if [ $(config "read_value" "webserver") == 'false' ] || [ $(config "read_value" "webserver") == 'null' ]; then
		log "webserver parameter or value does not exist - set to default value"
		config "write_value" "webserver" "disabled"
	else
		WEBSERVERTYPE=$(config "read_value" "webserver")
		webservermenustatus=$([ "$WEBSERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$WEBSERVERTYPE" == "false" ] && echo "false" || echo "true" ))
		apachemenustatus=$([ "$WEBSERVERTYPE" == "apache" ] && echo "true" || echo "disabled")
		nginxmenustatus=$([ "$WEBSERVERTYPE" == "nginx" ] && echo "true" || echo "disabled")
		lightspeedmenustatus=$([ "$WEBSERVERTYPE" == "lightspeed" ] && echo "true" || echo "disabled")
	fi
	# DATABASESERVERTYPE mysql, mariadb, postgresql, false, disabled, null
	if [ $(config "read_value" "databaseserver") == 'false' ] || [ $(config "read_value" "databaseserver") == 'null' ]; then
		log "databaseserver parameter or value does not exist - set to default value"
		config "write_value" "databaseserver" "disabled"
	else
		DATABASESERVERTYPE=$(config "read_value" "databaseserver")
		databasemenustatus=$([ "$DATABASESERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$DATABASESERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# APPSERVERTYPE php, java, tomcat, osa, mobile, bbs, false, disabled, null
	if [ $(config "read_value" "appserver") == 'false' ] || [ $(config "read_value" "appserver") == 'null' ]; then
		log "appserver parameter or value does not exist - set to default value"
		config "write_value" "appserver" "disabled"
	else
		APPSERVERTYPE=$(config "read_value" "appserver")
		applicationmenustatus=$([ "$APPSERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$APPSERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# EMAILSERVERTYPE postfix, citadel, sendmail, exim, courier, false, disabled, null
	if [ $(config "read_value" "emailserver") == 'false' ] || [ $(config "read_value" "emailserver") == 'null' ]; then
		log "emailserver parameter or value does not exist - set to default value"
		config "write_value" "emailserver" "disabled"
	else
		EMAILSERVERTYPE=$(config "read_value" "emailserver")
		emailmenustatus=$([ "$EMAILSERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$EMAILSERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# FILEERVERTYPE postfix, citadel, sendmail, exim, courier, false, disabled, null
	if [ $(config "read_value" "fileserver") == 'false' ] || [ $(config "read_value" "fileserver") == 'null' ]; then
		log "fileserver parameter or value does not exist - set to default value"
		config "write_value" "fileserver" "disabled"
	else
		FILEERVERTYPE=$(config "read_value" "fileserver")
		filemenustatus=$([ "$FILEERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$FILEERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# MSGSERVERTYPE (right now not sure what to put here)
	if [ $(config "read_value" "msgserver") == 'false' ] || [ $(config "read_value" "msgserver") == 'null' ]; then
		log "msgserver parameter or value does not exist - set to default value"
		config "write_value" "msgserver" "disabled"
	else
		MSGSERVERTYPE=$(config "read_value" "msgserver")
		messagemenustatus=$([ "$MSGSERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$MSGSERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# PROXYSERVERTYPE (right now not sure what to put here)
	if [ $(config "read_value" "proxyserver") == 'false' ] || [ $(config "read_value" "proxyserver") == 'null' ]; then
		log "proxyserver parameter does not exist - set to default value"
		config "write_value" "proxyserver" "disabled"
	else
		PROXYSERVERTYPE=$(config "read_value" "proxyserver")
		proxymenustatus=$([ "$PROXYSERVERTYPE" == "disabled" ] && echo "disabled" || ([ "$PROXYSERVERTYPE" == "false" ] && echo "false" || echo "true" ))
	fi
	# SERVETYPE true, false, disabled, null
	if [ $(config "read_value" "servetype") == 'false' ] || [ $(config "read_value" "servetype") == 'null' ]; then
		log "servetype parameter or value does not exist - set to default value"
		config "write_value" "servetype" "disabled"
	else
		SERVETYPE=$(config "read_value" "servetype")
		servertype=$([ "$SERVETYPE" == "disabled" ] && echo "disabled" || ([ "$SERVETYPE" == "false" ] && echo "false" || echo "true" ))
	fi
}
