#!/bin/bash
<<'comment'
for item in apple banana cherry; do
    echo "Fruit: $item"
done

for file in *.txt; do
    echo "Processing file: $file"
done

for num in 1 2 3 4 5; do
    echo "Number: $num"
done

count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done

# IFS - Internal Field Separator
# while loop - runs until a condition becomes false
while IFS= read -r line; do
    echo "Line: $line"
done < sample.txt

# until loop - runs until a condition becomes true
number=1
until [ $number -gt 5 ]; do
    echo "Number: $number"
    ((number++))
done

for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Stopping loop at $i"
        break
    fi
    echo "Number: $i"
done
comment
for i in {1..5}; do
    if [ $i -eq 3 ]; then
        echo "Skipping $i"
        continue
    fi
    echo "Number: $i"
done