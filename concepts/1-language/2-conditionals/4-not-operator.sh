#!/usr/bin/env bash

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals

cd "$(dirname "${BASH_SOURCE[0]}")"

# - The NOT operator inverses the exit code of the command it is applied to
#   - This is the "logical NOT" operator
#   - Bitwise inverse is ~. There IS a bitwise inverse operator in an arithmetic context
inverse_exit_code() {
    #rm 'blah.txt' && printf '%s\n' 'Removal successful!'
    ! rm 'blah.txt' && printf '%s\n' 'Removal successful!'
    printf '%s\n' $?
}

inverse_exit_code
