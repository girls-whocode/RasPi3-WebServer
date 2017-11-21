#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi

function config() {
	option="${1}"
	option_mode="ini"
	SEPARATOR_INI="="

	case $option in
		"change_value")
			parameter="${2}"
			separator="${SEPARATOR_INI}"
			value="${3}"
			
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
					sort -o "${configfile}" "${configfile}"
				fi
			fi
			config "verify_write" $parameter $value
			;;
		"get_line")
			parameter="${2}"
			separator="${SEPARATOR_INI}"
			log "Retrieving line number for ${parameter}"
			output=$(sed -n "/^${parameter}${separator}/=" "${configfile}" 2>/dev/null)
			if [[ ! -z ${output##*[!0-9]*} ]]; then
				log "Parameter was found on ${output}"
				echo $output
			fi
			;;
		"read_value")
			parameter="${2}"
			separator="${SEPARATOR_INI}"
			output=$(sed -n "s/^${parameter}${separator}//p" "${configfile}" 2>/dev/null)
			
			if [[ -n $output ]]; then
				log "${parameter} found"
				echo "${output}"
			else
				if grep -q "^${parameter}${separator}$" "${configfile}" 2>/dev/null; then
					log "${parameter} null"
					echo "null"
				else
					log "${parameter} false"
					echo "false"
				fi
			fi
			;;
		"remove_config")
			rm -f "${2}" &>/dev/null
			config_return=true
			
			if [[ -f $configfile ]]; then
				exit 200
			fi
			;;
		"remove_value")
			parameter="${2}"
			separator="${SEPARATOR_INI}"

			line_number=$(config "get_line" $parameter $separator)

			[[ -n $line_number ]] && sed -i "${line_number}d" "$configfile" 2>/dev/null
			if grep -q "^${parameter}${separator}" "$configfile" 2>/dev/null; then
				exit 202
			elif [[ -f $configfile && ! -s $configfile ]]; then  # remove config if empty
				config "remove_config" $configfile
			fi
			;;
		"sanitize_value")
			parameter="${2}"
 
			if ! echo "${parameter}" | grep -q '^[A-Za-z0-9_-]\+$'; then
				exit 203
			fi
			;;
		"verify_write")
			fullstring="${2}${SEPARATOR_INI}${3}"
			if ! grep -q "^${fullstring}$" "${configfile}" &>/dev/null; then
				log "Error 201 - ${2} was not written to ${configfile}"
				exit 201
			fi
			;;
		"write_value")
			parameter="${2}"
			separator="${SEPARATOR_INI}"
			value="${3}"

			if [[ -f $configfile ]]; then
				log "Opening configuration file for modification"
				line_number="$(config "get_line" $parameter)"
				if [[ -n $line_number ]]; then
					log "Found ${parameter} on line ${line_number} - Writing value ${value}"
					sed -i "${line_number}c${parameter}${separator}${value}" "$configfile" 2>/dev/null
				else
					log "${parameter} was not found - Adding to configuration file with value of ${value}"
					echo "${parameter}${separator}${value}" >> "${configfile}"
					sort -o "${configfile}" "${configfile}"
				fi
			else
				log "Creating configuration file for first use"
				log "Add ${parameter} to ${configfile} with ${value}"
				echo "${parameter}${separator}${value}" >> "${configfile}"
			fi
			config "verify_write" $parameter $value
			;;
		*)
			exit 180
			;;
	esac
}
function loadcfg() {
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
	
	# Read the config file, $value, false, or null will be returned
	DISTROCFG=$(config "read_value" "distro")
	CODENAMECFG=$(config "read_value" "codename")
	DISTVERSIONCFG=$(config "read_value" "distro_version")
	EMAILCFG=$(config "read_value" "email")
	IPCFG=$(config "read_value" "ip")
	OWNERGROUPCFG=$(config "read_value" "ownergroup")
	TZONECFG=$(config "read_value" "tzone")
	WEBSERVERDIRCFG=$(config "read_value" "webserverdir")
	PKGMGRCFG=$(config "read_value" "pkgmgr")
	FQDNCFG=$(config "read_value" "fqdn")
	SERVERUSERCFG=$(config "read_value" "user")
	WEBSERVERTYPECFG=$(config "read_value" "webserver")
	DATABASESERVERTYPE=$(config "read_value" "databaseserver")
	APPSERVERTYPECFG=$(config "read_value" "appserver")
	EMAILSERVERTYPECFG=$(config "read_value" "emailserver")
	FILEERVERTYPECFG=$(config "read_value" "fileserver")
	MSGSERVERTYPECFG=$(config "read_value" "msgserver")
	PROXYSERVERTYPECFG=$(config "read_value" "proxyserver")
	SERVETYPECFG=$(config "read_value" "servetype")

	# DISTRO sets the distribution information -- currently this is reading the config file 3 times for each item, should probably re-write this to save some read/write calls
	if [ "${DISTROCFG}" == "false" ] || [ "${DISTROCFG}" == "null" ]; then
		DISTRO=$(lsb_release -is)
		log "DISTRO parameter or value does not exist - set to default value"
		config "write_value" "distro" $DISTRO
	else
		DISTRO=$(config "read_value" "distro")
	fi

	# CODENAME sets the distribution codename
	if [ "${CODENAMECFG}" == "false" ] || [ "${CODENAMECFG}" == "null" ]; then
		CODENAME=$(lsb_release -cs)
		log "CODENAME parameter or value does not exist - set to default value"
		config "write_value" "codename" $CODENAME
	else
		CODENAME=$(config "read_value" "codename")
	fi

	# DISTVERSION sets the distribution codename
	if [ "${DISTVERSIONCFG}" == "false" ] || [ "${DISTVERSIONCFG}" == "null" ]; then
		DISTVERSION=$( lsb_release -rs )
		log "DISTVERSION parameter or value does not exist - set to default value"
		config "write_value" "distro_version" $DISTVERSION
	else
		DISTVERSION=$(config "read_value" "distro_version")
	fi

	# EMAIL set a default email value
	if [ "${EMAILCFG}" == "false" ] || [ "${EMAILCFG}" == "null" ]; then
		EMAIL="disabled"
		log "Email parameter or value does not exist - set to default value"
		config "write_value" "email" $EMAIL
	else
		EMAIL=$(config "read_value" "email")
	fi

	# IP sets the IP address
	if [ "${IPCFG}" == "false" ] || [ "${IPCFG}" == "null" ]; then
		IP="127.0.0.1"
		log "IP parameter or value does not exist - set to default value"
		config "write_value" "ip" $IP
	else
		IP=$(config "read_value" "ip")
	fi

	# OWNERGROUP sets the default ower:group for webserver files and folders
	if [ "${OWNERGROUPCFG}" == "false" ] || [ "${OWNERGROUPCFG}" == "null" ]; then
		OWNERGROUP="www-data:www-data"
		log "OWNERGROUP parameter or value does not exist - set to default value"
		config "write_value" "ownergroup" $OWNERGROUP
	else
		OWNERGROUP=$(config "read_value" "ownergroup")
	fi

	# TZONE gets the default value for the current system timezone
	if [ "${TZONECFG}" == "false" ] || [ "${TZONECFG}" == "null" ]; then
		TZONE="$(cat /etc/timezone)"
		log "TZONE parameter or value does not exist - set to default value"
		config "write_value" "tzone" $TZONE
	else
		TZONE=$(config "read_value" "tzone")
	fi

	# WEBSERVERDIR sets the default web server directory
	if [ "${WEBSERVERDIRCFG}" == "false" ] || [ "${WEBSERVERDIRCFG}" == "null" ]; then
		WEBSERVERDIR="/var/www/"
		log "WEBSERVERDIR parameter or value does not exist - set to default value"
		config "write_value" "webserverdir" $WEBSERVERDIR
	else
		WEBSERVERDIR=$(config "read_value" "webserverdir")
	fi

	# PKGINSTALL finds what package manager is installed and allows the user to choose which one to use
	if [ "${PKGMGRCFG}" == "false" ] || [ "${PKGMGRCFG}" == "null" ]; then
		log "PKGINSTALL parameter or value does not exist - set to default value"
		if haveprog "apt-get"; then
			log "Package manager set to APT"
			PKGMGR="apt"
			PKGINSTALL="sudo apt -y install"
			config "write_value" "pkgmgr" "apt"
		elif haveprog "dnf"; then
			log "Package manager set to DNF"
			PKGMGR="dnf"
			PKGINSTALL="sudo dnf -y install"
			config "write_value" "pkgmgr" "dnf"
		elif haveprog "yum"; then
			log "Package manager set to YUM"
			PKGMGR="yum"
			PKGINSTALL="sudo yum -y install"
			config "write_value" "pkgmgr" "yum"
		elif haveprog "up2date"; then
			log "Package manager set to UP2DATE"
			PKGMGR="up2date"
			PKGINSTALL="sudo up2date -y install"
			config "write_value" "pkgmgr" "up2date"
		else
			log "Package manager set to NONE"
			config "write_value" "pkgmgr" "none"
			PKGMGR="none"
			# Consider installing and configuring everything without a package manager
			exit 100
		fi
	else
		PKGMGR=$(config "read_value" "pkgmgr")
		if [ $PKGMGR == "apt" ]; then
			PKGINSTALL="sudo apt -y install"
		elif [ $PKGMGR == "dnf" ]; then
			PKGINSTALL="sudo dnf -y install"
		elif [ $PKGMGR == "yum" ]; then
			PKGINSTALL="sudo yum -y install"
		elif [ $PKGMGR == "up2date" ]; then
			PKGINSTALL="sudo up2date -y install"
		fi
	fi

	# FQDN sets the default domain of the server
	if [ "${FQDNCFG}" == "false" ] || [ "${FQDNCFG}" == "null" ]; then
		FQDN="$(hostname --fqdn)"
		log "FQDN parameter or value does not exist - set to default value"
		config "write_value" "fqdn" $FQDN
	else
		FQDN=$(config "read_value" "fqdn")
	fi

	# SERVERUSER tries to resolve the non-root user if available, if not, then set from $USER
	if [ "${SERVERUSERCFG}" == "false" ] || [ "${SERVERUSERCFG}" == "null" ]; then
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
	fi

	# WEBSERVERTYPE apache, nginx, lightspeed, false, disabled, null
	if [ "${WEBSERVERTYPECFG}" == "false" ] || [ "${WEBSERVERTYPECFG}" == "null" ]; then
		log "webserver parameter or value does not exist - set to default value"
		config "write_value" "webserver" "disabled"
	else
		WEBSERVERTYPE=$(config "read_value" "webserver")
	fi

	# DATABASESERVERTYPE mysql, mariadb, postgresql, false, disabled, null
	if [ "${DATABASESERVERTYPE}" == "false" ] || [ "${DATABASESERVERTYPE}" == "null" ]; then
		log "databaseserver parameter or value does not exist - set to default value"
		config "write_value" "databaseserver" "disabled"
	else
		DATABASESERVERTYPE=$(config "read_value" "databaseserver")
	fi

	# APPSERVERTYPE php, java, tomcat, osa, mobile, bbs, false, disabled, null
	if [ "${APPSERVERTYPECFG}" == "false" ] || [ "${APPSERVERTYPECFG}" == "null" ]; then
		log "appserver parameter or value does not exist - set to default value"
		config "write_value" "appserver" "disabled"
	else
		APPSERVERTYPE=$(config "read_value" "appserver")
	fi

	# EMAILSERVERTYPE postfix, citadel, sendmail, exim, courier, false, disabled, null
	if [ "${EMAILSERVERTYPECFG}" == "false" ] || [ "${EMAILSERVERTYPECFG}" == "null" ]; then
		log "emailserver parameter or value does not exist - set to default value"
		config "write_value" "emailserver" "disabled"
	else
		EMAILSERVERTYPE=$(config "read_value" "emailserver")
	fi

	# FILEERVERTYPE postfix, citadel, sendmail, exim, courier, false, disabled, null
	if [ "${FILEERVERTYPECFG}" == "false" ] || [ "${FILEERVERTYPECFG}" == "null" ]; then
		log "fileserver parameter or value does not exist - set to default value"
		config "write_value" "fileserver" "disabled"
	else
		FILEERVERTYPE=$(config "read_value" "fileserver")
	fi

	# MSGSERVERTYPE (right now not sure what to put here)
	if [ "${MSGSERVERTYPECFG}" == "false" ] || [ "${MSGSERVERTYPECFG}" == "null" ]; then
		log "msgserver parameter or value does not exist - set to default value"
		config "write_value" "msgserver" "disabled"
	else
		MSGSERVERTYPE=$(config "read_value" "msgserver")
	fi

	# PROXYSERVERTYPE (right now not sure what to put here)
	if [ "${PROXYSERVERTYPECFG}" == "false" ] || [ "${PROXYSERVERTYPECFG}" == "null" ]; then
		log "proxyserver parameter does not exist - set to default value"
		config "write_value" "proxyserver" "disabled"
	else
		PROXYSERVERTYPE=$(config "read_value" "proxyserver")
	fi

	# SERVETYPE true, false, disabled, null
	if [ "${SERVETYPECFG}" == "false" ] || [ "${SERVETYPECFG}" == "null" ]; then
		log "servetype parameter or value does not exist - set to default value"
		config "write_value" "servetype" "disabled"
	else
		SERVETYPE=$(config "read_value" "servetype")
	fi
}
function switchserver() {
	case "$1" in
		"apache")
			if [ "${SERVETYPE}" == "false" ] || [ "${SERVETYPE}" == "disabled" ]; then
				config "write_value" "webserver" "apache"
				config "write_value" "servetype" "true"
			elif [ "${SERVETYPE}" == "true" ] && [ "${WEBSERVERTYPE}" != "apache" ]; then
				config "write_value" "webserver" "apache"
			else
				if [ "${WEBSERVERTYPE}" == "apache" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			menusystem
			;;
		"nginx")
			if [ "${SERVETYPE}" == "false" ] || [ "${SERVETYPE}" == "disabled" ]; then
				config "write_value" "webserver" "nginx"
				config "write_value" "servetype" "true"
			elif [ "${SERVETYPE}" == "true" ] && [ "${WEBSERVERTYPE}" != "nginx" ]; then
				config "write_value" "webserver" "nginx"
			else
				if [ "${WEBSERVERTYPE}" == "nginx" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			menusystem
			;;
		"lightspeed")
			# If the server type is false, then activate it
			if [ "${SERVETYPE}" == "false" ] || [ "${SERVETYPE}" == "disabled" ]; then
				config "write_value" "webserver" "lightspeed"
				config "write_value" "servetype" "true"
			# If the server is true and it has a different web server type, then change it
			elif [ "${SERVETYPE}" == "true" ] && [ "${WEBSERVERTYPE}" != "lightspeed" ]; then
				config "write_value" "webserver" "lightspeed"
			else
				if [ "${WEBSERVERTYPE}" == "lightspeed" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			menusystem
			;;
	esac
}
