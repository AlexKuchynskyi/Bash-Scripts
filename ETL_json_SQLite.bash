#!/bin/bash
######################################
# Script performs ETL process. 
# It collects all of the commits that have been made until a certain date, 
# then it labels each of them as "Internal contribution" or "External contribution"
# and finally loads the commits in an SQLite database.
#####################################

###############################
# Variables
###############################

BASE_URL="https://api.github.com/repos/:owner/:repo/commits"
DATE="2018-06-27T00:00:00Z"

##############################
# Execution section
##############################

# get number of pages which API provides by pagination
LAST_PAGE=`curl -s -I "${BASE_URL}?until=${DATE}&per_page=100" | grep -w "link:" | awk -F "rel=\"next\"" '{print $2}' | grep -Po '(?<=\&page=).*(?=\>;)'`

# to prevent duplicating - remove initial_file.json if exists
rm -f initial_file.json

# call API and collect commits info
for PAGE_NUMBER in `seq 1 $LAST_PAGE`; do 
	curl -s "${BASE_URL}?until=${DATE}&page=${PAGE_NUMBER}&per_page=100" >> initial_file.json
done

# select needed fields from json and redirect output to file
cat initial_file.json | jq '.[] | {sha: .sha, date: .commit.author.date, author: .author.login, message: .commit.message}' > commits_parsed.json

# add qoutes to the authors named 'null' for correct further processing
sed  -i '/author/ s=null="null"=g' commits_parsed.json

# edit members.json and leave only login names
cat assets/members.json | jq '.[]|{login: .login}' | grep -Po '(?<=login": ").*(?=")' > members.txt

# classify the internal and the external commits based on the author's login username
# and add 'is_external' field to the file
# redirect output to 'final_file' for further processing
while read -r LINE; do 
	if [[ `grep -w "$LINE" members.txt` ]];
		then jq --arg LINE "$LINE" 'select(.author==$LINE) + {is_external: "0"}' commits_parsed.json;
		else jq --arg LINE "$LINE" 'select(.author==$LINE) + {is_external: "1"}' commits_parsed.json;
	fi;
done < <(grep -Po '(?<=author": ").*(?=")' commits_parsed.json | sort | uniq) > final_file.json

# substitute '\n' to '<LF>' in the 'message' field to make more readable format
sed -i '/message/ s=\\n=<LF>=g' final_file.json

#convert json to csv
jq -r '[.sha, .date, .author, .message, .is_external] | @csv' final_file.json > final_file.csv

# connect to sqlite, drop existing table to prevent duplicating, create table and load data into the table
sqlite3 github.db <<EOF
DROP TABLE IF EXISTS commits;
CREATE TABLE commits (sha TEXT, date TEXT, author TEXT, message TEXT, is_external INTEGER);
.mode csv
.import final_file.csv commits
EOF

# remove intermediate files if needed
# rm -f *.json
# rm -f *.txt
# rm -f *.csv
