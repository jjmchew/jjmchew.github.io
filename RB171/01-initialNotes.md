# LS170 initial notes

### Definitions

#### A-M

- **Bandwidth** : the *amount* of data that can be sent in a particular unit of time (typically a second) [2]; a measure of *capacity* [6]

- **Broadcast address** : the IP address at the END of the range assigned to a single local network (see also Network Address) [5]

- **Byte** : a unit of digital information containing 8 bits

- **Connectionless network communication** : a single socket object that is set to `listen()` for incoming messages (from any source) directed to its specific IP address:port [10]

- **Connection-oriented network communication** : instantiating multiple socket objects to create a connection between applications;  analogous to replicating yourself to participate in 5 different concurrent conversations [10]
  - there is still a single socket object listening for incoming messages, but once a message arrives, a new socket object is instantiated to listen specifically for messages corresponding to the four-tuple (a specific source port, source IP, destination port, destination IP) [10]
  - generally, these connections are more reliable:  easier to implement rules for managing communication order of messages, responses, retransmission, etc. [10]

- **CRC** (Cyclic Redundancy Check) : see FCS below [3]

- **Bandwidth bottleneck** : a point at which bandwidth changes from relatively high to relatively low [2]

- **Encapsulation** : how protocols at different network layers can work together;  implemented through PDUs (i.e., the info at a higher layer is part of the data payload of a lower layer) [6]

- **Frame** : an Ethernet PDU [6] i.e., structured data.  Key components to remember are Source and Destination MAC address and Data Payload. [3] Exact headers used in an Ethernet frame will vary according to different Ethernet standards [9 q6]

- **FCS** (Frame Check Sequence) : the final 4 bytes (32 bits) of an Ethernet frame used for a CRC (cyclic redundancy check).  The receiving device generates it's own FCS from frame data then compares it to the FCS in the sent data. If the 2 don't match, the frame is dropped.  Ethernet does not implement retransmission functionality - this is left to higher level protocols. [3]

- **Four-tuple** : Four pieces of information defined for connection-oriented network communication:  source port, source IP, destination port, destination IP;  newly instantiated sockets listen for messages where all 4 pieces of info match [10]

- **Hop** : journeys between nodes on the network (i.e., interruptions for transmission, processing, queuing) [2]

- **Hub** : a basic piece of network hardware that replicates a message and forwards it to all of the devices on the network. Devices connected to a hub that receive a message not intended for it (i.e., MAC address is different) will ignore the frame [3]

- **Interframe Gap** : a brief pause in transmission between each Ethernet frame; allows the receiver to prepare to receive the next frame; contributes to Transmission Delay. For 100Mbps Ethernet the gap is 0.96 microseconds. [3]

- **Internet** : A network of networks;  comprised of *network infrastructure* (physical devices: routers, switches, physical network, cables, etc.) and *protocols* (which allow infrastructure to function) [6]

- **Internet Layer** : Also called Network Layer (OSI model).  Generally uses Internet Protocol (IP) at this layer; primary purpose is to facilitate communication between hosts (e.g., computers) on different networks [5]

- **IP** : Internet Protocol [1]; IPv4 and IPv6 are currently in use; primary functions are: routing data between one device and another (i.e., between hosts) [10] across networks via IP addressing, encapsulation of data into packets [5]; the predominant protocol for *inter-network communication* [6]  (see also Packet)

- **IP Address** : logical address (unlike MAC addresses) - can be assigned as required to devices as they join a network;  must be assigned within  a range of addresses available to the LAN they join.[5]
  - IPv4 address: 32-bit length; set of 4 numbers of 8 bits each; decimal numbers between `0` and `255` (e.g., `109.156.106.57`); maximum possible unique addresses is ~4.3 billion [5]
  - IPv6 address: 128-bit length; 8 x 16 bit blocks (e.g., 8 sets of hexadecimal characters); max possible addresses is 340 undecillion [5] The first 4 sets are used to locate a specific network, the last 4 sets to identify a particular interface or device within that network [9 q9]

