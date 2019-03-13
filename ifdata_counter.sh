#!/bin/bash

# script shows the amount of received and transmitted data for the specified 
# network interface. Each 10 seconds it shows delta (difference) for these parameters,
# and writes it down to the log file.

# show all the network interfaces available
echo ''
echo "Network interfaces available:"
ip link | awk -F ': <' '{print $1}' | grep -E '[[:digit:]]:[[:space:]]' | awk -F ': ' '{print $2}'
echo ''

read -p "Select the network interface to get info about (just copy and paste): " IF  #wait for input
echo "The network interface is: $IF"
FILE="$IF"_datacount.log

#ip -s link | grep -A 5 "$IF" 							#show info about selected interface
echo ''
date | tee $FILE

# awk: / / - regexp tp find needed line, 
# 'getline' just eats the line and goes on to the next line, after that gives the first field ($1).
RECEIVED=$(ip -s link | grep -A 5 "$IF" | awk -F ' ' '/RX/{getline; print $1}') 
TRANSMITTED=$(ip -s link | grep -A 5 "$IF" | awk -F ' ' '/TX/{getline; print $1}')
echo "received = $RECEIVED bytes, transmitted = $TRANSMITTED bytes" | tee -a $FILE
echo '' | tee -a $FILE
REC1=$RECEIVED
TRANS1=$TRANSMITTED
sleep 10
while true; do
	date |tee -a $FILE
	RECEIVED=$(ip -s link | grep -A 5 "$IF" | awk -F ' ' '/RX/{getline; print $1}')
	TRANSMITTED=$(ip -s link | grep -A 5 "$IF" | awk -F ' ' '/TX/{getline; print $1}') 
	echo "Delta received: $(( $RECEIVED-$REC1 ))" | tee -a $FILE
	echo "Delta transmitted: $(( $TRANSMITTED-$TRANS1 ))" | tee -a $FILE
	sleep 10
	REC1=$RECEIVED
	TRANS1=$TRANSMITTED
done
