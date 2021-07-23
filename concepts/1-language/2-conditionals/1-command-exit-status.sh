#!/usr/bin/env bash

# - https://mywiki.wooledge.org/BashGuide/TestsAndConditionals

# - Every command finishes by returning an integer between 0 and 255. This integer is known as the "exit status" of the command
#   - Returning 0 indicates success
#   - Returning any other integer indicates a failure
#       - The meaning of the error integer is application-specific
execute_command_successfully() {
    echo 'hi'
    echo "$?" # 0
}

execute_command_successfully