- **Internet Protocol Suite** : (also called TCP/IP model or DoD model) a framework for organizing the set of communication protocols used in the internet [8]
  - Layers include [corresponding PDU name]: [8]
    - Application
    - Transport [segment (TCP) or datagram (UDP)]
    - Internet [packet] (IP - from network to sub-network)
    - Link [frame] (Ethernet - from router to device)
  - lower levels (Ethernet, IP) are inherently unreliable - although checksum data is provided, if the frame or packet is corrupt, it will just be dropped [11]


- **LAN** (Local Area Network) : multiple devices (computers) connected via a network bridging device (like a hub, or more likely a switch).  If connected wirelessly, would be known as WLAN (Wireless LAN) [4]

- **Latency** : a measure of the *time* (or delay [6]) it takes for data to get from 1 point in a network to another [2]
  - consists of:
    - **propogation delay** : the time it takes for a message to travel from sender to receiver; ratio between distance and speed [2]
    - **transmission delay** : the time it takes to push data onto each "link" in it's journey from 1 point to another (e.g., between switches, routers, other network devices) [2]
    - **processing delay** : data needs to be processed at each 'link' - this is the delay to process data between links [2]
    - **queuing delay** : (also buffering) the amount of time data waits in a queue to be processed [2]
    - **last-mile latency** : delays which involve getting a network signal from ISP's network to home or office network; as data is directed down the network hierarchy to the correct sub-network there will be more frequent and shorter 'hops' [2]

- **MAC Address** : a (unique) sequence of 6, two-digit hexadecimal numbers (e.g., `00:40:96:9d:68:0a`) assigned to every device with a NIC; used to direct Ethernet frames between network devices in a (W)LAN;  MAC address is "burned in" when manufactured;  in theory, should all be unique (may not be, but rarely causes problems) [3] [6] MAC addresses have a 'flat' structure [9 q7]

- **Multiplexing** : transmitting multiple signals over a single channel;  opposite:  **demultiplexing** [10]


#### N-Z

- **Network** : 1 or more computers connected in such a way that they can communicate or exchange data [4]

- **Network address** : the IP address at the START of the range assigned to a single local network (see also Broadcast Address) [5]

- **Network edge** : the 'entry point' into a network like a home or corporate LAN [2]

- **NIC** (Network Interface Card) : any network-enabled device [3]

- **OSI model** (Open Systems Interconnection model): a conceptual model for general computer network communication [8] (see also Internet Protocol Suite)
  - Layers include: [8]
    - Application
    - Presentation
    - Session
    - Transport
    - Network
    - Data Link
    - Physical

- **Packet** : a PDU within the IP Protocol;  has a header and a data payload;  data payload is generally a TCP segment or UDP datagram [5]

- **PDU** : Protocol Data Units [1]
  - an amount or block of data transferred over a network
  - may have diffrent names within different protocols or protocol layers
  - consists of a header, data payload, trailer (or footer)
  - e.g., Ethernet Frames are a PDU that encapsulate data from the Internet/Network layer above [3]

- **Physical network** : the tangible infrastructure that transmits electrical signals, light, radio waves which carry network communications [6]

- **Pipelining** : similar to a Stop-and-Wait protocol, but the sender continuously sends messages in a "window" (maximum number of messages in the pipeline at any 1 time) without waiting for the acknowledgement.  If there is a time-out before an acknowledgement is received, that message will be re-sent, etc as per the Stop-and-Wait protocol [11]
  - specific implementations are "Go-back-N" and "Selective Repeat" [11]

- **Port** : an identifer for a specific process running on a host (will between 0 - 65,535, some numbers are reserved) [10]
  - 0 - 1023 : assigned to processes that provide commonly used network services
      - HTTP is port 80
      - FTP is port 20
      - SMTP is port 25
  - 1024 - 49,151 : registered ports; assigned as requested by private entities; may also be *ephemeral* (temporary) ports assigned by the operating system
  - source and destination ports are included in PDU for transport layer (exact structure varies based on specific transport protocol used) [10]

- **Protocol** : (network protocol) a system of rules governing the exchange or transission of data; various protocols have various functions (corresponding to the various 'layers' of the network) [6]
  - there are many different protocols to address different aspects of network communication OR the same aspect, but a specific use case [7]

