#!/bin/bash

f_to_c() {
    awk "BEGIN {printf \"%.1f\", ($1 - 32) * 5/9}"
}

TEMPF=`redis6-cli get "weather:awn:tempf"`
TEMPINF=`redis6-cli get "weather:awn:tempinf"`
HUMID=`redis6-cli get "weather:awn:humid"`
DEWP=`redis6-cli get "weather:awn:dewp"`
DATE=`redis6-cli get "weather:awn:date"`
NOW=`date +%s`
AGO=$(( NOW - DATE ))
DAYMINF=`redis6-cli get "weather:awn:dayminf"`
DAYMAXF=`redis6-cli get "weather:awn:daymaxf"`

TEMPC=$(f_to_c $TEMPF)
TEMPINC=$(f_to_c $TEMPINF)
DEWPC=$(f_to_c $DEWP)
DAYMINC=$(f_to_c $DAYMINF)
DAYMAXC=$(f_to_c $DAYMAXF)

echo
echo "Weather ($AGO sec ago)"
echo "-----------------------------"
printf "Outdoor temp:  %5.1f °F | %5.1f °C\n" $TEMPF $TEMPC
printf "Indoor temp :  %5.1f °F | %5.1f °C\n" $TEMPINF $TEMPINC
printf "Today's low :  %5.1f °F | %5.1f °C\n" $DAYMINF $DAYMINC
printf "Today's high:  %5.1f °F | %5.1f °C\n" $DAYMAXF $DAYMAXC
printf "Dew point   :  %5.1f °F | %5.1f °C\n" $DEWP $DEWPC
printf "Humidity    :  %3d %% \n" $HUMID
echo
