#!/bin/bash

# script  parses "/opt/interview/logs" file (you may change to any)
# shows the list of IPs and counts the attempts to connect from 
# the each of them 

# find neccessary IP and write it to the file
grep -oER "Calling-Station-Id \"([0-9]{1,3}\.){3}[0-9]{1,3}" /opt/interview/logs | cut -d '"' -f 2 > tmp_file
#awk -F '"' '{print $2}' > tmp_file

declare -A ARR_IP 	# declare associative array

# read file line by line
while read LINE; do
#echo "$LINE" 

	# add IP as array's key and increment it
	(( ARR_IP[$LINE]++ ))
done < tmp_file

echo "Total amount of connection attempts: " > log.parse
echo "<Calling station IP> - <amount> " >> log.parse

# Looping through keys and values in an associative array
for K in "${!ARR_IP[@]}"; do 
	echo "$K - ${ARR_IP[$K]}" >> log.parse
done

# remove temporary file
rm -f tmp_file

