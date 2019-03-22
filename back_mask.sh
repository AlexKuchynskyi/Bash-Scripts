#!/bin/bash

# script gets as an input possible IP-address and checks
# whether an input is correct IP-address or not

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
	BACK_ELEMENT=0
        for (( i=0; i<=3; i++ )) ; do
		[ ${ARRAY[$i]} -gt $BACK_ELEMENT ] && break
		case ${ARRAY[$i]} in
        	0)
 			BACK_MASK[$i]='255'
			echo "$BACK_ELEMENT... Ok.";;
		128)
			BACK_MASK[$i]='127'
			echo "$BACK_ELEMENT... Ok.";;
		192)
			BACK_MASK[$i]='63'
			echo "$BACK_ELEMENT... Ok.";;
		224)
			BACK_MASK[$i]='31'
			echo "$BACK_ELEMENT... Ok.";;
		240)
			BACK_MASK[$i]='15'
			echo "$BACK_ELEMENT... Ok.";;
		248)
			BACK_MASK[$i]='7'
			echo "$BACK_ELEMENT... Ok.";;
		252)
			BACK_MASK[$i]='3'
			echo "$BACK_ELEMENT... Ok.";;
		254)
			BACK_MASK[$i]='1'
			echo "$BACK_ELEMENT... Ok.";;
		255)
			BACK_MASK[$i]='0'
			echo "$BACK_ELEMENT... Ok.";;
		* ) 
			echo "Non valid mask... "
			exit;;
		esac
		BACK_ELEMENT=${ARRAY[$i]}		
        done
	echo "${BACK_MASK[@]}" | sed 's/ /\./g'
fi
