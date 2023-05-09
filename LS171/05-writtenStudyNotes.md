# The Internet

### Have a broad understanding of what the internet is and how it works

- the internet is a network of networks; i.e., separate networks connected by systems of routers that direct traffic between networks [^1]
- these networks are connected all over the world
- it is comprised of *network infrastructure* (devices, routers, switches, cables, etc.) and *protocols* that enable infastructure to function [^5]


### Understand the characteristics of the physical network, such as latency and bandwidth

- *physical network* is tangible infrastructure that transmits electrical signals, light, radio waves which carry network communications [^5]

- **Latency** : a meausre of the *time* it takes data to get from 1 point in a network to another [^2]
  - e.g., related to the time it takes 1 car to travel from point A to point B
  - comprised of:
    - propogation delay : ratio between distance and speed
    - transmission delay : delay in going from 1 network device to another
    - processing delay : delay in actual processing of information at each network device
    - queuing delay : delay from data waiting in buffers at each network device
  - last-mile latency : increased delays at the network 'edge' (i.e., in getting the network signal from the ISPs network to the home or office network) as a result of more 'hops' (a journey between nodes on the network)

- **Bandwidth** : a measure of the *amount* of ata that can be sent in a particular unit of time (typically a second) [^2]
  - e.g., the number of lanes in that road (all cars travelling at the same speed) 
  
- increasing bandwidth doesn't necessary improve performance of network [^2]
- **bandwidth bottleneck** : a point within a network at which the bandwidth changes from relatively high to relatively low [^2]

### Have a basic understanding of how lower level protocols operate

- **Link layer**: Ethernet protocol, sends "frames" from switch to device (i.e., communication in a LAN[^5]), PDU header contains destination and source MAC address (Media Access Control) [^3]

- **Internet layer**: IP protocol, sends "packets" from host (network) to host (network) (essentially router to router, inter-network[^5]), PDU header (IPv4) contains source and destination IP addresses, TTL, Protocol (UDP vs TCP), checksum [^4]
  - 2 versions of IP in use:  IPv4, IPv6

### Know what an IP address is and what a port number is
- a logical, hierarchical address used to identify the unique 'location' of a device within the network it is connected to [^4]
- routers compare the IP address of a received packet against their routing table; use this info to determine the best route to send packets
  - routers keep track of best routes to take based upon time, politics, relationships - supports fault tolerance and reliability [^7]

- 2 versions of IP address in use: IPv4, IPv6 [^4]
  - IPv4 IP address:  32 bit length: 4 sections of 8 bits (decimal digits 0 - 255); ~4.3 billion unique, e.g., `109.156.106.255`
    - contains checksum in header
  - IPv6 IP address:  128 bit length: 8 sections of 16 bits [^4] (groups of 4 hexadecimal digits separated by colons); ~340 undecillion unique, e.g., `[2001:0:9d38:6ab8:1c48:3a1c:a95a:b1c2]`
    - different header, no checksum in header

- **port** : an identifier for a specific process running on a host from 0 - 65535 [^6]
  - ports from 49152 - 65535 are *ephemeral ports* (temporary ports that are assigned by the OS, as required)
  - common ports:
    - 80: HTTP
    - 20 and 21: FTP
    - 25: SMTP
    - 433: HTTPS

- need to use an IP address AND a port (part of transport layer PDU header) to establish inter-process communication [^6]

- **network socket**: combination of IP address and port number [^10]

### Have an understanding of how DNS works

- DNS is the Domain Name System [^11] : a distributed database that translates domain names to IP addresses; the database is stored on DNS servers
  - DNS servers are hierarchically organized and connected in a global network
  - no single DNS server contains the entire database
  - if a single DNS server does not have the required domain name mapping, the request is forwarded to another DNS server until the required IP address is found

### Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model

- HTTP is a *request response protocol* - a set of rules for the transfer of files (including. hypertext documents, CSS documents, scripts, images, videos) [^11]

---

# TCP & UDP

### Have a clear understanding of the TCP and UDP protocols, their similarities and differences

- similarities:
  - both transport layer protocols
  - headers both contain source port and destination port : support multiplexing / demultiplexing
  - support transmission of Application layer data within their data payloads

- TCP:  Transmission Control Protocol [^8]
  - connection-oriented; provides multiplexing/demultiplexing
  - provides reliable network communication on an unreliable channel, including flow-control and congestion avoidance
  - key features:
    - data integrity (error detection)
    - de-duplication
    - in-order delivery
    - re-transmission of lost data
  - PDU is a Segment
    - header includes:  source port, destination port, sequence number, flags (SYN / ACK / FIN), Checksum, window size
  - Disadvantages:
    - HOL (head-of-line) blocking : issues in delivering or processing 1 message block delivery or processing of subsequent messages (b/c of in-order delivery)
    - latency overhead in establishing connection (b/c of handshaking)

- UDP:  User Datagram Protocol [^9]
  - connection-less (no handshaking[^10])
  - key features:
    - faster - no retransmissions, acknowledgements (no HOL blocking)
    - flexible - lets dev decide what features to implement
  - does NOT offer:
    - guarantee of message delivery, 
    - in-order delivery
    - built-in congestion avoidance or flow-control
    - connection state tracking
  - PDU is a Datagram
    - header includes: source port, destination port, length, checksum (optional in IPv4)
  - Disadvantages:
    - no reliability (guaranteed message delivery, in-order delivery), no flow-control, no congestion avoidance
    - must implement required features (like congestion avoidance) yourself


