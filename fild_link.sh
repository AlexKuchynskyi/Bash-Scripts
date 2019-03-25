#!/bin/bash

# script gets file_name and creates multiple hardlinks to this file.
# After that script finds all the files with the same inode as input file 
# (looks for all the hardlinks) and deletes them.

# make sure about correct input
if [ -z $1 ]
then
        echo "Usage: $0   file_name ..."
else
	echo "Input is correct..."
	# create multiple hardlinks...
	for (( i=0; i<10; i++ )) ; do
    		ln $1 $1_hard$i
	done
	# -c modifies output of stat command, %i gives Inode
	INODE=$(stat -c '%i' $1) 
	echo "Inode= $INODE"
	echo "current path= $PWD/$1"
	find / -inum $INODE  
	echo "================================="
	# '! -path' means except path...
	# so we find all the files with specified inode  except our input file
	# and remove them
	find / -inum $INODE ! -path "$PWD/$1" -exec rm -f {} \;
fi
