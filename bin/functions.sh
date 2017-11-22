#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi

function trap_with_arg() {
    func="$1" ; shift
    for sig ; do
        trap "$func $sig" "$sig"
    done
}
function haveprog() {
    [ -x "$(which $1)" ]
}
function managehost() {
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
function evallog() {
	eval "$@" |& tee -a $logfile >/dev/null 2>&1
}
function log() {
	echo "`date '+%m-%d-%Y [%I:%M:%S]'` | $@" |& tee -a $logfile >/dev/null 2>&1
}
function chkmemory(){
	freemem="$(awk '/^MemFree:/{print $2}' $meminfo)"
	log "Memory at ${freemem}"
}
function chkinet() {
    case "$(curl -s --max-time 2 -I http://google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in
	[23]) 
		log "CHECKING FOR INTERNET - The network connection passed"
		inetchk="true"
		;;
	5) 
		log "CHECKING FOR INTERNET - The web proxy won't let us through"
		inetchk="proxy"
		;;
	*) 
		log "CHECKING FOR INTERNET - The network is down or very slow"
		inetchk="down"
		;;
    esac
}
function chkversion() {
	# Check for Internet Connection
	if [ $inetchk == "true" ]; then
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
function quitscript() {
	tput cnorm
	stty sane
	log "quit signal: $1"
	( set -o posix ; set ) >logs/variables.log

	case "$1" in
		"HUP")
			# When the terminal is closed
			log "Hangup signal received"
			log "${error["112"]}"
			log "[112] Script ended ###############################################################"
			exit 112
			;;
		"INT")
			# When Ctrl-C is pressed
			log "${error["110"]}"
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
			exit 110
			;;
		"QUIT")
			# When Ctrl-\ is pressed
			logfile=$logfile
			log "${error["113"]}"
			log "Script ended ###############################################################"
			exit 113
			;;
		"EXIT")
			# Standard Exit from script
			log "${error["113"]}"
			log "Script ended ###############################################################"
			exit 0
			;;
		"ILL")
			# When Illegal instruction is sent
			log "${error["114"]}"
			log "Script ended ###############################################################"
			exit 114
			;;
		"TRAP")
			# When trap is not reset
			log "${error["115"]}"
			log "Script ended ###############################################################"
			exit 115
			;;
		"ABRT")
			log "${error["116"]}"
			log "Script ended ###############################################################"
			exit 116
			;;
		"POLL")
			log "${error["117"]}"
			log "Script ended ###############################################################"
			exit 117
			;;
		"FPE")
			log "${error["118"]}"
			log "Script ended ###############################################################"
			exit 118
			;;
		"KILL")
			log "${error["119"]}"
			log "Script ended ###############################################################"
			exit 119
			;;
	esac
}
function progress() {
    echo -n " "
    tput civis
    while kill -0 "$pid" > /dev/null 2>&1; do
        for i in "${spin[@]}"; do
            echo -ne "\b$i"
            sleep .1
        done
    done
    echo ""
    tput cnorm
}
