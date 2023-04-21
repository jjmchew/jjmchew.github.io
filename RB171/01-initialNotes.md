# LS170 initial notes

### Definitions

#### A-M
- **Bandwidth** : the *amount* of data that can be sent in a particular unit of time (typically a second) [2]

- **CRC** (Cyclic Redundancy Check) : see FCS below [3]

- **Bandwidth bottleneck** : a point at which bandwidth changes from relatively high to relatively low [2]

- **Ethernet Frame** : a PDU - i.e., structured data.  Key components to remember are Source and Destination MAC address and Data Payload. [3]

- **FCS** (Frame Check Sequence) : the final 4 bytes (32 bits) of an Ethernet frame used for a CRC (cyclic redundancy check).  The receiving device generates it's own FCS from frame data then compares it to the FCS in the sent data. If the 2 don't match, the frame is dropped.  Ethernet does not implement retransmission functionality - this is left to higher level protocols. [3]

- **Hop** : journeys between nodes on the network (i.e., interruptions for transmission, processing, queuing) [2]

- **Hub** : a basic piece of network hardware that replicates a message and forwards it to all of the devices on the network. Devices connected to a hub that receive a message not intended for i (i.e., MAC address is different) will ignore the frame [3]

- **Interframe Gap** : a brief pause in transmission between each Ethernet frame; allows the receiver to prepare to receive the next frame; contributes to Transmission Delay. For 100Mbps Ethernet the gap is 0.96 microseconds. [3]

- **Internet Layer** : Also called Network Layer (OSI model).  Generally uses Internet Protocol (IP) at this layer; primary purpose is to facilitate communication between hosts (e.g., computers) on different networks [5]

- **IP** : Internet Protocol [1]; IPv4 and IPv6 are currently in use; primary functions are: routing capability via IP addressing, encapsulation of data into packets [5]

- **LAN** (Local Area Network) : multiple devices (computers) connected via a network bridging device (like a hub, or more likely a switch).  If connected wirelessly, would be known as WLAN (Wireless LAN) [4]

- **Latency** : a measure of the *time* it takes for data to get from 1 point in a network to another [2]
  - consists of:
    - **propogation delay** : the time it takesfor a message to trave from sender to receiver; ratio between distance and speed [2]
    - **transmission delay** : the time it takes to push data onto each "link" in it's journey from 1 point to another (e.g., between switches, routers, other network devices) [2]
    - **processing delay** : data needs to be processed at each 'link' - this is the delay to process data between links [2]
    - **queuing delay** : (also buffering) the amount of time data waits in a queue to be processed [2]
    - **last-mile latency** : delays which involve getting a network signal from ISP's network to home or office network; as data is directed down the network hierarchy to the correct sub-network there will be more frequent and shorter 'hops' [2]

- **MAC Address** : a (unique) sequence of 6, two-digit hexadecimal numbers (e.g., `00:40:96:9d:68:0a`) assigned to every device with a NIC; used to direct Ethernet frames between network devices in a (W)LAN;  MAC address is "burned in" when manufactured;  in theory, should all be unique (may not be, but rarely causes problems) [3]

#### N-Z
- **Network edge** : the 'entry point' into a network like a home or corporate LAN [2]

- **NIC** (Network Interface Card) : any network-enabled device [3]

- **Packet** : a PDU within the IP Protocol;  has a header and a data payload [5]

- **PDU** : Protocol Data Units [1]
  - an amount or block of data transferred over a network
  - may have diffreent names within different protocols or protocol layers
  - consists of a header, data payload, trailer (or footer)
  - e.g., Ethernet Frames are a PDU that encapsulate data from the Internet/Network layer above [3]

- **Round-trip Time (RTT)** : a latency calculation often used in networking - the length of time for a signal to be sent, added to the length of time for an acknowledgement or response to be received [2]

- **Switch** : a network device that directs Ethernet frames to ONLY the desired MAC address;  a MAC Address Table keeps a record of ports and MAC addresses for connected devices [3]

- **WLAN** (Wireless LAN) : where devices are connected wirelessly to a central device (wireess hub or switch) [4]


### Commands

- `traceroute google.com`  (`tracert` for Windows): displays the route and latency of a path across a network (e.g., my computer to Google server) [2]


### References
[1](https://launchschool.com/lessons/4af196b9/assignments/21ef33af)
[2](https://launchschool.com/lessons/4af196b9/assignments/097d7577)
[3](https://launchschool.com/lessons/4af196b9/assignments/81df3782)
[4](https://launchschool.com/lessons/4af196b9/assignments/268243e5)
[5](https://launchschool.com/lessons/4af196b9/assignments/b222ecfb)


### Other articles
- https://www.linkedin.com/pulse/how-internet-works-introduction-overview-robert-rodes/?lipi=urn%3Ali%3Apage%3Ad_flagship3_publishing_published%3BM4DGpPvCQu%2B9IEJm2vTbKA%3D%3D
