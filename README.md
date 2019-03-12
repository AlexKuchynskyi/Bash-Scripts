# Bash-Scripts
Below is the list of scripts...

[correct_IP](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/check_IP) script gets as an input possible IP-address and checks whether the user input string is the correct IP-address or not.  

[cron_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/cron_conf) script creates cron's task for logrotate running to rotate specified by user log file each 2 minutes.  

[extract_day_interval](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/extract_date_interval) script processes log file and extracts only part of log according to the time interval specified by user.

[find_extention](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/find_extentions) shows the list of all the files' extentions and the amount of files with each extention in the specified directory and subdirectories.

[find_IP_MAC](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/find_IP_MAC) script gets a directory name as an input parameter and finds mentioning of IP-addresses in all the files (regular files only) located in the specified directory. If flag --mac is specified the script also finds mentioning of MAC-addresses. Results are written to the files. 

[logrotate_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/logrotate_conf) script gets a path to the log file 
which is needed to be rotated and creates log rotation rule.  

[parse_log](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/parse_log.sh) script parses specified file (may change to any) and shows the list of IPs and counts the attempts to connect from the each of them.  

[ping_check](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/ping_check.sh) script processes specified file which contains list of hosts (IPs or domain names) and checks their accessibility by ping. The output is: <Host_name (IP or domain) - packet loss(%)>. Input arguments are: file_name, packets quantity, packets interval. If no input arguments - script proposes default values.  

[process_terminate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/process_terminate) script cheks the system processes and sends the TERM signal to the processes which use more RSS memory than N specified by user.    

[PS_log_rotate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/PS_log_rotate) script which checks running processes every 2 seconds and writes the information to the PS.log file. After each 5 iteration current PS.log file is compressed by gzip into the file PS.log1.gz. There're only 5 compressed logs in the system, afterwards PS.log5.gz file is removed and new PS.log1.gz file is added. 
