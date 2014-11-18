#!/bin/bash

export BZA=http://qa.a.blazemeter.com/api/latest
export BZA_API_KEY=0b203f0b4cf4ee6abf99
export CURL_ARGS='--insecure -H "Content-Type: application/json" -H "x-api-key: 0b203f0b4cf4ee6abf99" '

TEST_ID=$(curl -X POST -d @test1.json -s -k -H "Content-Type: application/json" -H "x-api-key: ${BZA_API_KEY}"  ${BZA}/tests/custom?custom_test_type=yahoo | jq '.result.id' )

#TEST_ID=$(curl -X POST -d @test1.json $CURL_ARGS ${BZA}/tests/custom?custom_test_type=yahoo | jq '.result.id' )
if [ "$TEST_ID" = "null" ] ; then
	echo "Failed to create test"
	exit 1
fi

echo "Test created .. ID = " $TEST_ID

SESSION_ID=$(curl --silent --insecure ${BZA}/tests/${TEST_ID}/start?api_key=${BZA_API_KEY} | jq '.result.sessionsId[]' | tr -d \")
echo "Test started .."

TEST_RUN_STATUS=$(curl --silent --insecure ${BZA}/sessions/${SESSION_ID}?api_key=${BZA_API_KEY} | jq '.result.status' | tr -d \" )
while [ "$TEST_RUN_STATUS" != "ENDED" ]; do
        echo "Test status = " $TEST_RUN_STATUS
        sleep 60
        echo "Trying again .."
	TEST_RUN_STATUS=$(curl --silent --insecure ${BZA}/sessions/${SESSION_ID}?api_key=${BZA_API_KEY} | jq '.result.status' | tr -d \" )
done
echo "Test status = " $TEST_RUN_STATUS
