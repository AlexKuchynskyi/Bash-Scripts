#!/bin/bash

######################################
# Script restores deleted objects from AWS S3 bucket.
# Works for buckets with enabled bucket versioning.
# Needs jq to be installed.
#####################################

recoverfiles=$(aws s3api list-object-versions --bucket <bucket_name> --prefix <path/to/folder/> --query "DeleteMarkers[?IsLatest]")
# you may also select the specific date: "DeleteMarkers[?IsLatest && starts_with(LastModified,'yyyy-mm-dd')]"

for row in  $(echo "${recoverfiles}" | jq -c '.[]'); do
    key=$(echo "${row}" | jq -r '.Key'  )
    versionId=$(echo "${row}" | jq -r '.VersionId'  )
    echo $key 
    aws s3api delete-object --bucket <bucket_name> --key $key --version-id $versionId
    echo "Recovered"
    echo "-----"
done
