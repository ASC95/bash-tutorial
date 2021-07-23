#!/usr/bin/env bash

# - https://tiswww.case.edu/php/chet/bash/bashref.html#Bash-Conditional-Expressions

cd "$(dirname "${BASH_SOURCE[0]}")"

check_if_file_exists() {
    #file='file-operators.sh'
    file='file operators.sh'
    if [ -a $file ]
    then
        printf '%s' "File $file exists" 
    else
        printf '%s' "File $file doesn't exist" 
    fi
}

check_if_file_exists