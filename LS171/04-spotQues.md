# SPOT wiki practice questions
https://fine-ocean-68c.notion.site/LS170-09792b25c5824b79bf97ca27fdd8c9aa?p=51650b0259b1467a8500473d853ec14c&pm=s

---

1
What is a network?

- A network is 1 or more computers connected in such a way that allows them to communicate and share information.

---

2
What is the Internet?

- The internet is a network of networks.  It includes all of the physical devices (e.g., cables, routers, servers, computers, etc.) and the protocols which enable the sharing of information between computers.

---

3
Is the Internet the same thing as a network? 

- Not quite. The internet is similar to a network, but because it's the interconnection of many different networks, it's much larger and more complex than any specific network might be.  At the smallest scale, a network could be a LAN (Local Area Network) where 2 computers are connected by a single cable to share information.  The internet is comprised of many (more complicated) LANs all interconnected by what can be thought of as a network of routers and supported by a series of protocols that allow all of the computers to connect and share information.

---

4
==What is WEB (world wide web)==

- The World Wide Web or "web" is an internet service that is supported primarily through the HTTP protocol (HyperText Transfer Protocol). This service allows one computer the ability to request information from another computer on the internet. These requests and the corresponding responses are completed using HTTP requests / responses and information is shared through HTML (Hyper Text Markup Language) "pages" of information. Today, the web has evolved to include a multitude of more complex and feature-rich protocols and languages, however, the basic HTTP request/response structure is still used today.

---

5
What is the difference between network, Internet, and WEB?

- A network is the most basic "unit" - the interconnection of 1 or more computers to share information.  The Internet is a connection of multiple networks to be able to share information.  The Web is a service (an agreed upon standard way to access and share information on the Internet) which uses the physical interconnection and protocols of the Intenet to share information.

---

6
==What are LAN and WLAN?==

- A LAN is a Local Area Network. This is the most basic form of network where 1 or more computers are connected together and configured to share information. Typically, all of the computers in the LAN are connected via cables to a hub or a switch. Information is shared between the computers through an ethernet cable.  A WLAN (Wireless Local Area Network) is similar to a LAN, but the computers are connected to a wireless switch via radio waves rather than physical cables.

---

7
What is a protocol?

- A protocol is an (agreed) set of rules that govern the sharing of information.
- A protocol is a system of rules governing the exchange or transmission of data.  Different protocols may have different functions (and in the case of the TCP/IP model, will correspond to different layers of the TCP/IP model).

---

8
What is the role of protocols? 

- Protocols allow the efficient and effective communication of information between 2 parties. Without agreed rules, it would be very difficult to communicate, especially as the number of parties increases. An example of a protocol might be the use of a (common) language, or the social convention of taking turns when speaking - without either of these "protocols" it would be extremely difficult to communicate effectively.

---

9
Why there are many different types of protocols?

- Protocols may govern different aspects or forms of communication. For example, in everyday communication defining a common language (and the structure and rules of that language) may be 1 protocol. Whether or not we speak those words or write them down in a message (and how that message might be structured) is another protocol. The physical transmission of that message from 1 party to another, whether it's through the air or through the mail, might require another protocol.

---

10
What does it mean that a protocol is stateless?

- A protocol is stateless when each request / response pair is independent of every other request / response pair. This means that all of the information required to respond must be contained in each request. This also implies that no information is saved between each request and response. In other protocols, it may be necessary to keep track of a "status" between each request / response, which may involve assigning a "state" such as active, pending, or closed to each request and tracking that state through a number of request / response cycles. In a stateless protocol, no such information is required to be tracked.

---

11
Explain briefly what are OSI and TCP/IP models? ==What is the purpose of having models like that?==

- The OSI (Open Systems Interconnection) model is a conceptual framework that describes the various elements which interact to provide networked communications such as the internet. The purpose of this model is to help understand the role of various protocols and devices in allowing network communication.
- The TCP/IP (Transport Connection Protocol / Internet Protocol) model is a practical framework that describes the various protocols that allow computers on the internet to connect and communicate. The purpose of this model is to help describe the relationship between various related, but distinct, protocols used in internet communication.

---

12
What is PDU? What is its role?

- A PDU is a Protocol Data Unit. It generically describes what a single unit of information within a protocol is. Each PDU has a distinct name and includes different information with a slightly different (although similar) structure. The role of a PDU is to provide a structured way to share information between computers using a particular protocol.

---

13
What is Data Payload? 

- Data Payload is the part of each PDU that carries information from the "layer" (with reference to the layers of the OSI model or TCP/IP model) above it. The Data Payload is used to encapsulate the information from the layer above. For example, all of the HTTP request information at the Application layer will be encapsulated within the PDU for the Transport layer - the Data Payload for a Segment (PDU at the Transport layer) will BE the HTTP request from the Application layer.

---

14
What is the relationship between PDU and Data Payload? 

- The PDU contains a Data Payload. Thus the Data Payload is one part of a particular PDU. Typically, each PDU would include a header, the Data Payload, and sometimes a footer or trailer.

---

15
==Explain how lower-level protocols work in general?==

- The levels referred to here are the layers of the OSI or TCP/IP model. The levels or layers at the bottom of these models relate more to the transmission of information over physical infrastructure such as the wires, cables, or radio waves. Protocols at these levels define how binary information will actually be sent and received. At the lowest levels (data link, physical or link) common protocols might be 802.11 for wifi communication, Ethernet standards, or other standards for coaxial and fibre optic cable. These protocols govern the sending and receiving of information via that physical infrastructure. The Ethernet standard defines a Frame (a unit of information sent via Ethernet) which includes a header with source and destination MAC address information along with additional data payload information.

- The layer "above" the data link / physical or link layer is the network or internet layer. The protocol at this layer, the "Internet Protocol" (IP) is concerned with routing Packets (the name of the PDU for this protocol) of information across the internet from 1 router to another, ultimately helping data to traverse from 1 network to another. Packets are labelled with a source IP address and a destination IP address.  The IP address is a logical address, assigned dynamically to computers that connect to the internet, which is hierarchical in nature and thus supports routers in progressively routing packets towards the correct router managing the destination network.


