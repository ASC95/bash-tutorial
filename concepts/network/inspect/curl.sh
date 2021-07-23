#!/usr/bin/env bash

# - https://askubuntu.com/questions/166068/port-seems-to-be-open-but-connection-refused
# - https://serverfault.com/questions/78048/whats-the-difference-between-ip-address-0-0-0-0-and-127-0-0-1

# - Sometimes $ curl localhost:<port> $ refuses the connection even if the server is up and the port is open 
# - The solution is to do $ curl 0.0.0.0:<port> $ instead
#   - I don't completely understand the explanation in the sources
connect_to_localhost_server() {
  # - Make sure Splunk Web is running
  curl localhost:8000
  #curl 0.0.0.0:8000
}

# - Flags
#   - k: instruct curl to skip SSL verification if the server is using a self-signed certificate 
#     - Without this flag, accessing a site with a self-signed certificate will cause curl to raise an error
#     - This flag will also cause curl to ignore other SSL errors, like an outdated certificate
# - E.g. curl -k -u <user>:<password> https://localhost:8089/servicesNS/nobody/kvstoretutorial/storage/collections/config/mycollection/acl
connect_and_authenticate_with_localhost_server() {
  curl -k -u austin:1q2w3e4r https://localhost:8089/servicesNS/nobody/utcyber/storage/collections/data/ttp_reports
}

post_form_data() {
  curl -F foo=bar -v http://127.0.0.1:5000/view_form_data
}

#connect_to_localhost_server
post_form_data