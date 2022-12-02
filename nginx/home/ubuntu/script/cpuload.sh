#!/bin/bash

while true; do
 mpstat | grep all > ~/load/load.txt;
 export cpufree=$(awk '{print $NF}' ~/load/load.txt);
 echo free $cpufree
 export cpuload=$(echo "(100-$cpufree)"|bc -l);
 echo load $cpuload;
 awk -v x="CPU load is $cpuload" 'BEGIN{pat = "CPU load is [0-9\\\\.]+"} {gsub (pat, x); print}' ~/site/solid/index.html > ~/load/index.html;
 mv ~/load/index.html ~/site/solid/index.html;
 set $cpufree=100;
 set $cpuload=0;
 sleep 0.5; 
done