---

16
What is encapsulation in the context of networking?

- In the context of networking, encapsulation is the term given to how information from a higher-level layer is embedded within the data payload of the PDU of a lower-level layer. For example, the HTTP request information at the Application layer forms the data payload for a TCP Segment at the Transport layer. The TCP Segment at the Transport layer is the data payload for a Packet at the Internet layer.

---

17
Why do we need encapsulation?

- Encapsulation allows the information at the various layers of the TCP/IP model to be segregated from each other - information required at the Application layer is distinct from the information required at the Transport or Link layers. By using encapsulation, the protocols we choose to use at higher-level layers do not impact the protocols we use at lower-level layers, and vice versa.

---

18
==What are the characteristics of a physical network?== 

- A physical network is used to transmit binary data from one physical location to another. It must be able to clearly distinguish an "on" signal from an "off" signal and differentiate between successive "on"s or "off"s reliably. The key characteristics of a physical network are bandwidth and latency. When a number of different physical networks are connected together, the number of 'hops' (interconnections from 1 physical device to another) may also be relevant.

- Latency is a measure of how much time it takes a packet of data to travel from source to destination. It is typically measured in milliseconds (ms). If a packet of data is thought of as a car, the latency is the time the car would take to drive from point A to point B.

- Bandwidth is a measure of how much data can travel between 2 points of a network in a single unit of time (Usually 1 sec). Bandwidth is typically measured in bps (bits per second). To use the car analogy, increasing bandwidth would be analogous to increasing the number of lanes (and thus cars) that could concurrently travel from point A to point B.

---

19
==How can we as developers deal with the limitations of physical network?==

- Developers are always working within the limitations of physical networks (bandwidth, latency, hops). Being aware of these limitations and consciously choosing what protocols to use and what information to send over the physical network can help to optimize performance for the end-user. For example, where latency is a significant concern (and reliability is not), the use of UDP may be a more appropriate Transport protocol than TCP: TCP requires initial handshaking which takes a single round-trip time to establish a connection, whereas UDP does not and can send data immediately.
- The use of content delivery servers which are located closer to end-users can also decrease latency, by reducing the physical distance (and thus the number of hops) data needs to travel to reach the user.

---

20
==What is Latency?==

- Latency is the amount of time (delay) it takes a single unit of data to go from 1 location to another. It is comprised of a few different elements:
  - ~~Transmission delay~~ Propogation delay : the amount of time it takes a signal to travel along the physical media (e.g., cable or through the air)
  - ~~Processing delay~~ Transmission delay : the amount of time it takes a signal to be "pushed" from 1 physical device to another (e.g., cable to a router); this is roughly a measure of the amount of time it takes to modulate / demodulate a signal from it's physical form to/from (e.g., a light wave) to it's 'digital' form (i.e., stored as binary 1's or 0's).
  - Processing delay : the amount of time it takes a device to actually process information prior as part of transmission (and before / after propogation)
  - Queuing delay : the amount of time a signal may wait in a buffer before it is processed
- Latency can be thought of as a car on a road - ~~how fast that car travels~~ the length of time it takes that car to get from 1 point to another is a measure of the latency similar to the length of time between a packet of data travelling from 1 point to another through a network.

---

21
What is Bandwidth?

- Bandwidth is the amount of data that can travel from 1 location to another in a single unit of time.
- If using a car to transport cargo from 1 location to another is an analogy for transporting some quantity of data from 1 location to another, then using a truck to transport data at the same speed would be increasing the bandwidth. Increasing bandwidth has also been described as increasing the number of lanes to allow more cars to transport data concurrently.

---

22
==What are Network 'Hops'?==

- A 'hop' refers to the interconnection between 1 node on a network and another. At each 'hop' a frame of data will move ~~from 1 physical device to another (e.g., from a cable to a router, or from a router to wireless signal)~~ through a router.
- a 'hop' is a 'journey between nodes' (e.g., routers) on the network

---

23
What is the relationship between network 'Hops' and latency? 

- The more hops that a unit of data has to undergo, the higher the overall latency will be (i.e., the higher the delay will be for that unit of data to reach its destination). This is the result of additional processing and possibly queuing delays which may occur at each 'hop'.
- "Last-mile latency" refers to the increased latency near the "edges" of the network - i.e., closest to the destination where data must pass through more devices that are relatively close together.

---

24
What is a switch and what is it used for?

- A switch is a physical device used to connect computers together in a network. The switch will maintain a record of the MAC address for each device which is connected to it (and the port that it is connected to) and send only information that is intended for each device. This is in contrast to a hub (see next question).

---

25
What is a hub and what is it used for?

- A hub is a physical device used to connect computers together in a network. The hub will broadcast messages it receives to all devices that are connected to it. It works well for simple networks with few devices, however, it does not work well for large networks since it broadcasts messages to all connected devices and thus creates unnecessary network traffic which can impede or delay messages being transmitted across the network.

---

26
==What is a modem and what it is used for?==

