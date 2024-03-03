#!/bin/bash

# Check if the first argument has been provided and has '*.txt' format
if [ "$#" -eq 0 ] || [[ ! "$1" =~ ^.*\.txt$ ]]; then
    echo "missing data file"
    exit 1
fi

data_file="$1"
weights=("${@:2}")

# Read the header line to get the number of parts (N)
IFS=',' read -ra header < "$data_file"
num_parts=$((${#header[@]} - 1))

# if no weights are provided, set all weights to 1
if [ ${#weights[@]} -eq 0 ]; then
    weights=($(awk -v num_parts="$num_parts" 'BEGIN { for (i=1; i<=num_parts; i++) print 1 }'))
fi

# if the number of weights provided is not equal to the number of parts,
# 1. if the number of weights provided less than the number of parts, set the remaining weights to 1
# 2. if the number of weights provided greater than the number of parts, ignore the extra weights
if [ ${#weights[@]} -lt $num_parts ]; then
    weights+=($(awk -v num_parts="$num_parts" -v weights="${#weights[@]}" 'BEGIN { for (i=1; i<=num_parts-weights; i++) print 1 }'))
elif [ ${#weights[@]} -gt $num_parts ]; then
    weights=("${weights[@]:0:$num_parts}")
fi

# read the lines and compute the weighted average
avg_sum=0
students=0
while IFS=',' read -ra line
do
    total_weight=0
    weighted_sum=0
    for (( i=1; i<=num_parts; i++ ))
    do
        weighted_sum=$((weighted_sum + line[i] * weights[i-1]))
        total_weight=$((total_weight + weights[i-1]))
    done
    avg_sum=$((avg_sum + weighted_sum / total_weight))
    students=$((students + 1))
done < "$data_file"

# compute the rounded average
result=$((avg_sum / students))
rounded_result=$(printf "%.0f" $result)
echo "$rounded_result"
