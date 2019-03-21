#!/bin/bash

# script checks running processes every 2 seconds and
# writes the information to the PS.log file.
# After each 5 iteration current PS.log file is compressed
# by gzip into the file PS.log1.gz. There're only 5 
# compressed logs in te system (PS.log1.gz, ..., PS.log5.gz).
# If you doesn't want to see the comments output 
# change "| tee -a" to ">>" and write all the "echo "..." " commands
# to the file (PS.log)

# creating 5 log files
file_counter=1
while [ $file_counter -lt 6 ] ; do
	echo "Starting ..."
	for (( i=1; i<=5; i++ )); do
		echo "=========================================================================================" | tee -a PS.log
		echo "==================== $i $i $i    `date`    $i $i $i ====================" | tee -a PS.log
		echo "=========================================================================================" | tee -a PS.log
		ps aux >> PS.log
		sleep 2 
	done
	gzip -fS $file_counter.gz PS.log 
	echo "Finishing $file_counter ..."
	(( file_counter++ ))
done

# rotation log files 
# PS.log5.gz - removing, PS.log1.gz - creating
while : ; do
        rm PS.log5.gz
	echo "`ls`"
	change=0
	for (( i=4; i>=1; i-- )); do
		(( change=$i+1 ))
		mv PS.log$i.gz PS.log$change.gz 2>/dev/null
		#echo "$i $change"
	done
	echo "`ls`"
	echo ''
	echo "Creating new log..."
	echo "=========================================================================================" | tee -a PS.log
	echo "==========================     `date`    ==========================" | tee -a PS.log
	echo "=========================================================================================" | tee -a PS.log
	ps aux >> PS.log
	sleep 2
	gzip -fS 1.gz PS.log
	echo "Created new log!"

done
