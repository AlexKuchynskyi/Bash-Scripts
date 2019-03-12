#!/bin/bash

# script processes specified file which contains list of hosts (IPs or domain names)
# and checks their accessibility by ping.
# The output is: <Host_name (IP or domain) - packet loss(%)>.
# Input arguments are: file_name, packets quantity, packets interval.
# If no input arguments - script proposes default values.

# make sure about the correct input
if [ -z $1 ] ||  [ -z $2 ] || [ -z $3 ]  
then
	echo "Please, check if the input is correct!"
        echo "Usage: script_name    path/to/file_with_list_of_hosts   packets_quantity    packets_interval"
	echo "You may start the script with default values (file = $PWD/host_list.txt,"
	echo "packets_quantity = 4, packets_interval = 1). Confirm?"
	select yn in "Yes" "No"; do
    	case $yn in
        	Yes ) 
			echo "Default values selected..."
		 	FILE='host_list.txt'
			N_PACK=4
			PACK_INTERVAL=1
			echo "file = $FILE, packets_quantity = $N_PACK, packets_interval = $PACK_INTERVAL"
			break;;
	        No ) 
			echo "Please, specify!"
		        echo "Usage: script_name    path/to/file_with_list_of_hosts   packets_quantity    packets_interval"
			echo " "
			exit;;
		* ) echo "Please answer 1 or 2.";;
	esac
	done
else
	FILE=$1
	N_PACK=$2
	PACK_INTERVAL=$3
	echo "file = $FILE, packets_quantity = $N_PACK, packets_interval = $PACK_INTERVAL"
fi

while read LINE; do
	echo ' '
	# awk: -v - set variable LINE; /packet loss/ - regular expression
	ping -q -c $N_PACK -i $PACK_INTERVAL $LINE | awk -v LINE=$LINE -F ', ' '/packet loss/ {print LINE " - " $3}'
done < $FILE
