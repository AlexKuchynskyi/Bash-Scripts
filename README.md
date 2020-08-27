# Bash-Scripts
Below is the list of scripts...  

[back_mask](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/back_mask.sh) script gets as an input possible IP-mask and returns back-mask if the inputed mask is valid  
  
[check_directory_files](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/check_directory_files.sh) script checks if a file is in one directory when file is present script considers that file processing has been started and checks if files are in another directory. When this (second) directory is empty script is finished.  

[correct_IP](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/check_IP) script gets as an input possible IP-address and checks whether the user input string is the correct IP-address or not.  

[count_IP_URL](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/count_IP_URL.sh) cript takes the log file to process and gives the most appeared IPs and URLs. The output amount may be specified (default are 5, i.e. 5 most often IPs and 5 most often URLs).  

[count_lines](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/count_lines.sh) script counts lines in the list of files and returns list of files with the quantity of lines in each file and total number of files and lines as well.  

[cron_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/cron_conf) script creates cron's task for logrotate running to rotate specified by user log file each 2 minutes.  

[ETL_json_SQLite](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/ETL_json_SQLite.bash) performs ETL process. It collects all of the commits from GitHub API that have been made until a certain date, labels each commit as "Internal" or "External" (based on condition specified), and finally loads the commits in an SQLite database.

[extract_day_interval](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/extract_date_interval) script processes log file and extracts only part of log according to the time interval specified by user.

[find_extention](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/find_extentions.sh) shows the list of all the files' extentions and the amount of files with each extention in the specified directory and subdirectories.

[find_IP_MAC](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/find_IP_MAC) script gets a directory name as an input parameter and finds mentioning of IP-addresses in all the files (regular files only) located in the specified directory. If flag --mac is specified the script also finds mentioning of MAC-addresses. Results are written to the files.  

[find_link](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/fild_link.sh) script gets file_name and creates multiple hardlinks and softlinks to this file. After that script finds all the files with the same inode as input file (looks for all the hardlinks), then it looks for all the symlinks to the specified file and deletes them.  

[ifdata_counter](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/ifdata_counter.sh) script shows the amount of received and transmitted data for the specified network interface. Each 10 seconds it shows delta (difference) for these parameters and writes it down to the log file.  

[logrotate_conf](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/logrotate_conf) script gets a path to the log file 
which is needed to be rotated and creates log rotation rule.  

[parse_log](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/parse_log.sh) script parses specified file (may change to any) and shows the list of IPs and counts the attempts to connect from the each of them.  

[ping_check](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/ping_check.sh) script processes specified file which contains list of hosts (IPs or domain names) and checks their accessibility by ping. The output is: <Host_name (IP or domain) - packet loss(%)>. Input arguments are: file_name, packets quantity, packets interval. If no input arguments - script proposes default values.  

[process_terminate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/process_terminate) script cheks the system processes and sends the TERM signal to the processes which use more RSS memory than N specified by user.    

[PS_log_rotate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/PS_log_rotate) script which checks running processes every 2 seconds and writes the information to the PS.log file. After each 5 iteration current PS.log file is compressed by gzip into the file PS.log1.gz. There're only 5 compressed logs in the system, afterwards PS.log5.gz file is removed and new PS.log1.gz file is added. 

[remove_trg_file](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/remove_trg_file.sh) script removes specified file at specified location. Set as cronJob.

[space_alert_monitor](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/space_monitor_alert.sh) monitors used space on specified location and sends an email notification if space usage exceeds specified threshold.

[unpack](https://github.com/AlexKuchynskyi/Bash-Scripts/edit/master/unpack.sh) script takes folder name and checks if the files in it are archives (Gzip or Bzip). If so, script decompresses them, if not - just skip the file.
