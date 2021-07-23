#!/usr/bin/env bash

# - https://askubuntu.com/questions/410244/is-there-a-command-to-list-all-users-also-to-add-delete-modify-users-in-the

# - After running this command, I should also delete the users home directory
#   -  Alternatively, I can use the -r option to automatically remove the home directory and the user's mail spool
delete_user() {
    sudo userdel -r hadoop
}