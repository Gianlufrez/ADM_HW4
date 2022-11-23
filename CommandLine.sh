#!bin/bash
# 1. Which place has the most transactions associated with it?
## Get the location column
## Sort them to prepare for the uniq command
## count unique occurrences
## sort in numeric reverse order
## pick the first element which will be the places with the most transcations 
most_common_place=$(awk -F ',' '{print $5}' data/bank_transactions.csv | sort | uniq -c | sort -bnr | head -1)
place=$(awk -F " " '{print $2}' <<< "$most_common_place")
amount=$(awk -F " " '{print $1}' <<< "$most_common_place")

printf -- '-%.0s' {1..50}
printf '\n'
echo "1. Which place has the most transactions associated with it?"
echo "The most common place is '$place' with '$amount' transactions."
printf -- '-%.0s' {1..50}
printf '\n'

#2. Did females spend more than males, or vice versa?
## Get the gender and the transaction amount columns
## Sum up the transaction amounts for men and women
## Compare the amounts
men_total_expenditure=$(awk -F "," '{print $4, $9}' data/bank_transactions.csv | awk '{if ($1=="M") {print $2}}' | awk '{s+=$1} END {print s}')

women_total_expenditure=$(awk -F "," '{print $4, $9}' data/bank_transactions.csv | awk '{if ($1=="F") {print $2}}' | awk '{s+=$1} END {print s}')

# When summing the total, we get scientific notation. Creating a sequence gives us the actual number
men=$(seq "$men_total_expenditure" "$men_total_expenditure")
women=$(seq "$women_total_expenditure" "$women_total_expenditure")

echo "2. Who spent more, males or females?"
echo "Men spent: $men INR"
echo "Women spent: $women INR"

if [[ $men -gt $women ]]
then
	echo "Men spent more than women."
else
	echo "Women spent more than men."
fi

printf -- '-%.0s' {1..50}
printf '\n'


#3. Report the customer with the highest average transaction amount in the dataset.
## Find all unique customer ids
## For each customer id, find all transactions
awk 'BEGIN { FS=OFS=SUBSEP=","}{print $2, $9}' data/bank_transactions.csv | awk 'BEGIN { FS=OFS=SUBSEP=","} {arr[$1]+=$2} END {for (i in arr) print i,arr[i]}' | sort -nr -k 2 -t ','
