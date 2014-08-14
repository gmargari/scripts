#!/bin/bash 

free -om | grep -v ^Swap

echo "sudo sync ..."
sudo sync

echo "echo 3 > /proc/sys/vm/drop_caches ..."
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

free -om | grep ^Mem