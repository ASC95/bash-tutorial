# https://apple.stackexchange.com/questions/117644/how-can-i-list-my-open-network-ports-with-netstat
# http://osxdaily.com/2011/09/30/remote-login-ssh-server-mac-os-x/ - ssh settings in macOS

# Options
# - "P": inhibits the conversion of port numbers to port names for network files.  Inhibiting the conversion may make lsof run a little faster.  It is
#   also useful when port name lookup is not working properly.
# - "i": selects the listing of files any of whose Internet address matches the address specified in i.  If no address is specified, this option
#   selects the listing of all Internet and x.25 (HP-UX) network files.
#   - TCP is a protocol argument to the "-i" option
# - "s":  When the optional form is available, the s may be followed by a protocol name (p), either TCP or UDP, a colon (`:') and a comma-separated
#   protocol state name list, the option causes open TCP and UDP files to be excluded if  their  state name(s) are in the list (s) preceded by a `^';
#   or included if their name(s) are not preceded by a `^'.
#
# Use sudo to see ports opened by system processes. Without sudo, I could only view processes that I own. 
# - The ssh process(es) are owned by the system
view_open_ports() {
    sudo lsof -PiTCP -sTCP:LISTEN
}