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

echo "3. Who is the customer with the highest average transaction amount?"

# Count how many transactions each user has
awk -F ',' '{print $2}' data/bank_transactions.csv | sort | uniq -c | sort -k 2 | awk 'BEGIN {FS = " ";OFS = ","} {print $1, $2}'  > counts.tmp 

# Get the total amounts for each user
awk 'BEGIN { FS=OFS=SUBSEP=","}{print $2, $9}' data/bank_transactions.csv | awk 'BEGIN { FS=OFS=SUBSEP=","} {arr[$1]+=$2} END {for (i in arr) print i,arr[i]}' | sort -k 1 -t ',' > amounts.tmp 

# Create a csv with id, total sum, and counts
paste counts.tmp amounts.tmp | awk 'BEGIN {FS=" "; OFS=","} {print $1, $2}' | awk 'BEGIN {FS=","; OFS=","} {print $2, $4, $1}' > count_amounts.tmp

# Calculate the average
highest_avg=$(awk 'BEGIN {FS=OFS=","} {$4 = $2 / $3}1' count_amounts.tmp | sort -t ',' -nr -k 4 | head -1)

# Get the fields we are interested in
id=$(awk -F ',' '{print $1}' <<< "$highest_avg")
avg=$(awk -F ',' '{print $4}' <<< "$highest_avg")

echo "The customer with the highest average transaction amount is '$id' with an average amount of '$avg' INR."

# Clean up
rm -f ./*.tmp
