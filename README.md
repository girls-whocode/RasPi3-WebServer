#             Raspberry Pi 3 Web Server                
##          Script created by Jessica Brown             
###               jessica@jbrowns.com                    
                                                      
  DESCRIPTION:                                        
  This script is just to help streamline the install  
  process for Raspberry Pi 3 web and email servers.   
  You assume all responsibility of this script and    
  understand there is no warranties, liabilities, or  
  guarentees on this script. This script assumes a    
  fresh OS install.                                   
                                                      
  I used Geany IDE to create this script with tab     
  stops at 4 characters.                              
                                                      
  Feel free to modify, but please give credit where   
  it's due. Thanks!                                   
                                                      
  UID: root GROUP: root                               
                                                      
                                                      
  Errors:                                             
                                                      
    100 - Package manager was not found
			- Future try to install and setup without
			  package manager
    110 - Early exit status from script
			- CTRL-C was pressed, auto run finalize
			  function
    112 - Script requires to be run as su
			- changing files like /etc/hosts require
			  sudo.
    125 - Internet connection issue
			- Internet connection could not be found
    150 - xterm or rxvt was not detected
			- This script requires xterm for proper
			  display. Future try to make a headless
			  install.
    151 - tputs column width is less than 150
			- To make this look pretty and user friendly
			  the columns on the terminal is required to
			  be at 150 columns. You can still run this
			  script with the --forcewidth argument.
                                                      
                                                      
  Change Log:                                         
                                                      
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
                                                      
                                                      
