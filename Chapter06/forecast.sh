#!/bin/bash
curl -s "https://api.weather.gov/gridpoints/BOX/55,80" |  jq -r '[.properties.maxTemperature.values[1].validTime[0:10],.properties.maxTemperature.values[1].value] | @csv'

