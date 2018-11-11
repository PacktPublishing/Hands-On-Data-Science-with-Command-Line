#!/bin/bash

gnuplot -e “set terminal sixelgd background rgb ‘white’; test”


head  amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv

head -n1  amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv


cat amazon_reviews_us_Digital_Ebook_Purchase_v1_00.tsv | cut -d ' ' -f 4,8-12,15 > test.tsv
sqlite3 aws-ebook-reviews.sq3 <<EOF
.mode csv
.separator "\t"
.import test.tsv reviews
EOF


sqlite3 aws-ebook-reviews.sq3 <<EOF
.mode csv
.separator "\t"
.import test.tsv reviews
EOF


sqlite3 -header -column aws-ebook-reviews.sq3 " select product_id as ID, strftime('%Y-%m', review_date) DATE, star_rating as STAR, count(product_id) as COUNT from reviews group by ID order by COUNT desc limit 10"

sqlite3 -header -column aws-ebook-reviews.sq3 " select strftime('%Y-%m', review_date) DATE, star_rating as STAR, count(star_rating) as COUNT from reviews where product_id = 'B00L9B7IKE' group by DATE, STAR"


sqlite3 -header aws-ebook-reviews.sq3 "select DATE, MAX(CASE WHEN STAR='1' THEN COUNT END) as '1STAR', MAX(CASE WHEN STAR='2' THEN COUNT END) as '2STAR', MAX(CASE WHEN STAR='3' THEN COUNT END) as '3STAR', MAX(CASE WHEN STAR='4' THEN COUNT END) as '4STAR', MAX(CASE WHEN STAR='5' THEN COUNT END) as '5STAR', SUM(COUNT) as TOTAL from ( select strftime('%Y-%m', review_date) DATE, star_rating as STAR, count(star_rating) as COUNT from reviews where product_id = 'B00L9B7IKE' group by DATE, STAR) results group by DATE" | tr '|' '\t' > clusterchart.dat
cat clusterchart.dat


gnuplot -e "set style data histograms ; set style fill solid border lt -1 ; plot 'clusterchart.dat' using 2:xtic(1) ti col, '' u 3 ti col, '' u 4 ti col, '' u 5 ti col, '' u 6 ti col"


GNUTERM=dumb gnuplot -e "set style data histograms ; set style fill solid border lt -1 ; plot 'clusterchart.dat' using 2:xtic(1) ti col, '' u 3 ti col, '' u 4 ti col, '' u 5 ti col, '' u 6 ti col"


GNUTERM=dumb gnuplot -e "set style data histograms ; set style fill solid border lt -1 ; plot 'clusterchart.dat' using 2:xtic(1) ti col, '' u 3 ti col, '' u 4 ti col, '' u 5 ti col, '' u 6 ti col"


barchart -s -f clusterchart.dat 'plot for [i=2:6] $data using i:xtic(1)'


barchart -s -f clusterchart.dat 'plot for [i=2:6] $data using (100.*column(i)/column(7)):xtic(1) title column(i)'
