# Links
- https://docstore.mik.ua/orelly/networking_2ndEd/tcp/ch02_04.htm - detailed explanation of `$ route` output, including 0.0.0.0 as a gateway
- https://stackoverflow.com/questions/8599424/understanding-routing-table-entry - TLDR explanation of `$ route` output
- https://networkengineering.stackexchange.com/questions/50352/network-gateways-vs-interfaces - gateway vs. interface
- https://argus-sec.com/docker-networking-behind-the-scenes/ - describes docker0 (very dense, but I understand a little bit)
- https://superuser.com/questions/872479/what-does-0-0-0-0-gateway-mean-in-routing-table - great explanation of 0.0.0.0 as a gateway
- https://unix.stackexchange.com/questions/94018/what-is-the-meaning-of-0-0-0-0-as-a-gateway - another explanation of 0.0.0.0 as a gateway
# Examples
## Output of $ route -n
```
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 enp4s0
169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 enp4s0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp4s0
```
### Destination column
- The "Destination" column contains the network ID that outgoing IP datagrams will be matched against after they have been AND-ed with the gemask
  (a.k.a. subnet mask)
### Genmask column
- The "Genmask" column contains the subnet mask that is associated with the network ID specified in the "Destination" column
### Iface column
- The "Iface" column contains the name of the interface that matching IP datagrams will be sent to
  - E.g. "enp4s0" represents my ethernet cord
  - E.g. "wlp5s0" represents my wifi card
  - E.g. I _think_ "docker0" is "bridge" that connects all running Docker containers to a single broadcast network
- My computer has an IP address on every connected interface 
  - E.g. network IDs 192.168.1.0/24, 169.254.0.0/16, and 0.0.0.0/0 are connected to the enp4s0 interface. My computer's IP address on that interface
    is 192.168.1.222
  - E.g. network ID 172.17.0.0/16 is connected to the docker0 interface. My computer's IP address on that interface is 172.17.0.1
- The IP addresses associated with each interface can be viewed with `$ ifconfig`
### Gateway column
- This contains the IP address that matching IP datagrams will be sent to
  - E.g. the value 192.168.1.1 is the IP address of my router, so IP datagrams that match 0.0.0.0 (the "Destination") when AND-ed with /0 (the
    "Genmask") will be sent there
    - Since this gateway is associated with network ID + submask 0.0.0.0/0, it is called my "default gateway"
  - E.g. a value of "0.0.0.0" in the "Gateway" column means "there is no gateway." When my routing table says "there is no gateway," it means that the
    "Destination" in question is directly attached to _this_ machine (i.e. my computer), so my computer doesn't need to forward matching IP datagrams
    to some other gateway and will use _this_ computer's own network interface to send the IP datagram
- Recall that a gateway is literally "an IP address to which you send packets for a specific network" 
  - The default gateway is just the IP address that IP packets are sent to if there are no "other" (i.e. more specific) matches in the routing table
## Output of $ route
```
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         Fios_Quantum_Ga 0.0.0.0         UG    100    0        0 enp4s0
link-local      0.0.0.0         255.255.0.0     U     1000   0        0 enp4s0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.1.0     0.0.0.0         255.255.255.0   U     100    0        0 enp4s0
```
- This displays the same information as the first example, except in a "prettier" way
# Purpose
- I can use the `$ route` command to examine my computer's routing table
# Information that isn't shown
- Recall that NAT is implemented by the router so in that sense only the router contains a NAT table.  Therfore, no NAT information is shown here
  - It's actually more complicated
- Also recall that NAT is implemented on top of routing as the next-highest level of abstraction
- Localhost (a.k.a. 127.0.0.1) isn't shown here because the localhost address doesn't send any packets on any network interface, as designed
# Additional questions
## Why can multiple gateways use the same interface?
- Recall how layer 2 stuff works: 
  - Assume the sender is sending data to a receiver within the private network
  - Assume that the sender already has a mapping of receiver's IP address -> receiver's MAC address in its ARP table
  - The sender builds their layer 3 IP datagram which only contains the sender's and receiver's IP addresses
  - This layer 3 IP datagram is encapsulated with a layer 2 datagram that contains the sender's MAC address and the receiver's MAC address
  - The switch knows to route this layer 2 datagram to the receiver, so it won't be sent to the router
  - See 2a-routing-basics.odt for details
- Recall that an interface is something physical that creates a one-to-one connection, like a plumbing pipe
  - Interfaces can be virtual, but just think of it as a physical thing for now
- The interface connects to a switch, so IP datagrams that are routed down the interface _will_ go to _different_ locations because the switch will
  route them appropriately based on their contents
- Thus, the "Gateway" column is a _helpful indicator_ to _me_ that tells me _where_ matching IP datagrams will go from the perspective of _this_ the
  network that my computer is immediately connected to
  - E.g. pretend like I had another desktop computer in my house with local IP 192.168.1.223. In order to send messages to this other computer, my
    messages would _still_ have to travel through my Ethernet cord (as they do when going to the default gateway), but the "Gateway" column indicates that
    those messages would stay within the local network that is composed of _my_ desktop computer and the _other_ desktop computer
    - Technically the router is _also_ part of this local network, which is why it has the IP address 192.168.1.1, but just think of the network as consisting
      of my two desktop computers for simplicity
- This explanation can be confirmed with an example:
  - First, recall that addresses in 192.168.x.x can be used for internal addressing within a network
    - These addresses are _not_ the same as the loopback address block (a.k.a. localhost)!
  - Second, I can run Cribl on 192.168.1.222:9000 on my desktop computer and access the website through my laptop!
