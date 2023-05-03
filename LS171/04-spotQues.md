# SPOT wiki practice questions
https://fine-ocean-68c.notion.site/LS170-09792b25c5824b79bf97ca27fdd8c9aa?p=51650b0259b1467a8500473d853ec14c&pm=s

---

1
What is a network?

- A network is 1 or more computers connected in such a way that allows them to communicate and share information.

---

2
What is the Internet?

- The internet is a network of networks.  In includes all of the physical devices (e.g., cables, routers, servers, computers, etc.) and the protocols which enable the sharing of information between computers.

---

3
Is the Internet the same thing as a network? 

- Not quite. The internet is similar to a network, but because it's the interconnection of many different networks, it's much larger and more complex than any specific network might be.  At the smallest scale, a network could be a LAN (Local Area Network) where 2 computers are connected by a single cable to share information.  The internet is comprised of many (more complicated) LANs all interconnected and supported by a series of protocols that allow all of the computers to connect and share information.

---

4
==What is WEB (world wide web)==

- The World Wide Web or "web" is an internet service that is supported primarily through the HTTP protocol (HyperText Transfer Protocol). This service allows one computer the ability to request information from another computer on the internet. These requests and the corresponding responses are completed using HTTP requests / responses and information is shared through HTML (Hyper Text Markup Language) "pages" of information. Today, the web has evolved to include a multitude of more complex and feature-rich protocols and languages, however, the basic HTTP request/response structure is still used today.

---

5
What is the difference between network, Internet, and WEB?

- A network is the most basic "unit" - the interconnection of 1 or more computers to share information.  The Internet is a connection of multiple networks to be able to share information.  The Web is a service (an agreed upon standard way to share information on the Internet) which uses the physical interconnection and protocols of the Intenet to share information.

---

6
==What are LAN and WLAN?==

- A LAN is a Local Area Network. This is the most basic form of network where 1 or more computers are connected together to share information. Typically, all of the computers in the LAN are connected via cables to a hub or a switch. Information is shared between the computers through an ethernet cable.  A WLAN (Wireless Local Area Network) is similar to a LAN, but the computers are connected to a wireless switch via radio waves rather than physical cables.

---

7
What is a protocol?

- A protocol is an (agreed) set of rules that govern the sharing of information.

---

8
What is the role of protocols? 

- Protocols allow the efficient and effective communication of information between 2 parties. Without agreed rules, it would be very difficult to communicate, especially as the number of parties increases. An example of a protocol might be the use of a (common) language, or the social convention of taking turns when speaking - without either of these "protocols" it would be extremely difficult to communicate effectively.

---

9
Why there are many different types of protocols?

- Protocols may govern different aspects or forms of communication. For example, in everyday communication defining a common language (and the structure and rules of that language) may be 1 protocol. Whether or not we speak those words or write them down in a message (and how that message might be structured) is another protocol. How the physical transmission of that message from 1 party to another, whether it's through the air or through the mail, might require another protocol.

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

- The levels referred to here are the layers of the OSI or TCP/IP model. The levels or layers at the bottom of these models relate more to the transmission of information over physical infrastructure such as the wires, cables, or radio waves. Protocols at these levels define how binary information will actually be sent and received. At the lowest level (physical) common protocols might be 802.11 for wifi communication or standards for coaxial and fibre optic cable. The sending and receiving of information via that physical infrastructure will be governed by link protocols such as Ethernet which includes a header with source and destination address information along with additional data payload information.

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

---

19
==How can we as developers deal with the limitations of physical network?==

- Developers are always working within the limitations of physical networks (bandwidth, latency, hops). Being aware of these limitations and consciously choosing what protocols to use and what information to send over the physical network can help to optimize performance for the end-user. For example, where latency is a significant concern (and reliability is not), the use of UDP may be a more appropriate Transport protocol than TCP: TCP requires initial handshaking which takes a single round-trip time to establish a connection, whereas UDP does not and can send data immediately.

---

20
==What is Latency?==

- Latency is the amount of time (delay) it takes a single unit of data to go from 1 location to another. It is comprised of a few different elements:
  - Transmission delay : the amount of time it takes a signal to travel along the physical media (e.g., cable or through the air)
  - Processing delay : the amount of time it takes a signal to be "pushed" from 1 physical device to another (e.g., cable to a router)
  - Queuing delay : the amount of time a signal may wait in a buffer before it is processed
- Latency can be thought of as the speed of a car on a road - how fast that car travels is a measure of the latency similar to how a packet of data may travel through a cable.

---

21
What is Bandwidth?

