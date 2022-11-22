#!bin/bash

# Which place has the most transactions associated with it?
## Get the location column
## Sort them to prepare for the uniq command
## count unique occurrences
## sort in numeric reverse order
## pick the first element which will be the places with the most transcations 
most_common_place=$(awk -F ',' '{print $5}' data/bank_transactions.csv | sort | uniq -c | sort -bnr | head -1)

echo $most_common_place
