#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi
############## MENU SYSTEM
mainmenusystem() {
	# Get the updated config file so menu status icons will be displayed correctly
	loadcfg
	###################################################################
	# Menu icon status symbols
	###################################################################
	# Main Menu Items
	webservermenuicon=$([ "$webservermenustatus" == "true" ] && echo "$OKSYMB" || ([ "$webservermenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	databasemenuicon=$([ "$databasemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$databasemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	applicationmenuicon=$([ "$applicationmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$applicationmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	emailmenuicon=$([ "$emailmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$emailmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	filemenuicon=$([ "$filemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$filemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	messagemenuicon=$([ "$messagemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$messagemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	proxymenuicon=$([ "$proxymenustatus" == "true" ] && echo "$OKSYMB" || ([ "$proxymenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	systemconfigmenuicon=$([ "$systemconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systemconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	logsmenuicon=$([ "$logsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$logsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# Web Server Menu Items
	apachemenuicon=$([ "$apachemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$apachemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	nginxmenuicon=$([ "$nginxmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$nginxmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	lightspeedmenuicon=$([ "$lightspeedmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$lightspeedmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sslmenuicon=$([ "$sslmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sslmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	# Apache Server Menu Items

	# nGinX Server Menu Items
	
	# Lightspeed Server Menu Items
	
	# SSL Menu Items
	###################################################################
	# Database Server Menu Items
	mysqlmenuicon=$([ "$mysqlmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mysqlmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mariadbmenuicon=$([ "$mariadbmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mariadbmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	postgresqlmenuicon=$([ "$postgresqlmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$postgresqlmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	
	# MySQL Database Menu Items
	
	# MariaDB Database Menu Items
	
	# PostgreSQL Database Menu Items
	###################################################################
	# Application Server Menu Items
	phpmenuicon=$([ "$phpmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$phpmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	javamenuicon=$([ "$javamenustatus" == "true" ] && echo "$OKSYMB" || ([ "$javamenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	tomcatmenuicon=$([ "$tomcatmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$tomcatmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	osamenuicon=$([ "$osamenustatus" == "true" ] && echo "$OKSYMB" || ([ "$osamenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mobilemenuicon=$([ "$mobilemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mobilemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	phpappmenuicon=$([ "$phpappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$phpappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	javaappmenuicon=$([ "$javaappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$javaappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	tomcatappmenuicon=$([ "$tomcatappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$tomcatappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	osaappmenuicon=$([ "$osaappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$osaappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mobileappmenuicon=$([ "$mobileappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mobileappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	bbsappmenuicon=$([ "$bbsappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$bbsappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	# PHP Application Menu Items

	# Java Application Menu Items
	
	# Tomcat Application Menu Items
	
	# Open Source Application Menu Items
	
	# Mobile Application Menu Items
	
	# BBS Application Menu Items
	###################################################################
	# Email Server Menu Items
	postfixmenuicon=$([ "$postfixmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$postfixmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	citadelmenuicon=$([ "$citadelmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$citadelmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sendmailmenuicon=$([ "$sendmailmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sendmailmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	eximmenuicon=$([ "$eximmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$eximmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	couriermenuicon=$([ "$couriermenustatus" == "true" ] && echo "$OKSYMB" || ([ "$couriermenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	# Postfix Email Menu Items
	
	# Citadel Email Menu Items
	
	# Sendmail Email Menu Items
	
	# Courier Email Menu Items
	###################################################################
	# File Server Menu Items
	ftpmenuicon=$([ "$ftpmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$ftpmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	nfsmenuicon=$([ "$nfsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$nfsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sambamenuicon=$([ "$sambamenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sambamenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	# FTP Menu Items
	
	# NFS Menu Items
	
	# Samba Menu Items
	###################################################################
	# Message Server Menu Items
	###################################################################
	# Proxy Server Menu Items
	###################################################################
	# System Configuration Menu Items
	systeminfomenuicon=$([ "$systeminfomenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systeminfomenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	filesystemmenuicon=$([ "$filesystemmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$filesystemmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	###################################################################
	# System Information Menu Items
	###################################################################
	# File System Information Menu Items
	drivespacemenuicon=$([ "$drivespacemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$drivespacemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mountpointmenuicon=$([ "$mountpointmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mountpointmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	raidconfigmenuicon=$([ "$raidconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$raidconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	usbdrivemenuicon=$([ "$usbdrivemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$usbdrivemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# Memory System Information Menu Items
	memoryconfigmenuicon=$([ "$memoryconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$memoryconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	memoryfreemenuicon=$([ "$memoryfreemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$memoryfreemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	swapmemorymenuicon=$([ "$swapmemorymenustatus" == "true" ] && echo "$OKSYMB" || ([ "$swapmemorymenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# File Editor Menu Items
	fileeditormenuicon=$([ "$fileeditormenustatus" == "true" ] && echo "$OKSYMB" || ([ "$fileeditormenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	hostsfilemenuicon=$([ "$hostsfilemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$hostsfilemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	hostnamefilemenuicon=$([ "$hostnamefilemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$hostnamefilemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# Network Configuration Menu Items
	networkconfigmenuicon=$([ "$networkconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$networkconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	wirelessconfigmenuicon=$([ "$wirelessconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$wirelessconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	networkitemconfigmenuicon=$([ "$networkitemconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$networkitemconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# Application Configuration Menu Items
	applicationconfigmenuicon=$([ "$applicationconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$applicationconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	gitconfigmenuicon=$([ "$gitconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$gitconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	uninstallappmenuicon=$([ "$uninstallappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$uninstallappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################
	# Logs Information Menu Items
	###################################################################
	apachelogsmenuicon=$([ "$apachelogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$apachelogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	phplogsmenuicon=$([ "$phplogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$phplogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	accesslogsmenuicon=$([ "$accesslogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$accesslogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	errorlogsmenuicon=$([ "$errorlogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$errorlogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	installationlogsmenuicon=$([ "$installationlogmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$installationlogmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	systemlogsmenuicon=$([ "$systemlogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systemlogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	autoconfigmenuicon=$([ "$autoconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$autoconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	###################################################################


	# Server enable/disable status items
	apachestatus=$([ "$WEBSERVERTYPE" == "apache" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")
	nginxstatus=$([ "$WEBSERVERTYPE" == "nginx" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")
	lightspeedstatus=$([ "$WEBSERVERTYPE" == "lightspeed" ] && echo "\Z3Disable Server\Zn" || echo "\Z2Enable Server\Zn")

	mainmenu=(1 "$webservermenuicon Web Server" 2 "$databasemenuicon Database Server" 3 "$applicationmenuicon Application Server" 4 "$emailmenuicon Email Server" 5 "$filemenuicon File Server" 6 "$messagemenuicon Message Server" 7 "$proxymenuicon Proxy Server" 8 "$systemconfigmenuicon System Configuration" 9 "$logsmenuicon Logs")
	webservermenu=(1 "$apachemenuicon Apache" 2 "$nginxmenuicon nGinX" 3 "$lightspeedmenuicon Lightspeed" 4 "$sslmenuicon SSL")
	apachemenu=(1 "Apache Configuration" 2 "Apache Restart" 3 "Apache Start" 4 "Apache Stop" 5 "$apachestatus")
	nginxmenu=(1 "nGinX Configuration" 2 "nGinX Restart" 3 "nGinX Start" 4 "nGinX Stop" 5 "$nginxstatus")
	lightspeed=(1 "Lightspeed Configuration" 2 "Lightspeed Restart" 3 "Lightspeed Start" 4 "Lightspeed Stop" 5 "$lightspeedstatus")
	letsencryptmenu=(1 "Let's Encrypt Settings" 2 "Renew Certification" 3 "Revoke Certification")
	databaseservermenu=(1 "mySQL" 2 "MariaDB" 3 "PostgreSQL")
	mysqlmenu=(1 "$mysqlmenuicon mySQL Configuration" 2 "mySQL Restart" 3 "mySQL Start" 4 "mySQL Stop")
	mariadbsqlmenu=(1 "$mariadbmenuicon MariaDB Configuration" 2 "MariaDB Restart" 3 "MariaDB Start" 4 "MariaDB Stop")
	postgresqlmenu=(1 "$postgresqlmenuicon PostgreSQL Configuration" 2 "PostgreSQL Restart" 3 "PostgreSQL Start" 4 "PostgreSQL Stop")
	applicationservermenu=(1 "$phpappmenuicon PHP" 2 "$javaappmenuicon Java" 3 "$tomcatappmenuicon Tomcat" 4 "$osaappmenuicon Open Source" 5 "$mobileappmenuicon Mobile Application" 6 "$bbsappmenuicon BBS Applications")
	phpmenu=(1 "$phpmenuicon PHP Configuration" 2 "PHP Restart" 3 "PHP Start" 4 "PHP Stop")
	javamenu=(1 "$javamenuicon Java Configuration" 2 "Java Restart" 3 "Java Start" 4 "Java Stop")
	tomcatmenu=(1 "$tomcatmenuicon Tomcat Configuration" 2 "Tomcat Restart" 3 "Tomcat Start" 4 "Tomcat Stop")
	opensourcemenu=(1 "$osamenuicon Open Source Configuration" 2 "Open Source Restart" 3 "Open Source Start" 4 "Open Source Stop")
	mobilemenu=(1 "$mobilemenuicon Mobile App Configuration" 2 "Mobile App Restart" 3 "Mobile App Start" 4 "Mobile App Stop")
	bbsappsmenu=(1 "Mystic" 2 "WWIV")
	mysticmenu=(1 "Mystic Configuration" 2 "Mystic Local Mode")
	wwivmenu=(1 "WWIV Configuration" 2 "WWIV Local Mode")
	emailservermenu=(1 "Postfix" 2 "Citadel" 3 "Sendmail" 4 "Exim" 5 "Courier")
	postfixmenu=(1 "$postfixmenuicon Postfix Configuration" 2 "Postfix Restart" 3 "Postfix Start" 4 "Postfix Stop")
	citadelmenu=(1 "$citadelmenuicon Citadel Configuration" 2 "Citadel Restart" 3 "Citadel Start" 4 "Citadel Stop")
	sendmailmenu=(1 "$sendmailmenuicon Sendmail Configuration" 2 "Sendmail Restart" 3 "Sendmail Start" 4 "Sendmail Stop")
	eximmenu=(1 "$eximmenuicon Exim Configuration" 2 "Exim Restart" 3 "Exim Start" 4 "Exim Stop")
	couriermenu=(1 "$couriermenuicon Courier Configuration" 2 "Courier Restart" 3 "Courier Start" 4 "Courier Stop")
	fileservermenu=(1 "FTP" 2 "NFS" 3 "Samba")
	ftpmenu=(1 "$ftpmenuicon FTP Configuration" 2 "FTP Restart" 3 "FTP Start" 4 "FTP Stop")
	nfsmenu=(1 "$nfsmenuicon NFS Configuration" 2 "NFS Restart" 3 "NFS Start" 4 "NFS Stop")
	sambamenu=(1 "$sambamenuicon Samba Configuration" 2 "Samba Restart" 3 "Samba Start" 4 "Samba Stop")
	messageservermenu=(1 "Not set up" 2 "Not set up" 3 "Not set up")
	proxyservermenu=(1 "Not set up" 2 "Not set up" 3 "Not set up")
	systemconfigmenu=(1 "$systeminfomenuicon System Information" 2 "$filesystemmenuicon File System" 3 "$memoryconfigmenuicon Memory" 4 "$fileeditormenuicon File Editor" 5 "$networkconfigmenuicon Network Configuration" 6 "$applicationconfigmenuicon Application Configuration")
	filesystemmenu=(1 "$drivespacemenuicon Drive Space" 2 "$mountpointmenuicon Mount Points" 3 "$raidconfigmenuicon Raid Configuration" 4 "$usbdrivemenuicon USB Drive Configuration")
	memorymenu=(1 "$memoryfreemenuicon Memory Free" 2 "$swapmemorymenuicon Swap Memory")
	fileeditormenu=(1 "$hostsfilemenuicon Hosts file" 2 "$hostnamefilemenuicon Hostname file")
	networkconfigmenu=(1 "$wirelessconfigmenuicon Wireless Configuration" 2 "$networkitemconfigmenuicon Network Configuration")
	applicationmenu=(1 "$gitconfigmenuicon Git Configuration" 2 "$uninstallappmenuicon Uninstall Applications")
	logsmenu=(1 "$apachelogsmenuicon Apache Logs" 2 "$phplogsmenuicon PHP Logs" 3 "$accesslogsmenuicon Access Logs" 4 "$errorlogsmenuicon Error Logs" 5 "$installationlogsmenuicon Installation Logs" 6 "$systemlogsmenuicon System Logs" 7 "$autoconfigmenuicon $APPNAME Logs")
}
############## MENU SYSTEMS
switchserver() {
	case "$1" in
		"apache")
			if [ $SERVETYPE == "false" ] || [ $SERVETYPE == "disabled" ]; then
				config "write_value" "webserver" "apache"
				config "write_value" "servetype" "true"
			elif [ $SERVETYPE == "true" ] && [ $WEBSERVERTYPE != "apache" ]; then
				config "write_value" "webserver" "apache"
			else
				if [ $WEBSERVERTYPE == "apache" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			loadcfg
			mainmenusystem
			;;
		"nginx")
			if [ $SERVETYPE == "false" ] || [ $SERVETYPE == "disabled" ]; then
				config "write_value" "webserver" "nginx"
				config "write_value" "servetype" "true"
			elif [ $SERVETYPE == "true" ] && [ $WEBSERVERTYPE != "nginx" ]; then
				config "write_value" "webserver" "nginx"
			else
				if [ $WEBSERVERTYPE == "nginx" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			loadcfg
			mainmenusystem
			;;
		"lightspeed")
			# If the server type is false, then activate it
			if [ $SERVETYPE == "false" ] || [ $SERVETYPE == "disabled" ]; then
				config "write_value" "webserver" "lightspeed"
				config "write_value" "servetype" "true"
			# If the server is true and it has a different web server type, then change it
			elif [ $SERVETYPE == "true" ] && [ $WEBSERVERTYPE != "lightspeed" ]; then
				config "write_value" "webserver" "lightspeed"
			else
				if [ $WEBSERVERTYPE == "lightspeed" ]; then
					config "write_value" "webserver" "disabled"
				fi
				config "write_value" "servetype" "disabled"
			fi
			loadcfg
			mainmenusystem
			;;
	esac
}
main() {
	unset title
	unset instructions
	title="Main Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --cancel-label "Exit Configuration" --nook --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${mainmenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Are you sure you want to quit?" 10 30
				case $? in
					0) # If Yes was pressed
						clear
						exit 0
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
		case $CHOICE in
			1) # WebServer
				webservermenu
				;;
			2) # Database
				databasemenu
				;;
			3) # Application
				applicationmenu
				;;
			4) # Email
				emailmenu
				;;
			5) # File
				filemenu
				;;
			6) # Message
				messagemenu
				;;
			7) # Proxy
				proxymenu
				;;
			8) # System Configuration
				systemconfigmenu
				;;
			9) # Logs
				systemlogsmenu
				;;
		esac
	done
}
webservermenu() {
	unset title
	unset instructions
	title="Web Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${webservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the Main Menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
			5) # Disable Web Server
				echo "Disable Web Server"
				;;
		esac
	done
}
databasemenu() {
	unset title
	unset instructions
	title="Database Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${databaseservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
applicationmenu() {
	unset title
	unset instructions
	title="Application Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${applicationservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
emailmenu() {
	unset title
	unset instructions
	title="Email Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${emailservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
filemenu() {
	unset title
	unset instructions
	title="File Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${fileservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
messagemenu() {
	unset title
	unset instructions
	title="Message Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${messageservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
	done
}
proxymenu() {
	unset title
	unset instructions
	title="Proxy Server Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${proxyservermenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
	done
}
systemconfigmenu() {
	unset title
	unset instructions
	title="System Configuration Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} Dialog Form called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${systemconfigmenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
systemlogsmenu() {
	unset title
	title="System Logs Menu"
	log "${title} Dialog Form called"
	returncode=0

	while test $returncode != 1 && test $returncode != 250; do
		# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
		loadcfg
		mainmenusystem
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${logsmenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the main menu?" 10 30
				case $? in
					0) # If Yes was pressed
						main
						;;
					1) # No was pressed, so return back to the form
						returncode=99
						;;
				esac
				;;
		esac
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
	done
}
############## WEBSERVER CONFIG FORMS
apacheselectmenu() {
	unset title
	unset instructions
	title="Apache Options Menu"
	instructions="Use the arrow keys or press the number to choose one of the following options, press ESC to exit:\n\n[${OKSYMB}] - \Z2Valid \Znsettings\n[${BADSYMB}] - \Zb\Z1Invalid \Znsettings\n[${DISABLEDSYMB}] - \Z3Disabled\Zn settings\n"
	returncode=0
	log "${title} menu called"
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem
	while test $returncode != 1 && test $returncode != 250; do
		# Redirect stream 3 to the stream 1 (STDOUT)
		exec 3>&1
		CHOICE=$(dialog --colors --ok-label "$OKLABEL" --cancel-label "$CANCELLABEL" --hline "$CREDITS" --backtitle "$SCREENTITLE" --title "$title" --menu "$instructions" $HEIGHT $WIDTH $CHOICE_HEIGHT "${apachemenu[@]}" 2>&1 1>&3)
		returncode=$?
		exec 3>&-
		case $returncode in
			1|255) # If back or ESC was pressed
				dialog --backtitle "$SCREENTITLE" --yesno "Return to the Web Server Menu?" 10 30
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
				returncode=99
				;;
		esac
	done
}
nginxselectmenu() {
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
lightspeedselectmenu() {
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
sslselectmenu() {
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
############## WEBSERVER CONFIG FORMS
apacheconfigform() {
	unset title
	unset instructions
	title="Apache Configuration Settings"
	instructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
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
nginxconfigform() {
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
lightspeedconfigform() {
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
############## WEBSERVER CONTROL DIALOGS
apachectrlform() {
	action=$1
	# Don't forget to check to see if Apache is even installedappsform
	
	case $action in
		"restart")
			# Check to see if Apache is running, then restart
			echo "restart"
			;;
		"start")
			# Check to see if Apache is not running
			echo "start"
			;;
		"stop")
			# Check to see if Apache is running
			echo "stop"
			;;
	esac
}
nginxctrlform() {
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
lightspeedctrlform() {
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
emailserverform() {
	dialogtitle="Email Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
databaseserverform(){
	dialogtitle="Database Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
driveserverform(){
	dialogtitle="File Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
installedappsform() {
	dialogtitle="Application Server Settings"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
servertypemenu() {
	# Place the loadcfg and mainmenusystem here so it is rechecked on each menu load
	loadcfg
	mainmenusystem

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
systeminfomenu() {
	dialogtitle="System Information Menu"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
installationlogsdialog() {
	dialogtitle="Installation Logs"
	dialoginstructions="Please answer the questions below to configure your web server to your specific needs. Some defaults are assumed from system variables."
	log "${dialogtitle} Dialog Form called"
	returncode=0
}
