#!/bin/bash
WATCH_ENDPOINT="http://127.0.0.1:9105/metrics"
KNOWN_CERTS_PATH="./conf/knowncerts.txt"

#for sha in  $(curl $WATCH_ENDPOINT | grep sha | awk -F "," '{print$1,$3}' | sort | uniq  | awk -F " " '{print$2}')
for domain in  $(curl -s $WATCH_ENDPOINT | awk -F " " '{print$1}' | grep sha  )
do
  #echo $domain
  sha=$(echo $domain | awk -F "," '{print$1,$3}' | sort | uniq | awk -F " " '{print$2}' )
  endpoint=$(grep $sha $KNOWN_CERTS_PATH | sort | uniq )
  #echo $sha
  #echo $endpoint
  if [ -z "$endpoint" ]
  then
        echo "!!Unknown certificate at $domain"
  fi
done

