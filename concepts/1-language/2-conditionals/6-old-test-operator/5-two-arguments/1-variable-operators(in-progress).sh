#!/usr/bin/env bash

# - https://tiswww.case.edu/php/chet/bash/bashref.html#Bash-Conditional-Expressions

cd "$(dirname "${BASH_SOURCE[0]}")"

# - Providing two arguments to the test operator is also known as using the unary conditional operators, of which there are many. Nearly all of the
#   unary conditional operators check conditions for variables, files, or strings

# - -v <variable> : exits successfully if the shell variable is set (i.e. has been assigned a value)
#   - It does not matter if the variable is null or not
#   - <variable> is NOT supposed to be expanded
check_if_variable_is_set() {
    # - "my_var" is set and is not null
    my_var='foo'
    [ -v my_var ]; echo "$?" # 0
    # - "your_var" is set and is null
    your_var=''
    [ -v your_var ]; echo "$?" # 0
    # - "dog" is not set at all
    [ -v dog ]; echo "$?" # 1
}

check_if_variable_is_set