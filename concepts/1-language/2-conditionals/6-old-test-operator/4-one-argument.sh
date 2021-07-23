#!/usr/bin/env bash

# - https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Builtin-Commands - describes the "test" (i.e. "[") operator in detail

cd "$(dirname "${BASH_SOURCE[0]}")"

# - [ ! <expr> ] exits successfully if <expr> was null (i.e. <expr> is an empty string which in Bash is the same as nothing at all)
check_if_argument_is_null() {
    foo='foo'
    [ ! "$foo" ]; echo "$?" # 1
    bar=''
    [ ! "$bar" ]; echo "$?" # 0
}

# - [ <expr> ] exits successfully if <expr> was not null 
check_if_argument_is_not_null() {
    foo='foo'
    [ "$foo" ]; echo "$?" # 0
    bar=''
    [ "$bar" ]; echo "$?" # 1
}

check_complex_example() {
    # - The false command exits with 1, but does not evaluate to anything
    result=$(false)
    echo 'result is: ' $result # <nothing>
    # - "false" is an argument to the [ command, so "false" is treated as a string. "false" is not a null string. 
    [ false ]; echo "$?" # 0
    # - The evaluation of the false command doesn't return anything, so the command substitution evaluates to the null string
    # - This turns into the case of providing 0 arguments to the [ operator
    [ $(false) ]; echo "$?" # 1
    # - $not_set evaluates to the null string
    # - This turns into the case of providing 0 arguments to the [ operator
    [ $not_set ]; echo "$?" # 1
}

#check_if_argument_is_null
#check_if_argument_is_not_null
check_complex_example
