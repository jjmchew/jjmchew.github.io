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
    - transmission delay : delay in going from 1 network device to another (e.g., mod/demod)
    - processing delay : time required for actual processing of information at each network device (e.g., build 'frames', ARP requests, etc.)
    - queuing delay : delay from data waiting in buffers at each network device
  - last-mile latency : increased delays at the network 'edge' (i.e., in getting the network signal from the ISPs network to the home or office network) as a result of more 'hops' (a journey between nodes on the network)

- **Bandwidth** : a measure of the *amount* of ata that can be sent in a particular unit of time (typically a second) [^2]
  - e.g., the number of lanes in that road (all cars travelling at the same speed) 
  
- increasing bandwidth doesn't necessary improve performance of network [^2]
- **bandwidth bottleneck** : a point within a network at which the bandwidth changes from relatively high to relatively low [^2]

- latency is most relevant in "smaller" tasks (online gaming, instant messaging, light website browsing);  bandwidth affects "large" tasks (downloading large files, streaming videos, viewing complex, interactive websites) [^31]

### Have a basic understanding of how lower level protocols operate

- **Link layer**: Ethernet protocol, sends "frames" from switch to device (i.e., communication in a LAN[^5]), PDU header contains destination and source MAC address (Media Access Control) [^3]

- **Internet layer**: IP protocol, sends "packets" from host (network) to host (network) (essentially router to router, inter-network[^5]), PDU header (IPv4) contains source and destination IP addresses, TTL, Protocol (UDP vs TCP), checksum [^4]
  - 2 versions of IP in use:  IPv4, IPv6

- summary of layers: [^29]
  - Application: *end-to-end* communication between applications
  - Transport: *end-to-end* communication between devices
  - Internet: logical *point-to-point* communication
  - Link: physical *point-to-point* communication


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

- DNS is the Domain Name System [^11] : a distributed database that translates/maps [^19] domain names to IP addresses; the database is stored on DNS servers
  - DNS servers are hierarchically organized and connected in a global network
  - no single DNS server contains the entire database
  - if a single DNS server does not have the required domain name mapping, the request is forwarded to another DNS server until the required IP address is found

- DNS operates at the Transport layer and is initiated by software (e.g., a browser) [^30]
  - DNS may be cached locally, as well, so a DNS query isn't always required

### Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model

- HTTP is a stateless *request response protocol* for how clients communicate with servers [^16]
  - a set of rules for the transfer of files (including hypertext documents, CSS documents, scripts, images, videos) [^11]

- clients make HTTP requests, server process and sends an HTTP response [^16]
  - client is separate from the server (although more than 1 client may connect to the server) (in contrast to peer-to-peer networking: each node can be client and server for another node [^28])

- server could be made up of [^16]:
  - web server : responds to requests for static assets (files, images, css, javascript, etc.) (no data processing)
  - application server : where application or business logic reside (more complicated requests)
  - data store : where persistent data lives for retrieval and processing (simple files, key/value stores, document stores, etc.)

- "persistent data" - data that doesn't go away after each request/response cycle [^16]

- HTTP (usually) relies on a TCP connection; TCP ensures request/response cycle gets completed [^16]
- HTTP is the syntax and structure of messages exchanged between applications [^20]
- HTTP responses / requests are transferred in plain text - are essentially insecure [^26]

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
  - flow control (and pipelining) work by modifying the "WINDOW" field of the TCP header to adjust the amount of data that is sent to the receiver [^32]

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

- URL is a subset (type of) URI [^19]

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
  - `Connection: Keep-Alive` [^27]

- HTTP request contains [^13] [^18]:
  - **HTTP method** (e.g., `GET`)
  - **path** (e.g., `/tasks`)
  - optional query string / query parameters (e.g., `?due=today&age=3`)
  - **headers** [^19] (e.g., `Host: www.host.com` required in HTTP 1.1)
  - optional message body (if using a POST request)

- HTTP method and path together form the "start-line" or "request-line" [^18]

- HTTP response contains [^14] [^18]:
  - **status (line)** (code w/ text) (e.g., `200 OK`)
  - headers (e.g., `Content-Type: text/html`, `Content-Length: 837`)
  - optional message body (contains raw response data)