- Bandwidth is the amount of data that can travel from 1 location to another in a single unit of time.
- If using a car to transport cargo from 1 location to another is an analogy for transporting some quantity of data from 1 location to another, then using a truck to transport data at the same speed would be increasing the bandwidth. Increasing bandwidth has also been described as increasing the number of lanes to allow more cars to transport data concurrently.

---

22
==What are Network 'Hops'?==

- A 'hop' refers to the interconnection between 1 physical device and another on a network. At each 'hop' a frame of data will move from 1 physical device to another (e.g., from a cable to a router, or from a router to wireless signal).
---

23
What is the relationship between network 'Hops' and latency? 

- The more hops that a unit of data has to undergo, the higher the overall latency will be (i.e., the higher the delay will be for that unit of data to reach its destination). This is the result of additional processing and possibly queuing delays which may occur at each 'hop'.

---

24
What is a switch and what is it used for?

- A switch is a physical device used to connect computers together in a network. The switch will maintain a record of the MAC address for each device which is connected to it (and the port that it is connected to) and send only information that is intended for each device. This is in contrast to a hub (see next question).
---

25
What is a hub and what is it used for?

- A hub is a physical device used to connect computers together in a network. The hub will broadcast messages it receives to all devices that are connected to it. It works well for simple networks with few devices, however, it does not work well for large networks since it broadcasts messages to all connected devices and thus creates unnecessary network traffic which can ==lead to increased latency.==

---

26
==What is a modem and what it is used for?==

- A modem (modulate/demodulate) is a physical device used to convert data (i.e., binary information) to a signal suitable for the physical media it is travelling over (e.g., a modem could convert binary data to sounds to transmit over phone lines).

---

27
==What is a router and what is it used for?==

- A router is a physical device used to direct information it receives in a network to the appropriate place - either to another router (i.e., for a different network / sub-network) or to a switch within a network. Routers are typically assigned a consecutive series of IP addresses for which they are responsible for receiving incoming data.

---

28
==What is the difference between a switch, hub, modem, and router?==

- Switches and hubs are used to connect computers together into a LAN. Switches are more efficient devices to use since they only send messages that are intended to each device; hubs send all messages to all devices connected. Modems are used to send information across non-ethernet media or cables (such as phone lines, coaxial cable, or fibre-optic cable). Routers are used to connect networks together.

---

29
==How does the Internet work?==

- The internet is a complex system comprised of computers being physically connected together and communicating through a set of standard protocols.
- Computers are connected together using Ethernet cables or wireless wifi networks into Local Area Networks (LANs) via hubs or switches. The Ethernet protocol helps to send information along these cables between computers. LANs are to other networks through modems and routers. The Router acts as a 'gateway' for each LAN to the other networks connected together, and the modem is used to transmit the data between routers from 1 network to another (sometimes over great distances like under the ocean from 1 continent to another). The information sent between computers is structured in specific ways to contain some Application information (like an HTTP request), some Transport information related to reliability/integrity/etc information, some Internet information like a network address (IP), and some Link information like a MAC address for a device. This information allows a request from a single computer to travel out across a network of networks and to its final destination (e.g., an HTTP server that can respond to the request).

---

30
==What is a MAC address and what is its role in network communication?==

- A MAC address is (theoretically) a unique identifier assigned to every physical device that can connect to a network (i.e., that has a Network Interface Card [NIC]). MAC addresses are comprised of several digits where the first section of digits are assigned to each device manufacturer by the IANA.
- The MAC address is used to identify a particular device within a LAN so that information sent in Frames within a network can be sent to specific, desired devices.

---

31
Give an overview of the Link/Data Layer

- The Link/Data layer is the layer that references the physical media like cables that data travels over. The primary protocol we are concerned with at this layer is Ethernet which defines a PDU called a Frame which includes the MAC address of the source and destination computers. Frames which travel along Ethernet cables are separated by an "inter-frame gap" which for 100 Mbps ethernet is typically around ==0.96 ms==.

---

32
What is included in an Ethernet frame?

- An Ethernet frame includes a header which contains the source and destination MAC address, the data payload (which contains encapsulated data from higher level protocls) and a footer which includes the ==FCS (frame checksum)== which is used to validate the integrity of the frame.

---

33
Give an overview of the Internet/Network Layer and it's role.

- The Internet/Network layer is the layer that references various hosts (routers) on the internet and facilitates the travel of information across the many networks which make up the internet. Every router is responsible for a series of IP addresses which may be defined according the IPv4 or IPv6 protocol. These protocols use a series of digits to assign a unique logical address to every device connected to the internet. The digits which make up the IP address are assigned in a hierarchical fashion: the left-most digits correspond to high-level regions, and as you right, digits correspond to successively smaller sub-networks.

