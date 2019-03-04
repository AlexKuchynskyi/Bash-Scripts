#!/bin/bash

# script  parses "/opt/interview/logs" file (you may change to any)
# shows the list of IPs and counts the attempts to connect from 
# the each of them 

#	echo ''
#        find $DIR -type f -exec basename {} \; > file.tmp
grep -oER "Calling-Station-Id \"([0-9]{1,3}\.){3}[0-9]{1,3}" /opt/interview/logs | awk -F '"' '{print $2}' > tmp_file
#TOTAL_ADDR={ wc -l tmp_file }
#echo "Total = $TOTAL_ADDR"
#        EXT=0
declare -A ARR_IP 	# declare associative array
while read LINE; do
                # count files with no extention
echo "$LINE" 

                # count files with extention
#                if echo "$LINE" | grep -qE "[A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]\.
#                [A-Za-z0-9\@\#\%\^\&\(\)\?\<\>\+\-\=\~\`\|\*\_\,\!\"\'\/\$]+$";
#                then
#                        (( EXT+=1 ))
                        #echo "$LINE"
#                        EXTENTION=$(echo "$LINE" | awk -F '.' '{print $NF}')
                        #echo "$EXTENTION"
(( ARR_IP[$LINE]++ ))
#                        continue
#                fi
done < tmp_file
#        echo "Total amount os files' extentions: $EXT"
        # Looping through keys and values in an associative array
for K in "${!ARR_IP[@]}"; do 
	echo "			$K - ${ARR_IP[$K]}" | tee -a log.parse
done

# remove temporary file
rm -f tmp_file
#	echo ''
#	echo "The amount of files with no extention: $NO_EXT"
#	echo ''

#fi
