#!/bin/bash


curl -s "https://api.weather.gov/points/42.5,-71.5"

sudo apt-get install -y jq

curl -s "https://api.weather.gov/points/42.5,-71.5" | jq -r '.| "\(.properties.cwa) \(.properties.gridX) \(.properties.gridY)"'

curl -s "https://api.weather.gov/points/42.5,-71.5" | jq -r '.| "\(.properties.forecastGridData)"'

curl -s "https://api.weather.gov/gridpoints/BOX/55,80" |  jq -r '[.properties.maxTemperature.values[1].validTime[0:10],.properties.maxTemperature.values[1].value] | @csv'

curl -s "https://api.weather.gov/gridpoints/BOX/55,80/stations" | jq -r '.observationStations[0]'

curl -s "https://api.weather.gov/stations/KBED/observations/current" | jq -r '[.properties.timestamp[0:10],.properties.temperature.value]| @csv'

gawk  'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } {count[$1]++ ; max[$1] = (count[$1]==1||max[$1]<$2)?$2:max[$1]} END{ for (i in max) print $i,max[$i]}' actual.csv

join -t',' <(gawk  'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } {count[$1]++ ; max[$1] = (count[$1]==1||max[$1]<$2)?$2:max[$1]} END{ for (i in max) print $i,max[$i]}' actual.csv ) forecast.csv

join -t',' <(gawk  'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } {count[$1]++ ; max[$1] = (count[$1]==1||max[$1]<$2)?$2:max[$1]} END{ for (i in max) print $i,max[$i]}' actual.csv ) forecast.csv | gawk 'BEGIN { FPAT = "([^,]+)|(\"[^\"]+\")" } {print $1,$2-$3}'


