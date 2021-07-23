# https://www.hostinger.com/tutorials/ssh-tutorial-how-does-ssh-work
# https://stackoverflow.com/questions/34045375/connect-over-ssh-using-a-pem-file - connect with .pem file example
# https://www.thegeekdiary.com/how-to-fix-the-error-host-key-verification-failed/ - fix host verification error
# https://serverfault.com/questions/9708/what-is-a-pem-file-and-how-does-it-differ-from-other-openssl-generated-key-file - different certificate
# formats (annoying)
# 

# ssh runs on port 22. It must be setup between two computers before it will work. 
# - The proper packages must be installed and the keys must be created and exchanged

# Errors:
# permission denied (publickey): ...

# The syntax for an ssh command is $ ssh <user>@<host>
# - user is the user account on the machine I am trying to access
# - host is either a domain name or an IP address of the computer/server I'm trying to access
syntax() {
}

# $ ssh -i <path to .pem> <user>@<host>
# - E.g. ssh -i '~/.ssh/aifbdp/splunk.pem' <user>@<IP>
connect_with_pem_file() {
}