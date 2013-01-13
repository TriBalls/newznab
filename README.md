############################################
# Scripts by _R0N_
# Version 20130113-0843
# created for Centos to run as a service
############################################

I want the Newznab import scripts to automaticly start whenever my Newznab server reboots.
To do so I used the newznab_screen.sh script and changed it that it does not output to screen
but to logfiles.

There are 3 variables in the newznab_centos.sh script that need to bee changed to match 
your system.
- NEWZNAB_PATH 
		The path to the directory where the newznab update scripts are located.
		This is the directory located <path to newznab>/misc/update_scripts

- NEWZNAB_LOG1  
		newznab service uses 2 logfiles, this logfile is the one where the output of the import is stored
		this logfile is overwritten on every run, you could tail it like:
		tail -f <path to logfile>

- NEWZNAB_LOG2
		This logfile is the file that logs every start en stop time of the import, you could check if it 
		runs every time.

There is 1 optional variable you could change
- NEWZNAB_SLEEP_TIME
		This sets the sleep time between the imports in seconds, 600 is 10 minutes.
		

In the actual scheduler service, called newznab, you should look at 2 variables:
- scriptfile
		This is the path to newznab_centos.sh
		
- pidfile
		This is the location of the pidfile that is needed for the service to run.

You also make the scripts executable
chmod 700 newznab_centos.sh

make the file called newznab executable and place it in /etc/init.d/
chmod 700 newznab

If you want it to start at runtime 
chkconfig newznab on

These scripts are written for Centos, if you need to change it to make it work on other dirtibutions
please let me know I can include the files.


