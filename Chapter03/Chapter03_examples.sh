#!/bin/bash

curl -O https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv.gz && curl -O https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz

ls -al amazon*

zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv.gz >> amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv && zcat amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv.gz >> amazon_reviews_us_Digital_Ebook_Purchase_v1_01.tsv

cat *.tsv > reviews.tsv

wc -l reviews.tsv

cut -d$'\t' -f 6,8,13,14 reviews.tsv | more

cut -d$'\t' -f 6,8,13,14 reviews.tsv > stripped_reviews.tsv

grep -i Packt stripped_reviews.tsv | wc -w

cat stripped_reviews.tsv | tr "\\t" "," >  all_reviews.csv

cat all_reviews.csv | awk -F ","  '{print $4}' | grep -i Packt

cat all_reviews.csv | awk -F ","  '{print $4}' | grep -i Packt > background_words.txt &

nohup cat all_reviews.csv | awk -F ","  '{print $4}' | grep -i Packt > background_words.txt &

sudo apt install -y screen tmux
