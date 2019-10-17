#!/bin/bash
sum=0
for i in 1{0..1}{0..1}{0..1};
do
    sum=$(($sum + $i))
done
echo $sum

