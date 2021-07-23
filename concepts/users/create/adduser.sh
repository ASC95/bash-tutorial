#!/usr/bin/env bash

# - https://www.computerhope.com/unix/adduser.htm
# - https://unix.stackexchange.com/questions/80277/whats-the-difference-between-a-normal-user-and-a-system-user - normal vs. system user

# - $ adduser $ is a high-level utility that does a bunch of set up for me according to some configuration files while $ useradd $ is a low-level
#   utility that doesn't do any set up
#   - When a normal user is created, a corresponding home directory is created for them according to some configuration files (see man page)
# - By default, each user is put into a corresponding group with the same name
#   - I can change which group a user belongs to with various options
# - As far as I can tell, a normal user is simply one that has a high enough UID and GID to not be considered a system user
#   - The difference between a system and normal user is primarily organizational. I should never need to create a system user anyway
add_normal_user() {
    # - Only root may add a user or group (and recall that sudo temporarily makes me the root user for the duration of the command)
    sudo adduser hadoop
}

# - It's good to specify the home directory here instead of changing it later just in case there's some tricky configuration I could mess up that I'm
#   not aware of
add_normal_user_and_home_dir() {
    sudo adduser --home /opt/hadoop hadoop
}