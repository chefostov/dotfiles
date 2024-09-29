#!/bin/bash

# Shows the most resource-consuming processes

# Collect the top 10 processes by CPU, memory, IO, and time
topcpu=$(ps aux --sort=-%cpu | awk 'NR==1 || NR<=11 {printf "%-8s %-8s %-8s %-8s %-10s %s\n", $1, $2, $3, $4, $11, $12}' | column -t)
topmem=$(ps aux --sort=-%mem | awk 'NR==1 || NR<=11 {printf "%-8s %-8s %-8s %-8s %-10s %s\n", $1, $2, $3, $4, $11, $12}' | column -t)
topio=$(sudo iotop -b -o -n 10 | head -n 12 | column -t)
toptime=$(ps aux --sort=-time | awk 'NR==1 || NR<=11 {printf "%-8s %-8s %-8s %-10s %s\n", $1, $2, $10, $11, $12}' | column -t)

# Print and format the results
echo "Top 10 processes by CPU usage:"
echo "$topcpu"
echo

echo "Top 10 processes by memory usage:"
echo "$topmem"
echo

echo "Top 10 processes by I/O usage:"
echo "$topio"
echo

echo "Top 10 processes by time:"
echo "$toptime"
