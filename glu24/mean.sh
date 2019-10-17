#!/bin/bash                                                                     

column=$1
file=$2

if [[ $column == '' ]]; then
	    echo 'usage: mean.sh <column> [file.csv], that reads the column specified b\
		    y <column>(a number) from the comma-separated-values file (with header) specifi\
		    ed by [file.csv] (or from stdinif no [file.csv] is specified) and writes its me\
		    an.'
	        exit 0
fi

content=$(cut -d "," -f $column $file | tail -n +2)
sum=0
line_count=0
while read line; do
	    sum=$(bc -l <<<"${line}+${sum}")
	        line_count=$(bc -l <<< "${line_count}+1")
		   # echo "$line"                                                               
	    done <<< "$content"

	    mean=$(bc -l <<<"${sum}/${line_count}")
	    printf "mean of colum $column: %.4f\n" $mean
