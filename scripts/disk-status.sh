#!/bin/bash
# Takes current path as only argument, outputs % free of current storage device
PERCENT_USED=$(df --output=target,pcent -h $1 | sed '1d' | awk '{ print $2 }' | sed 's/%//')
[ "${PERCENT_USED#}" == 0 ] && PERCENT_USED="0"
printf "%s%%\n" $(expr 100 - $PERCENT_USED)
