#!/usr/bin/env bash

# - https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Builtin-Commands - describes the "test" (i.e. "[") operator in detail

# - The -a option used this way is equivalent to combining two expressions with a logical AND 
# - Since [ is not a Bash keyword, the && is treated as a normal Bash && (See 1-language/conditionals/2-and-operator.sh), which messes up the [
#   operator
#   - Thus, the -a option is required to logical AND two expressions
logical_and_two_expressions() {
    if [ 'first' = 'first' -a 'second' = 'second' ]; then
    #if [ 'first' = 'first' && 'second' = 'second' ]; then
        echo 'Everything was true'
    else
        echo 'Something was false'
    fi
}

logical_and_two_expressions
