# Bash-Scripts
Below is the list of scripts...

[PS_log_rotate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/PS_log_rotate) script which checks running processes every 2 seconds and writes the information to the PS.log file. After each 5 iteration current PS.log file is compressed by gzip into the file PS.log1.gz. There're only 5 compressed logs in the system, afterwards PS.log5.gz file is removed and new PS.log1.gz file is added. 

[find_IP_MAC](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/find_IP_MAC) script gets a directory name as an input parameter and finds mentioning of IP-addresses in all the files (regular files only) located in the specified directory. If flag --mac is specified the script also finds mentioning of MAC-addresses. Results are written to the files. 

[logrotate_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/logrotate_conf) script gets a path to the log file 
which is needed to be rotated and creates log rotation rule. 

[cron_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/cron_conf) script creates cron's task for logrotate running to rotate specified by user log file each 2 minutes.

[process_terminate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/process_terminate) script cheks the system processes and sends the TERM signal to the processes which use more RSS memory than N specified by user.
