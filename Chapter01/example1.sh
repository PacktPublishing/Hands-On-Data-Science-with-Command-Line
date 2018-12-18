#!/bin/bash

cat file.txt | tr '[:space:]' '[\n*]' | grep -v "^$" | sort | uniq -c | sort -bnr (tr '[:space:]' '[\n*]' | grep -v "^$" | sort | uniq -c | sort -bnr )<file.txt
