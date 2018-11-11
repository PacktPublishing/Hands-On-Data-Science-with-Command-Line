#!/bin/bash

TMP_PATH=/bin:/usr/bin:/sbin:/usr/sbin
IFS=:
PATH_ARRAY=($TMP_PATH)
unset IFS

echo First element - ${PATH_ARRAY}
echo First element - ${PATH_ARRAY[0]}
echo Second element - ${PATH_ARRAY[1]}
echo All elements - ${PATH_ARRAY[*]}
echo All elements - ${PATH_ARRAY[@]}

