#!/usr/bin/env bash

# - https://www.youtube.com/watch?v=bxFwpm4IobU - mediocre tutorial. I hate the way he talks
# - https://stackoverflow.com/questions/152457/what-is-the-difference-between-a-port-and-a-socket - a socket consists of five things: protocol, local
#   address, local port, remote address, remote port. A port is a number between 1 and 65535 inclusive that signifies a logical gate in a device
# - https://serverfault.com/questions/725262/what-causes-the-connection-refused-message

# - netstat is a tool that displays network connections, routing tables, and information about other network interfaces and statistics

# - Flags:
#   - i: display table of network interfaces
#   - e: show more detail
# - The output of this command is very similar to that of $ ifconfig
# - My external network interface (to my local network) on my computer is called "enp3s0" and it shows that my IP on my local network is 192.168.1.222
#   - If I run a web server on my machine that accepts connections from any IP, I can do something like view Splunk on my phone
view_network_interfaces() {
  netstat -ie
}

# - Flags
#   - r: display kernel routing tables
# - The output of this command is identical to that of $ route -e
#  - Use $ route -n $ for entirely numerical data
view_routing_table() {
  netstat -r
}

# - Flags
#   - c: continuously print information
# - This is overwhelming and not very helpful
view_all_sockets_live() {
  netstat -c
}

# - Flags
#   - a: show both listening and non-listening sockets
# - Columns
#   - Foreign address
#     - If a foreign address ends with "https" as its port, then the connection is probably to a website
#       - Port 443 is used for SSL connections
#   - State
#     - LISTEN: there is no current active connection, but the process is waiting for a connection 
#     - ESTABLISHED: there is a current active connection
view_all_sockets() {
  netstat -a
}

# - Flags:
#   - a: show both listening and non-listening sockets
#   - t: show only tcp connections
# - The $ netstat -at $ and $ netstat -t $ commands are not the same
#   - $ netstat -at
#     - This displays active internet connections including servers that I'm running on my machine
#   - $ netstat -t
#     - This displays active internet connections without servers I'm running on my machine
#   - Compare the commands with $ diff <(netstat -at) <(netstat -t)
view_all_tcp_sockets() {
  netstat -at
}

# - This is similar to the above example but it's for udp connections instead of tcp connections
view_all_udp_sockets() {
  netstat -au
}

# - Flags
#   - l: show only listening sockets
#   - t: show only tcp connections
# - This is useful for seeing what ports on my machine are open and are waiting for a connection
view_listening_tcp_sockets() {
  netstat -lt
}

# - This is similar to the above example but it's for udp connections instead of tcp connections
#   - Technically, udp is a connectionless protocol so it doesn't really meaning anything that a udp connection is "listening" for a connection
view_listening_udp_sockets() {
  netstat -lu
}

# - Flags
#   - p: show the PID and name of the program to which each socket belongs
#   - a: show both listening and non-listening sockets
#   - t: show only tcp connections
# - I'll almost always want to use the -p flag to see what program is responsible for using a port
view_all_tcp_sockets_with_name() {
  netstat -atp
}

# - Flags
#   - t: view tcp sockets
#   - l: only view sockets in a listening state
#     - This is different from -a, which would display all sockets regardless of state
#   - n: show numerical addresses instead of symbolic names (e.g. show 127.0.0.1 insteaf of localhost)
#   - p: show the PID and name of the program to which each socket belongs
view_listening_tcp_sockets_numerically_with_name() {
  netstat -tlnp
}