#!/bin/bash

cat all_reviews.csv | awk -F ","  '{print $4}' | grep -i Packt > background_words.txt &

nohup cat all_reviews.csv | awk -F ","  '{print $4}' | grep -i Packt > background_words.txt &

sudo apt install -y screen tmux
