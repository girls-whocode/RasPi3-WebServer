#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi

function variables() {
	# Set program specific values
	majversion="3"
	minversion="0"
	subversion="0"
	codestatus="a"
	version="${majversion}.${minversion}.${subversion}${codestatus}"
	APPNAME="Server Auto Config ${majversion}"
	minmemoryreq=262144 # 256 Megabytes
	mindrivereq=665600 # 650 Megabytes

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
	SCREENTITLE="System Server Auto Configuration"
	HEIGHT=23
	WIDTH=40
	CHOICE_HEIGHT=21
	OKLABEL="Submit"
	CANCELLABEL="Back"
	CREDITS="Jessica Brown"

	# Since this script was ran with sudo, it will always return root,
	# this method will look for the normal privileged user first, if it
	# does exists or is blank, then default to the current user which is
	# probably root. We'll ask later anyways.
	user="$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)"
	if [ -z $user ]; then
		user="$USER"
	fi

	OKSYMB="\Z2✔\Zn"
	BADSYMB="\Zb\Z1x\Zn"
	DISABLEDSYMB="\Z3o\Zn"
	
	# Define paths and files
	hosts="/etc/hosts"
	meminfo="/proc/meminfo"
	cpuinfo="/proc/cpuinfo"
	logfolder="logs/"
	logfile="${logfolder}install.log"
	touch $logfile
	
	# System information
	phymem="$(awk '/^MemTotal:/{print $2}' $meminfo)"
	swpmem="$(awk '/^SwapTotal:/{print $2}' $meminfo)"
	cpucore="$(grep -c 'processor' $cpuinfo)"

	# [[ $environment = 'development' ]] && logfile="${logfolder}"raspy3-install.log || logfile="${logfolder}"raspy3-install_`date +'%m-%d-%Y_%H%M%S'`.log
	
	configfile="serverconfig.ini"

	# Output file name (constructed out of script name)
	OUTFILE=$0.output
	returncode=0

	# Set spinner text for progress function
	spin[0]="${LIGHTRED}-"
	spin[1]="${WHITE}\\"
	spin[2]="${YELLOW}|"
	spin[3]="${LIGHTGREEN}/"

	# If CTRL-C, ESC, or any other quit key combination run the quitscript function
	trap_with_arg quitscript HUP INT QUIT ILL TRAP ABRT TSTP TERM EXIT
	
	( set -o posix ; set ) >logs/variables.log
}
function varreset() {
	webservermenustatus="disabled"
	sslmenustatus="disabled"
	
	# Apache Server Menu Switches Settings that need to be validated:
	apachestatus="disabled"
	apachemenustatus="disabled"
	nginxstatus="disabled"
	nginxmenustatus="disabled"
	lightspeedstatus="disabled"
	lightspeedmenustatus="disabled"
	cherokeestatus="disabled"
	cherokeemenustatus="disabled"
	caddystatus="disabled"
	caddymenustatus="disabled"
	monkeystatus="disabled"
	monkeymenustatus="disabled"
	hiawathastatus="disabled"
	hiawathamenustatus="disabled"

	# Database Server Menu
	databasemenustatus="disabled"
	mysqlmenustatus="disabled"
	mariadbmenustatus="disabled"
	postgresqlmenustatus="disabled"

	# Database Configuration Menu Switches that need to be validated:
	mysqlstatus="false"
	mariadbstatus="false"
	postgresqlstatus="false"
	sqlitestatus="false"
	pervasivestatus="false"
	voltdbstatus="false"
	gigabase="false"
	
	# System Configuration Menu Switches that need to be validated:
	systeminfostatus="false"
	filesystemstatus="false"
	memorystatus="false"
	fileeditorstatus="false"
	networkconfigstatus="false"
	applicationconfigstatus="false"

	
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
	webserverfailtest=""
	returncode=0
	( set -o posix ; set ) >logs/variables.log
}
