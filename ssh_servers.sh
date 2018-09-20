#!/bin/sh

FILE=`readlink -f $0`
FILE_PATH=`dirname $FILE`

opts=()
params=()

mapfile -t < ${FILE_PATH}/servers

serverLength=${#MAPFILE[@]}

for (( i=1; i<${serverLength}+1; i++ ));
do
   opt=`echo ${MAPFILE[$i-1]}  | tr -s [:blank:] | cut -d' ' -f1-3 | tr [:blank:] _`
   opts+=($opt)
   param=`echo ${MAPFILE[$i-1]}  | tr -s [:blank:] | cut -d' ' -f2-4 | tr [:blank:] _`
   params+=($param)
done

select o in "${opts[@]}"
do
  if [[ $o =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        selectedParam=`echo ${params[$REPLY-1]} | tr _ ' '`
        echo 'login ...'
        ${FILE_PATH}/login.exp ${selectedParam}
        break
  else
        echo 'invalid option'
  fi
done
