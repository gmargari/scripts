#/bin/bash

if [ $# -ne 2 ]; then
    echo "Syntax: $0 <min int> <max int>"
    exit 1
fi

min=$1
max=$2
python -c "import random; print random.randrange(${min},${max})"
