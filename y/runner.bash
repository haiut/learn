#!/bin/bash

#env
#
export BZA=http://qa.a.blazemeter.com/api/latest
export BZA_API_KEY="api_key=0b203f0b4cf4ee6abf99"

curl -k ${BZA}/tests/5002315?${BZA_API_KEY}
curl -k ${BZA}/tests/5002315/sessions?${BZA_API_KEY}
