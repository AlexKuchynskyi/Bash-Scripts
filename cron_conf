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
        CFG_FILE="/var/spool/cron/$USER"
        PREFIX=`basename $1 | awk -F '.' '{print $1}'`
        echo "file = $FILE"
        echo "cfg .d = $CFG_FILE"
        echo "prefix_to_add = $PREFIX"

  # specify rotation options
        echo "*/2 * * * * /usr/sbin/logrotate /etc/logrotate.d/$PREFIX" >> $CFG_FILE
fi
