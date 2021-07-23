#!/usr/bin/env bash

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals
# - https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Builtin-Commands - describes the old test (i.e. [) operator in detail
# - https://tiswww.case.edu/php/chet/bash/bashref.html#Bash-Conditional-Expressions - Bash unary conditional operators

cd "$(dirname "${BASH_SOURCE[0]}")"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# - TLDR: always double quote variable expansions within the old test condition. Also, don't use the old test operator. Use the new test operator
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# - "-z": true if the length of string is zero (i.e. true if the string is null)
#   - It doesn't matter how the string was created (it could have been expanded from a variable or not)
check_if_string_is_null() {
    # - foo is set and it expands to the null string. This is NOT the case of providing one argument to [
    foo=''
    [ -z $foo ]; echo $? # 0
    [ -z $loo ]; echo $? # 0

    # - blah is not set, so it expands to the null string. This actually turns into the case of providing one argument to [
    [ -z $blah ]; echo $? # 0
    # - "blah" is literally the string "blah" which has length greater than 0, so it isn't null
    [ -z blah ]; echo $? # 1
}

# - Use the -n unary conditional operator to return true if the string is NOT null (i.e. it has length greater than 0)
check_if_string_is_not_null() {
    [ -n '' ]; echo $? # 1
    [ -n ' ' ]; echo $? # 0
    # - This is the case of providing one argument to [, which evaluates to true since -n is not null
    [ -n ]; echo $? # 0
    # - This is the case of providing one argument to [, which evaluates to true since -n is not null. This is EXTREMELY confusing because I thought
    #   that I was evaluating whether or not $cat was null
    #   - This is why I must use the new test operator instead of the old test operator
    [ -n $cat ]; echo $? # 0
    # - cat is unset, so it expands to null. Since I double quoted the variable expansion, THIS correctly tells me that cat is indeed null
    [ -n "$cat" ]; echo $? # 1
}

check_if_string_is_null
#check_if_string_is_not_null
