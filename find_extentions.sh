#!/bin/bash

# script shows the list of file extentions and counts
# the amount of files with each extention in the 
# directory and subdirectories

# make sure about the correct input
if [ -z $1 ]
then
        echo "Usage: script_name    path/to/directory"
else
        DIR=$1
	echo ''
	echo "Counting the extentions in the directory `realpath $DIR`"
	echo ''
        find $DIR -type f -exec basename {} \; > file.tmp
        NO_EXT=0
        EXT=0
        declare -A ARR_EXT 	# declare associative array
        while read LINE; do
                # count files with no extention
                if echo "$LINE" | grep -qEv "\."; then (( NO_EXT+=1 )); continue; fi # no '.' symbol, so no extention
		# exclude hidden files ('.' is in teh begining of name)
                if echo "$LINE" | grep -qE "^\.[A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]+$";
                then (( NO_EXT+=1 )); fi

                # count files with extention, (anything'.'and anything till the end of line)
                if echo "$LINE" | grep -qE "[A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]\.
                [A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]+$";
                then
                        (( EXT+=1 ))
                        #echo "$LINE"
                        EXTENTION=$(echo "$LINE" | awk -F '.' '{print $NF}')
                        #echo "$EXTENTION"
                        (( ARR_EXT[$EXTENTION]++ ))
                        continue
                fi
        done < file.tmp
        echo "Total amount os files' extentions: $EXT"
        # Looping through keys and values in an associative array
        for K in "${!ARR_EXT[@]}"; do echo "			$K - ${ARR_EXT[$K]}"; done
	echo ''
	echo "The amount of files with no extention: $NO_EXT"
	echo ''

fi
