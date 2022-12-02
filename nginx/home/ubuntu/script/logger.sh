#!/bin/bash

while true; do
  cat /var/log/nginx/access.log >> ~/logs/overall-logs.log;
  sudo truncate -s 0 /var/log/nginx/access.log;
  cat /var/log/nginx/error.log >> ~/logs/overall-logs.log;
  sudo truncate -s 0 /var/log/nginx/error.log;
  awk  '{
   if ($7 ~ /request_status=4../)
     print $0 >> "/home/ubuntu/logs/400-error.log"
   else if ($7 ~ /request_status=5../)
     print $0 >> "/home/ubuntu/logs/500-error.log"
   }' /home/ubuntu/logs/overall-logs.log;
  export size=$(wc --bytes ~/logs/overall-logs.log | awk '{print $1}');
  if [[ $size -gt 512000 ]]
  then
    export date=$(date)
    truncate -s 0 /home/ubuntu/logs/overall-logs.log
    echo "$date logs file has been wiped" >> /home/ubuntu/logs/cleanup-history.log
  fi;
 sleep 5; 
 done