### Be able to describe the HTTP request/response cycle

- clients issue requests to servers, server processes that request, server sends a response [^16]

- high-level overview of HTTP request / response [^34]
  - HTTP defines the format for the request / response by the web / application servers (application end-to-end)
  - Transport defines the specific process (application) on source and destination computers to process that request (process end-to-end)
  - Internet layer defines the logical address to navigate from a computer on a sub-network through the internet (network of networks connected by routers) to the destination network (router); at each stop, there will be a new source IP address defined (i.e., this layer is point-to-point)
  - Ethernet layer defines the physical address (MAC address) of each device source/destination at each stop along the way from request source computer to destination server computer


### Be able to explain what status codes are, and provide examples of different status code types

- the HTTP 'status code' is a 3 digit number;  'status text' is a short description of the code [^14]
- common status codes are: [^14]
  - 200 OK
  - 302 Found : (will redirect to URL in `Location` response header)
  - 400 Bad Request : (HTTP request was formed incorrectly [^21])
  - 404 Not Found : (could be for any 'resource': file, CSS, scripts, images, videos, etc.)
  - 500 Internal Server Error : (for a variety of server-side errors, e.g., configuration, etc.)


### Understand what is meant by 'state' in the context of the web, and be able to explain some techniques that are used to simulate state

- a protocol is 'stateless' when it's designed such that each request/response pair is completed independent of the previous one [^11]
  - the server does not need to hang on to information or state between requests
  - when requests (or responses) break en route to the server, there is no clean-up
  - each request contains all info necessary the request to be fulfilled

- 3 techniques to simulate state in web applications: [^15]
  1. sessions (session identifier) : each request is inspected for a (valid) session ID and used as a key to retrieve required data by the server
  2. cookies : can be used to store session information
  3. AJAX (Asynchronous JavaScript and XML) : allows browsers to issue requests without a full page refresh; responses are processed by a callback function
  - (sending stateful data as query parameters: was used, but generally insecure and rarely used now)

### Explain the difference between GET and POST, and know when to choose each

