#!/bin/bash
if [ "$SYSTEMKEY" != "3d430f9af713781b92af4a97fc2e6664be7ce8e0" ]; then
	echo "Do not run this file. To run this program use sudo ./install.sh"
	exit 105
fi
############## MENU SYSTEM
mainmenusystem() {
	# Get the updated config file so menu status icons will be displayed correctly
	loadcfg

	webservermenuicon=$([ "$webservermenustatus" == "true" ] && echo "$OKSYMB" || ([ "$webservermenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	apachemenuicon=$([ "$apachemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$apachemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	nginxmenuicon=$([ "$nginxmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$nginxmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	lightspeedmenuicon=$([ "$lightspeedmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$lightspeedmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sslmenuicon=$([ "$sslmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sslmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	databasemenuicon=$([ "$databasemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$databasemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mysqlmenuicon=$([ "$mysqlmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mysqlmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mariadbmenuicon=$([ "$mariadbmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mariadbmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	postgresqlmenuicon=$([ "$postgresqlmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$postgresqlmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	applicationmenuicon=$([ "$applicationmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$applicationmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
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
	emailmenuicon=$([ "$emailmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$emailmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	postfixmenuicon=$([ "$postfixmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$postfixmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	citadelmenuicon=$([ "$citadelmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$citadelmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sendmailmenuicon=$([ "$sendmailmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sendmailmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	eximmenuicon=$([ "$eximmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$eximmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	couriermenuicon=$([ "$couriermenustatus" == "true" ] && echo "$OKSYMB" || ([ "$couriermenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	filemenuicon=$([ "$filemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$filemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	ftpmenuicon=$([ "$ftpmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$ftpmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	nfsmenuicon=$([ "$nfsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$nfsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	sambamenuicon=$([ "$sambamenustatus" == "true" ] && echo "$OKSYMB" || ([ "$sambamenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	messagemenuicon=$([ "$messagemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$messagemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	proxymenuicon=$([ "$proxymenustatus" == "true" ] && echo "$OKSYMB" || ([ "$proxymenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	systemconfigmenuicon=$([ "$systemconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systemconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	systeminfomenuicon=$([ "$systeminfomenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systeminfomenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	filesystemmenuicon=$([ "$filesystemmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$filesystemmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	drivespacemenuicon=$([ "$drivespacemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$drivespacemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	mountpointmenuicon=$([ "$mountpointmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$mountpointmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	raidconfigmenuicon=$([ "$raidconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$raidconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	usbdrivemenuicon=$([ "$usbdrivemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$usbdrivemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	memoryconfigmenuicon=$([ "$memoryconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$memoryconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	memoryfreemenuicon=$([ "$memoryfreemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$memoryfreemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	swapmemorymenuicon=$([ "$swapmemorymenustatus" == "true" ] && echo "$OKSYMB" || ([ "$swapmemorymenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	fileeditormenuicon=$([ "$fileeditormenustatus" == "true" ] && echo "$OKSYMB" || ([ "$fileeditormenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	hostsfilemenuicon=$([ "$hostsfilemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$hostsfilemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	hostnamefilemenuicon=$([ "$hostnamefilemenustatus" == "true" ] && echo "$OKSYMB" || ([ "$hostnamefilemenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	networkconfigmenuicon=$([ "$networkconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$networkconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	wirelessconfigmenuicon=$([ "$wirelessconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$wirelessconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	networkitemconfigmenuicon=$([ "$networkitemconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$networkitemconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	applicationconfigmenuicon=$([ "$applicationconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$applicationconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	gitconfigmenuicon=$([ "$gitconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$gitconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	uninstallappmenuicon=$([ "$uninstallappmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$uninstallappmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	logsmenuicon=$([ "$logsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$logsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	apachelogsmenuicon=$([ "$apachelogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$apachelogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	phplogsmenuicon=$([ "$phplogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$phplogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	accesslogsmenuicon=$([ "$accesslogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$accesslogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	errorlogsmenuicon=$([ "$errorlogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$errorlogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	installationlogsmenuicon=$([ "$installationlogmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$installationlogmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	systemlogsmenuicon=$([ "$systemlogsmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$systemlogsmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))
	autoconfigmenuicon=$([ "$autoconfigmenustatus" == "true" ] && echo "$OKSYMB" || ([ "$autoconfigmenustatus" == "false" ] && echo "$BADSYMB" || echo "$DISABLEDSYMB"))

	mainmenu=(1 "$webservermenuicon Web Server" 2 "$databasemenuicon Database Server" 3 "$applicationmenuicon Application Server" 4 "$emailmenuicon Email Server" 5 "$filemenuicon File Server" 6 "$messagemenuicon Message Server" 7 "$proxymenuicon Proxy Server" 8 "$systemconfigmenuicon System Configuration" 9 "$logsmenuicon Logs")
	webservermenu=(1 "$apachemenuicon Apache" 2 "$nginxmenuicon nGinX" 3 "$lightspeedmenuicon Lightspeed" 4 "$sslmenuicon SSL" 5 "Disable Web Server")
	apachemenu=(1 "Apache Configuration" 2 "Apache Restart" 3 "Apache Start" 4 "Apache Stop")
	nginxmenu=(1 "nGinX Configuration" 2 "nGinX Restart" 3 "nGinX Start" 4 "nGinX Stop")
	lightspeed=(1 "Lightspeed Configuration" 2 "Lightspeed Restart" 3 "Lightspeed Start" 4 "Lightspeed Stop")
	letsencryptmenu=(1 "Let's Encrypt Settings" 2 "Renew Certification" 3 "Revoke Certification")
	databaseservermenu=(1 "mySQL" 2 "MariaDB" 3 "PostgreSQL" 4 "Disable Database Server")
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
	emailservermenu=(1 "Postfix" 2 "Citadel" 3 "Sendmail" 4 "Exim" 5 "Courier" 6 "Disable Email Server")
	postfixmenu=(1 "$postfixmenuicon Postfix Configuration" 2 "Postfix Restart" 3 "Postfix Start" 4 "Postfix Stop")
	citadelmenu=(1 "$citadelmenuicon Citadel Configuration" 2 "Citadel Restart" 3 "Citadel Start" 4 "Citadel Stop")
	sendmailmenu=(1 "$sendmailmenuicon Sendmail Configuration" 2 "Sendmail Restart" 3 "Sendmail Start" 4 "Sendmail Stop")
	eximmenu=(1 "$eximmenuicon Exim Configuration" 2 "Exim Restart" 3 "Exim Start" 4 "Exim Stop")
	couriermenu=(1 "$couriermenuicon Courier Configuration" 2 "Courier Restart" 3 "Courier Start" 4 "Courier Stop")
	fileservermenu=(1 "FTP" 2 "NFS" 3 "Samba" 4 "Disable File Server")
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
############## WEBSERVER CONFIG FORMS
apacheconfigform() {
	dialogtitle="Server Settings"
	dialoginstructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webmenufailtest" == "true" ]; then
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
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
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
nginxconfigform() {
	dialogtitle="Server Settings"
	dialoginstructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webmenufailtest" == "true" ]; then
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
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
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
lightspeedconfigform() {
	dialogtitle="Server Settings"
	dialoginstructions="Please answer the questions below to configure your Apache server to your specific needs. Some defaults are assumed from the system configuration."
	if [ "$webmenufailtest" == "true" ]; then
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
			"       Domain Name :"	1 1	"$FQDN"			1 22 27 0 \
			"         User Name :"	2 1	"$SERVERUSER"	2 22 27 0 \
			"Public HTML folder :"	3 1	"$WEBSERVERDIR"	3 22 27 0 \
			"             Email :"	4 1	"$EMAIL"		4 22 27 0 \
			"    File ownership :"  5 1 "$OWNERGROUP"	5 22 27 0 \
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
	# Place the loadcfg and checkcfg here so it is rechecked on each menu load
	loadcfg
	checkcfg

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
