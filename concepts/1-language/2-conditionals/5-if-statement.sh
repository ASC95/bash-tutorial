#!/usr/bin/env

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals

# - The if-statement is completely distinct from the [ and [[ operators
# - The if-statement branches to the then-statement if the commands exited with a status code of 0
#   - Otherwise, the if-statement evaluates the next elif condition and/or evaluates the else branch
successful_exit_code() {
    if false; then
        printf '%s\n' 'if branch'
    elif true; then
        printf '%s\n' 'elif branch'
    else
        printf '%s\n' 'else branch'
    fi
}

successful_exit_code # elif branch