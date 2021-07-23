#!/usr/bin/env bash

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals
# - https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Builtin-Commands - describes the "test" (i.e. "[") operator in detail
# - https://tiswww.case.edu/php/chet/bash/bashref.html#Bash-Conditional-Expressions - Bash unary conditional operators

cd "$( dirname "${BASH_SOURCE[0]}")"

# - If two arguments are provided to the test operator:
#   - If the first argument is ! (logical NOT), then [ evaluates to true if the second argument is null
#   - If the first argument is a unary conditional operator, then [ evaluates to true if the unary test is true 
two_arguments() {
    # - $not_set expands to nothing (i.e. an empty string)
    [ ! $not_set ]; echo "$?" # 0
    # - Return true if the file exists
    [ -a  'string-conditions.sh' ]; echo "$?" # 0

    [ -a  '1-exit-statuz.sh' ]; echo "$?" # 1
    # - Return true if the file exists and is a symbolic link
    [ -h  'string-conditions-symlink.sh' ]; echo "$?" # 1
    # - This is false because $my_var expands to 'foo', and the variable 'foo' is not set
    [ -v $my_var ]; echo "$?" # 1
}

# - "-R": true if the shell variable varname is set and is a name reference
check_if_variable_is_name_reference() {
    # - "bish" is a name reference. Since it is a name reference, it IS set to something, so it is set
    declare -n bish=bay
    [ -R bish ]; echo $? # 0
    # - "wish" is not a name reference
    wish=whoa
    [ -R wish ]; echo $? # 1
    # - "dish" is not a name reference (it's also not even declared, but that's irrelevant)
    [ -R dish ]; echo $? # 1
}

two_arguments
#check_if_variable_is_set
#check_if_variable_is_name_reference
