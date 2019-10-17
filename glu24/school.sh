#!/bin/bash 

cat -n Property_Tax_Roll.csv | grep 'MADISON SCHOOLS' | awk -F "," 'BEGIN{i=0}{\
	SUM += $7;i++ }; END {print SUM/i}'

