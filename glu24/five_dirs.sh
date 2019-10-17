#!/bin/bash
mkdir five
mkdir five/dir{1..5}
touch five/dir{1..5}/file{1..4}
for i in $(seq 5);do
    for j in $(seq 4);do
	for k in $(seq $j);do
	    echo $j>>five/dir$i/file$j
	done
    done
    done
