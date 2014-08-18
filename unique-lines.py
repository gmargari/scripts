#!/usr/bin/python
import fileinput

lines_seen = set() # lines already seen
for line in fileinput.input():
    if line not in lines_seen:
        print line,
        lines_seen.add(line)


