#!/bin/bash

pwd

mkdir foo

ls

ls -l

cd foo

echo “Hello world...” > hello.txt

cat hello.txt

echo -e "1\n3\n19\n1\n25\n5" > numbers.txt

cat numbers.txt

cat numbers.txt | sort -n

cat numbers.txt | sort -n | uniq

history

export PS1="\u@\h:\w>"
