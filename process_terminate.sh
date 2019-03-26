#!/bin/bash

# script cheks the system processes and sends the TERM signal
# to the processes which use more RSS memory than N specified by user

# make sure about the correct input
if [ -z $1 ]
then
        echo "Usage: script_name  N(RSS memory)"

else
        N=$1
        while : ; do

                # sort ps aux output by rss, exclude first line (with the columns names), and cut off the processes
                # which use less RSS than specified N, so only PIDs of the processes using rss>N are written to the file
                ps aux k-rss --width=50 | tail -n +2 | awk -v N=$N '{ if ($6 > N) { print } }' | awk '{print $2}' | tee file

                # reading file line by line...
                # and terminating the processes with PID listed in the file
                while read LINE
                do
                        kill -TERM $LINE
                done < file

                sleep 5
        done
fi
