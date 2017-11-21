# RasPi-3 Server Auto Configuration
[![Gitter](https://badges.gitter.im/RasPi3-WebServer/Lobby.svg)](https://gitter.im/RasPi3-WebServer/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=body_badge)  [![HitCount](http://hits.dwyl.io/jessicakennedy1028/RasPi3-WebServer.svg)](http://hits.dwyl.io/jessicakennedy1028/RasPi3-WebServer)  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)

## Description

NOTICE! THIS SCRIPT IS INCOMPLETE AS I STARTED A NEW BUILD, I DO NOT HAVE A PRIVATE GITHUB ACCOUNT SO IT IS OUT HERE! YOU MAY DOWNLOAD AND PLAY WITH THE CODE. PLEASE LET ME KNOW IF THERE IS ANY CHANGES THAT NEEDS TO BE MADE. THIS NOTICE WILL DISAPPEAR IN THE BETA VERSION

This script is just to help streamline the install process for Raspberry Pi 3 web, database, file, application, messaging, proxy and email servers. With a advanced installation system it will determine what is already installed and configured and allow you to make changes, or install or remove any application built into this system. You assume all responsibility of this script and understand there is no warranties, liabilities, or guarentees on this script. This script assumes a fresh OS install.

I used Geany IDE to create this script with tab stops at 4 characters.

Feel free to modify, but please give credit where it's due. Thanks!

If you wish to see the progress and TODO's please click here: https://github.com/jessicakennedy1028/RasPi3-WebServer/projects/1

## Screenshots

[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_078.png)
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_080.png)
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_081.png)
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_082.png)
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_083.png)
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/Terminal_084.png)

## Installation

1. Download or clone into your home folder
2. chmod +x install.sh
3. sudo ~/.install.sh

## Usage

RasPi-3 Server Configuration manages many mundane file changes automatically for you from questions that is given. Although this has been built on Ubuntu 17.10, I have tested on Raspberry 3 with Rasberian Stretch.

### Menu System

	Server Type
	1. Web Server
		1. Apache
			1. Apache Configuration
			2. Apache Restart
			3. Apache Start
			4. Apache Stop
		2. nGinX
			1. nGinx Configuration
			2. nGinX Restart
			3. nGinX Start
			4. nGinX Stop
		3. Lightspeed
			1. Lightspeed Configuration
			2. Lightspeed Restart
			3. Lightspeed Start
			4. Lightspeed Stop
		4. SSL Setup
			1. Let's Encrypt Settings
			2. Renew Certification
			3. Revoke Certification
		5. Disabled

	2. Database Server
		1. mySQL
			1. mySQL Configuration
			2. mySQL Restart
			3. mySQL Start
			4. mySQL Stop
		2. MariaDB
			1. MariaDB Configuration
			2. MariaDB Restart
			3. MariaDB Start
			4. MariaDB Stop
		3. PostgreSQL
			1. PostgreSQL Configuration
			2. PostgreSQL Restart
			3. PostgreSQL Start
			4. PostgreSQL Stop

	3. Application Server
		1. PHP
			1. PHP Configuration
			2. PHP Restart
			3. PHP Start
			4. PHP Stop
		2. Java
			1. Java Configuration
			2. Java Restart
			3. Java Start
			4. Java Stop
		3. Tomcat
			1. Tomcat Configuration
			2. Tomcat Restart
			3. Tomcat Start
			4. Tomcat Stop
		4. Open Source
			1. OSA Configuration
			2. OSA Restart
			3. OSA Start
			4. OSA Stop
		5. Mobile Application
			1. Mobile App Configuration
			2. Mobile App Restart
			3. Mobile App Start
			4. Mobile App Stop
		6. BBS Applications
			1. Mystic
				1. Mystic Configuration
			2. WWIV
				1. WWIV Configuration

	4. Email Server
		1. Postfix
			1. Postfix Configuration
			2. Postfix Restart
			3. Postfix Start
			4. Postfix Stop
		2. Citadel
			1. Citadel Configuration
			2. Citadel Restart
			3. Citadel Start
			4. Citadel Stop
		3. Sendmail
			1. Sendmail Configuration
			2. Sendmail Restart
			3. Sendmail Start
			4. Sendmail Stop
		4. Exim
			1. Exim Configuration
			2. Exim Restart
			3. Exim Start
			4. Exim Stop
		5. Courier
			1. Courier Configuration
			2. Courier Restart
			3. Courier Start
			4. Courier Stop
	5. File Server
		1. FTP
		2. NFS
		3. Samba
	6. Message Server

	7. Proxy Server

	8. System Configuration
		1. File System
			1. Drive Space
			2. Mount Points
			3. Raid Configuration
			4. USB Drive Configuration
		2. Memory
			1. Memory Free
			2. Swap Memory
		3. File Editor
			1. Hosts file
			2. Hostname file
		4. Network Configuration
			1. Wireless Editor
			2. Network Editor
		5. Application Configuration
			1. Git Configuration
			2. Uninstall Applications

	9. Logs
		1. Apache Logs
		2. PHP Logs
		3. Access Logs
		4. Error Logs
		5. Installation Logs

## Current Tested Systems

Ubuntu 17.10
Raspberian Stretch

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

This started as a simple command line interface for installing Apache, PHP, MariaDB, Webmin, myPHPadmin, Roundcube, Postfix and Dovecot since then I continued to build more functionality and it is now a complete system written in BASH script. Although in the near future Python will be introduced to some of the application's core functions, it will maintain a simple programming structure.

Currently it will automatically install 2 additional programs at startup: whosis and dialog.

## Credits

So far: Jessica Brown

## License

GPL 3.0

## Other Information

	Errors:

		100 - Package manager was not found
		110 - Early exit status from script
		111 - Log file failed to write
		112 - Hangup signal received
		113 - Script quit script was performed
		114 - Illegal instruction signal received
		115 - Trace trap not reset signal received
		116 - Abort signal received
		117 - Pollable event [XSR] generated, not supported signal received
		118 - Floating point signal received
		119 - Kill signal received
		125 - Internet connection issue
		150 - xterm or rxvt was not detected
		151 - tputs column width is less than 150
		180 - Configuration file error
		190 - Script requires to be run as su
		200 - Failed to write configuration file
		201 - Failed to verify the write of config value
		202 - Failed to remove parameter from configuration file
		203 - Parameter may consist of A-Z, a-z, 0-9, underscores, and
			dashes (no spaces or special characters)

## Change Log

    2.0
       Total redesign, currently not functional

    1.0.1
       Added Change Log to file
       Added managehost function
       Added screen resize message to forcewidth
       Moved all variables to it's own function
       Added set and unset to variables function

    1.0.0
       Script comments added
       Init script

    0.5.0
       Proof of concept

    0.1.0
       Manual creation documents
