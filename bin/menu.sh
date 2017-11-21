#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi

############## MENU SYSTEM
function menusystem() {
	# Get the updated config file so menu status icons will be displayed correctly
	loadcfg
	webservererror=""

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

	# Domain name must be valid for all web servers
	host "${FQDN}" 2>&1 > /dev/null
	if [ $? -eq 0 ]; then
        apachestatus="true"
        apachemenustatus="true"
        nginxstatus="true"
		nginxmenustatus="true"
		lightspeedstatus="true"
		lightspeedmenustatus="true"
		cherokeestatus="true"
		cherokeemenustatus="true"
		caddystatus="true"
		caddymenustatus="true"
		monkeystatus="true"
		monkeymenustatus="true"
		hiawathastatus="true"
		hiawathamenustatus="true"
    else
		apachestatus="false"
		apachemenustatus="false"
		nginxstatus="false"
		nginxmenustatus="false"
		lightspeedstatus="false"
		lightspeedmenustatus="false"
		cherokeestatus="false"
		cherokeemenustatus="false"
		caddystatus="false"
		caddymenustatus="false"
		monkeystatus="false"
		monkeymenustatus="false"
		hiawathastatus="false"
		hiawathamenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Domain Name\Zn - cannot be resolved\n"
    fi

	# Web folder must be valid
	if [ -d $WEBSERVERDIR ]; then
		# Directory exist
		if [ "${apachestatus}" != "false" ] || [ "${apachestatus}" != "disabled" ]; then
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "false" ] || [ "${nginxstatus}" != "disabled" ]; then
			nginxstatus="true"
			nginxmenustatus="true"
		fi
	else
		# Directory does not exist
		apachestatus="false"
		apachemenustatus="false"
		nginxstatus="false"
		nginxmenustatus="false"
		lightspeedstatus="false"
		lightspeedmenustatus="false"
		cherokeestatus="false"
		cherokeemenustatus="false"
		caddystatus="false"
		caddymenustatus="false"
		monkeystatus="false"
		monkeymenustatus="false"
		hiawathastatus="false"
		hiawathamenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Public HTML folder\Zn - Does not exist\n"
	fi

	# Web user must exist
	getent passwd "${SERVERUSER}" > /dev/null 2&>1
	if [ $? -eq 0 ]; then
		# The user exist
		if [ "${apachestatus}" != "false" ] || [ "${apachestatus}" != "disabled" ]; then
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "false" ] || [ "${nginxstatus}" != "disabled" ]; then
			nginxstatus="true"
			nginxmenustatus="true"
		fi
	else
		# User does not exist
		apachestatus="false"
		apachemenustatus="false"
		nginxstatus="false"
		nginxmenustatus="false"
		lightspeedstatus="false"
		lightspeedmenustatus="false"
		cherokeestatus="false"
		cherokeemenustatus="false"
		caddystatus="false"
		caddymenustatus="false"
		monkeystatus="false"
		monkeymenustatus="false"
		hiawathastatus="false"
		hiawathamenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1User ${SERVERUSER}\Zn - Does not exist\n"
	fi

	# Web folder must have correct permissions
	if [ -n "$(find "${WEBSERVERDIR}" -maxdepth 0 -user "${OWNERGROUP}")" ]; then
		# Ownership is correct
		if [ "${apachestatus}" != "false" ] || [ "${apachestatus}" != "disabled" ]; then
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "false" ] || [ "${nginxstatus}" != "disabled" ]; then
			nginxstatus="true"
			nginxmenustatus="true"
		fi
	else
		# User does not exist
		apachestatus="false"
		apachemenustatus="false"
		nginxstatus="false"
		nginxmenustatus="false"
		lightspeedstatus="false"
		lightspeedmenustatus="false"
		cherokeestatus="false"
		cherokeemenustatus="false"
		caddystatus="false"
		caddymenustatus="false"
		monkeystatus="false"
		monkeymenustatus="false"
		hiawathastatus="false"
		hiawathamenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Public HTML folder\Zn - Has invalid ownership\n"
	fi

	# Apache must be installed
	if haveprog "apache2"; then
		if [ "${apachestatus}" != "false" ] || [ "${apachestatus}" != "disabled" ]; then
			apachestatus="true"
			apachemenustatus="true"
		fi
	else
		apachestatus="false"
		apachemenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Apache Server\Zn - Has not been installed\n"
	fi

	# nGinX must be installed
	if haveprog "nginx"; then
		if [ "${nginxstatus}" != "false" ] || [ "${nginxstatus}" != "disabled" ]; then
			nginxstatus="true"
			nginxmenustatus="true"
		fi
	else
		nginxstatus="false"
		nginxmenustatus="false"
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1nGinX Server\Zn - Has not been installed\n"
	fi

	# Apache log folder must exist
		# TODO
	# Apache sites-enabled must exist
		# TODO

	###################################################################
	# Menu icon status symbols
	###################################################################
	# Apache, nGinX, Lightspeed Server icon status symbols
	###################################################################
	if [ "${WEBSERVERTYPE}" == "apache" ]; then
		if [ "${apachestatus}" != "false" ]; then
			apachemenustatus="true"
		fi
		nginxstatus="disabled"
		lightspeedstatus="disabled"
		cherokeestatus="disabled"
		caddystatus="disabled"
		monkeystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "nginx" ]; then
		if [ "${nginxstatus}" != "false" ]; then
			nginxmenustatus="true"
		fi
		apachestatus="disabled"
		lightspeedstatus="disabled"
		cherokeestatus="disabled"
		caddystatus="disabled"
		monkeystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "lightspeed" ]; then
		if [ "${lightspeedstatus}" != "false" ]; then
			lightspeedmenustatus="true"
		fi
		apachestatus="disabled"
		nginxstatus="disabled"
		cherokeestatus="disabled"
		caddystatus="disabled"
		monkeystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "cherokee" ]; then
		if [ "${cherokeestatus}" != "false" ]; then
			cherokeemenustatus="true"
		fi
		apachestatus="disabled"
		lightspeedstatus="disabled"
		caddystatus="disabled"
		monkeystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "caddy" ]; then
		if [ "${caddystatus}" != "false" ]; then
			caddymenustatus="true"
		fi
		apachestatus="disabled"
		lightspeedstatus="disabled"
		cherokeestatus="disabled"
		monkeystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "monkey" ]; then
		if [ "${monkeystatus}" != "false" ]; then
			monkeymenustatus="true"
		fi
		apachestatus="disabled"
		lightspeedstatus="disabled"
		cherokeestatus="disabled"
		caddystatus="disabled"
		hiawathastatus="disabled"
	fi
	if [ "${WEBSERVERTYPE}" == "hiawatha" ]; then
		if [ "${hiawathastatus}" != "false" ]; then
			hiawathamenustatus="true"
		fi
		apachestatus="disabled"
		lightspeedstatus="disabled"
		cherokeestatus="disabled"
		caddystatus="disabled"
		monkeystatus="disabled"
	fi

	if [ "${WEBSERVERTYPE}" == "disabled" ]; then
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
	fi

	if [ "${apachestatus}" == "diasbled" ] && [ "${nginxstatus}" == "disabled" ] && [ "${lightspeedstatus}" == "disabled" ]; then
		webservermenuicon="${DISABLEDSYMB}"
	else
		webservermenuicon="${OKSYMB}"
	fi

	if [ "${apachestatus}" == "false" ] && [ "${nginxstatus}" == "false" ] && [ "${lightspeedstatus}" == "false" ]; then
		webservermenuicon="${BADSYMB}"
	else
		webservermenuicon="${OKSYMB}"
	fi

	if [ "${apachestatus}" == "true" ]; then
		apacheconfigmenuicon="${OKSYMB}"
		apachemenuicon="${OKSYMB}"
		service="apache2"
		if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
			apacherestartmenuicon="${OKSYMB}"
			apachestartmenuicon="${BADSYMB}"
			apachestopmenuicon="${OKSYMB}"
		else
			apacherestartmenuicon="${OKSYMB}"
			apachestartmenuicon="${OKSYMB}"
			apachestopmenuicon="${BADSYMB}"
		fi
	fi

	if [ "${nginxstatus}" == "true" ]; then
		nginxconfigmenuicon="${OKSYMB}"
		nginxmenuicon="${OKSYMB}"
		service="nginx"
		if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
			nginxrestartmenuicon="${OKSYMB}"
			nginxstartmenuicon="${BADSYMB}"
			nginxstopmenuicon="${OKSYMB}"
		else
			nginxrestartmenuicon="${OKSYMB}"
			nginxstartmenuicon="${OKSYMB}"
			nginxstopmenuicon="${BADSYMB}"
		fi
	fi

	if [ "${lightspeedstatus}" == "true" ]; then
		lightspeedconfigmenuicon="${OKSYMB}"
		lightspeedmenuicon="${OKSYMB}"
		service="lightspeed"
		if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 )); then
			lightspeedrestartmenuicon="${OKSYMB}"
			lightspeedstartmenuicon="${BADSYMB}"
			lightspeedstopmenuicon="${OKSYMB}"
		else
			lightspeedrestartmenuicon="${OKSYMB}"
			lightspeedstartmenuicon="${OKSYMB}"
			lightspeedstopmenuicon="${BADSYMB}"
		fi
	fi

	if [ "${apachestatus}" == "false" ]; then
		apacheconfigmenuicon="${BADSYMB}"
		apachemenuicon="${BADSYMB}"
		apacherestartmenuicon="${BADSYMB}"
		apachestartmenuicon="${BADSYMB}"
		apachestopmenuicon="${BADSYMB}"
	fi
	if [ "${nginxstatus}" == "false" ]; then
		nginxconfigmenuicon="${BADSYMB}"
		nginxmenuicon="${BADSYMB}"
		nginxrestartmenuicon="${BADSYMB}"
		nginxstartmenuicon="${BADSYMB}"
		nginxstopmenuicon="${BADSYMB}"
	fi
	if [ "${lightspeedstatus}" == "false" ]; then
		lightspeedconfigmenuicon="${BADSYMB}"
		lightspeedmenuicon="${BADSYMB}"
		lightspeedrestartmenuicon="${BADSYMB}"
		lightspeedstartmenuicon="${BADSYMB}"
		lightspeedstopmenuicon="${BADSYMB}"
	fi
	if [ "${cherokeestatus}" == "false" ]; then
		cherokeeconfigmenuicon="${BADSYMB}"
		cherokeemenuicon="${BADSYMB}"
		cherokeerestartmenuicon="${BADSYMB}"
		cherokeestartmenuicon="${BADSYMB}"
		cherokeestopmenuicon="${BADSYMB}"
	fi
	if [ "${caddystatus}" == "false" ]; then
		caddyconfigmenuicon="${BADSYMB}"
		caddymenuicon="${BADSYMB}"
		caddyrestartmenuicon="${BADSYMB}"
		caddystartmenuicon="${BADSYMB}"
		caddystopmenuicon="${BADSYMB}"
	fi
	if [ "${monkeystatus}" == "false" ]; then
		monkeyconfigmenuicon="${BADSYMB}"
		monkeymenuicon="${BADSYMB}"
		monkeyrestartmenuicon="${BADSYMB}"
		monkeystartmenuicon="${BADSYMB}"
		monkeystopmenuicon="${BADSYMB}"
	fi
	if [ "${hiawathastatus}" == "false" ]; then
		hiawathaconfigmenuicon="${BADSYMB}"
		hiawathamenuicon="${BADSYMB}"
		hiawatharestartmenuicon="${BADSYMB}"
		hiawathastartmenuicon="${BADSYMB}"
		hiawathastopmenuicon="${BADSYMB}"
	fi

	if [ "${apachestatus}" == "disabled" ]; then
		apacheconfigmenuicon="${DISABLEDSYMB}"
		apachemenuicon="${DISABLEDSYMB}"
		apacherestartmenuicon="${DISABLEDSYMB}"
		apachestartmenuicon="${DISABLEDSYMB}"
		apachestopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${nginxstatus}" == "disabled" ]; then
		nginxconfigmenuicon="${DISABLEDSYMB}"
		nginxmenuicon="${DISABLEDSYMB}"
		nginxrestartmenuicon="${DISABLEDSYMB}"
		nginxstartmenuicon="${DISABLEDSYMB}"
		nginxstopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${lightspeedstatus}" == "disabled" ]; then
		lightspeedconfigmenuicon="${DISABLEDSYMB}"
		lightspeedmenuicon="${DISABLEDSYMB}"
		lightspeedrestartmenuicon="${DISABLEDSYMB}"
		lightspeedstartmenuicon="${DISABLEDSYMB}"
		lightspeedstopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${cherokeestatus}" == "disabled" ]; then
		cherokeeconfigmenuicon="${DISABLEDSYMB}"
		cherokeemenuicon="${DISABLEDSYMB}"
		cherokeerestartmenuicon="${DISABLEDSYMB}"
		cherokeestartmenuicon="${DISABLEDSYMB}"
		cherokeestopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${caddystatus}" == "disabled" ]; then
		caddyconfigmenuicon="${DISABLEDSYMB}"
		caddymenuicon="${DISABLEDSYMB}"
		caddyrestartmenuicon="${DISABLEDSYMB}"
		caddystartmenuicon="${DISABLEDSYMB}"
		caddystopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${monkeystatus}" == "disabled" ]; then
		monkeyconfigmenuicon="${DISABLEDSYMB}"
		monkeymenuicon="${DISABLEDSYMB}"
		monkeyrestartmenuicon="${DISABLEDSYMB}"
		monkeystartmenuicon="${DISABLEDSYMB}"
		monkeystopmenuicon="${DISABLEDSYMB}"
	fi
	if [ "${hiawathastatus}" == "disabled" ]; then
		hiawathaconfigmenuicon="${DISABLEDSYMB}"
		hiawathamenuicon="${DISABLEDSYMB}"
		hiawatharestartmenuicon="${DISABLEDSYMB}"
		hiawathastartmenuicon="${DISABLEDSYMB}"
		hiawathastopmenuicon="${DISABLEDSYMB}"
	fi

	if [ "${apachestatus}" == "true" ] || [ "${nginxstatus}" == "true" ] || [ "${lightspeedstatus}" == "true" ] || [ "${cherokeestatus}" == "true" ] || [ "${caddystatus}" == "true" ] || [ "${monkeystatus}" == "true" ] || [ "${hiawathastatus}" == "true" ]; then
		webservermenuicon="${OKSYMB}"
	fi

	apachestatus="$([ "${WEBSERVERTYPE}" == "apache" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
	nginxstatus="$([ "${WEBSERVERTYPE}" == "nginx" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
	lightspeedstatus="$([ "${WEBSERVERTYPE}" == "lightspeed" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
	sslmenuicon="$([ "${sslmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${sslmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Database Server icon status symbols
	###################################################################
	databasemenuicon="$([ "${databasemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${databasemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	mysqlmenuicon="$([ "${mysqlmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${mysqlmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	mariadbmenuicon="$([ "${mariadbmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${mariadbmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	postgresqlmenuicon="$([ "${postgresqlmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${postgresqlmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# System Configuration Server icon status symbols
	###################################################################
	minmemoryreq=262144 # 256 Megabytes
	mindrivereq=665600 # 650 Megabytes

	systeminfomenustatus="true"
	filesystemmenustatus="true"
	drivespacemenustatus="true"
	mountpointmenustatus="disabled"
	raidconfigmenustatus="disabled"
	usbdrivemenustatus="disabled"

	if [ $phymem -lt $minmemoryreq ]; then
		systeminfostatus="false"
		memoryconfigmenustatus="false"
	else
		systeminfostatus="true"
		memoryconfigmenustatus="true"
	fi
	
	if [ $systeminfostatus == "true" ]; then
		systemconfigmenustatus="true"
	else
		systemconfigmenustatus="false"
	fi

	memoryfreemenustatus="true"
	swapmemorymenustatus="true"
	fileeditormenustatus="true"
	hostsfilemenustatus="true"
	hostnamefilemenustatus="true"
	networkconfigmenustatus="true"
	wirelessconfigmenustatus="true"
	networkitemconfigmenustatus="true"
	applicationconfigmenustatus="true"
	gitconfigmenustatus="true"
	uninstallappmenustatus="true"

	###################################################################
	# Logs icon status symbols
	###################################################################
	logsmenustatus="true"

	###################################################################
	# Application Server icon status symbols
	###################################################################
	applicationmenuicon="$([ "${applicationmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${applicationmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	phpmenuicon="$([ "${phpmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${phpmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	javamenuicon="$([ "${javamenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${javamenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	tomcatmenuicon="$([ "${tomcatmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${tomcatmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	osamenuicon="$([ "${osamenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${osamenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	mobilemenuicon="$([ "${mobilemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${mobilemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	phpappmenuicon="$([ "${phpappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${phpappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	javaappmenuicon="$([ "${javaappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${javaappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	tomcatappmenuicon="$([ "${tomcatappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${tomcatappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	osaappmenuicon="$([ "${osaappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${osaappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	mobileappmenuicon="$([ "${mobileappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${mobileappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	bbsappmenuicon="$([ "${bbsappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${bbsappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Email Server icon status symbols
	###################################################################
	emailmenuicon="$([ "${emailmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${emailmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	postfixmenuicon="$([ "${postfixmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${postfixmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	citadelmenuicon="$([ "${citadelmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${citadelmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	sendmailmenuicon="$([ "${sendmailmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${sendmailmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	eximmenuicon="$([ "${eximmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${eximmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	couriermenuicon="$([ "${couriermenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${couriermenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# File Server icon status symbols
	###################################################################
	filemenuicon="$([ "${filemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${filemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	ftpmenuicon="$([ "${ftpmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${ftpmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	nfsmenuicon="$([ "${nfsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${nfsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	sambamenuicon="$([ "${sambamenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${sambamenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Message Server icon status symbols
	###################################################################
	messagemenuicon="$([ "${messagemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${messagemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Proxy Server icon status symbols
	###################################################################
	proxymenuicon="$([ "${proxymenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${proxymenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# System Configuration icon status symbols
	###################################################################
	systemconfigmenuicon="$([ "${systemconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${systemconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	systeminfomenuicon="$([ "${systeminfomenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${systeminfomenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	filesystemmenuicon="$([ "${filesystemmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${filesystemmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	drivespacemenuicon="$([ "${drivespacemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${drivespacemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	mountpointmenuicon="$([ "${mountpointmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${mountpointmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	raidconfigmenuicon="$([ "${raidconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${raidconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	usbdrivemenuicon="$([ "${usbdrivemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${usbdrivemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	memoryconfigmenuicon="$([ "${memoryconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${memoryconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	memoryfreemenuicon="$([ "${memoryfreemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${memoryfreemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	swapmemorymenuicon="$([ "${swapmemorymenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${swapmemorymenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	fileeditormenuicon="$([ "${fileeditormenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${fileeditormenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	hostsfilemenuicon="$([ "${hostsfilemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${hostsfilemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	hostnamefilemenuicon="$([ "${hostnamefilemenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${hostnamefilemenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	networkconfigmenuicon="$([ "${networkconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${networkconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	wirelessconfigmenuicon="$([ "${wirelessconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${wirelessconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	networkitemconfigmenuicon="$([ "${networkitemconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${networkitemconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	applicationconfigmenuicon="$([ "${applicationconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${applicationconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	gitconfigmenuicon="$([ "${gitconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${gitconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	uninstallappmenuicon="$([ "${uninstallappmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${uninstallappmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Logs icon status symbols
	###################################################################
	logsmenuicon="$([ "${logsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${logsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	phplogsmenuicon="$([ "${phplogsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${phplogsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	accesslogsmenuicon="$([ "${accesslogsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${accesslogsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	errorlogsmenuicon="$([ "${errorlogsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${errorlogsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	installationlogsmenuicon="$([ "${installationlogmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${installationlogmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	systemlogsmenuicon="$([ "${systemlogsmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${systemlogsmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"
	autoconfigmenuicon="$([ "${autoconfigmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${autoconfigmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

	###################################################################
	# Menu Lists
	###################################################################
	mainmenu=("1" "${webservermenuicon} Web Server" "2" "${databasemenuicon} Database Server" "3" "${applicationmenuicon} Application Server" "4" "${emailmenuicon} Email Server" "5" "${filemenuicon} File Server" "6" "${messagemenuicon} Message Server" "7" "${proxymenuicon} Proxy Server" "8" "${systemconfigmenuicon} System Configuration" "9" "${logsmenuicon} Logs")
	###################################################################
	webservermenu=(1 "${apachemenuicon} Apache" 2 "${nginxmenuicon} nGinX" 3 "${lightspeedmenuicon} LightTPD" 4 "${cherokeemenuicon} Cherokee" 5 "${caddymenuicon} Caddy" 6 "${monkeymenuicon} Monkey HTTP" 7 "${hiawathamenuicon} Hiawatha" 8 "${sslmenuicon} SSL")
	###################################################################
	apachemenu=(1 "${apacheconfigmenuicon} Apache Configuration" 2 "${apacherestartmenuicon} Apache Restart" 3 "${apachestartmenuicon} Apache Start" 4 "${apachestopmenuicon} Apache Stop" 5 "${apachestatus}")
	nginxmenu=(1 "${nginxconfigmenuicon} nGinX Configuration" 2 "${nginxrestartmenuicon} nGinX Restart" 3 "${nginxstartmenuicon} nGinX Start" 4 "${nginxstopmenuicon} nGinX Stop" 5 "${nginxstatus}")
	lightspeed=(1 "${lightspeedconfigmenuicon} Lightspeed Configuration" 2 "${lightspeedrestartmenuicon} Lightspeed Restart" 3 "${lightspeedstartmenuicon} Lightspeed Start" 4 "${lightspeedstopmenuicon} Lightspeed Stop" 5 "${lightspeedstatus}")
	###################################################################
	letsencryptmenu=(1 "Let's Encrypt Settings" 2 "Renew Certification" 3 "Revoke Certification")
	databaseservermenu=(1 "mySQL" 2 "MariaDB" 3 "PostgreSQL" 4 "SQLite" 5 "Pervasive" 6 "VoltDB" 7 "GigaBASE")
	mysqlmenu=(1 "${mysqlmenuicon} mySQL Configuration" 2 "mySQL Restart" 3 "mySQL Start" 4 "mySQL Stop")
	mariadbsqlmenu=(1 "${mariadbmenuicon} MariaDB Configuration" 2 "MariaDB Restart" 3 "MariaDB Start" 4 "MariaDB Stop")
	postgresqlmenu=(1 "${postgresqlmenuicon} PostgreSQL Configuration" 2 "PostgreSQL Restart" 3 "PostgreSQL Start" 4 "PostgreSQL Stop")
	applicationservermenu=(1 "${phpappmenuicon} PHP" 2 "${javaappmenuicon} Java" 3 "${tomcatappmenuicon} Tomcat" 4 "${osaappmenuicon} Open Source" 5 "${mobileappmenuicon} Mobile Application" 6 "${bbsappmenuicon} BBS Applications")
	phpmenu=(1 "${phpmenuicon} PHP Configuration" 2 "PHP Restart" 3 "PHP Start" 4 "PHP Stop")
	javamenu=(1 "${javamenuicon} Java Configuration" 2 "Java Restart" 3 "Java Start" 4 "Java Stop")
	tomcatmenu=(1 "${tomcatmenuicon} Tomcat Configuration" 2 "Tomcat Restart" 3 "Tomcat Start" 4 "Tomcat Stop")
	opensourcemenu=(1 "${osamenuicon} Open Source Configuration" 2 "Open Source Restart" 3 "Open Source Start" 4 "Open Source Stop")
	mobilemenu=(1 "${mobilemenuicon} Mobile App Configuration" 2 "Mobile App Restart" 3 "Mobile App Start" 4 "Mobile App Stop")
	bbsappsmenu=(1 "Mystic" 2 "WWIV")
	mysticmenu=(1 "Mystic Configuration" 2 "Mystic Local Mode")
	wwivmenu=(1 "WWIV Configuration" 2 "WWIV Local Mode")
	emailservermenu=(1 "Postfix" 2 "Citadel" 3 "Sendmail" 4 "Exim" 5 "Courier")
	postfixmenu=(1 "${postfixmenuicon} Postfix Configuration" 2 "Postfix Restart" 3 "Postfix Start" 4 "Postfix Stop")
	citadelmenu=(1 "${citadelmenuicon} Citadel Configuration" 2 "Citadel Restart" 3 "Citadel Start" 4 "Citadel Stop")
	sendmailmenu=(1 "${sendmailmenuicon} Sendmail Configuration" 2 "Sendmail Restart" 3 "Sendmail Start" 4 "Sendmail Stop")
	eximmenu=(1 "${eximmenuicon} Exim Configuration" 2 "Exim Restart" 3 "Exim Start" 4 "Exim Stop")
	couriermenu=(1 "${couriermenuicon} Courier Configuration" 2 "Courier Restart" 3 "Courier Start" 4 "Courier Stop")
	fileservermenu=(1 "FTP" 2 "NFS" 3 "Samba")
	ftpmenu=(1 "${ftpmenuicon} FTP Configuration" 2 "FTP Restart" 3 "FTP Start" 4 "FTP Stop")
	nfsmenu=(1 "${nfsmenuicon} NFS Configuration" 2 "NFS Restart" 3 "NFS Start" 4 "NFS Stop")
	sambamenu=(1 "${sambamenuicon} Samba Configuration" 2 "Samba Restart" 3 "Samba Start" 4 "Samba Stop")
	messageservermenu=(1 "Not set up" 2 "Not set up" 3 "Not set up")
	proxyservermenu=(1 "Not set up" 2 "Not set up" 3 "Not set up")
	systemconfigmenu=(1 "${systeminfomenuicon} System Information" 2 "${filesystemmenuicon} File System" 3 "${memoryconfigmenuicon} Memory" 4 "${fileeditormenuicon} File Editor" 5 "${networkconfigmenuicon} Network Configuration" 6 "${applicationconfigmenuicon} Application Configuration")
	filesystemmenu=(1 "${drivespacemenuicon} Drive Space" 2 "${mountpointmenuicon} Mount Points" 3 "${raidconfigmenuicon} Raid Configuration" 4 "${usbdrivemenuicon} USB Drive Configuration")
	memorymenu=(1 "${memoryfreemenuicon} Memory Free" 2 "${swapmemorymenuicon} Swap Memory")
	fileeditormenu=(1 "${hostsfilemenuicon} Hosts file" 2 "${hostnamefilemenuicon} Hostname file")
	networkconfigmenu=(1 "${wirelessconfigmenuicon} Wireless Configuration" 2 "${networkitemconfigmenuicon} Network Configuration")
	applicationmenu=(1 "${gitconfigmenuicon} Git Configuration" 2 "${uninstallappmenuicon} Uninstall Applications")
	logsmenu=(1 "${apachelogsmenuicon} Apache Logs" 2 "${phplogsmenuicon} PHP Logs" 3 "${accesslogsmenuicon} Access Logs" 4 "${errorlogsmenuicon} Error Logs" 5 "${installationlogsmenuicon} Installation Logs" 6 "$systemlogsmenuicon System Logs" 7 "${autoconfigmenuicon} ${APPNAME} Logs")
}
############## MAIN MENU LIST
function mainmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Main Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nocancel --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mainmenu[@]}" 2>$tempfile

	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
			case $CHOICE in
				"1") # WebServer
					webservermenu
					;;
				"2") # Database
					databasemenu
					;;
				"3") # Application
					applicationmenu
					;;
				"4") # Email
					emailmenu
					;;
				"5") # File
					filemenu
					;;
				"6") # Message
					messagemenu
					;;
				"7") # Proxy
					proxymenu
					;;
				"8") # System Configuration
					systemconfigmenu
					;;
				"9") # Logs
					systemlogsmenu
					;;
			esac
			;;
		255)
			dialog --backtitle "$SCREENTITLE" --yesno "Would you like to Exit?" 10 30
			case $? in
				0) # If Yes was pressed
					clear
					exit 0
					;;
				1) # No was pressed, so return back to the form
					mainmenu
					;;
			esac
			;;
	esac
}
############## MAIN MENU ITEMS 1-9
function webservermenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Web Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${webservermenu[@]}" 2>$tempfile

	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"
	case $retval in
		0)
			case $CHOICE in
				1) # Apache
					apacheselectmenu
					;;
				2) # nGinX
					nginxselectmenu
					;;
				3) # Lightspeed
					lightspeedselectmenu
					;;
				4) # SSL
					sslselectmenu
					;;
			esac
			;;
		255)
			mainmenu
			;;
	esac
}
function databasemenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Database Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${databaseservermenu[@]}" 2>$tempfile

	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
function applicationmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Application Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${applicationservermenu[@]}" 2>$tempfile

	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
function emailmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Email Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${emailservermenu[@]}" 2>$tempfile

	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
function filemenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="File Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${fileservermenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
function messagemenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Message Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${messageservermenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
			case $CHOICE in
				1)
					echo "Null"
					;;
			esac
			;;
		255)
			mainmenu
			;;
	esac
}
function proxymenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Proxy Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${messageservermenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
			case $CHOICE in
				1)
					echo "Null"
					;;
			esac
			;;
		255)
			mainmenu
			;;
	esac
}
function systemconfigmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="System Configuration Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${systemconfigmenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
function systemlogsmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="System Logs Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${logsmenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
		255)
			mainmenu
			;;
	esac
}
############## WEB SERVER MENU ITEMS 1-4
function apacheselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Apache Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${apachemenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
			case $CHOICE in
				1) # Apache Configuration
					apacheconfigform
					;;
				2) # Apache Restart
					apachectrlform "restart"
					;;
				3) # Apache Start
					apachectrlform "start"
					;;
				4) # Apache Stop
					apachectrlform "stop"
					;;
				5) # Enable/Disable Server
					switchserver "apache"
					apacheselectmenu
					;;
			esac
			;;
		255)
			webservermenu
			;;
	esac
}
function nginxselectmenu() {
	unset title
	unset instructions
	title="nGinX Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${nginxmenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Are you sure you want to quit?" 10 30
				case $? in
					0) # If Yes was pressed
						webservermenu
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
		case $CHOICE in
			1) # nGinxX Configuration
				nginxconfigform
				;;
			2) # nGinxX Restart
				nginxctrlform "restart"
				;;
			3) # nGinxX Start
				nginxctrlform "start"
				;;
			4) # nGinxX Stop
				nginxctrlform "stop"
				;;
			5) # Enable/Disable Server
				switchserver "nginx"
				returncode=99
				;;
		esac
	done
}
function lightspeedselectmenu() {
	unset title
	unset instructions
	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Are you sure you want to quit?" 10 30
				case $? in
					0) # If Yes was pressed
						webservermenu
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
		case $CHOICE in
			1) # Lightspeed Configuration
				lightspeedconfigform
				;;
			2) # Lightspeed Restart
				lightspeedctrlform "restart"
				;;
			3) # Lightspeed Start
				lightspeedctrlform "start"
				;;
			4) # Lightspeed Stop
				lightspeedctrlform "stop"
				;;
			5) # Enable/Disable Server
				switchserver "lightspeed"
				returncode=99
				;;
		esac
	done
}
function sslselectmenu() {
	unset title
	unset instructions
	title="SSL Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${letsencryptmenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Are you sure you want to quit?" 10 30
				case $? in
					0) # If Yes was pressed
						webservermenu
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
		case $CHOICE in
			1) # SSL Configuration
				echo "Let's Encrypt Settings"
				;;
			2) # SSL Renew Cert
				echo "Renew Certification"
				;;
			3) # SSL Revoke Cert
				echo "Revoke Certification"
				;;
		esac
	done
}
############## WEB SERVER APACHE MENU ITEMS 1-5
function apacheconfigform() {
	unset title
	unset instructions
	title="Apache Configuration Settings"
	instructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webserverfailtest" == "true" ]; then
		instructions="$instructions \Zb\Z1INVALID SETTINGS\Zn detected, please correct the following\n\n${webservererror}"
	fi
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		# Store data to $VALUES variable
		VALUES=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --backtitle "$SCREENTITLE" --title "$title" --form "$instructions" 20 55 0 \
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
			"                IP :"	6 1	"$IP"			6 22 27 0 \
		2>&1 1>&3)
		returncode=$?
		exec 3>&-

		# Assign the variables to an array
		webservervars=($VALUES)
		show=`echo "$VALUES" |sed -e 's/^/ /'`
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to Apache Options Menu?" 10 30
				case $? in
					0)
						# If Yes was pressed
						apacheselectmenu
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
									apacheselectmenu
									;;
								255)
									returncode=99
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
						apacheselectmenu
						;;
				esac
				;;
		esac
	done
}
function apachectrlform() {
	action=$1
	# Don't forget to check to see if Apache is even installedappsform
	
	case $action in
		"restart")
			if [ -f /usr/local/apache/bin/apachectl ]; then
				log "Apache restart: /usr/local/apache/bin/apachectl"
				/usr/local/apache/bin/apachectl restart > /dev/null
				apacheselectmenu
			elif [ -f /etc/init.d/apache2 ]; then
				log "Apache restart: /etc/init.d/apache2"
				/etc/init.d/apache2 restart > /dev/null
				apacheselectmenu
			else
				log "Apache restart: service apache2 stop"
				service apache2 restart > /dev/null
				apacheselectmenu
			fi
			;;
		"start")
			if [ -f /usr/local/apache/bin/apachectl ]; then
				log "Apache start: /usr/local/apache/bin/apachectl"
				/usr/local/apache/bin/apachectl start > /dev/null
				apacheselectmenu
			elif [ -f /etc/init.d/apache2 ]; then
				log "Apache start: /etc/init.d/apache2"
				/etc/init.d/apache2 start > /dev/null
				apacheselectmenu
			else
				log "Apache start: service apache2 stop"
				service apache2 start > /dev/null
				apacheselectmenu
			fi
			;;
		"stop")
			if [ -f /usr/local/apache/bin/apachectl ]; then
				log "Apache stop: /usr/local/apache/bin/apachectl"
				/usr/local/apache/bin/apachectl stop > /dev/null
				apacheselectmenu
			elif [ -f /etc/init.d/apache2 ]; then
				log "Apache stop: /etc/init.d/apache2"
				/etc/init.d/apache2 stop > /dev/null
				apacheselectmenu
			else
				log "Apache stop: service apache2 stop"
				service apache2 stop > /dev/null
				apacheselectmenu
			fi
			;;
	esac
}
############## WEB SERVER NGINX MENU ITEMS 1-5
function nginxconfigform() {
	unset title
	unset instructions
	title="nGinX Configuration Settings"
	instructions="Please answer the questions below to configure your nGinX server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webmenufailtest" == "true" ]; then
		instructions="$instructions \Zb\Z1INVALID SETTINGS\Zn detected, please correct the following\n\n${faileditems1}"
	fi
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		# Store data to $VALUES variable
		VALUES=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --backtitle "$SCREENTITLE" --title "$dialogtitle" --menu "$instructions" --form "$dialoginstructions" 20 55 0 \
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
			"                IP :"	6 1	"$IP"			6 22 27 0 \
		2>&1 1>&3)
		returncode=$?
		exec 3>&-

		# Assign the variables to an array
		webservervars=($VALUES)
		show=`echo "$VALUES" |sed -e 's/^/ /'`
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to nGinX Options Menu?" 10 30
				case $? in
					0)
						# If Yes was pressed
						nginxselectmenu
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
function nginxctrlform() {
	action=$1
	# Don't forget to check to see if nGinX is even installedappsform
	
	case $action in
		"restart")
			# Check to see if nGinX is running, then restart
			echo "restart"
			;;
		"start")
			# Check to see if nGinX is not running
			echo "start"
			;;
		"stop")
			# Check to see if nGinX is running
			echo "stop"
			;;
	esac
}
############## WEB SERVER LIGHTSPEED MENU ITEMS 1-5
function lightspeedconfigform() {
	unset title
	unset instructions
	title="Lightspeed Configuration Settings"
	instructions="Please answer the questions below to configure your Lightspeed server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webmenufailtest" == "true" ]; then
		instructions="$instructions \Zb\Z1INVALID SETTINGS\Zn detected, please correct the following\n\n${faileditems1}"
	fi
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		# Store data to $VALUES variable
		VALUES=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --backtitle "$SCREENTITLE" --title "$dialogtitle" --menu "$instructions" --form "$dialoginstructions" 20 55 0 \
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
			"                IP :"	6 1	"$IP"			6 22 27 0 \
		2>&1 1>&3)
		returncode=$?
		exec 3>&-

		# Assign the variables to an array
		webservervars=($VALUES)
		show=`echo "$VALUES" |sed -e 's/^/ /'`
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to Lightspeed Options Menu?" 10 30
				case $? in
					0)
						# If Yes was pressed
						lightspeedselectmenu
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
function lightspeedctrlform() {
	action=$1
	# Don't forget to check to see if Lightspeed is even installedappsform
	
	case $action in
		"restart")
			# Check to see if Lightspeed is running, then restart
			echo "restart"
			;;
		"start")
			# Check to see if Lightspeed is not running
			echo "start"
			;;
		"stop")
			# Check to see if Lightspeed is running
			echo "stop"
			;;
	esac
}
function emailserverform() {
	dialogtitle="Email Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
function databaseserverform(){
	dialogtitle="Database Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
function driveserverform(){
	dialogtitle="File Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
function installedappsform() {
	dialogtitle="Application Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
function servertypemenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	$title="Server Type Configuration"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n\Zn[\Zb\Z1*\Zn/\Z2*\Zn] - Invalid/Valid Settings Detected\n\n"

	ServerTypeMenuOptions=(1 "\Zn[${opt11menuitem}] Web Server" 2 "\Zn[${opt12menuitem}] Database Server" 3 "\Zn[${opt13menuitem}] Application Server" 4 "\Zn[${opt14menuitem}] File Server" 5 "\Zn[${opt15menuitem}] Message Server" 6 "\Zn[${opt16menuitem}] Proxy Server" 7 "\Zn[${opt17menuitem}] Email Server")
	exec 3>&1
	CHOICE=$(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${ServerTypeMenuOptions[@]}" 2>&1 1>&3)
	exit_status=$?

	case $exit_status in
		255) return;;
	esac

	case $CHOICE in
		1) # Web Server
			servertype=$(config "read_value" "webserver")
			case $servertype in
				"apache")
					WebChoices=(1 "Apache" on 2 "nGinX" off 3 "LightSpeed" off 4 "Disable Server" off)
					;;
				"nginx")
					WebChoices=(1 "Apache" off 2 "nGinX" on 3 "LightSpeed" off 4 "Disable Server" off)
					;;
				"lightspeed")
					WebChoices=(1 "Apache" off 2 "nGinX" off 3 "LightSpeed" on 4 "Disable Server" off)
					;;
				"disabled")
					WebChoices=(1 "Apache" off 2 "nGinX" off 3 "LightSpeed" off 4 "Disable Server" on)
					;;
			esac
			cmd=(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --title "$title" --backtitle "$SCREENTITLE" --radiolist "Select a web server" 0 0 0)
			
			choices=$("${cmd[@]}" "${WebChoices[@]}" 2>&1 >/dev/tty)
			for choice in $choices; do
				case $choice in
					1)
						config "write_value" "webserver" "apache"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					2)
						config "write_value" "webserver" "nginx"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					3)
						config "write_value" "webserver" "lightspeed"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					4)
						config "write_value" "webserver" "disabled"
						chkserverconfig
						servertypemenu
						;;
				esac
			done
			;;
		2) # Database Server
			servertype=$(config "read_value" "databaseserver")
			case $servertype in
				"mysql")
					WebChoices=(1 "mySQL" on 2 "MariaDB" off 3 "PostgreSQL" off 4 "Disable Server" off)
					;;
				"mariadb")
					WebChoices=(1 "mySQL" off 2 "MariaDB" on 3 "PostgreSQL" off 4 "Disable Server" off)
					;;
				"postgresql")
					WebChoices=(1 "mySQL" off 2 "MariaDB" off 3 "PostgreSQL" on 4 "Disable Server" off)
					;;
				"disabled")
					WebChoices=(1 "mySQL" off 2 "MariaDB" off 3 "PostgreSQL" off 4 "Disable Server" on)
					;;
			esac
			cmd=(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --title "$title" --backtitle "$SCREENTITLE" --radiolist "Select a database server" 0 0 0)
			
			choices=$("${cmd[@]}" "${WebChoices[@]}" 2>&1 >/dev/tty)
			for choice in $choices; do
				case $choice in
					1)
						config "write_value" "databaseserver" "mysql"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					2)
						config "write_value" "databaseserver" "mariadb"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					3)
						config "write_value" "databaseserver" "postgresql"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					4)
						config "write_value" "databaseserver" "disabled"
						chkserverconfig
						servertypemenu
						;;
				esac
			done
			;;
		3) # Application Server
			servertype=$(config "read_value" "appserver")
			echo $servertype
			case $servertype in
				"php")
					WebChoices=(1 "PHP" on 2 "Java" off 3 "Tomcat" off 4 "Open Source Application" off 5 "Mobile Application" off 6 "Disable Server" off)
					;;
				"java")
					WebChoices=(1 "PHP" off 2 "Java" on 3 "Tomcat" off 4 "Open Source Application" off 5 "Mobile Application" off 6 "Disable Server" off)
					;;
				"tomcat")
					WebChoices=(1 "PHP" off 2 "Java" off 3 "Tomcat" on 4 "Open Source Application" off 5 "Mobile Application" off 6 "Disable Server" off)
					;;
				"osa")
					WebChoices=(1 "PHP" off 2 "Java" off 3 "Tomcat" off 4 "Open Source Application" on 5 "Mobile Application" off 6 "Disable Server" off)
					;;
				"mobile")
					WebChoices=(1 "PHP" off 2 "Java" off 3 "Tomcat" off 4 "Open Source Application" off 5 "Mobile Application" on 6 "Disable Server" off)
					;;
				"disabled")
					WebChoices=(1 "PHP" off 2 "Java" off 3 "Tomcat" off 4 "Open Source Application" off 5 "Mobile Application" off 6 "Disable Server" on)
					;;
			esac
			cmd=(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --title "$title" --backtitle "$SCREENTITLE" --radiolist "Select a application server" 0 0 0)
			
			choices=$("${cmd[@]}" "${WebChoices[@]}" 2>&1 >/dev/tty)
			for choice in $choices; do
				case $choice in
					1)
						config "write_value" "appserver" "php"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					2)
						config "write_value" "appserver" "java"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					3)
						config "write_value" "appserver" "tomcat"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					4)
						config "write_value" "appserver" "osa"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					5)
						config "write_value" "appserver" "mobile"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					6)
						config "write_value" "appserver" "disabled"
						chkserverconfig
						servertypemenu
						;;
				esac
			done
			;;
		4) # FileServer
			servertype=$(config "read_value" "fileserver")
			echo $servertype
			case $servertype in
				"ftp")
					WebChoices=(1 "FTP" on 2 "NFS" off 3 "Samba" off 4 "NAS" off 5 "Boot Image" off 6 "Disable Server" off)
					;;
				"nfs")
					WebChoices=(1 "FTP" off 2 "NFS" on 3 "Samba" off 4 "NAS" off 5 "Boot Image" off 6 "Disable Server" off)
					;;
				"smb")
					WebChoices=(1 "FTP" off 2 "NFS" off 3 "Samba" on 4 "NAS" off 5 "Boot Image" off 6 "Disable Server" off)
					;;
				"nas")
					WebChoices=(1 "FTP" off 2 "NFS" off 3 "Samba" off 4 "NAS" on 5 "Boot Image" off 6 "Disable Server" off)
					;;
				"bootimg")
					WebChoices=(1 "FTP" off 2 "NFS" off 3 "Samba" off 4 "NAS" on 5 "Boot Image" on 6 "Disable Server" off)
					;;
				"disabled")
					WebChoices=(1 "FTP" off 2 "NFS" off 3 "Samba" off 4 "NAS" off 5 "Boot Image" off 6 "Disable Server" on)
					;;
			esac
			cmd=(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --title "$title" --backtitle "$SCREENTITLE" --radiolist "Select a file server" 0 0 0)
			
			choices=$("${cmd[@]}" "${WebChoices[@]}" 2>&1 >/dev/tty)
			for choice in $choices; do
				case $choice in
					1)
						config "write_value" "fileserver" "ftp"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					2)
						config "write_value" "fileserver" "nfs"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					3)
						config "write_value" "fileserver" "smb"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					4)
						config "write_value" "fileserver" "nas"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					5)
						config "write_value" "fileserver" "bootimg"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					6)
						config "write_value" "fileserver" "disabled"
						chkserverconfig
						servertypemenu
						;;
				esac
			done
			;;
		5) # Message Server
			servertype=$(config "read_value" "fileserver")
			echo "Option 5"
			;;
		6) # Proxy Server
			echo "Option 6"
			;;
		7) # Email server
			EmailChoices=(1 "Postfix" "on" 2 "Citadel" "off" 3 "Sendmail" "off" 4 "Exim" "off" 5 "Courier" "off")
			servertype=$(config "read_value" "emailserver")
			echo $servertype
			case $servertype in
				"postfix")
					WebChoices=(1 "Postfix" on 2 "Citadel" off 3 "Sendmail" off 4 "Exim" off 5 "Courier" off 6 "Disable Server" off)
					;;
				"citadel")
					WebChoices=(1 "Postfix" off 2 "Citadel" on 3 "Sendmail" off 4 "Exim" off 5 "Courier" off 6 "Disable Server" off)
					;;
				"sendmail")
					WebChoices=(1 "Postfix" off 2 "Citadel" off 3 "Sendmail" on 4 "Exim" off 5 "Courier" off 6 "Disable Server" off)
					;;
				"exim")
					WebChoices=(1 "Postfix" off 2 "Citadel" off 3 "Sendmail" off 4 "Exim" on 5 "Courier" off 6 "Disable Server" off)
					;;
				"courier")
					WebChoices=(1 "Postfix" off 2 "Citadel" off 3 "Sendmail" off 4 "Exim" off 5 "Courier" off 6 "Disable Server" on)
					;;
				"disabled")
					WebChoices=(1 "Postfix" off 2 "Citadel" off 3 "Sendmail" off 4 "Exim" off 5 "Courier" off 6 "Disable Server" on)
					;;
			esac
			cmd=(dialog --clear --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --title "$title" --backtitle "$SCREENTITLE" --radiolist "Select a email server" 0 0 0)
			
			choices=$("${cmd[@]}" "${WebChoices[@]}" 2>&1 >/dev/tty)
			for choice in $choices; do
				case $choice in
					1)
						config "write_value" "emailserver" "postfix"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					2)
						config "write_value" "emailserver" "citadel"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					3)
						config "write_value" "emailserver" "sendmail"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					4)
						config "write_value" "emailserver" "exim"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					5)
						config "write_value" "emailserver" "courier"
						config "write_value" "servetype" "true"
						servertypemenu
						;;
					6)
						config "write_value" "fileserver" "disabled"
						chkserverconfig
						servertypemenu
						;;
				esac
			done
			;;
	esac
}
function systeminfomenu() {
	dialogtitle="System Information Menu"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
function installationlogsdialog() {
	dialogtitle="Installation Logs"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