- GET:
  - the most used HTTP request [^13]
  - the default behaviour of links is to issue a GET request to a URL [^13]
  - query strings are ONLY used in HTTP GET requests [^12]
  - the response from a GET can be anything, but if it's HTML and that HTML references other resources, the browser will automatically request those referenced resources (a pure HTTP tool like CURL will not) [^13]
  - should only retrieve content from the server (e.g,. retrieving search results) [^18]
    - majority of the content on the page should not change (e.g., a page view counter doesn't count as changing content)

- POST:
  - used to send data to the server (e.g., from a form) or initiate some action on the server [^13]
  - the optional body will contain data being transmitted in the HTTP message to be sent to the server; can contain HTML, images, audio, etc. [^13]
  - involves changing values that are stored on the server (e.g., submitting an info form) [^18]


---

# Security

### Have an understanding of various security risks that can affect HTTP, and be able to outline measures that can be used to mitigate against these risks

- **origin**: a combination of scheme, host, port [^16]
- cross-origin requests can be a security hazard : mitigated with **"same-origin policy"** [^16]

- **session hijacking** : when a malicious user obtains another user's session id information and can access that user's session (typically without the user knowing) [^16]
  - Mitigations:
    - reset sessions (e.g., when entering sensitive information like credit cards, deleting accounts)
    - setting an expiration time on sessions (limit exposure of compromised sessions)
    - use HTTPS (to minimize ability to obtain session info)
    - use "same-origin policy"

- **cross-site scripting (XSS)** : adding (malicious) javascript code to a webpage through forms, comments, etc. which is interpreted and executed as javascript code [^16]
  - Mitigations:
    - always sanitize user input (e.g., removing \<script> tags, disallowing HTML and JS altogether)
    - escape all user input to display it (i.e., don't let browser interpret entered text as code)
      - e.g., use HTML entities:  replace "<" with "\&lt;"; replace ">" with "\&gt;"

### Be aware of the different services that TLS can provide, and have a broad understanding of each of those services

- TLS is a cryptographic protocol that encrypts every HTTP request / response sent over the internet [^16]
- TLS handshake [^26]:
  - establishes cipher suites (agreed set of algorithms for encryption, authentication, integrity)
  - server sends certificate (for TLS authentication, server's public key sent for encryption)
  - handshake (TLS v1.2) (2 RTT) [^35]
    - client starts with ClientHello (define protocol versions, cipher suite)
    - then ServerHello (w/ server certificate, ServerKeyExchange, digital signature, ServerHelloDone)
    - then ClientKeyExchange, ChangeCipherSpec, Finished (ensure integrity)
    - server sends ChangeCipherSpec, Finished (ensure integrity)


- TLS offers secure message exchange over an unsecure channel (HTTP) by providing: [^22]
  - **encryption** : encoding messages so only authorized recipients can decode
    - uses TLS handshake to establish asymmetric/symmetric keys for message exchange; requires additional 2 RTT after TCP 3-way handshake [^23]
  - **authentication** : verify the identity of a party in message exchange [^24]
    - server issues a digital certificates; certificates issued by Certificate Authorities (CA) are safest, are digitally signed by CAs 
    - "Chain of Trust" : server certificates are issued by Intermediate CA, which is certified by Root CAs (small group of highly trusted CAs)
  - **integrity** : verify message has not be tampered with in transit
    - MAC - Message Authentication Code [^25]
    - TLS also uses a header, includes MAC field : acts like a checksum (contains "digest" of data payload created based on agreed cipher suite);  receiver will create and compare their own version of the "digest" to confirm data payload was not tampered with [^25]

- any time information is encrypted using the public key provided in a digital certificate, we do so knowing that if the certificate was copied illicitly, that the server would NOT be able to decrypt the messages that we sent since a server imposter would NOT have the private key to decrypt messages with - hence it will not be possible to establish a secure TLS connection [^33]

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
[^15]: [Stateful Web Applications](https://launchschool.com/books/http/read/statefulness)
[^16]: [ Security](https://launchschool.com/books/http/read/security)
[^17]: [Some Background and Diagrams](https://launchschool.com/lessons/cc97deb5/assignments/586769d9)
[^18]: [The Request Response Cycle](https://launchschool.com/lessons/cc97deb5/assignments/83ae67aa)
[^19]: [Intro to HTTP Summary](https://launchschool.com/lessons/cc97deb5/assignments/9f4e349a)
[^20]: [What to Focus On (Working with HTTP)](https://launchschool.com/lessons/0e67d1ce/assignments/b9609f49)
[^21]: [Speaking the Same Language](https://launchschool.com/lessons/0e67d1ce/assignments/ea90d10b)
[^22]: [The Transport Layer Security (TLS) Protocol](https://launchschool.com/lessons/74f1325b/assignments/83bf156b)
[^23]: [TLS Encryption](https://launchschool.com/lessons/74f1325b/assignments/54f6defc)
[^24]: [TLS Authentication](https://launchschool.com/lessons/74f1325b/assignments/95e698ab)
[^25]: [TLS Integrity](https://launchschool.com/lessons/74f1325b/assignments/a88271cf)
[^26]: [Transport Layer Security (TLS) Summary](https://launchschool.com/lessons/74f1325b/assignments/238ff36f)
[^27]: [Web Performance and HTTP Optimizations](https://launchschool.com/lessons/be1304f3/assignments/98ecce1c)
[^28]: [Peer to Peer Networking](https://launchschool.com/lessons/be1304f3/assignments/5a9cbadb)
[^29]: [ Discussion (layers)](https://launchschool.com/posts/bd0e3b06)
[^30]: [ Discussion (DNS)](https://launchschool.com/posts/97644af7)
[^31]: [ Discussion (latency vs bandwidth)](https://launchschool.com/posts/75869b56)
[^32]: [ Discussion (flow control)](https://launchschool.com/posts/a852ecad)
[^33]: [IBM TLS](https://www.ibm.com/docs/en/informix-servers/14.10?topic=tls-handshake-certificates-public-private-key-pairs)
[^34]: [Ethan Weiner HTTP request / response videos](https://youtu.be/ky9Qy0ZSx24)
[^35]: [ TLS handshake (computerphile)](https://youtu.be/86cQJ0MMses)