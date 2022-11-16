=========== Task 1 ===============
Q1.
available nodes are: 
Mininet> nodes:
c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7
mininet> net
h1 h1-eth0:s3-eth2
h2 h2-eth0:s3-eth3
h3 h3-eth0:s4-eth2
h4 h4-eth0:s4-eth3
h5 h5-eth0:s6-eth2
h6 h6-eth0:s6-eth3
h7 h7-eth0:s7-eth2
h8 h8-eth0:s7-eth3
s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
c0

Q2.
mininet> h7 ifconfig:
h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
        inet6 fe80::388c:9cff:fe3d:4a46  prefixlen 64  scopeid 0x20<link>
        ether 3a:8c:9c:3d:4a:46  txqueuelen 1000  (Ethernet)
        RX packets 21  bytes 1566 (1.5 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 9  bytes 726 (726.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


=========== Task 2 ===============
Q1.
_handle_PacketIn() -> act_like_hub() -> resend_packet()

Q2.
a. "h1 ping h2" Avg: 45.387 ms | "h1 ping h8" Avg: 278.059 ms
b. "h1 ping h2" Min: 16.835 ms, Max: 268.690 ms | "h1 ping h8" Min: 117.859 ms, Max: 1311.506 ms
c. "h1 ping h2" is faster than "h1 ping h8". It is because there are less switches between h1 and h2 comparing to h1 and h8. In detail, h1 ping h2 only needs s3 to forward packets, but h1 ping h8 needs s3, s2, s1, s5, s7 to forward packers.

Q3.
a. iperf can create TCP and UDP data streams and measure the throughput of a network that is carrying them.
b. "iperf h1 h2" results: ['173 Kbits/sec', '400 Kbits/sec'] | "iperf h1 h8" results: ['188 Kbits/sec', '325 Kbits/sec']
c. "iperf h1 h2" is slightly better than "iperf h1 h8". It may due to that it has shorter route between h1 and h2, and it has quicker return time. Because from h1 to h8, there are more switches needed to forward packets.

Q4.
I tested with "h1 h2" & "h1 h8". All switches got traffic. In "h1 h2", s3 observed traffic. In "h1 h8", s3, s2, s1, s5, s7 observed traffic. The way for observing is that I added a print statement inside _handle_PacketIn function to print the switch and packet's source & destination.


=========== Task 3 ===============
Q1.
The code is working as following:
Every time when a new source arrive at a switch and if it is not in map, it will inserts it into the map with packet.src as key and port as value. After that, it will check if destination is in the map. If the destination is in the map, it will send the packet directly to the port associate with it using resend_packet() function. If the destination is not in the map, it will flood the packet to all ports except the input port.

Q2.
a. "h1 ping h2" Avg: 42.705 ms | "h1 ping h8" Avg: 193.317 ms
b. "h1 ping h2" Min: 19.751 ms, Max: 176.856 ms | "h1 ping h8" Min:117.056 ms, Max: 773.023 ms
c. The difference is that the results in task 3 are better than results in task 2. The avg/min/max ping are all decreased. it is due to the map(mac_to_port) that could learn and improve the performance. Every time the map will learn and store the information, and use it to expedite the process.

Q3.
a. "iperf h1 h2" results: ['604 Kbits/sec', '1.41 Mbits/sec'] | "iperf h1 h8" results: ['403 Kbits/sec', '695 Kbits/sec']
b. 
Overall, the throughputs of task 3 increase and are better than the throughputs of tasks 2. It is due to the same reason of Q2, and it is more efficient when using the map to learn instead of flood packets to the network. In detail, because "iperf h1 h2" in Task3 don't need flood packets everywhere after mac_to_port map learn the ports.