- A modem (modulate/demodulate) is a physical device used to convert data (i.e., binary information) to a signal suitable for the physical media it is travelling over (e.g., a modem could convert binary data to sounds to transmit over phone lines).
- Typically a modem is used to convert digital signals for transmission over analog medium. (https://networkengineering.stackexchange.com/questions/11202/do-network-cards-work-as-modems-too)

---

27
==What is a router and what is it used for?==

- A router is a physical device used to direct information it receives in a network to the appropriate place - either to another router (i.e., for a different network / sub-network) or to a switch within a network. Routers are typically assigned a consecutive series of IP addresses for which they are responsible for receiving incoming data.
- Routers are network devices that can route network traffic to other networks.  Within a LAN, they act as gateways into and out of the network.

---

28
==What is the difference between a switch, hub, modem, and router?==

- Switches and hubs are used to connect computers together into a LAN. Switches are more efficient devices to use since they only send messages that are intended to each device; hubs send all messages to all devices connected. Modems are used to send information across non-ethernet media or cables (such as phone lines, or coaxial cable ~~or fibre-optic cable~~). Routers are used to connect networks together and contain information for what IP addresses a particular router is responsible for and how best to route packets of data to reach those routers.

---

29
==How does the Internet work?==

- The internet is a complex system comprised of computers being physically connected together and communicating through a set of standard protocols.
- Computers are connected together using Ethernet cables or wireless wifi networks into Local Area Networks (LANs) via hubs or switches. The Ethernet protocol helps to send information along these cables between computers. LANs are to other networks through modems and routers. The Router acts as a 'gateway' for each LAN to the other networks connected together, and data is transmitted between routers from 1 network to another (sometimes over great distances like under the ocean from 1 continent to another). The information sent between computers is structured in specific ways to contain some Application information (like an HTTP request), some Transport information related to reliability/integrity/etc information, some Internet information like a network address (IP), and some Link information like a MAC address for a device. This information allows a request from a single computer to travel out across a network of networks and to its final destination (e.g., an HTTP server that can respond to the request).

---

30
==What is a MAC address and what is its role in network communication?==

- MAC stands for Media Access Control.
- A MAC address is (theoretically) a unique identifier assigned to every physical device that can connect to a network (i.e., any device that has a Network Interface Card [NIC]). MAC addresses are comprised of 6 groups of 2 hexadecimal digits, where the first section of digits are assigned to each device manufacturer by the IANA. Generally speaking, MAC addresses are 'flat' as opposed to hierarchical (like IP addresses) and so are only used in point-to-point communication in networks (e.g., from 1 device to a switch or that switch to a router).
- The MAC address is used to identify a particular device within a LAN so that information sent in Frames within a network can be sent to specific, desired devices.

---

31
Give an overview of the Link/Data Layer

- The Link/Data layer is the layer that references the physical media like cables that data travels over. The primary protocol we are concerned with at this layer is Ethernet which defines a PDU called a Frame which includes the MAC address of the source and destination device. Frames which travel along Ethernet cables are separated by an "inter-frame gap" which for 100 Mbps ethernet is typically around 0.96 **micro**seconds.

---

32
What is included in an Ethernet frame?

- An Ethernet frame includes a header which contains the source and destination MAC address, the data payload (which contains encapsulated data from higher level protocls) and a footer which includes the ==FCS (frame checksum)== which is used to validate the integrity of the frame.

---

33
Give an overview of the Internet/Network Layer and it's role.

- The Internet/Network layer is the layer that references various hosts (routers) on the internet and facilitates the travel of information across the many networks which make up the internet. Every router is responsible for a series of IP addresses which may be defined according the IPv4 or IPv6 protocol. These protocols use a series of digits to assign a unique logical address to every device connected to the internet. The digits which make up the IP address are assigned in a hierarchical fashion: the left-most digits correspond to high-level regions, and as you move to the right, digits correspond to successively smaller sub-networks.

---

34
What is IP?

- IP refers to the "Internet Protocol" which is the protocol at the Internet/Network Layer. This protocol relates to the assignment and use of logical IP addresses to route data to devices connected to the internet. There are 2 specific versions of IP currently in use: IPv4 and IPv6. IPv6 is an updated version of the protocol that allows for significantly more unique IP addresses to be assigned (340 undecillion unique addresses in IPv6 vs only 4.3 billion unique addresses in IPv4).

---

35
What is IP address? 

- An IP address is a unique logical address assigned to each device connected to the internet. (see above)

---

36
==What are the components of IP addresses?==

- IP addresses are represented by a series of digits. IPv4 address are represented by a 4 sets of decimal numbers from 0 to 255.  IPv6 address are represented by **8 sets of 16 bit numbers (typically shown as 8 sets of 4 hexadecimal characters)**.

---

37
What is a packet in computer networking?

- A packet is the name given to ~~an Ethernet PDU at the Data/Link layer. This PDU contains header information with the source and destination MAC address along with a data payload and an ==FCS footer==.~~ a PDU for the Internet Protocol. It contains a header which includes the source and destination IP address and a data payload, which is often a TCP Segment or UDP Datagram.

---

38
Why do we need both MAC addresses and IP addresses? 

- MAC addresses are "burned in" (unchanging) identifiers used to identify specific devices in a LAN. IP addresses are a logical address that is assigned in a hierarchical way to help identify the regions, networks and sub-networks a particular device is associated with so that information travelling across the internet can be directed to the right place. An analogy for a MAC address might be someone's full name - it's an identifier which is required to send mail to someone, but it works best along with a full address (house number, street, city, province, country) to ensure that the mail can be routed effectively from 1 location in the world to another.

---

39
What is DNS and how does it work?

- DNS is the Domain Name System. This system allows internet users to type in text "addresses" (e.g., "www.example.com"), but be directed to actual IP addresses (e.g., 192.234.24.2). This distributed system is comprised of a series of servers, connected in a hierarchy by region, which store a mapping of text domain names to numerical IP addresses. No single DNS server contains all of the mappings of the internet. When a browser receives a request intended for "www.example.com", a request is sent to the closest DNS server to determine the corresponding IP address. If a particular DNS server does not possess the required mapping, the request is referred to another server (typically up the hierarchy chain first, and then back down the hierarchy to the correct region / sub-region). Typically, once a DNS server satisfies a particular DNS request, it saves that mapping within a cache to speed the response the next time it is received. 

---

40
How do port numbers and IP addresses work together?

- The combination of a port number and an IP address is called a "socket". It defines a communication endpoint for an application.  The IP address defines a specific computer and the port defines a specific process. Typical port numbers and their corresponding processes are 80 for HTTP, 443 for HTTPS, 587 for SMTP(s).

---

41
What is a checksum and what is it used for? How is it used?

- A checksum is a calculated result that is derived from applying a pre-determined algorithm to a set of data. It is used when transmitting data to confirm the integrity of the transmitted data. For example, a TCP Segment may send the data payload and a checksum derived from the data payload. The receiver would apply the same (pre-determined) algorithm to the data payload and then compare checksums - if both checksums are the same, the data is complete and unchanged; if the checksums are different, then the data received was not the same as the data sent.  
- The same principle is used in data encryption by Certificate Authorities (CA) where a private key is used to encrypt a message and both the encrypted message and unencrypted message are provided in a certificate. Use of the CA's public key to unencrypt the message should produce the same message as provided by the CA, demonstrating that the CA has the corresponding private key and is thus a trustworthy entity.

---

42
==Give an overview of the Transport Layer.==

- The Transport layer is responsible for end-to-end communication between devices or processes. PDUs at this layer have headers which contain a source port and a destination port which will identify how to access specific processes in the source computer and the destination server. This layer allows a computer which may have many applications (and associated processes) running concurrently, to all send information through a common connection to the internet. Messages from various applications are identified with a unique process number (port number) which allows the multiplexed use of common network infrastructure.
- This layer encapsulates data from the Application layer, and is transmitted via IP and Ethernet protocols across in the internet.
- The Transport layer has 2 common protocols, TCP and UDP, and is concerned with transmitting application (e.g., HTTP) information from port to port.
- TCP is a connection-oriented protocol and thus uses handshaking to establish a connection prior to sending data. The corresponding PDU is the Segment.
- UDP is a connection-less protocol and thus does not use handshaking to establish a connection prior to sending data. The PDU is the Datagram.

---

43
==What are the fundamental elements of reliable protocol?==

- A reliable protocol (e.g., TCP) is one that can:
  - ensure no duplication of data transmitted (i.e., each segment is assigned a sequence number)
  - ensure the integrity of data transmitted (i.e., error detection through the use of a checksum)
  - manage the order in which data is transmitted (i.e., each segment is assigned a sequence number)
  - ensure the completeness of data transmitted (i.e., using the sequence number to ensure all expected data segments are received)

---

44
==What is pipe-lining protocols? What are the benefits of it?==

- Pipelining in protocols is sending additional bundles of information prior to receiving acknowledgement from the receiver that the first bundle has been received. The benefits of pipelining are an overall increase in data transfer speeds since there is less waiting by the server to receive acknowledgements from the receiver before additional data is sent. Typically, a timeout is set so that if the sender does not receive acknowledgement from the receiver for having received a particular piece of information prior to the timeout, that bundle is re-sent automatically. If a receiver receives the same bundle more than once, then the extra bundles are dropped or ignored. 

---

45
==What is a network port?==

- A network port is a number assigned to a specific application process at a particular IP address. Use of a port allows 1 computer to run multiple processes concurrently and segregate information associated with each process to a specific port.

---

46
What is a port number?

- A port number is the unique number associated with a network port (see above).

---

47
What is a network socket?

- A network socket is a communication end-point for an application process which is identified by an IP address:port number.

---

48
Is TCP connectionless? Why?

- No - TCP is a connection-oriented Transport layer protocol. This is evident from the use of handshaking prior to sending data. The three-way handshake used in TCP establishes a connection between client and server and is a part of how the protocol provides reliable data transmission. Connectionless protocols (like UDP) do not have a handshake and allow data to be sent quite quickly, but do not inherently provide any confirmation that data has been sent properly, or is even received.

---

49
==How do sockets on the implementation level relate to the idea of protocols being connectionless or connection-oriented?==

- Sockets are used by both connectionless and connection-oriented protocols. Sockets essentially define where a message should be sent to and do not (in and of themselves) define what actually is or should be in a message. Conceptually speaking, sockets are a communication end-point made up of IP address:port number (e.g. `192.233.23.234:80`).
- At an implementation level, sockets are objects that can be instantiated to manage the messages at a specific IP:port number.

---

50
What are sockets on implementation and on a theoretical level? 

- Theoretically, sockets are a communication end-point which define where a message should be sent. Conceptually, this is an abstraction for an endpoint used for inter-process communication (e.g., an IP address:port number, e.g., `192.233.23.234:80`)
- On an implementation level, sockets are objects that can be instantiated to do specific things associated with creating connections between processes or applications. Sockets might be related to UNIX sockets which are a mechanism for communication between local processes running on the same machine, or internet sockets which are a mechanism for communication between networked processes (usually on different machines). The Berkeley sockets API model includes specific functions like `bind()`, `listen()`, `accept()`, and `connect()`.

---

51
What does it mean that the protocol is connection-oriented?

- A connection-oriented protocol is one that requires a connection be established between each sender and receiver (typically a process). If multiple processes are running on a computer, a new instance of a 'receiver' (i.e., a new socket object) is created for each process which receives only the specific messages associated with that process (i.e., will listen for messages sent to a specific four-tuple: source port, source IP, destination port, destination IP).
- A rough analogy for connection-oriented conversations with 5 different people at the same time would be for someone to clone themselves 5 times and assign a clone to each conversation which is taking place.

---

52
==What is a three-way handshake? What is it used for?==

- A three-way handshake is used as part of the TCP protocol to establish a connection between a client and a server.
- First the *sender* will send a "SYN" flag to the *receiver*.
- Once the "SYN" is received, the *receiver* will send a "SYN ACK" to the *sender*.
- Once the "SYN ACK" is received, the *sender* will send a **"ACK"** and then begin transmitting data

---

53
What are the advantages and disadvantages of a Three-way handshake? 

- Advantages:  establishes a more reliable connection between sender and receiver - i.e., no data is sent until the receiver confirms the connection has been established.
- Disadvantages:  the handshake process requires 1 RTT (round-trip-time) prior to sending data. In high-latency situations, this single RTT can be significant. If multiple connections are being made, then the need to wait for 1 RTT each time is also time-consuming.

---

54
What are multiplexing and demultiplexing?

- Multiplexing is the ability to send more than 1 message concurrently through a single channel. The act of coding or combining those messages to send is also 'multiplexing'.
- Demultiplexing is deciphering each individual message which may have been received in combination through a channel as a result of multiplexing.

---

55
==How does TCP facilitate efficient data transfer?==

- TCP can be considered efficient since the protocol includes features that prevent duplication of data sent and ensures the receipt of data sent; this prevents errors that may arise from incomplete or corrupt data.

---

56
==What is flow control? How does it work and why do we need it?==

- Flow control refers to the process where a sender ensures that the receiver is not overloaded with information being sent.
- Flow control is implemented through use of the window header in TCP segments which indicates to the sender how much data the receiver can receive.

---

57
==How TCP prevents from receiver's buffer to get overloaded with data?==

- TCP will reduce the window - the number of Segments that will be sent prior to a confirmation being sent by the receiver. As a receiver's buffer fills with data waiting to be processed, the receiver will reduce the window size in acknowledgements being returned to the sender.

---

58
==What is congestion avoidance?==

- ==Congestion avoidance is where a router chooses the most efficient path to send information from 1 network location to another.==
- Congestion avoidance is also implemented in the TCP protocol through the use of changing transmission windows. The protocol will monitor the amount of data loss (i.e, retransmissions) in the connection and will adjust the transmission window (how much data is sent over the connection before waiting for acknowledgements from the receiver) to minimize congestion. 

---

59
**==What is network congestion?==**

- Network congestion occurs when there is more data being transmitted on a network than there is capacity on the network to transmit that data. Typical consequences of network congestion are increased delays (latency), data loss, or the blocking of new connections.

---

60
How do transport layer protocols enable communication between processes?

- There are 2 main transport layer protocols:  UDP ==(User Datagram Protocol)== and TCP ==(Transmission Control Protocol)==
- The names of the PDUs are Datagram and Segment, respectively.
- These protocols enable communication between processes by embedding requests and other data from the Application layer within the data payload of the PDUs.
- The headers of both protocol PDUs contain the source port, destination port, and checksum.
- The Segment header will also contain flags such as SYN, ACK, FIN, window size, and sequence number.

---

61
Compare UDP and TCP. What are similarities, what are differences? What are pros and cons of using each one? 

- Similarities between UDP and TCP:
  - Both are transport layer protocols and enable the transfer of information from port to port (i.e., from server port to client port, in collaboration with the Internet and Link layers below)

- Differences:
  - UDP:  Connection-less protocol, offers no additional functionality for reliability, de-duplication, integrity-/error-checking, PDU sequence, no handshake on connection, so enables very quick sharing of data. Since this protocol offers no additional functionality, it's also very simple and "lightweight", making it flexible and adaptable for user-implemented features.
  - TCP:  Connection-oriented protocol, offers functionality for reliability, de-duplication, integrity-/error-checking, PDU sequence, uses three-way handshake to establish connection; uses something similar to close a connection; requires 1RTT to establish connection as part of three-way handshake; very stable and contains many features to ensure data is transmitted / received properly. These features can make TCP slower (e.g., handshaking, waiting for acknowledgement of receipt of sent data) and the use of in-order delivery makes TCP susceptible to head-of-line blocking

---

62
What does it mean that network reliability is engineered?

- Use of TCP (or implementing similar functions for receipt confirmation for data sent, de-duplication, integrity-checking, PDU sequencing, etc.) creates reliability for sharing of data over inherently unreliable physical networks and packet transmission

---

63
Give an overview of the Application Layer.

- The Application layer is the highest layer in the TCP/IP model which roughly maps to the  the Application, Presentation, and Session layers of the OSI model.
- This layer allows various actual internet services like the web, email, ftp, etc. to operate by providing the structure for these various processes to transmit messages. For example, the HTTP protocol transmits request and response messages (generally as text) composed as part of the Application layer as encapsulated data within the lower levels (Transport, Internet, Link).

---

64
What is HTML?

- HTML is HyperText Markup Language and is the specific syntax used to share information request and provided via the HTTP protocol (which is used for the world wide web service).
- HTML syntax is characterized by the use of opening and closing "tags" indicated by the use of "< >" and "</>" (e.g., "\<p>Paragraph content here\</p>")

---

65
What is a URL and what components does it have?

- A URL is a **Uniform Resource Locator**, a specific type of URI (Uniform Resource Identifier) and is a string of text which provides the means and location of a resource.
- Key components of the URL are:
  - scheme (e.g., `http`)
  - `://`
  - host (e.g., `www.example.com`)
  - optional port (e.g., `:200`)
  - path (e.g., `/info/index.html`)
  - optional query parameters (e.g., `?id=1234&field=name`)

---

66
What is a Query string? What is it used for?

- A query string is used to provide additional information to the server as part of an HTTP request. This information is passed to the server as part of the URL used to place the request.
- The query string is indicated by the use of the `?` character following the 'path' in the URL and a series of key-value pairs identified using the syntax 'key=value' and separated by `&`.

---

67
==What URL encoding is and when it might be used for?==

- URL encoding is a technique where certain characters in a URL are replaced with an ASCII code (e.g., `%20` replaces a ` `). Only standard (not extended) 128-bit ASCII characters can be used in a URL and certain characters are reserved (e.g., `?`, `&`, `:`, etc.) and others may be mis-interpreted by other back-end systems (e.g., ` `, `'`, `"`, `#`, `<>`, `[]`, `{}`, `~`).
- URL encoding is used when when unsupported, reserved, or special characters are included as part of the URL (typically in the path or query parameters).



---

68
Which characters have to be encoded in the URL? Why?

- Characters such as " ", "?", "&", "=", or non-UTF-8 characters must be encoded to be able to be transmitted to and interpreted correctly by the server.
- Any characters in the extended 128-bit ASCII character set, reserved characters (e.g., `/`, `?`, `:`, `&`, `@`), and 'unsafe' characters (those that could be misinterpreted or modified by some systems, e.g., `%`, ` `, `'`, `"`, `#`, `[]`, `<>`, `{}`)

---

69
What is www in the URL?

- "www" indicates "world wide web" - an internet service that may be available at a particular host.  e.g., `www.google.com` indicates the "world wide web" service at the host `google.com`

---

70
==What is URI?==

- A URI is a Universal Record Identifier : a generic term referring to a string of characters that identifies a particular resource within an information space (e.g., for a resource within a web, or a book within a library) that includes more specific identifiers like a URL (Uniform Resource Locator) or a URN (Uniform Resource Number).

---

71
What is the difference between scheme and protocol in URL?

- A scheme (also called a scheme name) is aa a specific keyword that indicates what protocol should be used when accessing a particular resource identified by the URL. Scheme names are assigned by the IANA and are typically all lowercase, while the corresponding protocol is referenced by all caps (e.g., `http` is the scheme and `HTTP` is the corresponding protocol).

---

72
What is HTTP?

- HTTP is HyperText Transfer Protocol, which is the protocol used by the world wide web to send and receive requests. Typically, information that is sent via HTTP is typically encoded as HTML (HyperText Markup Language) pages, but the information retrieved can also be other documents, scripts, images, videos, etc.
- HTTP is a stateless, text-based, response / request protocol which is inherently insecure.
- It is used by clients to make requests and servers to return correponding responses.

---

73
==What is the role of HTTP?==

- The role of HTTP is to define how requests and responses for the world wide web are structured.

---

74
Explain the client-server model of web interactions, and the role of HTTP as a protocol within that model

- Web interactions involve a request (sent by the client) and a response (sent by a separate server). HTTP is the protocol used to structre those requests and responses.
- Typically, 1 server will respond to requests from many clients.

---

75
What are HTTP requests and responses? What are the components of each?

- HTTP requests and responses are both HTTP messages. Requests are typically sent by the client to the server and responses are sent by the server back to the client. HTTP messages are text-based.
- An HTTP request will contain:
  - method + path ("request line"), protocol (HTTP) version (for HTTP version ==1.0+==)
  - headers (key-value pairs of additional related information)
  - optional body containing further info associated with the request (e.g., for POST requests)
- An HTTP response will contain:
  - status line (code and text)
  - headers (generally optional)
  - optional body containing associated info

---

76
Describe the HTTP request/response cycle.

- A connection is formed (via TCP) between the client and a web server
- A (text-based) HTTP request is sent
- Once received, the web server processes that request and sends a (text-baesd) HTTP response

---

77
What is a state in the context of the 'web'?

- State is any information stored about a particular (HTTP) request (e.g., or a user who makes that request).

---

78
What is statelessness?

- Statelessness means that no information is stored about any particular request: once the server has responded to a particular request, it is complete. This also implies that all of the information required to satisfy each request is sent with that request - thus no additional information needs to be stored to satisfy each request.

---

79
What is a stateful Web Application?

- A stateful web application is a web application (one that communicates with a server via HTTP) that mimics a stateful application through the use of various techniques. 
- Those techniques include the use of:
  - sessions and session identifiers
  - cookies
  - AJAX (Asynchronous Javascript and XML)

---

80
How can we mimic a stateful application?

- Since HTTP is an inherently stateless protocol, session identifiers and/or cookies are typically used to provide additional information along with each HTTP request to identify users and thus allow web applications to react as if persistent information (like a shopping cart, login, user profile, etc.) is being stored.
- Also, the use of AJAX can improve the interactivity of web applications by not requiring a full page refresh for requests made to the server. Requests can be made asynchronously (i.e,. in the background) and updates to the screen can be handled by callback functions which allow web applications to behave more like traditional software applications.

---

81
What is the difference between stateful and stateless applications?

- A stateful application is one in which information can persist (i.e., be saved) throughout multiple user interactions.
- In contrast, a stateless application is one in which no information from a prior interaction is saved (i.e., no information is saved from the current user interaction).

---

82
What does it mean that HTTP is a 'stateless protocol'? 

- No information about prior request/response interactions are required or saved for each request/response interaction between client and server.

---

83
Why HTTP makes it difficult to build a stateful application?

- Since HTTP is inherently stateless, each response/request is independent and the server will not be able to store information about users without the use of additional techniques to mimic a stateful application.

---

84
How the idea that HTTP is a stateless protocol makes the web difficult to secure? 

- Since HTTP is a stateless protocol, and HTTP requests are sent in as text, any identifying information about a user which needs to be submitted can be intercepted by a malicious user and can be used for session hijacking (i.e., a malicious user pretending to be an authorized user in a web application).

---

85
What is a `GET` request and how does it work? 

- A 'GET' request is used to request information from a web server, which is returned as HTML information in the HTTP response.

---

86
==How is `GET` request initiated?==

- A 'GET' request is encapsulated within the data payload of an IP packet which is transmitted when a client and server are connected via a TCP connection.
- The request will be text, which includes the method ('GET') a path indicating what information to retrieve (e.g., /index.html) and an HTTP protocol version (typically =='HTTP1.1'==)
- In addition, a number of headers (key-value pairs) related to the request may also be included which are used by the server.

---

87
What is the HTTP response body and what do we use it for?

- The HTTP response body is ==where the raw response data will be in an HTTP response.==

---

88
==What are the obligatory components of HTTP requests?==

- Required components of an HTTP request are:
  - request method
  - path
  - HTTP version (from version ==1.0== onwards)
  - Host header (required for specific HTTP versions)

---

89
==What are the obligatory components of HTTP response?==

- Required components of an HTTP response are:
  - a status line

---

90
Which HTTP method would you use to send sensitive information to a server? Why?

- `POST` is the right method to use since sensitive information can be encrypted and included within the body of the request rather than sent as plain text (e.g., as a query parameter).

---

91
==Compare `GET` and `POST` methods.==

- GET:
  - used to retrieve information from a web server
  - some information can be sent through query parameters, but there is an overall length restriction on info sent this way
  - information sent as query parameters is easily read as text

- POST:
  - used to change information on a web server
  - does not have a length limitation (within the body of the POST request)

---

92
==Describe how would you send a `GET` request to a server and what would happen at each stage.==

- Need to "form" the request: i.e., create the text associated with the request (method, path, protocol version, associated headers)
- Need to encapsulate that request as part of data payload of IP packet
- that packet needs to be sent across the internet to the correct socket (IP:port) and received
- 

---

93
==Describe how would you send `POST` requests to a server and what is happening at each stage.==

- Very similar to GET request (above), but information to be sent to the server is encoded within the 'body' of the request

---

94
What is a status code? What are some of the status codes types? What is the purpose of status codes? 

- Status codes are a required part of an HTTP response. These codes indicate whether or not a request can be fulfilled by the server, and if not, what the potential reason might be for the error.
- Status codes typically include a numeric code and then a short string of some identifying text.
- ==Common status codes are: 200 OK, 302 Found, 404 Not Found, 500 Server Error==

---

95
Imagine you are using an HTTP tool and you received a status code `302`. What does this status code mean and what happens if you receive a status code like that? 

- The code 302 means that the information requested has been moved to another location, but was found. Typically that new location (URL) is contained within the `Location` header and browsers will automatically re-direct to the indicated location.

---

96
How do modern web applications 'remember' state for each client?

- Modern web applications typically apply 1 or more workarounds to 'remember' state for each client:
  - cookies can be used to store information that pertains to a user
  - a session identifier can be used by the server to track history associated with a series of interactions

---

97
What role does AJAX play in displaying dynamic content in web applications?

- AJAX is ==Asynchronous Javascript And XML== which allows the browser to use Javascript to respond to web applications interactions, rather than having to send all interactions as HTTP requests to the server (and refresh the screen every time). Since every screen refresh requires re-drawing the screen, and possibly receiving content from the server (subject to network latency), this process would great slow down every interaction and prevent a fluid, application-like experience for users.
- By letting the response to user interactions occur asynchronously (i.e., responses can occur in the background) and letting Javascript, rather than HTML, handle the responses the user experience can be more specifically controlled and dynamic content can appear more fluid than pure HTTP interactions would allow.

---

98
Describe some of the security threats and what can be done to minimize them?

- **Session hijacking**: when a malicious user obtains the session information from an active user and can thus appear to be that user in interactions with a web server. This would allow a malicious user to use their own system to pretend to be another user without that other user being involved or even aware their account was being used.
- **Packet sniffing**: when a malicious user intercepts IP packets being sent through the internet and can retrieve sensitive information (such as session ids, bank account numbers, etc.)
  - Both of these threats can be minimized through the use of encrypted data payloads for transmission (e.g., using TLS - Transport Layer Security)
- Malicious users can setup fake servers / domains and pretend to be a trusted entity
- **Fake servers**: a malicious user may be able to pose as a legitimate site and fool users into entering sensitive information
  - Use of TLS requires a server to send a digital certificate which has been issued by a Certificate Authority (CA). These CAs validate the identity of domain owners (i.e., they are who they say they are). Certificates from CAs are digitally-signed through the use of a private key to validate each certificate.
- **Cross-site Scripting** is when a users adds javascript code to a website through forms, comments, or other text-input areas which is inadvertently executed by the server.
  - all input text should be sanitized (e.g., by removing \<script> tags or disallowing HTML and JS in user inputs)
  - any user input that is displayed on-screen should be escaped to prevent the browser from interpreting that text as code (e.g., using HTML entities to replace characters like "<>")

---

99
What is the Same Origin Policy? How it is used to mitigate certain security threats?  

- An "origin" is comprised of a scheme, host, and port. The Same Origin Policy would allow or restrict various requests or actions depending on whether the request was received from the same origin or a different origin ("Cross-Origin"). Generally, there are no restrictions on interactions from the same origin (i.e., the same server), but there are restrictions when a different origin tries to request resources programmatically using APIs like 'XHR' or 'fetch'.
- This policy also helps to prevent session hijacking.

---

100
What determines whether a request should use `GET` or `POST` as its HTTP method?

- The desired intent of the request: a 'GET' request is used to retrieve information from the webserver (information remains unchanged); a 'POST' request is used to change information on a webserver.

---

101
What is the relationship between a scheme and a protocol in the context of a URL?

- A scheme is the IANA-assigned name which corresponds to a particular Application-layer protocol. Typically (but not always), the scheme name is the same as the protocol name and is provided in lowercase and the corresponding protocol in uppercase (e.g., `http` is the scheme and `HTTP` is the protocol).

---

102
In what ways can we pass information to the application server via the URL?

- Information can be passed to the application via the (optional) query parameters of the URL.
- These parameters are separated from the URL path by `?` and take the form of a series of key-value pairs separated by `&`
- e.g., `id=19283&location=us&colour=blue`

---

103
How insecure HTTP message transfer looks like?

- Insecure HTTP messages are transmitted in plain text.
- The inclusion of sensitive information (e.g., usernames and passwords) being passed via the URL is also very insecure (e.g., `http://www.myaccount.com/login.html?username=James&pw=password`)
- Generally speaking, the use of the HTTP protocol is insecure. Malicious users can use packet sniffing and session hacking to compromise sensitive user information.

---

104
==What services does HTTP provide and what are the particular problems each of them aims to address?==

---

105
What is TLS Handshake?

- TLS handshake is used to establish a secure connection when using TLS for HTTPS. The handshake is used to determine the cipher suites which will be used and to establish a unique key used to encrypt communications between client and server. Initially, assymmetric key encryption is used to establish a symmetric key to encrypt further communications. Symmetric key encryption is then used for subsequent transmissions between server and client.
- ==The steps are:==
  - Client sends version(s) of TLS supported (which helps to establish cipher suites)
  - Server confirms cipher suites and sends certificate, public key for encryption, encrypted symmetric key
  - Client sends confirmation of secure connection using symmetric key 

---

106
==What is symmetric key encryption? What is it used for?==

- Symmetric key encryption is when a single key is used for both encrypting and decrypting messages.  Both the sender and the receiver would use the same key to code / decode messages.

---

107
==What is asymmetric key encryption? What is it used for?==

- Asymmetric key encryption involves the use of 2 keys - typically 1 for the sender and 1 for the receiver
- Message encryption with these keys only works in a single direction: i.e., messages encoded with key1 (e.g., a private key) can only be decoded by the corresponding key2 (e.g., a public key) and messages encoded by the key2 can only be decoded by the corresponding key1.
- Asymmetric key encryption can be used to help verify the identity of a Certificate Authority (CA):  Certificates issued by the CA will contain both the unencrypted signature, as well as a version that is encrypted via the CA's private key. By using the public key to decrypt the encrypted signature and compare it to the unencrypted version 3rd parties can confirm that the private key was used to encrypt the signature and thus the CA is who they say they are (the assumption is that only the real CA would know the private key associated with their signature).
- Assymmetric key encryption is also used in the TLS handshake. 

---

108
==Describe SSL/TLS encryption process.==

- The TLS encryption process starts with the TLS handshake which help to establish the cipher suites that will be used in the handshake and subsequent transmissions, as well as establishing the encryption keys that will be used.
- Asymmetric key encryption is used to establish a symmetric key. The symmetric key is used for encrypted HTTP message transmissions.
- TLS handshake:
  - Client sends 'ClientHello' containing:
    - max protocol version supported, list of cipher suites supported
  - Server sends 'ServerHello' and:
    - server's digital certificate w/ public key
    - sets protocol version and cipher suites
    - ServerHelloDone
  - Client sends:
    - ClientKeyExchange with 'pre-master secret' (encrypted w/ server public key), ChangeCipherSpec and Finished flag
  - Server:
    - decrypts 'pre-master secret' and generates symmetric key
    - sends ChangeCipherSpec
    - sends Finished

---

109
Describe the pros and cons of TLS Handshake

- Pros: secure, encrypted transmissions (asymmetric key encryption) are used to establish a secure, encrypted transmission channel (symmetric key encryption)

- Cons: can be slow; requires an additional ==2 RTT== (depending on TLS version) after the initial TCP three-way handshake has been established (1 RTT).

---

110
Why do we need digital TLS/SSL certificates? 

- Digital TLS/SSL certificates are sent by the server as part of the initial TLS handshake and are used by the client to verify that a CA has verified the web server.

---

111
What is it CA hierarchy and what is its role in providing secure message transfer?

- The CA hierarchy refers to various levels of Certificate Authorities - parties that issue digital certificates - which form a chain of trust which verifies the identities of domains on the internet.
- The highest-level of trust is given to a small group of Root Authorities (RA) which are internet entities that are endorsed by software and infrastructure companies as being the most trust-worthy. RAs guard their private keys (for their digital signatures) very carefully and provide sign-off on digital certificates for general Certificate Authorities (CA) which issue digital certificates on their behalf to trusted domains.
- CAs issue digital certificates, which include the digital sign-off by their RAs, to domains, whose identity they verify through various processes. The sign-off by CAs and RAs form the CA hierarchy, also called the "chain of trust" which help to validate domains are registered to legitimate businesses.
- If the domain, or even a CA is compromised, then the party which certified it can revoke their digital signature, which will raise a red flag during the TLS handshake and alert users that the domain may be compromised.

---

112
What is Cipher Suites and what do we need it for?

- Cipher Suites are a set of encryption algorithms defined jointly by the client and server, based upon the highest versions of TLS supported, which will be used throughout the TLS handshake process and secure message transmission process. The Suites include the encryption algorithms that will be used in asymmetric key encryption, symmetric key encryption, digital certificate verification, and data transfer integrity checking.

---

113
How does TLS add a security layer to HTTP?

- TLS is an additional protocol that encrypts the data payloads from the HTTP / Application layer prior to encapsulating them in the Transport layer.  TLS can be thought of as part of the "session" layer of the OSI model (still within the Application layer of the TCP/IP model).

---

114
Compare HTTP and HTTPS.

- HTTP is inherently insecure - messages are transmitted in unencrypted text through IP packets that can be easily intercepted and read
- HTTPS is an additional layer of encryption (using TLS) which is added to HTTP data payloads and prevents the easily intercepted IP packets from being read by malicious users. 

---

115
Does HTTPS use other protocols? 

- HTTPS uses the TLS protocol to encrypt data payloads being transmitted via TCP. Otherwise, it is similar to HTTP (same message structures) and also uses TCP, IP, Ethernet to package, route, and transmit data from the client to and from a server across the internet.

---

116
How do you know a website uses HTTPS?

- The URL scheme name will be `https`, which indicates the use of the HTTPS protocol scheme.
- Typically, browsers will also display a padlock icon near the URL indicating the user of a secure, encrypted connection.

---

117
Give examples of some protocols that would be used when a user interacts with a banking website. What would be the role of those protocols? 

- HTTPS and TLS will be used to establish a secure, encrypted message exchange protocol; these protocols use both asymmetric key encryption (to establish a symmetric key) and symmetric key encryption in message transmission
- HTTP is the protocol used to define what information is requested by the client and responded to by the server
- TCP is the protocol used to establish a connection between the client host and server host on the internet (e.g., for IP packets to travel from client computer to source server and vice versa)
- The Ethernet protocol would be used to transmit IP packets within Ethernet frames within the sub-networks which connect the client to the internet and also the server to the internet.

---

118
What is server-side infrastructure? What are its basic components?

- A server can be thought of as having a few basic components (each of which could be comprised of many physical or virtual machines):
  - web server: used to respond to requests for static assets like images, information or other components of web information
  - application server: used to contain the server-side code and business logic that are part of a web application
  - data storage: databases, text files, or other means by which information associated with the web application can be stored and persist so that it can be retrieved, as required, by the web application

---

119
What is a server? ==What is its role?==

- A server is any computer (or node) that can respond to requests that are issued to it. These requests may be relate to specific protocols such as HTTP for web servers, FTP for file servers, SMTP for email servers, etc.

---

120
==What are optimizations that developers can do in order to improve performance and minimize latency?==

- Using AJAX and client-side code can greatly improve the user experience of web applications by reducing page refreshes (which require new connections and handshaking, creating delays).
- Using a CDN (Content Delivery Network) to store and deliver static web assets can reduce latency. CDNs are a network of servers that are strategically located to be geographically closer to users and thus reduce the transmission delays which contribute to latency.
- Developers can also use long-lived TCP connections, which once established can be re-used and thus eliminate the 1 RTT handshake delay when opening a new connection.

---
