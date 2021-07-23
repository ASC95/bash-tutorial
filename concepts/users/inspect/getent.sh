#!/usr/bin/env bash

# - https://askubuntu.com/questions/410244/is-there-a-command-to-list-all-users-also-to-add-delete-modify-users-in-the
# - https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/ - read /etc/passwd
# - https://www.cyberciti.biz/faq/understanding-etcgroup-file/ - read /etc/group
# - https://serverfault.com/questions/605812/etc-passwd-shows-user-in-a-group-but-etc-group-does-not - Apparently the "primary" group of a user is
#   specified in /etc/passwd while only any "secondary" groups of a user are specified in /etc/group

# - The lines of /etc/passwd have the following structure: <username>:<password>:<userid>:<group id>:<comments about the user>:<home directory>:<shell>
#   - An "x" in the <password" field indicates that the encrypted password is stored in /etc/shadow
#   - E.g. root:x:0:0:root:/root:/bin/bash
#   - E.g. daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
#   - E.g. austin:x:1000:1000:Austin,,,:/home/austin:/bin/bash
#   - E.g. splunk:x:1001:1001:Splunk Server:/opt/splunk:/bin/bash
view_all_users() {
    # - These are equivalent
    #getent passwd
    cat '/etc/passwd'
}

# - The lines of /etc/group have the following structure: <group name>:<password>:<group id>:<list of users in the group>
#   - Apparently, if a group has no users listed after it, it means no users are using the group as one of their optional secondary groups. It does
#     not mean that the group doesn't have any users. It could have users who use that group as their primary group
#   - E.g. root:x:0:
#   - E.g. adm:x:4:syslog,austin
#   - E.g. austin:x:1000:
#   - E.g. splunk:x:1001:
view_all_groups() {
    # - These are equivalent
    #getent group
    cat '/etc/group'
}

view_users_groups() {
    groups austin # austin : austin adm cdrom sudo dip plugdev lpadmin lxd sambashare nordvpn
}

#view_all_users
#view_all_groups
view_users_groups