---

34
What is IP?

- IP refers to the "Internet Protocol" which is the protocol at the Internet/Network Layer. This protocol relates to the assignment and use of logical IP addresses to devices connected to the internet. There are 2 specific versions of IP currently in use: IPv4 and IPv6. IPv6 is an updated version of the protocol that allows for significantly more unique IP addresses to be assigned (340 undecillion unique addresses in IPv6 vs only 4.3 billion unique addresses in IPv4).

---

35
What is IP address? 

- An IP address is a unique logical address assigned to each device connected to the internet. (see above)
---

36
==What are the components of IP addresses?==

- IP addresses are represented by a series of digits. IPv4 address are represented by a 4 sets of decimal numbers from 0 to 255.  IPv6 address are represented by ==8 sets of 128 bit numbers (typically shown as 4 digit decimal numbers)==.

---

37
What is a packet in computer networking?

- A packet is the name given to an Ethernet PDU at the Data/Link layer. This PDU contains header information with the source and destination MAC address along with a data payload and an ==FCS footer==.

---

38
Why do we need both MAC addresses and IP addresses? 

- MAC addresses are "burned in" (unchanging) identifiers used to identify specific devices in a LAN. IP addresses are a logical address that is assigned in a hierarchical way to help identify the regions, networks and sub-networks a particular device is associated with so that information travelling across the internet can be directed to the right place. An analogy for a MAC address might be someone's full name - it's an identifier (although not necessarily unique) which is required to send mail to someone, but it works best along with a full address (house number, street, city, province, country) to ensure that the mail can be routed effectively from 1 location in the world to another.

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

- The Transport layer has 2 common protocols, TCP and UDP, and is concerned with transmitting application (e.g., HTTP) information from port to port.
- TCP is a connection-oriented protocol and thus uses handshaking to establish a connection prior to sending data. The corresponding PDU is the Segment.
- UDP is a connection-less protocol and thus does not use handshaking to establish a connection prior to sending data. The PDU is the Datagram.

---

43
==What are the fundamental elements of reliable protocol?==

- A reliable protocol is one that can:
  - ensure no duplication of data transmitted
  - ensure the integrity of data transmitted
  - manage the order in which data is transmitted
  - ensure the completeness of data transmitted

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

- TCP is a connection-oriented Transport layer protocol. This is evident from the use of handshaking prior to sending data. The three-way handshake used in TCP establishes a connection between client and server and is a part of how the protocol provides reliable data transmission. Connectionless protocols (like UDP) do not have a handshake and allow data to be sent quite quickly, but do not inherently provide any confirmation that data has been sent properly, or is even received.

---

49
==How do sockets on the implementation level relate to the idea of protocols being connectionless or connection-oriented?==

- Sockets are used by both connectionless and connection-oriented protocols. Sockets essentially define where a message should be sent to and to not (in and of themselves) define what actually is or should be in a message. Practically speaking, sockets are an IP address:port number (e.g. `192.233.23.234:80`)

---

50
What are sockets on implementation and on a theoretical level? 

- Theoretically, sockets are a communication end-point which define where a message should be sent.
- On an implementation level, sockets are a combination of an IP address:port number (e.g. `192.233.23.234:80`).

---

51
What does it mean that the protocol is connection-oriented?

- A connection-oriented protocol is one that requires a connection be established between each sender and receiver (typically a process). If multiple processes are running on a computer, a new instance of a 'receiver' is created for each process which receives only the specific messages associated with that process.
- A rough analogy for connection-oriented conversations with 5 different people at the same time would be for someone to clone themselves 5 times and assign a clone to each conversation which is taking place.

---

52
==What is a three-way handshake? What is it used for?==

- A three-way handshake is used as part of the TCP protocol to establish a connection between a client and a server.
- First the server will send a "SYN" flag to the client.
- Once the "SYN" is received, the client will send a "SYN ACK" to the server.
- Once the "SYN ACK" is received, the server will send a =="SEND"== and then begin transmitting data

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
- Flow control is implemented through adjusting the window and timeout settings when transmitting data.

---

57
==How TCP prevents from receiver's buffer to get overloaded with data?==

- TCP will reduce the window - the number of Segments that will be sent prior to a confirmation being sent by the receiver if too many segments timeout (no confirmation is received) and need to be re-sent.

---

58
==What is congestion avoidance?==

