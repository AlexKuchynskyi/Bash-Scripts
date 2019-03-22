#!/bin/bash

# script gets as an input possible IP-mask and returns
# back-mask if the inputed mask is valid

# make sure about correct input
if [ -z $1 ]
then
        echo "Usage: script_name   mask ..."
else
        # get the input string and split it by the '.' delimeter
        VAR=$1

        STRING=$(echo "$VAR" | tr . " ")
        # write string elements to array
        ARRAY=($STRING)
	declare -a BACK_MASK # create an empty array
	PREVIOUS_ELEMENT=0
        for (( i=0; i<=3; i++ )) ; do
		# if next element > pevious - non valid mask
		[ $i -gt 0 ] && [ ${ARRAY[$i]} -gt $PREVIOUS_ELEMENT ] && echo "Non valid mask..." && exit
		case ${ARRAY[$i]} in
        	0)
 			BACK_MASK[$i]='255';;
		128)
			BACK_MASK[$i]='127';;
		192)
			BACK_MASK[$i]='63';;
		224)
			BACK_MASK[$i]='31';;
		240)
			BACK_MASK[$i]='15';;
		248)
			BACK_MASK[$i]='7';;
		252)
			BACK_MASK[$i]='3';;
		254)
			BACK_MASK[$i]='1';;
		255)
			BACK_MASK[$i]='0';;
		* ) 
			echo "Non valid mask... "
			exit;;
		esac
		PREVIOUS_ELEMENT=${ARRAY[$i]}		
        done
	echo "${BACK_MASK[@]}" | sed 's/ /\./g'
fi
