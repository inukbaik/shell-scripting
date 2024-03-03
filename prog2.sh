#!/bin/bash

# if either the data file or the output file path is not provided, print "data file or output file not found"
if [ "$#" -ne 2 ]; then
    echo "data file or output file not found"
    exit 1
fi

data_file="$1"
output_file="$2"

# if the data file does not exist, print "<filename> not found"
if [ ! -f "$data_file" ]; then
    echo "$data_file not found"
    exit 1
fi

# if the output file does not exist, create it
if [ ! -f "$output_file" ]; then
    touch "$output_file"
fi

# if the output file exists, overwrite it
if [ -f "$output_file" ]; then
    rm "$output_file"
    touch "$output_file"
fi

# declare the array for column sums and initialize it to 0
declare -a col_sums

# loop over the lines in the input file
# read the numbers from the line which is separated by ',' or ';' or ':'
# sum the numbers and add it to the corresponding column sum
# write the output to the output file
while read line; do
    IFS=':;,'
    read -ra nums <<< "$line"
    for (( i=0; i<${#nums[@]}; i++ )); do
        col_sums[$i]=$((${col_sums[$i]} + ${nums[$i]}))
    done
done < "$data_file"

for (( i=0; i<${#col_sums[@]}; i++ )); do
    echo "Col $(($i+1)) : ${col_sums[$i]}" >> "$output_file"
done