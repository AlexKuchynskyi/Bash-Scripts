#!/bin/bash

# the script takes the log file to process and
# gives the most appeared IPs and URLs. 
# The output amount may be specified (default are 5, i.e. 5 most often IPs
# and 5 most often URLs)  

# make sure about correct input
if [ $# -lt 1 ]
then
	echo "Usage: $0    file_name    (optional-number of lines) ..."
	exit 1
fi

if [ -z $2 ]; then LINES=5 # specify number of lines to output
else LINES=$2
fi

# find IPs and write it down to the temporary file
grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" $1 > tmp_IP

# find URLs and write it down to the temporary file
# as far as log file contains URLs with prior "GET" and "POST" words only
# so URLs are fouded by these keywords
awk -F 'GET /' '{print $2}' $1 | cut -d ' ' -f 1 > tmp_url
awk -F 'POST /' '{print $2}' $1 | cut -d ' ' -f 1 >> tmp_url
sed -i '/^$/d' tmp_url  # remove epty lines

declare -A ARR_IP 	# declare associative array

# read file line by line
while read LINE; do
	# add IP as array's key and increment it
	(( ARR_IP[$LINE]++ ))
done < tmp_IP 

echo ''
echo "The amount of IPs: " 

# Looping through keys and values in an associative array
for K in "${!ARR_IP[@]}"; do 
	echo "$K - ${ARR_IP[$K]}"
done |
# sort in rear order (-r), deal with numbers as with string (the whole number
# is taken under consideration, not digit by digit)(-n), sort by the 3rd field (-k3) 
sort -rn -k3 | head -n $LINES

declare -A ARR_URL 	# declare associative array

# read file line by line
while read LINE; do

	# add url as array's key and increment it
	(( ARR_URL[$LINE]++ ))
done < tmp_url 

echo ''
echo "The amount of URLs: " 

# Looping through keys and values in an associative array
for K in "${!ARR_URL[@]}"; do 
	echo "$K - ${ARR_URL[$K]}"
done | sort -rn -k3 | head -n $LINES

# delete temporary files
rm -f tmp_IP
rm -f tmp_url
