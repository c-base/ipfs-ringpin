#!/bin/bash -e
LIST_PATH=$1

cat $LIST_PATH | while read line
do
    ref=$(echo $line | cut -f 1 -d ' ')
    name=$(echo $line | cut -f 2 -d '#')
    echo "Pinning topic... $name"
    ipfs pin add -r $ref
done
