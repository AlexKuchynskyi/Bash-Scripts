# Bash-Scripts
Below is the list of scripts...

[PS_log_rotate](https://github.com/AlexKuchynskyi/Bash-Scripts/blob/master/PS_log_rotate) script which checks running processes every 2 seconds and writes the information to the PS.log file. After each 5 iteration current PS.log file is compressed by gzip into the file PS.log1.gz. There're only 5 compressed logs in the system, afterwards PS.log5.gz file is removed and new PS.log1.gz file is added. 
