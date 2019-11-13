#!/bin/bash

# script checks if a file is in one directory
# when file is present script considers that file processing has been started
# and checks if files are in another directory. When this (second) directory is empty
# script is finished


START_PRCSTGLOAD=0
while [ "$START_PRCSTGLOAD" -eq 0 ]; do
        echo "`date '+%Y-%m-%d %H:%M:%S'` - checking if files are in the working directory..." >> prcFeedClusterJob_ctl.log

        if [ `ls -1 /path/to/file/prc_stg*$(date +%Y%m%d).impex 2> >( while read line; do echo "$(date): ${line}"; done >> error.log) | wc -l ` -gt 0 ]; then
        # "2> >( while read line; do echo "$(date): ${line}"; done >> error.log)" - this is redirecting to log file 
        # just to see possible errors; this expression may be changed to "2>&/dev/null"
                echo -n "`date '+%Y-%m-%d %H:%M:%S'`" >> prcFeedClusterJob_ctl.log
                echo "  - priceFeedClusterJob STARTED ................................................" >> prcFeedClusterJob_ctl.log
                START_PRCSTGLOAD=1
                break
        fi
        sleep 300
done

while [ "$START_PRCSTGLOAD" -eq 1 ]; do
        echo "`date '+%Y-%m-%d %H:%M:%S'` - continue processing file(s)..." >> prcFeedClusterJob_ctl.log

        if [ `ls -1 /path/to/file/prc_stg*$(date +%Y%m%d).impex 2> >( while read line; do echo "$(date): ${line}"; done >> error.log)  | wc -l ` -eq 0 ]; then
                echo -n "`date '+%Y-%m-%d %H:%M:%S'`" >> prcFeedClusterJob_ctl.log
                echo "  - STOP PROCESSING. priceFeedClusterJob FINISHED .................................." >> prcFeedClusterJob_ctl.log
                break
        fi
        sleep 300
done
