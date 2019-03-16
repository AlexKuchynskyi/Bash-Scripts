#!/bin/bash

# counting lines in list of files

# declare function
count_lines () {
	local f=$1
	# this is return value, i.e. non local
	# sed gets digit values [0-9], 1 or more (*),
	# and get only first group of digits (\1 in the 
	# second part), we also backslashed brackets (\( and \))
	# in order them not to be a part of tish regexp
	l=`wc -l $f | sed 's/^\([0-9]*\).*$/\1/'`
}

if [ $# -lt 1 ]
then
	echo "Usage: $0 file ..."
	exit 1
fi

echo "$0 counts the lines in the file"
l=0
n=0
s=0
while [ "$*" != "" ]
do
	count_lines $1
	echo "$1: $l"            # lines in current file
	n=$[ $n + 1 ]		 # total number of files
	s=$[ $s + $l ]		 # total number of lines
	shift
done

echo "$n files in total, with $s lines in total"