- Congestion avoidance is where a router chooses the most efficient path to send information from 1 network location to another.

---

59
What is network congestion?

---

60
How do transport layer protocols enable communication between processes?

---

61
Compare UDP and TCP. What are similarities, what are differences? What are pros and cons of using each one? 

---

62
What does it mean that network reliability is engineered?

---

63
Give an overview of the Application Layer.

---

64
What is HTML?

---

65
What is a URL and what components does it have?

---

66
What is a Query string? What it is used for?

---

67
What URL encoding is and when it might be used for?

---

68
Which characters have to be encoded in the URL? Why?

---

69
What is www in the URL?

- "www" indicates "world wide web" - an internet service that may be available at a particular host.  e.g., `www.google.com` indicates the "world wide web" service at the host `google.com`

---

70
==What is URI?==

- A URI is a Universal Record Identifier : a generic term referring to identifiers within a network that includes more specific identifiers like a URL (Uniform Resource Locator) or a URN (Uniform Resource Number).

---

71
What is the difference between scheme and protocol in URL?

- A scheme (also called a scheme name) is aa a specific keyword that indicates what protocol should be used when accessing a particular resource identified by the URL. Scheme names are assigned by the IANA and are typically all lowercase, while the corresponding protocol is referenced by all caps (e.g., `http` is the scheme and `HTTP` is the corresponding protocol).

---

72
What is HTTP?

- HTTP is HyperText Transfer Protocol, which is the protocol used by the world wide web to send and receive requests. Information that is sent via HTTP is typically encoded as HTML (HyperText Markup Language) pages.

---

73
==What is the role of HTTP?==

- The role of HTTP is to define how requests and responses for the world wide web are structured.

---

74
Explain the client-server model of web interactions, and the role of HTTP as a protocol within that model

---

75
What are HTTP requests and responses? What are the components of each?

---

76
Describe the HTTP request/response cycle.

---

77
What is a state in the context of the 'web'?

---

78
What is statelessness?

---

79
What is a stateful Web Application?

---

80
How can we mimic a stateful application?

---

81
What is the difference between stateful and stateless applications?

---

82
What does it mean that HTTP is a 'stateless protocol? 

---

83
Why HTTP makes it difficult to build a stateful application?

---

84
How the idea that HTTP is a stateless protocol makes the web difficult to secure? 

---

85
What is a `GET` request and how does it work? 

---

86
How is `GET` request initiated?

---

87
What is the HTTP response body and what do we use it for?

---

88
What are the obligatory components of HTTP requests? 

---

89
What are the obligatory components of HTTP response?

---

90
Which HTTP method would you use to send sensitive information to a server? Why?

---

91
Compare `GET` and `POST` methods.

---

92
Describe how would you send a `GET` request to a server and what would happen at each stage.

---

93
Describe how would you send `POST` requests to a server and what is happening at each stage.

---

94
What is a status code? What are some of the status codes types? What is the purpose of status codes? 

---

95
Imagine you are using an HTTP tool and you received a status code `302`. What does this status code mean and what happens if you receive a status code like that? 

---

96
How do modern web applications 'remember' state for each client?

---

97
What role does AJAX play in displaying dynamic content in web applications?

---

98
Describe some of the security threats and what can be done to minimize them?

---

99
What is the Same Origin Policy? How it is used to mitigate certain security threats?  

---

100
What determines whether a request should use `GET` or `POST` as its HTTP method?

---

101
What is the relationship between a scheme and a protocol in the context of a URL?

---

102
In what ways can we pass information to the application server via the URL?

---

103
How insecure HTTP message transfer looks like?

---

104
What services does HTTP provide and what are the particular problems each of them aims to address?

---

105
What is TLS Handshake?

---

106
What is symmetric key encryption? What is it used for?

---

107
What is asymmetric key encryption? What is it used for?

---

108
Describe SSL/TLS encryption process.

---

109
Describe the pros and cons of TLS Handshake

---

110
Why do we need digital TLS/SSL certificates? 

---

111
What is it CA hierarchy and what is its role in providing secure message transfer?

---

112
What is Cipher Suites and what do we need it for?

---

113
How does TLS add a security layer to HTTP?

---

114
Compare HTTP and HTTPS.

---

115
Does HTTPS use other protocols? 

---

116
How do you know a website uses HTTPS?

---

117
Give examples of some protocols that would be used when a user interacts with a banking website. What would be the role of 

---
those protocols? 
118
What is server-side infrastructure? What are its basic components?

---

119
What is a server? What is its role? 

---

120
What are optimizations that developers can do in order to improve performance and minimize latency?

---
