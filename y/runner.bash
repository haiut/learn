#!/bin/bash

#env
#
export BZA=http://qa.a.blazemeter.com/api/latest
export BZA_API_KEY="api_key=0b203f0b4cf4ee6abf99"

#curl --silent --insecure ${BZA}/tests/5002315?${BZA_API_KEY}
#curl --silent --insecure ${BZA}/tests/5002315/sessions?${BZA_API_KEY}

SESSION_ID=$(curl --silent --insecure ${BZA}/tests/5002315/start?${BZA_API_KEY} | jq '.result.sessionsId[]' | tr -d \")
echo "Test started .."

TEST_RUN_STATUS=$(curl --silent --insecure ${BZA}/sessions/${SESSION_ID}?${BZA_API_KEY} | jq '.result.status' | tr -d \" )
while [ "$TEST_RUN_STATUS" != "ENDED" ]; do
        echo "Test status = " $TEST_RUN_STATUS
        sleep 60
        echo "Trying again .."
	TEST_RUN_STATUS=$(curl --silent --insecure ${BZA}/sessions/${SESSION_ID}?${BZA_API_KEY} | jq '.result.status' | tr -d \" )
done
echo "Test status = " $TEST_RUN_STATUS
