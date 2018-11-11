#!/bin/bash

# A function to greet everyone

greet_everyone () {
    echo Hello, World!
}

greet_yourself () {
    echo Hello, ${USER}
}

greet_everyone
greet_yourself

