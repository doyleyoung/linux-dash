#!/bin/bash
awkCmd=`which awk`
grepCmd=`which grep`
sedCmd=`which sed`
ifconfigCmd=`which ifconfig`
trCmd=`which tr`
digCmd=`which dig`

externalIp=`$digCmd +short myip.opendns.com @resolver1.opendns.com`

result=""

result+="["

for item in $($ifconfigCmd | $grepCmd -oP "^([a-zA-Z0-9\-]+)")
do 
    result+="{\"interface\" : \""$item"\", \"ip\" : \"$( $ifconfigCmd $item | $grepCmd "inet" | $awkCmd '{match($0,"inet\\s(addr:)(\\S+)\\s",a); print a[2]; }')\"}, "
done

result+="{\"interface\": \"external\", \"ip\": \"$externalIp\"}]"

echo "$result"
