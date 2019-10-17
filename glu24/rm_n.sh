#!/bin/bash
if [ $# != 2 ]; then
    echo "usage: rm_n <dir> <n>"
    exit 0
fi
find $1 -type f -size +$2c -exec rm {} \;
