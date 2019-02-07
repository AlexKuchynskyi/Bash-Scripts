#!/bin/bash

# as an input parameter script gets a path to the log file 
# which is needed to be rotated

# make sure about correct input
if [ -z $1 ]
then
        echo "Usage: script_name  /path/to/file"

else
	# specify the file to be rotated
	FILE=$1
	CFG_FILE="/etc/logrotate.d/`basename $1 | awk -F '.' '{print $1}'`"
	echo "file = $FILE"
	echo "cfg .d = $CFG_FILE"
	echo "$FILE" > $CFG_FILE
  
  # specify rotation options
	echo '{' >> $CFG_FILE
	echo -e "\tmissingok" >> $CFG_FILE
	echo -e "\tnomail" >> $CFG_FILE
	echo -e "\tcompress" >> $CFG_FILE
	echo -e "\tsize=1M" >> $CFG_FILE
	echo -e "\trotate 5" >> $CFG_FILE
	echo -e "\tpostrotate" >> $CFG_FILE
	echo -e "\t\tdate >> /var/log/logrotate.log" >> $CFG_FILE
        echo -e "\t\techo 'Rotation complete!' >> /var/log/logrotate.log" >> $CFG_FILE
	echo -e "\tendscript" >> $CFG_FILE
	echo '}' >> $CFG_FILE
fi
