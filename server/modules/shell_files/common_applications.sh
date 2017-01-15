#!/bin/bash
result=$(whereis java node mysql apache2 openssl php \
| awk -F: '{if(length($2)==0) { installed="false"; } else { installed="true"; } \
			print \
			"{ \
				\"binary\": \""$1"\", \
				\"location\": \""$2"\", \
				\"installed\": "installed" \
			},"}')

echo "[" ${result%?} "]"
