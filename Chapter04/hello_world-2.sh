#!/bin/bash

# A function to greet everyone

echo Who would you like to greet?

read name

greet_yourself () {
    echo Hello, ${1:-$USER}!
}

greet_yourself $name
