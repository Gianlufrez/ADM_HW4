#!bin/bash

# Which place has the most transactions associated with it?
## Get the location column
## Sort them to prepare for the uniq command
## count unique occurrences
## sort in numeric reverse order
## pick the first element which will be the places with the most transcations 
most_common_place=$(awk -F ',' '{print $5}' data/bank_transactions.csv | sort | uniq -c | sort -bnr | head -1)

echo $most_common_place

# Did females spend more than males, or vice versa?
## Get the gender and the transaction amount columns
## Sum up the transaction amounts for men and women
## Compare the amounts
men_total_expenditure=$(awk -F "," '{print $4, $9}' data/bank_transactions.csv | awk '{if ($1=="M") {print $2}}' | awk '{s+=$1} END {print s}')

women_total_expenditure=$(awk -F "," '{print $4, $9}' data/bank_transactions.csv | awk '{if ($1=="F") {print $2}}' | awk '{s+=$1} END {print s}')

echo "Men spent: $men_total_expenditure"
echo "Women spent: $women_total_expenditure"

