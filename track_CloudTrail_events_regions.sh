#!/bin/bash

#######################################################
# Script looks up events that are captured by CloudTrail.
# You can look up events that occurred in a region within the last 90 days.
# Script iterates through each AWS region and writes output to the corresponding file: "tracked_CloudTrail_$region"
# Next steps are possible to use jq to filter events in the way needed.
# For instance:
# cat <filename> | jq  '.Versions[] | select(.EventName !="<EventName>")' - to exclude non-informative (for this case) events which prevail in the output
# cat <filename> | jq  '.Events[] | .EventName, (.CloudTrailEvent | fromjson | .sourceIPAddress)' - to list sourceIPAddresses for each event
# This example script looks for events performed by user - 'username' during time between 'start-time' and 'end-time'.
# Another lookup attributes can be specified according to documentation:
# https://docs.aws.amazon.com/cli/latest/reference/cloudtrail/lookup-events.html
# For instance: AttributeKey=EventSource,AttributeValue=iam.amazonaws.com - to lookup events from IAM (like creation new users etc.)
#######################################################

NOW=$(date +"%F_%T")
echo $NOW
# Create new directory for each lookup event... just to easier organize and track of what's done
DIRNAME=CloudTrail_tracking_results_$NOW
mkdir $DIRNAME
cd $DIRNAME

for region in `aws ec2 describe-regions --output json | jq -r '.Regions[] .RegionName'`; do
  echo "Tracking region $region ..."

  # Setup a delay. As per documentation:
  # "The rate of lookup requests is limited to two per second, per account, per region."
  sleep 1

  aws cloudtrail lookup-events --profile test --region $region \
  --start-time "2021-10-01T07:00:00Z" --end-time "2021-10-01T15:00:00Z" \
  --lookup-attributes AttributeKey=Username,AttributeValue='username' > tracked_CloudTrail_$region
done
