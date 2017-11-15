# RasPi-3 Server Auto Configuration
[![Gitter](https://badges.gitter.im/RasPi3-WebServer/Lobby.svg)](https://gitter.im/RasPi3-WebServer/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=body_badge)  [![HitCount](http://hits.dwyl.io/jessicakennedy1028/RasPi3-WebServer.svg)](http://hits.dwyl.io/jessicakennedy1028/RasPi3-WebServer)  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)

## Description

NOTICE! THIS SCRIPT IS INCOMPLETE AS I STARTED A NEW BUILD, I DO NOT HAVE A PRIVATE GITHUB ACCOUNT SO IT IS OUT HERE! YOU MAY DOWNLOAD AND PLAY WITH THE CODE. PLEASE LET ME KNOW IF THERE IS ANY CHANGES THAT NEEDS TO BE MADE. THIS NOTICE WILL DISAPPEAR IN THE BETA VERSION

This script is just to help streamline the install process for Raspberry Pi 3 web, database, file, application, messaging, proxy and email servers. With a advanced installation system it will determine what is already installed and configured and allow you to make changes, or install or remove any application built into this system. You assume all responsibility of this script and understand there is no warranties, liabilities, or guarentees on this script. This script assumes a fresh OS install.

I used Geany IDE to create this script with tab stops at 4 characters.

Feel free to modify, but please give credit where it's due. Thanks!

If you wish to see the progress and TODO's please click here: https://github.com/jessicakennedy1028/RasPi3-WebServer/projects/1

## Screenshots

[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-mainmenu.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-webserver.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-servertype.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-fileserver.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-appserver.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-databaseserver.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-emailserver.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-webserver-settings.png)]
[![RasPi3 Logo](https://github.com/jessicakennedy1028/RasPi3-WebServer/blob/master/screenshots/ss-webserver-settings-errors.png)]

## Installation

1. Download or clone into your home folder
2. chmod +x install.sh
3. sudo ~/.install.sh

## Usage

RasPi-3 Server Configuration manages many mundane file changes automatically for you from questions that is given. Although this has been built on Ubuntu 17.10, I have tested on Raspberry 3 with Rasberian Stretch.

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
