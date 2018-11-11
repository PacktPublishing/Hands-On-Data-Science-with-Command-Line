#!/bin/bash

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | tail -n +2 | head<

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f15 | cut -d$'-' -f2,3,1 | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -c1-12 | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | tail -n +2 | grep "^3" | head

join -j2 <(zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2 | sort | uniq -c) <(zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv.gz | cut -d$'\t' -f2 | sort | uniq -c) | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f 2 | sort | uniq -c | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | awk '{sum[$1]+=$2;count[$1]+=1} END {for (i in sum) {print i,sum[i],count[i],sum[i]/count[i]}}' | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | awk '{sum[$1]+=$2;count[$1]+=1} END {for (i in sum) {print i,sum[i],count[i],sum[i]/count[i]}}' | sort -k3 -r -n | head

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz | cut -d$'\t' -f2,8 | awk '{sum[$1]+=$2;count[$1]+=1} END {for (i in sum) {print i,sum[i],count[i],sum[i]/count[i]}}' | sort -k3 -r -n | awk '$3 >= 100 && $3 <=200' | head

cp database.sq3 backups/`date +%F`-database.sq3

sudo apt install sqlite3

sqlite3 test.sq3 <<EOF
.mode csv
.separator "\t"
.import test.csv test_reviews
EOF


COLS=`head  amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv | head -n1 | sed -e 's:^\|$:":g; s:\t:", ":g'`
VALUES=`head  amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv | tail -n1 | sed -e 's:^\|$:":g; s:\t:", ":g'`


sqlite3 reviews.sq3 "create table ‘aws-reviews’ ( $COLS) ;"

sqlite3 reviews.sq3 “.tables

sqlite3 reviews.sq3 “.schema aws-reviews”

head -n21 amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv | sed '1d; s/"/""/g ; s/\t/", "/g;' | while read LINE ; do VALUES="\"${LINE}\"" ; sqlite3 reviews.sq3 "insert into aws_reviews ($COLS) VALUES ($VALUES) ;"; done


sqlite3 reviews.sq3 “select * from aws_reviews”


