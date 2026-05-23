#!/bin/bash

set -x

source creds.env

curl "https://rt.ambientweather.net/v1/devices?applicationKey=$AWN_APP_KEY&apiKey=$AWN_API_KEY" | jq . | less

