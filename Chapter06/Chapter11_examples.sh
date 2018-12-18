#!/bin/bash

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsgz | tail -n +2 | head -n 10000 | cut -f14 | awk 'BEGIN {FS="[^a-zA-Z]+"}; {for (i=1;i<NF;i++) words[$i] ++}; END {for (i in words) print words[i], i}' | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | tail -n +2 | cut -f8 | awk '{star[$0]++}; END {for (i in star) print i,star[i]}'

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | head -n 100 | python average.py



