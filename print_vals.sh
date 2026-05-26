#!/bin/bash

TEMPF=`redis6-cli get "weather:awn:tempf"`
TEMPINF=`redis6-cli get "weather:awn:tempinf"`
HUMID=`redis6-cli get "weather:awn:humid"`
DEWP=`redis6-cli get "weather:awn:dewp"`
DATE=`redis6-cli get "weather:awn:date"`
NOW=`date +%s`
AGO=$(( NOW - DATE ))
DAYMINF=`redis6-cli get "weather:awn:dayminf"`
DAYMAXF=`redis6-cli get "weather:awn:daymaxf"`

echo "Weather ($AGO sec ago)"
echo "-----------------------------"
echo "Outdoor temp:  $TEMPF °F"
echo "Indoor temp:   $TEMPINF °F"
echo "Humidity:      $HUMID%"
echo "Dew point:     $DEWP °F"
echo "Today's low:   $DAYMINF °F"
echo "Today's high:  $DAYMAXF °F"
