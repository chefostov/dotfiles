#!/bin/bash

# Change the terminal title
echo -e "\033]0;${1}\007"

# Print the new title
echo "Terminal title changed to: ${1}"
