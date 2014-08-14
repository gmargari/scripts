#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 <eps folder>"
    exit
fi

infolder=$1
outfolder="simplified/"

cd $infolder
mkdir -p $outfolder
echo "[ Outpuf folder: $outfolder ]"

find ./ -maxdepth 1 -type f -name '*.eps' | while read -r file; do
    echo $file
    eps2eps $file $outfolder/$file
done
