#!/bin/bash

# script gets as an input possible IP-address and checks
# whether an input is correct IP-address or not

# make sure about correct input
if [ -z $1 ]
then
        echo "Usage: script_name   IP-address"

else
        # get the input string and split it by the '.' delimeter
        VAR=$1

        # checking for excesive dots
        DOT_COUNTER=$(echo "$VAR"  | sed 's/[^.]//g' | awk '{ print length }')

        STRING=$(echo "$VAR" | tr . " ")
        # write string elements to array
        ARRAY=($STRING)
        ARR_ELM_AMOUNT=${#ARRAY[@]}
        if [ $ARR_ELM_AMOUNT -ne 4 ]
        then echo "NOT an IP-address!!!"
        else
                COUNTER=0
                for (( i=0; i<=3; i++ )) ; do
                        if [ ${ARRAY[$i]} -lt 0 ] || [ ${ARRAY[$i]} -gt 255 ]; then break
                        else (( COUNTER+=1 ))
                        fi
                done

                if [ $COUNTER -eq 4 ] && [ $DOT_COUNTER -eq 3 ]; then echo "CORRECT IP-ADDRESS!!!"
                else echo "NOT an IP-address!!!"
                fi
        fi

fi
