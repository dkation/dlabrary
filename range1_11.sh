#!/bin/bash
a=1
while true
do
    if [[ $a == 12 ]]
    then
       break
    else
        echo $a
        ((a++))
    fi
done
