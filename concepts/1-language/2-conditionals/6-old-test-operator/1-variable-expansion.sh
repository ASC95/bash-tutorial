#!/usr/bin/env bash

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals - explains that [ is a Bash command. Hence, there are no special variable expansion
#   rules associated with it because it's a normal Bash parser context. Therefore, variables should be quoted for safety. In contrast, [[ is a Bash
#   keyword, so it parses arguments before the Bash parser and thus does not word-split variables. Thus, varibles do not need to be quoted for safety.
#   However, both [ and [[ will interpret quoted and unquoted literals the same way. Namely, unquoted literals with whitespace in between them are
#   separate arguments

cd "$(dirname "${BASH_SOURCE[0]}")"

test_without_variable_quotes() {
    v1='foo bar'
    v2='foo bar'
    if [ $v1 = $v2 ] # - too many arguments
    then
        printf '%s\n' 'foo bar = foo bar'
    else
        printf '%s\n' 'failure'
    fi
}

test_with_variable_quotes() {
    v1='foo bar'
    v2='foo bar'
    if [ "$v1" = "$v2" ]
    then
        printf '%s\n' 'foo bar = foo bar'
    else
        printf '%s\n' 'failure'
    fi
}

test_without_variable_quotes
test_with_variable_quotes