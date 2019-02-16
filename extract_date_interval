#!/bin/bash

# script processes log file and extracts only part of log
# according to the time interval specified by user.
# Input arguments are: file_name, start and end of the time interval.

# make sure about the correct input
if [ -z $1 ] ||  [ -z $2 ] || [ -z $3 ] || [ -z $4 ] || [ -z $5 ]
then
        echo "Usage: script_name    path/to/log_file   start_DATE(pattern: Jan 21)    end_DATE(pattern: Jan 21)"

else
        FILE=$1

        # create temporary file without redundant space (' ') symbols.
        # It's needed for seeking the start and the end dates if
        # the inputed start_DATE and end_DATE are absent in the file.
        cat $FILE | tr -s ' ' > conv_file.txt

        DATE1=$(echo "$2 $3")
        DATE2=$(echo "$4 $5")
        echo "$DATE1    $DATE2"
        # transform dates for further compairing
        START_DATE=`date -d "$DATE1" +'%m%d'`
        END_DATE=`date -d "$DATE2" +'%m%d'`
        echo "$START_DATE    $END_DATE"
        if [ $START_DATE -gt $END_DATE ]
        then
                echo "The end_DATE is earlier than start_DATE. Try again..."
                kill  -TERM $$
        fi

        # Check if start date is in the file.
        # If not - increment date by day untill the date is found
        d=$DATE1
        if ! grep -qw "$d" conv_file.txt
        then
                echo "Start date is absent in the file."
                echo "Seeking the closest start date..."
                while [ "$d" != "$DATE2" ]; do
                        echo $d
                        d=$(date -d "$d + 1 day" +'%b %-d')
                        grep -qw "$d"  conv_file.txt && DATE_TO_START=$d && echo "Start date is: $DATE_TO_START" && break
                done
        else
                echo "Start date is present in the file."
                DATE_TO_START=$DATE1
        fi

        # Check if  end date is in the file.
        # If not - decrement date by day untill the date is found
        d=$DATE2
        if ! grep -qw "$DATE2" conv_file.txt
        then
                echo "End date is absent in the file."
                echo "Seeking the closest end date..."
                while [ "$d" != "$DATE_TO_START" ]; do
                        echo $d
                        d=$(date -d "$d - 1 day" +'%b %-d')
                        grep -qw "$d"  conv_file.txt && DATE_TO_END=$d && echo "End date is: $DATE_TO_END" && break
                done
        else
                echo "End date is present in the file."
                DATE_TO_END=$DATE2
        fi


        PRINT=0
        # reading file line by line
        while read LINE
        do
                # if printing is allowed ....
                if [ $PRINT -eq 1 ]
                then
                        # and while havn't met end_DATE...
                        if echo "$LINE" | tr -s ' ' | grep "$DATE_TO_END"; then break
                        else
                                # printing needed part of file
                                echo "$LINE"
                                continue
                        fi
                fi

                # if met start_DATE mention in the file ...
                if echo "$LINE" | tr -s ' ' | grep "$DATE_TO_START"
                then
                        #allow printing and print the first mentioned line
                        echo "$LINE"
                        PRINT=1
                fi
        done < $FILE

        # remove temporary file
        rm -f conv_file.txt

fi
