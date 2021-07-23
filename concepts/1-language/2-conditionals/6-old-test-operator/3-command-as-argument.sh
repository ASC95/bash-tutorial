#!/usr/bin/env bash
set -uo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# - These notes don't technically fit here but I only ever end up needing to read them before the next set of notes so I put this one here

# - When a command is used as an argument to another command, the argument command is treated as a string!
#   - This behavior is caused by the execution of the Bash parser. After Bash has evaluated quotes and performed all expansions, the last thing it
#     does is execute the actual commands. Commands are executed from left to right, so the leftmost command WILL interpret everything to the right
#     of it as an argument!
command_as_argument_to_printf() {
    printf '~%s~ ' echo hi # ~echo~ ~hi~ 
    echo ''
    printf '~%s~ '; echo ^hi^ # ~~ ^hi^
}

# - If I want to use the output of a command as an argument to another command, I need to use command substitution (a.k.a. $(<commands>) )
#    - Command substitution is a type of an expansion, so the parser evaluates the command substitution before the leftmost command executes
command_output_as_argument_to_printf() {
    printf '~%s~ ' $(echo hi) # ~hi~
    echo ''
    printf '~%s~ ' $(echo ^hi^) # ~^hi^~
}

command_as_argument_to_printf
#command_output_as_argument_to_printf
