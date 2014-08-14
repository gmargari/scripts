#!/bin/bash

if [ $# -ne 1 -a $# -ne 2 ]; then
    echo "Syntax: $0 <window size> [<number of demical digits>]"
    exit 1
fi

windowsize=$1
if [ $# -eq 2 ]; then
    digits=$2
else
    digits=2;
fi

while read line; do
    echo ${line}
done |                                                      \
awk -v winsize=$windowsize -v digits=$digits               \
'{                                                          \
    if (columns == 0)                                       \
        columns = NF;                                       \
    if (NF != columns) {                                    \
        printf "Line %d has different number of columns than default (%d instead of %d)\n",NR, NF, columns;                                \
        exit 1;                                             \
    }                                                       \
    for (i = 1; i <= NF; i++)                               \
        sum[i] += $(i) - t[i,winsize];                      \
    for (i = 1; i <= NF; i++)                               \
        for (w = winsize; w >= 2; w--)                      \
            t[i,w] = t[i,w-1];                              \
    for (i = 1; i <= NF; i++)                               \
        t[i,1] = $(i);                                      \
    if (NR >= winsize) {                                    \
        for (i = 1; i <= NF; i++)                           \
            printf "%.*f ", digits, sum[i]/winsize;         \
        print "";                                           \
    }                                                       \
}'

