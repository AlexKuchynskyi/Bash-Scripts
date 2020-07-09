#! /bin/bash
######################################
# Script removes Accounts.trg file
#####################################

###############################
# Variables
###############################

CRONJOB_CODE="AccountsTrgFileDeleteJob"
FILE_PATH="/path/to/file"
FILE_NAME="Accounts.trg"
WORKING_DIR="/path/to/script/${CRONJOB_CODE}"
LOG_FILE="${WORKING_DIR}/${CRONJOB_CODE}.log"
DATE="date +%Y-%m-%d:%H:%M:%S.%3N"

##############################
# Execution section
##############################

# If required folders are missing create them
if [ ! -d "${WORKING_DIR}" ]; then
# Create the directory
        mkdir -p ${WORKING_DIR}
# Set permissions for the directory
        chmod 770 ${WORKING_DIR}
# Check that the folder is writable
        if [ ! -w "${WORKING_DIR}" ]; then
                echo -e "\t`$DATE` [ERROR] The ${WORKING_DIR} location is not writable, please verify permissions. Terminating script."  >> ${LOG_FILE}
                exit 1
        fi
fi

# Start logging
echo -e "\t`$DATE` [INFO] Starting script." >> ${LOG_FILE}

# If required file is missing
if [ ! -f "${FILE_PATH}/${FILE_NAME}" ]; then
    echo -e "\t`$DATE` [ERROR] The ${FILE_NAME} file or location ${FILE_PATH} doesn't exist. Terminating script."  >> ${LOG_FILE}
    exit 1
fi

# Executing section
rm ${FILE_PATH}/${FILE_NAME}
EXIT_STATUS=$?

# Parse the result and status values from the received response
        #RESPONSE_RESULT=`echo "cat //cronjob/result" | xmllint --shell ${RESPONSE_FILE} | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
        #RESPONSE_STATUS=`echo "cat //cronjob/status" | xmllint --shell ${RESPONSE_FILE} | sed '/^\/ >/d' | sed 's/<[^>]*.//g'`
        #RESPONSE_RESULT=`grep -oP "(?<=<result>).*(?=<\/result>)" ${RESPONSE_FILE}`
        #RESPONSE_STATUS=`grep -oP "(?<=<status>).*(?=<\/status>)" ${RESPONSE_FILE}`

# Check for errors
if [ ${EXIT_STATUS} -ne 0 ]; then
# If exit status is different from zero sript failed. Record error to log and end script.
        echo -e "\t`$DATE` [ERROR] Unable to remove file. The error code was ${EXIT_STATUS}. Terminating script."  >> ${LOG_FILE}
        exit 3
else
        echo -e "\t`$DATE` [INFO] SUCCESS. File removing completed. Script ends successfully." >> ${LOG_FILE}
fi

# Return Success
exit 0

