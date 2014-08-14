#!/bin/bash

if [ $# -ne 1 -a $# -ne 2 ]; then
    echo "Syntax: $0 <percentile> [<number of demical digits>]"
    exit 1
fi

percentile=$1
if [ $# -eq 2 ]; then
    digits=$2
else
    digits=2;
fi

tmpfile=$(mktemp)
while read line; do
    echo ${line}
done | sort -n > ${tmpfile}

lines=`cat ${tmpfile} | wc -l`

cat ${tmpfile} | \
awk -v perc=${percentile} -v lines=${lines} -v digits=${digits}     \
'{                                                                  \
    if (NF > 1) {                                                   \
        print "ERROR: Number of columns more than 1";               \
        exit;                                                       \
    }                                                               \
    if (NR >= perc * lines) {                                       \
        printf "%.*f\n", digits, $1;                                \
        exit;                                                       \
    }                                                               \
}'

rm ${tmpfile}

