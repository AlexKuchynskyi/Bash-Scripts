#! /bin/bash
######################################
# Script checks free space and sends alert if threshold is exceeded
#####################################

###############################
# Variables
###############################

JOB_NAME="nfs_SpaceMonitor"
WORKING_DIR="/path/to/script/${JOB_NAME}"
LOG_FILE="${WORKING_DIR}/${JOB_NAME}.log"
DATE="date +%Y-%m-%d_%H:%M"
THRESHOLD=90
MSG_HEADER="<<NFS SPACE ALERT>> NFS space usage threshold ${THRESHOLD}% has been reached"
TO_MAIL=receive_mail@mail.com

##############################
# Execution section
##############################

# If required folders are missing create them
if [ ! -d "${WORKING_DIR}" ]; then
# Create the directory
        mkdir -p "${WORKING_DIR}"
# Set permissions for the directory
        chmod 770 "${WORKING_DIR}"
# Check that the folder is writable
        if [ ! -w "${WORKING_DIR}" ]; then
                /bin/echo -e "\t`$DATE` [ERROR] The ${WORKING_DIR} location is not writable, please verify permissions. Terminating script."  >> ${LOG_FILE}
                exit 1
        fi
fi

# Check used space
USED_SPACE=`df -m /data | awk '{print $4}' | tail -1 | cut -d'%' -f1`
/bin/echo -e "\t`$DATE` [INFO] Current used space is ${USED_SPACE} percent."  >> ${LOG_FILE}

if [ $USED_SPACE -ge ${THRESHOLD} ]
then
        /bin/echo -e "\t`$DATE` [WARNING] Current used space is ${USED_SPACE}%. Threshold is reached. Sending alert email..."  >> ${LOG_FILE}
        MSG_BODY="Hello,\n\nNFS current space usage is ${USED_SPACE}%.\nCleanup is needed.\nPlease go to server and run 'df -h /data' command to verify space used."
        /bin/echo -e "${MSG_BODY}" | mailx -r sending_email@mail.com  -s "${MSG_HEADER}"  -S smtp=mailserver.com:25  "${TO_MAIL}"
fi
