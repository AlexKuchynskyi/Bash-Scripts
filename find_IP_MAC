#!/bin/bash

# script gets a directory name as an input parameter,
# then finds mentioning of IP-addresses in all the files
# (regular files only) located in the specified directory
# BTW the script checks if the file is the regular one.
# if flag --mac is specified so the script also finds 
# mentioning of MAC-addresses  

# make sure about correct input
if [ -z $1 ]
then
        echo "Usage: script_name   dir_name (--mac flag additionally for MAC-addresses)"

	elif [ -z $2 ]
	then
		# specify a directory to find files in
		DIR=$1

		# find needed expression and write the result to the file
		echo "Seeking for IP-addresses in $DIR ... and writing the result to the file..."
		find $DIR -type f -exec grep -ER "([0-9]{1,3}\.){3}[0-9]{1,3}" '{}' \; > IP_1.log

	elif [ $2 -ne "--mac" ]
	then
	        echo "Usage: script_name   dir_name (--mac flag additionally for MAC-addresses)"
	else

		# specify a directory to find files in
		DIR=$1

		# find needed expression and write the result to the file
		echo "Seeking for IP- and MAC-addresses in $DIR ... and writing the result to the files IP.log and MAC.log ..."
		find $DIR -type f -exec grep -ER "([0-9]{1,3}\.){3}[0-9]{1,3}" '{}' \; > IP_1.log
		find $DIR -type f -exec grep -ER "([[:xdigit:]]{2}:){5}[[:xdigit:]]" '{}' \; > MAC_1.log

fi
