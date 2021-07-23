#!/usr/bin/env bash

# - https://tiswww.case.edu/php/chet/bash/bashref.html#Shell-Builtin-Commands - detailed description of old test (i.e. [ ) operator

cd "$(dirname "${BASH_SOURCE[0]}")"

# - If zero arguments (other than the mandatory ]) are provided to the test operator, then it exits with 1 (i.e. it indicates that the condition check
#   failed)
exit_with_error() {
    [ ] 
    # - [ exits with 1 because no arguments were provided to the test operator
    echo "$?" # 1
}

exit_with_error
