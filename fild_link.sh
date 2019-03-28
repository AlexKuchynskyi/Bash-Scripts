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
    echo "Successfully created hard links... Inode= $INODE"
    echo "current path= $PWD/$1"
    find / -inum $INODE                             # show all the hardlinks  
    echo "================================="
    # '! -path' means except path...
    # so we find all the files with the specified inode
    # except our input file and remove them
    find / -inum $INODE ! -path "$PWD/$1" -exec rm -f {} \;
    echo "Successfully removed all the hardlinks..."
    
    # create multiple symlinks...
    echo "================================="
    for (( i=0; i<10; i++ )) ; do
        ln -s $1 $1_symlink$i
    done
    
    echo "Successfully created syminks..."
    # find all the symlinks which point to the original file
    # BTW if specify the root directory as the directory to start from (/)
    # the system comes to eternal loop and gives the error   !!!!!!!!!!!!!!!!!! 
    find -L /root -samefile $PWD/$1 #! -path "$PWD/$1"       # show all the symlinks
    find -L /root -samefile $PWD/$1 ! -path "$PWD/$1" -exec rm -f {} \;   
    echo "================================="
    echo "Successfully removed all the syminks..."
fi
