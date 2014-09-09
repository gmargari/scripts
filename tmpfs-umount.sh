#!/bin/bash 

if [ $# -ne 1 ]; then
    echo "Syntax: $0 <directory>"
    exit 1
fi
dir=$1

sudo umount $dir
