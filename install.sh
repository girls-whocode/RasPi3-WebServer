#!/bin/bash

SYSTEMKEY="3d430f9af713781b92af4a97fc2e6664be7ce8e0"

# Set mode for script [ development, production ]
environment="production"

if [ $environment == "development" ]; then
	set -vxe
fi
( set -o posix ; set ) >logs/variables.log

# Load the files required for this script
if [ -f ./bin/errors.sh ]; then source ./bin/errors.sh; else echo "./bin/errors.sh file is missing"; exit 141; fi
if [ -f ./bin/variables.sh ]; then source ./bin/variables.sh; else echo "./bin/variables.sh ${error["141"]}"; exit 141; fi
if [ -f ./bin/config.sh ]; then source ./bin/config.sh; else echo "./bin/config.sh ${error["141"]}"; exit 141; fi
if [ -f ./bin/functions.sh ]; then source ./bin/functions.sh; else echo "./bin/functions.sh ${error["141"]}"; exit 141; fi
if [ -f ./bin/menu.sh ]; then source ./bin/menu.sh; else echo "./bin/menu.sh ${error["141"]}"; exit 141; fi
if [ -f ./bin/dialog.sh ]; then source ./bin/dialog.sh; else echo "./bin/dialog.sh ${error["141"]}"; exit 141; fi

variables
varreset

tty -s
status=$?
if [ $status -ne 0 ]; then
	log "${0} must run from terminal"
	echo "${0} must be run from terminal"
	echo error["110"]
	exti 110
else
	if [ "${BASH_VERSINFO}" -lt 4 ]; then
		log "${error["140"]}"
		exit 140
	fi
fi

function main() {
	log "Script started #############################################################"
	log "Start installation script"

	# Test for ncurses dialog application
	echo -e $LIGHTRED"=== "$LIGHT_GREEN `date +'%I:%M:%S'` $LIGHT_RED" === "$WHITE"Starting Application and checking dependancies "$LIGHTRED"==="$COLOR_NONE
	if haveprog "dialog"; then
		log "Dialog is already installed"
		if [ ! -f "./.dialogrc" ]; then
			evallog "dialog --create-rc ./.dialogrc"
		fi
	else
		evallog "${PKGINSTALL} dialog" & pid=$!
		progress

		if haveprog "dialog"; then
			log "Dialog installed successfully"
		else
			log "${error["185"]}"
			log "Script ended ###############################################################"
		fi
	fi

	# Test for net-tools whois application
	if haveprog "whois"; then
		log "Whois is already installed"
	else
		evallog "${PKGINSTALL} whois" & pid=$!
		progress
	fi

	if haveprog "lsb_release"; then
		log "lsb_release is already installed"
	else
		evallog "${PKGINSTALL} redhat-lsb-core" & pid=$!
		progress
	fi

	chkmemory
	chkinet
	chkversion
	loadcfg
	if [ "${PKGMGR}" == "apt" ]; then
		evallog "DEBIAN_FRONTEND=noninteractive"
	fi
	chkmemory
	
	menusystem
	mainmenu
}

main
