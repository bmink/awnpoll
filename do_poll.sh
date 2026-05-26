#!/bin/bash

#set -x

source creds.env
 

RESP=`curl -s "https://rt.ambientweather.net/v1/devices?applicationKey=$AWN_APP_KEY&apiKey=$AWN_API_KEY"`

#echo "$RESP" | jq . | less

TEMPOUTF=`echo "$RESP" | jq -r '.[0].lastData.tempf'`
TEMPINF=`echo "$RESP" | jq -r '.[0].lastData.tempinf'`
HUMID=`echo "$RESP" | jq -r '.[0].lastData.humidity'`
DEWP=`echo "$RESP" | jq -r '.[0].lastData.dewPoint'`
DATE=`echo "$RESP" | jq -r '.[0].lastData.dateutc' | sed -e 's/000$//'`

#echo "Tempoutf: $TEMPOUTF"
#echo "Tempinf: $TEMPINF"
#echo "Humidity: $HUMID"
#echo "Dew Point: $DEWP"
#echo "Date: $DATE"

redis6-cli set "weather:awn:tempoutf" "$TEMPOUTF" > /dev/null
redis6-cli set "weather:awn:tempinf"  "$TEMPINF" > /dev/null
redis6-cli set "weather:awn:humid"    "$HUMID" > /dev/null
redis6-cli set "weather:awn:dewp"     "$DEWP" > /dev/null
redis6-cli set "weather:awn:date"     "$DATE" > /dev/null


