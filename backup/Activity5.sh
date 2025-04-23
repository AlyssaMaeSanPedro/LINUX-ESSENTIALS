#!/bin/bash

echo "1. Write a while loop that prints numbers from 1 to 10."

count=1
while [ $count -le 10 ]; do
        echo $count
        ((count++))
done

echo -e "\n2. Modify the script to skip even numbers using continue."

count2=1
while [ $count2 -le 10 ]; do
    if (( $count2 % 2 == 0 )); then
        ((count2++))
        continue
    fi
        echo $count2
        ((count2++))
done

echo -e "\n3. Write a script that renames .jpg files to .png."

for file in *.jpg; do
mv "$file" "${file%.jpg}.png"
echo "Renamed $file to ${file%.jpg}.png"
done