#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Syntax: $0 <size_in_mb> <directory>"
    exit 1
fi
size=$1
dir=$2

mkdir -p ${dir}
cmd="sudo mount -o size=${size}M -t tmpfs tmpfs ${dir}"

$cmd