### Have a broad understanding of the three-way handshake and its purpose
  
  - threeway handshake is used to establish a TCP connection, steps are: [^8]
    - Sender sends SYN
    - Receiver sends SYN ACK
    - Sender sends ACK
  - then sender can send data (requires 1 RTT to establish connection)
  - flags (SYN, ACK) are used to manage "connection state" (i.e., `ESTABLISHED`, `LISTEN`, `SYN-SENT`, etc.) [^8]

### Have a broad understanding of flow control and congestion avoidance

- **Flow control**: reducing the amount of data sent so that the receiver does not lose data
  - each side uses the "WINDOW" field of TCP header to let the other side know how much data it is willing to receive;  once buffer starts to get full, WINDOW size is reduced [^8]

- **Network congestion**: when the underlying network is overwhelmed with data - more data is being transmitted on the network than there is capacity to process and transmit that data; excess data (that overflows a buffer) is lost [^8]

- **Congestion avoidance**: reducing the number of concurrent segments sent through the network to ensure no information is lost
  - TCP reduces the WINDOW size using an algorithm; uses the number of retransmissions (data loss) on the network as an input [^8]

---

# URLs

### Be able to identify the components of a URL, including query strings
### Be able to construct a valid URL

- components [^12]
  - scheme : always comes before `://`, e.g., `http`
  - host : e.g., `www.example.com`
  - port : optional: required only if not using a default, e.g., `:88`
  - path : optional: identifies what resource is being requested, e.g., `/home` or `/home/index.html`
  - query string : optional: sends data to servers, e.g., `?item=book&results=10`

### Have an understanding of what URL encoding is and when it might be used

- URL encoding is replacing characters within URL strings that are: [^12]
  1. reserved (if not being used for their reserved purpose)
  2. not part of the standard ASCII character set
  3. may be mis-interpreted by other systems (e.g., " ", "#", "<>", "[]", "{}", "~")
- e.g., " " is replaced with "%20"; "$" is replaced with "%24" [^12]

---

# HTTP and Request/Response Cycle

### Be able to explain what HTTP requests and responses are, and identify the components of each

- HTTP headers : colon-separated name-value pairs sent in plain-text [^13]

- HTTP request must contain [^13]:
  - HTTP method
  - path (resource name and query parameters)
  - headers
  - optional message body (if using a POST request)

### Be able to describe the HTTP request/response cycle

### Be able to explain what status codes are, and provide examples of different status code types

### Understand what is meant by 'state' in the context of the web, and be able to explain some techniques that are used to simulate state

- a protocol is 'stateless' when it's designed such that each request/response pair is completed independent of the previous one [^11]
  - the server does not need to hang on to information or state between requests
  - when requests (or responses) break en route to the server, there is no clean-up

### Explain the difference between GET and POST, and know when to choose each

- GET:
  - the most used HTTP request [^13]
  - the default behaviour of links is to issue a GET request to a URL [^13]
  - query strings are ONLY used in HTTP GET requests [^12]
  - the response from a GET can be anything, but if it's HTML and that HTML references other resources, the browser will automatically request those referenced resources (a pure HTTP tool like CURL will not) [^13]

- POST:
  - used to send data to the server (e.g., from a form) or initiate some action on the server [^13]
  - the optional body will contain data being transmitted in the HTTP message to be sent to the server; can contain HTML, images, audio, etc. [^13]


---

# Security

### Have an understanding of various security risks that can affect HTTP, and be able to outline measures that can be used to mitigate against these risks

### Be aware of the different services that TLS can provide, and have a broad understanding of each of those services

---

# References
[^1]: [What is the Internet?](https://launchschool.com/lessons/4af196b9/assignments/268243e5)
[^2]: [The Physical Network](https://launchschool.com/lessons/4af196b9/assignments/097d7577)
[^3]: [The Link / Data Link Layer](https://launchschool.com/lessons/4af196b9/assignments/81df3782)
[^4]: [The Internet / Network Layer](https://launchschool.com/lessons/4af196b9/assignments/b222ecfb)
[^5]: [The Internet Summary](https://launchschool.com/lessons/4af196b9/assignments/6b7df8fb)
[^6]: [Communication Between Processes](https://launchschool.com/lessons/2a6c7439/assignments/41113e98)
[^7]: [ Packets (Khan Academy)](https://youtu.be/aD_yi5VjF78)
[^8]: [Transmission Control Protocol (TCP)](https://launchschool.com/lessons/2a6c7439/assignments/d09ddd52)
[^9]: [User Datagram Protocol (UDP)](https://launchschool.com/lessons/2a6c7439/assignments/9bb82c9b)
[^10]: [The Transport Layer Summary](https://launchschool.com/lessons/2a6c7439/assignments/4ab0993c)
[^11]: [ Background](https://launchschool.com/books/http/read/background)
[^12]: [What is a URL?](https://launchschool.com/books/http/read/what_is_a_url)
[^13]: [Making HTTP Requests](https://launchschool.com/books/http/read/making_requests)
[^14]: [Processing Responses](https://launchschool.com/books/http/read/processing_responses)
