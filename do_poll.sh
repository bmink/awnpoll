#!/bin/bash

#set -x

source creds.env
 

RESP=`curl -s "https://rt.ambientweather.net/v1/devices?applicationKey=$AWN_APP_KEY&apiKey=$AWN_API_KEY"`

#echo "$RESP" | jq . | less

TEMPF=`echo "$RESP" | jq -r '.[0].lastData.tempf'`
TEMPINF=`echo "$RESP" | jq -r '.[0].lastData.tempinf'`
HUMID=`echo "$RESP" | jq -r '.[0].lastData.humidity'`
DEWP=`echo "$RESP" | jq -r '.[0].lastData.dewPoint'`
DATE=`echo "$RESP" | jq -r '.[0].lastData.dateutc' | sed -e 's/000$//'`

#echo "Tempoutf: $TEMPF"
#echo "Tempinf: $TEMPINF"
#echo "Humidity: $HUMID"
#echo "Dew Point: $DEWP"
#echo "Date: $DATE"


redis6-cli set "weather:awn:tempf" "$TEMPF" > /dev/null
redis6-cli set "weather:awn:tempinf"  "$TEMPINF" > /dev/null
redis6-cli set "weather:awn:humid"    "$HUMID" > /dev/null
redis6-cli set "weather:awn:dewp"     "$DEWP" > /dev/null
redis6-cli set "weather:awn:date"     "$DATE" > /dev/null


# Update daily max and min if needed
CURDAY=`date "+%Y-%m-%d"`
CURMINMAXDAY=`redis6-cli get "weather:awn:curminmaxday"`

if [ "$CURDAY" != "$CURMINMAXDAY" ]; then
	# A new day, reset min and max

	redis6-cli set "weather:awn:curminmaxday" "$CURDAY" > /dev/null
	redis6-cli set "weather:awn:dayminf" "$TEMPF" > /dev/null
	redis6-cli set "weather:awn:daymaxf" "$TEMPF" > /dev/null
else
	# Compare and update as needed

	DAYMINF=`redis6-cli get "weather:awn:dayminf"`
	if awk "BEGIN { exit !($TEMPF < $DAYMINF) }"; then
		redis6-cli set "weather:awn:dayminf" "$TEMPF" > /dev/null
	fi

	DAYMAXF=`redis6-cli get "weather:awn:daymaxf"`
	if awk "BEGIN { exit !($TEMPF > $DAYMAXF) }"; then
		redis6-cli set "weather:awn:daymaxf" "$TEMPF" > /dev/null
	fi

fi


