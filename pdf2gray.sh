#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Syntax: $0 <input file> <output file>"
    exit 1
fi

inputfile=$1
outputfile=$2

gs -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
-dCompatibilityLevel=1.4 -dAutoRotatePages=/None -dNOPAUSE -dBATCH \
-sOutputFile=${outputfile} \
 ${inputfile}
 