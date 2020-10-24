#!/usr/bin/ksh

#DIRNAME="$HOME"
#LOGFILE="$DIRNAME/logs/script_log.log"
ENVFILE="/path/to/envfile/global_env.ksh"

. $ENVFILE

RETVAL=`sqlplus -s USERNAME/PSWD <<EOF
spool updated_vendors.txt
SET LINESIZE 120 PAGESIZE 25
COLUMN VENDORID FORMAT A14
COLUMN FIELD_NAME FORMAT A40
COLUMN LABEL FORMAT A14
COLUMN TYPE_OF_FIELD FORMAT A20

SELECT VENDORID, FIELD_NAME, LABEL, TYPE_OF_FIELD
  FROM TABLENAME
 WHERE    (VENDORID = '32678' AND LABEL = '4:00 PM CT')
       OR (VENDORID = '00936' AND LABEL = '3:00 PM CT')
       OR (VENDORID = '20511' AND LABEL = '1:00 PM CT')
       OR (VENDORID = '12547' AND LABEL = '3:00 PM CT')
       OR (VENDORID = '10272' AND LABEL = '4:00 PM CT');

spool off
EXIT;
EOF`

> current_statement_to_insert.txt

LINE_COUNTER=0
while read LINE; do
  vendor_ID=$(echo "$LINE" |  awk  'match($0, /[0-9]{5}/) {print substr($0, RSTART, RLENGTH)}')
  grep -q "$vendor_ID" updated_vendors.txt && LINE_COUNTER=$((LINE_COUNTER+1)) || echo "$LINE" >> current_statement_to_insert.txt
done < full_statement_to_insert.txt

echo "\nToday's loaded vendors are "$LINE_COUNTER" of 5:\n"
cat updated_vendors.txt

echo "\nWe have to insert below vendors with the statements:\n"
cat current_statement_to_insert.txt

echo "\n\nDo you want to proceed with insertion?"

select answer in "Yes" "No"; do
    case $answer in
      Yes ) 
        echo "Selected "Yes". Currently no any insertion... Will be later...."
        break;;

      No ) 
        echo "Selected "No""
        break;;

      * ) 
        echo "Unknown option, please press 1 or 2"
        ;;
    esac
done    
