#!/usr/bin/env bash

# - Running this command will create a subshell that runs as the specified user
#   - If I press ctrl + d, the subshell exits and I go back to my shell
#   - The password prompt is asking for the password of the user I intend to become
run_subshell_as_other_user() {
    su - hadoop
}

# - If no user is specified, it defaults to root
#   - This is very dangerous!
run_subshell_as_root() {
    su
}

# - The -c flag lets me run commands as the specified user
#   - It just doesn't work if I don't use the -c flag
run_command_as_other_user() {
    su - hadoop -c env | grep -i 'path'
}