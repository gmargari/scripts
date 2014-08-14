#!/bin/bash

tmpfile=$(mktemp)
if [[ ! -z "$1" ]]; then
    if [[ ! -f "$1" ]]; then
    	echo "Error: file $1 does not exist."
    	exit 1;
    fi
    cat "$1" | sort -n > ${tmpfile}
else
    echo "# Reading data from stdin..."
    while read line; do
        echo ${line}
    done | sort -n > ${tmpfile}
fi

xmean_lines=`cat ${tmpfile} | awk '{n++; s+=$1} END{print s/n, n}'`
xmean=`echo $xmean_lines | awk '{print $1}'`
lines=`echo $xmean_lines | awk '{print $2}'`

cat $tmpfile | awk -v lines=$lines -v xmean=$xmean \
'
{
    if (NF != 1) {
        printf "Error: more than one columns";
        error = 1;
        exit 1;
    }

    rows++;
    if (NR == 1) { min = $1; max = $1; }
    if ($1 < min) min = $1;
    if ($1 > max) max = $1;
    sum += $1;
    sum2 += ($1 - xmean)^2;
    if (!p500 && NR >= 0.500 * lines) p500 = $1;
    if (!p900 && NR >= 0.900 * lines) p900 = $1;
    if (!p990 && NR >= 0.990 * lines) p990 = $1;
    if (!p999 && NR >= 0.999 * lines) p999 = $1;
}
END{
    if (error)
        exit 1;
    avg = sum/rows;
    std = sqrt(sum2/rows);
    printf "%-8s : %s\n", "rows", rows;
    printf "%-8s : %s\n", "sum", sum;
    printf "%-8s : %s\n", "min", min;
    printf "%-8s : %s\n", "max", max;
    printf "%-8s : %s\n", "avg", avg;
    printf "%-8s : %s\n", "std", std;
    printf "%-8s : %s , %s\n", "avg-+std", avg - std, avg + std;
    printf "%-8s : %s\n", "median  ", p500;
    printf "%-8s : %s\n", "90.0perc", p900;
    printf "%-8s : %s\n", "99.0perc", p990;
    printf "%-8s : %s\n", "99.9perc", p999;
}
'
rm "$tmpfile"
