#!/bin/bash

count=1
while [ $count -le 10 ]; do
    if (( $count % 2 == 0 )); then
        ((count++))
        continue
    fi
        echo $count
        ((count++))
done