#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi

############## MENU SYSTEM
function menusystem() {
	# Get the updated config file so menu status icons will be displayed correctly
	loadcfg
	varreset

	# Domain name must be valid for all web servers
	host "${FQDN}" 2>&1 > /dev/null
	if [ $? -eq 0 ]; then
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="true"
			nginxmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="true"
			lightspeedmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="true"
			cherokeemenustatus="true"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="true"
			caddymenustatus="true"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="true"
			monkeymenustatus="true"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="true"
			hiawathamenustatus="true"
		fi
    else
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="false"
			apachemenustatus="false"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="false"
			nginxmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="false"
			lightspeedmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="false"
			cherokeemenustatus="false"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="false"
			caddymenustatus="false"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="false"
			monkeymenustatus="false"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="false"
			hiawathamenustatus="false"
		fi
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Domain Name\Zn - cannot be resolved\n"
    fi

	# Web folder must be valid
	if [ -d $WEBSERVERDIR ]; then
		# Directory exist
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="true"
			nginxmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="true"
			lightspeedmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="true"
			cherokeemenustatus="true"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="true"
			caddymenustatus="true"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="true"
			monkeymenustatus="true"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="true"
			hiawathamenustatus="true"
		fi
	else
		# Directory does not exist
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="false"
			apachemenustatus="false"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="false"
			nginxmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="false"
			lightspeedmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="false"
			cherokeemenustatus="false"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="false"
			caddymenustatus="false"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="false"
			monkeymenustatus="false"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="false"
			hiawathamenustatus="false"
		fi
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1Public HTML folder\Zn - Does not exist\n"
	fi

	# Web user must exist
	getent passwd "${SERVERUSER}" > /dev/null
	if [ $? -eq 0 ]; then
		# The user exist
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="true"
			nginxmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="true"
			lightspeedmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="true"
			cherokeemenustatus="true"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="true"
			caddymenustatus="true"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="true"
			monkeymenustatus="true"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="true"
			hiawathamenustatus="true"
		fi
	else
		# User does not exist
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="false"
			apachemenustatus="false"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="false"
			nginxmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="false"
			lightspeedmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="false"
			cherokeemenustatus="false"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="false"
			caddymenustatus="false"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="false"
			monkeymenustatus="false"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="false"
			hiawathamenustatus="false"
		fi
		webserverfailtest="true"
		webservererror="${webservererror} \Zb\Z1User ${SERVERUSER}\Zn - Does not exist\n"
	fi

	# Web folder must have correct permissions
	if [ -n "$(find "${WEBSERVERDIR}" -maxdepth 0 -user "${OWNERGROUP}")" ]; then
		# Ownership is correct
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="true"
			apachemenustatus="true"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="true"
			nginxmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="true"
			lightspeedmenustatus="true"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="true"
			cherokeemenustatus="true"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="true"
			caddymenustatus="true"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="true"
			monkeymenustatus="true"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="true"
			hiawathamenustatus="true"
		fi
	else
		# Ownership is incorrect
		if [ "${apachestatus}" != "disabled" ]; then 
			apachestatus="false"
			apachemenustatus="false"
		fi
		if [ "${nginxstatus}" != "disabled" ]; then 
			nginxstatus="false"
			nginxmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="false"
			lightspeedmenustatus="false"
		fi
		if [ "${lightspeedstatus}" != "disabled" ]; then
			cherokeestatus="false"
			cherokeemenustatus="false"
		fi
		if [ "${caddystatus}" != "disabled" ]; then
			caddystatus="false"
			caddymenustatus="false"
		fi
		if [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="false"
			monkeymenustatus="false"
		fi
		if [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="false"
			hiawathamenustatus="false"
		fi
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
		webserverfailtest="true"
		# If Apache is disabled, we don't care if it is installed or not
		if [ "${apachestatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1Apache Server\Zn - Has not been installed\n"
			apachestatus="false"
			apachemenustatus="false"
		fi
	fi

	# nGinX must be installed
	if haveprog "nginx"; then
		if [ "${nginxstatus}" != "false" ] || [ "${nginxstatus}" != "disabled" ]; then
			nginxstatus="true"
			nginxmenustatus="true"
		fi
	else
		webserverfailtest="true"
		# If nGinX is disabled, we don't care if it is installed or not
		if [ "${nginxstatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1nGinX Server\Zn - Has not been installed\n"
			nginxstatus="false"
			nginxmenustatus="false"
		fi
	fi

	# LightTPD must be installed
	if haveprog "lighttpd"; then
		if [ "${lightspeedstatus}" != "false" ] || [ "${lightspeedstatus}" != "disabled" ]; then
			lightspeedstatus="true"
			lightspeedmenustatus="true"
		fi
	else
		webserverfailtest="true"
		# If LightTPD is disabled, we don't care if it is installed or not
		if [ "${lightspeedstatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1LightTPD Server\Zn - Has not been installed\n"
			lightspeedstatus="false"
			lightspeedmenustatus="false"
		fi
	fi

	# Cherokee must be installed
	if haveprog "cherokee"; then
		if [ "${cherokeestatus}" != "false" ] || [ "${cherokeestatus}" != "disabled" ]; then
			cherokeestatus="true"
			cherokeemenustatus="true"
		fi
	else
		webserverfailtest="true"
		# If Cherokee is disabled, we don't care if it is installed or not
		if [ "${cherokeestatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1Cherokee Server\Zn - Has not been installed\n"
			cherokeestatus="false"
			cherokeemenustatus="false"
		fi
	fi

	# Caddy must be installed
	if haveprog "caddy"; then
		if [ "${caddystatus}" != "false" ] || [ "${caddystatus}" != "disabled" ]; then
			caddystatus="true"
			caddymenustatus="true"
		fi
	else
		webserverfailtest="true"
		# If Caddy is disabled, we don't care if it is installed or not
		if [ "${caddystatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1Caddy Server\Zn - Has not been installed\n"
			caddystatus="false"
			caddymenustatus="false"
		fi
	fi

	# Monkey must be installed
	if haveprog "monkey"; then
		if [ "${monkeystatus}" != "false" ] || [ "${monkeystatus}" != "disabled" ]; then
			monkeystatus="true"
			monkeymenustatus="true"
		fi
	else
		webserverfailtest="true"
		# If Monkey is disabled, we don't care if it is installed or not
		if [ "${monkeystatus}" != "disabled" ]; then
			webservererror="${webservererror} \Zb\Z1Monkey HTTP Server\Zn - Has not been installed\n"
			monkeystatus="false"
			monkeymenustatus="false"
		fi
	fi

	# Hiawatha must be installed
	if haveprog "hiawatha"; then
		if [ "${hiawathastatus}" != "false" ] || [ "${hiawathastatus}" != "disabled" ]; then
			hiawathastatus="true"
			hiawathamenustatus="true"
		fi
	else
		# If Hiawatha is disabled, we don't care if it is installed or not
		webserverfailtest="true"
		echo $hiawathastatus
		if [ "${hiawathastatus}" != "disabled" ]; then
			zzz="Shouldn't exist"
			webservererror="${webservererror} \Zb\Z1Hiawatha Server\Zn - Has not been installed\n"
			hiawathastatus="false"
			hiawathamenustatus="false"
		fi
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

	if [ "${apachestatus}" == "diasbled" ] && [ "${nginxstatus}" == "disabled" ] && [ "${lightspeedstatus}" == "disabled" ] && [ "${cherokeestatus}" == "disabled" ] && [ "${caddystatus}" == "disabled" ] && [ "${monkeystatus}" == "disabled" ] && [ "${hiawathastatus}" == "disabled" ]; then
		webservermenuicon="${DISABLEDSYMB}"
	else
		webservermenuicon="${OKSYMB}"
	fi

	if [ "${apachestatus}" == "false" ] || [ "${nginxstatus}" == "false" ] || [ "${lightspeedstatus}" == "false" ] || [ "${cherokeestatus}" == "false" ] || [ "${caddystatus}" == "false" ] || [ "${monkeystatus}" == "false" ] || [ "${hiawathastatus}" == "false" ]; then
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
			webservermenuicon="${OKSYMB}"
		else
			apacherestartmenuicon="${OKSYMB}"
			apachestartmenuicon="${OKSYMB}"
			apachestopmenuicon="${BADSYMB}"
			webservermenuicon="${BADSYMB}"
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
	elif [ "${apachestatus}" == "disabled" ] && [ "${nginxstatus}" == "disabled" ] && [ "${lightspeedstatus}" == "disabled" ] && [ "${cherokeestatus}" == "disabled" ] && [ "${caddystatus}" == "disabled" ] && [ "${monkeystatus}" == "disabled" ] && [ "${hiawathastatus}" == "disabled" ]; then
		webservermenuicon="${DISABLEDSYMB}"
	fi

#	apachestatus="$([ "${WEBSERVERTYPE}" == "apache" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	nginxstatus="$([ "${WEBSERVERTYPE}" == "nginx" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	lightspeedstatus="$([ "${WEBSERVERTYPE}" == "lightspeed" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	cherokeestatus="$([ "${WEBSERVERTYPE}" == "cherokee" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	caddystatus="$([ "${WEBSERVERTYPE}" == "caddy" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	monkeystatus="$([ "${WEBSERVERTYPE}" == "monkey" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	hiawathastatus="$([ "${WEBSERVERTYPE}" == "hiawatha" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")"
#	sslmenuicon="$([ "${sslmenustatus}" == "true" ] && echo "${OKSYMB}" || ([ "${sslmenustatus}" == "false" ] && echo "${BADSYMB}" || echo "${DISABLEDSYMB}"))"

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

	( set -o posix ; set ) >logs/variables.log
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
					quitscript
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
					mysqlselectmenu
					;;
				2) # MariaDB
					mariadbselectmenu
					;;
				3) # PostgreSQL
					postgresqlselectmenu
					;;
				4) # SQLite
					sqliteselectmenu
					;;
				5) # Pervasive
					pervasiveselectmenu
					;;
				6) # VoltDB
					voltdbselectmenu
					;;
				7) # GigaBASE
					gigabaseselectmenu
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
					phpselectmenu
					;;
				2) # Java
					javaselectmenu
					;;
				3) # Ruby
					rubyselectmenu
					;;
				4) # Perl
					perlselectmenu
					;;
				5) # Python
					pythonselectmenu
					;;
				6) # BBS Applications
					bbsappselectmenu
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
					postfixselectmenu
					;;
				2) # Citadel
					citadelselectmenu
					;;
				3) # Sendmail
					sendmailselectmenu
					;;
				4) # Exim
					eximselectmenu
					;;
				5) # Courier
					courierselectmenu
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
					ftpselectmenu
					;;
				2) # NSF
					nsfselectmenu
					;;
				3) # Samba
					sambaselectmenu
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
		0) # Under Construction
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
		0) # Under Construction
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
					systeminfoselectmenu
					;;
				2) # File System
					filesystemselectmenu
					;;
				3) # Memory
					memoryselectmenu
					;;
				4) # File Editor
					fileeditorselectmenu
					;;
				5) # Network Configuration
					networkselectmenu
					;;
				6) # Application Configuration
					applicationselectmenu
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
					apachelogsdialog
					;;
				2) # PHP Logs
					phplogsdialog
					;;
				3) # Access Logs
					accesslogsdialog
					;;
				4) # Error Logs
					errorlogsdialog
					;;
				5) # Installation Logs
					installationlogsdialog
					;;
			esac
			;;
		255)
			mainmenu
			;;
	esac
}
############## WEB SERVER MENU ITEMS 1-8
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
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="nGinX Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${nginxmenu[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
}
function lightspeedselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
}
function cherokeeselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
}
function caddyselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
}
function monkeyselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
}
function hiawathaselectmenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Lightspeed Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	: ${DIALOG=dialog}
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15
	log "${title} menu called"

	$DIALOG --colors --nook --nocancel --hline "ESC to return to Main Menu" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${lightspeed[@]}" 2>$tempfile
	retval=$?
	CHOICE=`cat $tempfile`
	log "${CHOICE} from ${title}"

	case $retval in
		0)
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
			;;
		255)
			webservermenu
			;;
	esac
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
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	menusystem

	title="Apache Configuration Settings"
	instructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webserverfailtest" == "true" ]; then
		instructions="$instructions \Zb\Z1INVALID SETTINGS\Zn detected, please correct the following\n\n${webservererror}"
	fi

	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load

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
				dialog --backtitle "$SCREENTITLE" --yesno "If you leave, your values will be lost, would you like to return to Apache Options Menu?" 10 30
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

						# Test the number of fields to make sure there are no empty values
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
						varreset
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
############## WEB SERVER LIGHTTPD MENU ITEMS 1-5
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
############## WEB SERVER CHEROKEE MENU ITEMS 1-5
function cherokeeconfigform() {
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
function cherokeectrlform() {
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
############## WEB SERVER CADDY MENU ITEMS 1-5
function caddyconfigform() {
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
function caddyctrlform() {
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
############## WEB SERVER MONKEY MENU ITEMS 1-5
function monkeyconfigform() {
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
function monkeyctrlform() {
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
############## WEB SERVER HIAWATHA MENU ITEMS 1-5
function hiawathaconfigform() {
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
function hiawathactrlform() {
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
############## DATABASE SERVER MENU ITEMS 1-7
function mysqlselectmenu() {
	databasemenu
}
function mariadbselectmenu () {
	databasemenu
}
function postgresqlselectmenu() {
	databasemenu
}
function sqliteselectmenu() {
	databasemenu
}
function pervasiveselectmenu() {
	databasemenu
}
function voltdbselectmenu() {
	databasemenu
}
function gigabaseselectmenu() {
	databasemenu
}
############## APPLICATION SERVER MENU
function phpselectmenu() {
	applicationmenu
}
function javaselectmenu() {
	applicationmenu
}
function rubyselectmenu() {
	applicationmenu
}
function perlselectmenu() {
	applicationmenu
}
function pythonselectmenu() {
	applicationmenu
}
function bbsappselectmenu() {
	applicationmenu
}
############## EMAIL SERVER MENU
function postfixselectmenu() {
	emailmenu
}
function citadelselectmenu() {
	emailmenu
}
function sendmailselectmenu() {
	emailmenu
}
function eximselectmenu() {
	emailmenu
}
function courierselectmenu() {
	emailmenu
}
############## FILE SERVER MENU
function ftpselectmenu() {
	filemenu
}
function nsfselectmenu() {
	filemenu
}
function sambaselectmenu() {
	filemenu
}
############## SYSTEM CONFIGURATION MENU
function systeminfoselectmenu() {
	systemconfigmenu
}
function filesystemselectmenu() {
	systemconfigmenu
}
function memoryselectmenu() {
	systemconfigmenu
}
function fileeditorselectmenu() {
	systemconfigmenu
}
function networkselectmenu() {
	systemconfigmenu
}
function applicationselectmenu() {
	systemconfigmenu
}
############## LOGS MENU
function apachelogsdialog() {
	systemlogsmenu
}
function phplogsdialog() {
	systemlogsmenu
}
function accesslogsdialog() {
	systemlogsmenu
}
function errorlogsdialog() {
	systemlogsmenu
}
function installationlogsdialog() {
	systemlogsmenu
}