- **Round-trip Time (RTT)** : a latency calculation often used in networking - the length of time for a signal to be sent, added to the length of time for an acknowledgement or response to be received [2]

- **Router** : a network device;  responsible for a network 'segment' (i.e., a range of IP addresses for which the router keeps a record and can forward packets to);  routers also keep a routing table - record of other routers on the network and their network addresses [5]

- **Socket** : also a *communication end-point*; conceptually, it is an endpoint used for inter-process communication [10]
  - could be a UNIX socket (mechanism for communicating between local process running on the same maching)
  - could also be an internet socket (e.g., TCP/IP socket): a mechanism for inter-process communication between networked processes (usually on different machines)
  - the combo of an IP address and port information; this enables end-to-end communication between specific applications (often on different machines, but could be a `localhost` and a browser on the same machine) (e.g., `216.3.128.12:8080`) [10]
  - sockets are implemented by instantiating *socket objects* (often following the Berkeley sockets API model:  `bind()`, `listen()`, `accept()`, `connect()`, etc. Ruby, Python, Node.js use this) [10]

- **Stop-and-Wait protocol** : a reliable protocol, but not very efficient - a lot of waiting for acknowledgements [11]
  -  messages are sent with sequence numbers and a timeout; receiver sends an acknowledgement (w/ sequence number) once received; then sender sends next message in sequence (w/ sequence number) [11]
  - if acknowledgement goes missing, sender will re-send a message (w/ sequence number) after time-out [11]
  - if receiver gets a duplicate, it will drop it and re-send the acknowledgement [11]
  - 

- **Sub-net** : when a network range (of IP addresses) is split into smaller networks (e.g., the range 109.156.106.0 - 109.156.106.255 is split into 2 smaller segments with 2 routers: 1 responsible for 109.156.106.0 - 109.156.106.127 AND another for 109.156.106.128 - 109.156.106.255) [5]

- **Switch** : a network device that directs Ethernet frames to ONLY the desired MAC address;  a MAC Address Table keeps a record of ports and MAC addresses for connected devices [3]

- **TCP** (Transmission Control Protocol) : provides reliable network communication (data transfer) on top of an unreliable channel [12]
  - Key focuses are: [12]
    - data integrity
    - de-duplication
    - in-order delivery
    - retransmission of lost data
  - also provides data encapsulation and multiplexing (through TCP segments) [12]

- **TTL** (Time to Live) : a value within the Packet header that defines the maximum number of network 'hops' a packet can take before being dropped; at each hop, the network router will decrement TTL by 1 [5]

- **WLAN** (Wireless LAN) : where devices are connected wirelessly to a central device (wireess hub or switch) [4]


### Commands

- `traceroute google.com`  (`tracert` for Windows): displays the route and latency of a path across a network (e.g., my computer to Google server) [2]

- `netstat -ntup` : displays all of the active network connections (including local address and foreign address as sockets [IP address:port]) for active applications


### References
[1](https://launchschool.com/lessons/4af196b9/assignments/21ef33af)
[2](https://launchschool.com/lessons/4af196b9/assignments/097d7577)
[3](https://launchschool.com/lessons/4af196b9/assignments/81df3782)
[4](https://launchschool.com/lessons/4af196b9/assignments/268243e5)
[5](https://launchschool.com/lessons/4af196b9/assignments/b222ecfb)
[6](https://launchschool.com/lessons/4af196b9/assignments/6b7df8fb)
[7](https://launchschool.com/lessons/4af196b9/assignments/a53e65ce)
[8](https://launchschool.com/lessons/4af196b9/assignments/21ef33af)
[9](https://launchschool.com/quizzes/18c3a173)
[10](https://launchschool.com/lessons/2a6c7439/assignments/41113e98)
[11](https://launchschool.com/lessons/2a6c7439/assignments/89636ed4)
[12](https://launchschool.com/lessons/2a6c7439/assignments/d09ddd52)


### Other articles
- https://www.linkedin.com/pulse/how-internet-works-introduction-overview-robert-rodes/?lipi=urn%3Ali%3Apage%3Ad_flagship3_publishing_published%3BM4DGpPvCQu%2B9IEJm2vTbKA%3D%3D
