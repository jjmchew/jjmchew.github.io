# LS170 initial notes

## Definitions

### A-M

<details>

#### **AJAX**
- (Asynchronous JavaScript and XML)
- a feature that allows browsers to issue requests and process responses *without a full page refresh*; this prevents the very expensive overhead of re-creating an entire webpage on every interaction [^22]
  - AJAX requests: [^22]
    - are performed asynchronously (the page does NOT refresh, JS can do other things while waiting for a response from the server[^39])
    - are similar to normal requests (same components, handled by server in same way)
    - have their response typically handled by some client-side JavaScript code
- uses XHR[^39] (see also [XHR](#xhr))

#### **Application Layer**
- The top-most layer of the OSI and IPS models;  provides communication services to applications themselves;  does not refer to actual applications [^15]
  - protocols in this layer are the ones which actual applications most directly interact with; provides a syntax for applications to interact [^15]

#### **Application server**
- typically where application or busines logic resides and where more complicated requests are handled; server-side code lives here when deployed [^24] (see also [Web Server](#web-server), [Data Store](#data-store))

#### **Asymmetric key encryption**
- (also known as Public key encryption [^34])
- uses a pair of keys:  *public key* (for encryption) and *private key* (for decryption); communication is only intended to work in 1 direction [^34] (see also [Symmetric key encryption](#symmetric-key-encryption))
  - Person A would generate both a public and private key;  the public key is made public for others to encrypt messages for Person A (to decrypt using their private key)

#### **Bandwidth**
- the *amount* of data that can be sent in a particular unit of time (typically a second) [^2]; a measure of *capacity* [^6]

#### **Broadcast address**
- the IP address at the END of the range assigned to a single local network (see also [Network Address](#network-address)) [^5]

#### **Browser**
- (web browser)
- Browsers hide much of the underlying HTTP request/response cycle: [^20]
  - e.g., if you fill out a web form, it will issue the POST request, get a response with a `Location` header, issue a request to the location defined in the `Location` header and then display the (HTML) response from the second request; a browser tool like CURL or Postman may not do all of that [^20]

#### **Buffer**
- memory allocated according to OS configuration and physical resources available to store data awaiting processing [^12]
  - used in TCP for flow control [^12]

#### **Byte**
- a unit of digital information containing 8 bits

#### **CA**
- (Certificate Authority)
- a trustworthy source that issues digital certificates (see also [Certificate](#certificate)) [^35]
  - will verify identity : e.g., by proving you own the domain
  - digitally sign the certificate : encrypting some data with the CA's own private key as a 'signature' and including unencrypted data with certificate that can be compared
- there are *Intermediate CAs* and also *Root CAs* [^35]
  - an Intermediate CA is authorized by a Root CA to issue certificates on its behalf
  - the certificate is certified by the Intermediate CA;  Intermediate CA is certified by the Root CA (known as the *Chain of Trust*)
  - Root CAs can revoke their certificate to Intermediate CAs if Intermediate CAs have a trust breach; all certificates issued by the Intermediate CA would appear invalid
  - Root CAs are a small group of organisations approved by browsers and operating system vendors
  - Let's Encrypt in an Intermediate CA and provides free, automated certificates
  - GlobalSign is a Root CA

#### **Callback**
- a piece of logic you pass on to some function to be executed after a certain event has happened [^22]
  - e.g., a `callback` may be triggered when a response is returned

#### **CDN**:
- (Content Delivery Network[^38])
- These networks can reduce latency

#### **Certificate**
- (also known as TLS Certificate; SSL Certificate; Digital Certificate)
- Sent by the server as part of the TLS handshake (see also [TLS handshake](#tls-handshake))
- contains various pieces of information: [^35]
  - public key (for exchanging symmetric key info)
  - identifies owner of certificate
  - a 'signature' : data encrypted with the server's *private key*
  - data used to create 'signature'
- client receiving the certificate can decrypt the 'signature' using the *public key* sent and compare decrypted data to the original version;  a match indicates authenticity of certificate [^35]
- **certificates are signed by a CA** (see also [CA](#ca))

#### **Cipher suites**
- (for TLS handshake) see also [TLS handshake](#tls-handshake)
- the agreed set of algorithms used by the client and server during secure message exchange [^37]
- a set of ciphers (i.e., cryptographic algorithms - steps for performing encryption, decryption, other related tasks) to be used for establishing and maintaining a secure connection [^34]
  - different ciphers are typically used for key exchange process, authentication, symmetric key encryption, checking message integrity

#### **Congestion avoidance**
- the application of an approach and algorithm to determine the size of the initial transmission window, and how much the window should be reduced depending on network conditions (i.e., network congestion) [^12]
  - typically uses data loss and number of retransmissions to determine if the network is congested [^12]

#### **Connectionless network communication**
- a single socket object that is set to `listen()` for incoming messages (from any source) directed to its specific IP address:port [^10]

#### **Connection-oriented network communication**
- instantiating multiple socket objects to create a connection between applications;  analogous to replicating yourself to participate in 5 different concurrent conversations [^10]
  - there is still a single socket object listening for incoming messages, but once a message arrives, a new socket object is instantiated to listen specifically for messages corresponding to the four-tuple (see also [Four-tuple](#four-tuple)) [^10]
  - generally, these connections are more reliable:  easier to implement rules for managing communication order of messages, responses, retransmission, etc. [^10]

#### **Connection state**
- (for TCP, connection-oriented communication) : possible states which a TCP connection progresses through during its lifetime: [^12]
  - LISTEN : this state is important (on server side)
  - SYN-SENT
  - SYN-RECEIVED
  - ESTABLISHED : this state is important
  - FIN-WAIT-1
  - FIN-WAIT-2
  - CLOSE-WAIT
  - CLOSING
  - LAST-ACK
  - TIME-WAIT
  - CLOSED (a fictional state, since if closed, no connection exists)
  - Listen and Established are most important since other states relate to establishing and terminating connections

#### **Cookie**
- (HTTP cookie) : small files of data (containing session information) sent from the server and stored in the client (browser) during a request/response cycle [^22]
  - session information is stored in the cookie; actual session data is stored on the server
  - the client-side cookie is compared with server-side data on every request to identify the current session

#### **CORS**
- (Cross-Origin Resource Sharing) : a mechanism that allows interactions that would normally be restricted cross-origin to take place; adds new HTTP headers that lets servers serve resources cross-origin to specified origins [^23]

#### **CRC**
- (Cyclic Redundancy Check) : see [FCS](#fcs) [^3]

#### **Cryptography**
- the use of techniques for securing communication [^34]
  - e.g., Caesar cipher (a simple substitution cipher)
  - e.g., Vigenere cipher (use of a keyword and tabula recta) (see also [Symmetric Key Encryption](#symmetric-key-encryption))

#### **Bandwidth bottleneck**
- a point at which bandwidth changes from relatively high to relatively low [^2]

#### **Data store**
- has the ability to save persistent data in some format for later retrieval and processing (e.g., relational database, simple files, key/value stores, document stores, etc.);  typically consulted by the Application Server [^24] (see also [Application Server](#application-server))

#### **DNS**
- (Domain Name System) : a distributed database which maps domain names (e.g., `www.google.com`) to an IP address (e.g., `197.251.230.45`) [^17] [^27]
  - DNS databases are stored on a hierarchy of world-wide DNS servers - no one server contains the complete database; if 1 server does not contain a requested domain name, that server routes the request to another DNS server up the hierarchy [^17]

#### **DTLS**
- (Datagram Transport Layer Security)
- a form of TLS used with UDP (see also [TLS](#tls-handshake), [UDP](#udp))

#### **Encapsulation**
- how protocols at different network layers can work together;  implemented through PDUs (i.e., the info at a higher layer is part of the data payload of a lower layer) [^6]

#### **Frame**
- an Ethernet PDU [^6] i.e., structured data.  Key components to remember are Source and Destination MAC address and Data Payload. [^3] Exact headers used in an Ethernet frame will vary according to different Ethernet standards [^9]q6

#### **FCS**
- (Frame Check Sequence)
- the final 4 bytes (32 bits) of an Ethernet frame used for a CRC (cyclic redundancy check).  The receiving device generates it's own FCS from frame data then compares it to the FCS in the sent data. If the 2 don't match, the frame is dropped.  Ethernet does not implement retransmission functionality - this is left to higher level protocols. [^3]

#### **Flow Control**
- a mechanism to prevent the sender from overwhelming the receiver with too much data at once [^12]
  - in TCP: data awaiting processing is stored in a buffer
  - the amount of data each side can accept is defined in the WINDOW field of the TCP header; this is a dynamic field (i.e., will change depending on how full the buffer is) [^12]

#### **Four-tuple**
- Four pieces of information defined for connection-oriented network communication:  source port, source IP, destination port, destination IP;  newly instantiated sockets listen for messages where all 4 pieces of info match [^10]

#### **Four-way handshake**
- a process used for terminating TCP connections; uses `FIN` flag of TCP headers [^12]

#### **GET**
- (HTTP request)
- used to retrieve a resource (most links are GETs); the response can be anything, but if it's HTML and that HTML references other resources, a browser will automatically request those referenced resources, a pure HTTP tool (like `curl`) will not [^20]

#### **Header**
- (HTTP request or response header)
- colon-separated name-value pairs sent in plain text; HTTP headers allow the client and server to send additional info during the HTTP response/request cycle;  [^20]

#### **HOL blocking**
- (Head-of-Line blocking)
- a general networking concept where an issue in delivering or processing 1 message in a sequence will 'block' or delay the deilvery of processing of subsequent messages [^12]

#### **Hop**
- journeys between nodes on the network (i.e., interruptions for transmission, processing, queuing) [^2]

#### **HTML**
- (Hypertext Markup Language)
- the means by whch resources on the web should be uniformly structured; one of the three technologies / concepts upon which the web was based (see also [URI](#uri), [HTTP](#http)) [^16]
  - e.g., `<a>` with `href` attribute to provide links to other resources

#### **HTTP**
- (Hypertext Transfer Protocol)
- a **stateless[^17], insecure[^37], text-based [^32] protocol for how clients communicate with servers** [^24]; the set of rules which provide uniformity to the way resources on the web are transferred between applications (a *request response protocol* between a *server* and a *client* [^17]) [^16]
  - a single HTTP message exchange consists of a request and a response between a client and a server [^27]
    - client sends the request, server sends the response
  - serves as a link between applications (a message format) and the transfer of hypertext documents [^17]
  - is an inherently *stateless* protocol - makes it hard to build user experiences that are stateful (e.g., know where a request came from, differentiating users, staying "logged in", etc.) [^17]
  - is inherently *insecure* [^37], but can be made more secure through use of:
    - https (see also [HTTPS](#https))
    - enforcing same-origin policy (see also [Same-origin policy](#same-origin-policy))
    - preventing session hijacking, and cross-site scripting (see also [Session Hijacking](#session-hijacking), [XSS](#xss-cross-site-scripting))
- in HTTP/1.1 the end of headers is indicated by an empty line [^32]
  - the `Content-Length` header indicates the size of the body (if not present, then the browser will keep trying to load content) [also noted through HTTP server assignment]

#### **HTTPS**
- (Secure HTTP)
- the use of TLS to encrypt the requests/responses associated with HTTP (i.e., not send them as strings, which are susceptible to *packet sniffing*) [^23] (see also [TLS](#tls))

#### **HTTP optimizations**
- Basic optimizations developers can take to improve HTTP performance are: [^38]
  - reducing resources and dependencies - limit the number of things to be fetched to what's needed for the page users are viewing
  - compressing resources that are fetched (e.g., minifying)
  - re-using TCP connections: fetch multiple resources with a single TCP connection (eliminate handshaking) e.g., include `Connection: Keep-Alive` header
  - DNS optimization: reduce the number of hostnames that need to be resolved; download any external resources and host them on the same server as web app (may not be necessary with a CDN); use common libraries (may already be available on users' systems in the browser cache); use a faster DNS provider (e.g., Amazon Route 53 is faster than GoDaddy)
  - caching (server-side): most valuable for dynamically generated content - store content that was recently accessed by a user so if it is requested again, it can be quickly served and reduces processing load on the server

#### **HTTP request**
- can be Get or Post (see also [GET](#get) and [POST](#post)) [^20]
  - key components: [^20]
    - request line : made up of method and path [^26]q1
        - HTTP method (i.e., GET vs POST) * required [^26]q1
        - path (resource name and any query parameters) * required [^26]q1
    - headers  (`Host` header is required since HTTP 1.1, other headers optional [^26]q1)
    - parameters (optional [^26]q1)
    - message body (for POST requests) (optional [^26]q1)
  - `GET` requests should only retrieve content from server (main webpage content doesn't change) [^26]q3
    - e.g., return search results; display a webpage that displays how many times it's been viewed (main content doesn't change)
  - `POST` requests involve changing values stored on server [^26]q3
    - e.g., submit form info
  - Webservers may not support HTTP 0.9, requests may need to be submitted in certain ways (e.g., `GET / HTTP/1.1` and with `Host: launchschool.com` header included to meet HTTP 1.1 specifications) [^30]

#### **HTTP response**
- the raw data returned by a server to an HTTP request [^21]
  - key components of a response: [^21]
    - status line : comprised of a code (e.g., 200) (see also [Status Code](#status-code)) and short text * required [^26]q2
    - headers (optional [^26]q2)
    - message body (contains the raw response data) (optional [^26]q2)

#### **Hub**
- a basic piece of network hardware that replicates a message and forwards it to all of the devices on the network. Devices connected to a hub that receive a message not intended for it (i.e., MAC address is different) will ignore the frame [^3]

#### **Interframe Gap**
- a brief pause in transmission between each Ethernet frame; allows the receiver to prepare to receive the next frame; contributes to Transmission Delay. For 100Mbps Ethernet the gap is 0.96 microseconds. [^3]

#### **Internet**
- A network of networks;  comprised of *network infrastructure* (physical devices: routers, switches, physical network, cables, etc.) and *protocols* (which allow infrastructure to function) [^6]

#### **Internet Layer**
- Also called Network Layer (OSI model).  Generally uses Internet Protocol (IP) at this layer; primary purpose is to facilitate communication between hosts (e.g., computers) on different networks [^5]

#### **IP**
- Internet Protocol [^1]; IPv4 and IPv6 are currently in use; primary functions are: routing data between one device and another (i.e., between hosts) [^10] across networks via IP addressing, encapsulation of data into packets [^5]; the predominant protocol for *inter-network communication* [^6]  (see also [Packet](#packet))

#### **IP Address**
- logical address (unlike MAC addresses) - can be assigned as required to devices as they join a network;  must be assigned within  a range of addresses available to the LAN they join.[^5]
  - IPv4 address: 32-bit length; set of 4 numbers of 8 bits each; decimal numbers between `0` and `255` (e.g., `109.156.106.57`); maximum possible unique addresses is ~4.3 billion [^5]
  - IPv6 address: 128-bit length; 8 x 16 bit blocks (e.g., 8 sets of hexadecimal characters); max possible addresses is 340 undecillion [^5] The first 4 sets are used to locate a specific network, the last 4 sets to identify a particular interface or device within that network [^9]q9

#### **Internet Protocol Suite**
- (also called TCP/IP model or DoD model)
- a framework for organizing the set of communication protocols used in the internet [^8]
  - Layers include [corresponding PDU name]: [^8]
    - Application
    - Transport [segment (TCP) or datagram (UDP)]
    - Internet [packet] (IP - from network to sub-network)
    - Link [frame] (Ethernet - from router to device)
  - lower levels (Ethernet, IP) are inherently unreliable - although checksum data is provided, if the frame or packet is corrupt, it will just be dropped [^11]
  - for reliable data transmission, a system of rules must be implemented to enable it (e.g, TCP) [^13]


#### **LAN**
- (Local Area Network)
- multiple devices (computers) connected via a network bridging device (like a hub, or more likely a switch).  If connected wirelessly, would be known as WLAN (Wireless LAN) [^4]

#### **Latency**
- a measure of the *time* (or delay [^6]) it takes for data to get from 1 point in a network to another [^2]
  - consists of:
    - **propogation delay** : the time it takes for a message to travel from sender to receiver; ratio between distance and speed [^2]
    - **transmission delay** : the time it takes to push data onto each "link" in it's journey from 1 point to another (e.g., between switches, routers, other network devices) [^2]
    - **processing delay** : data needs to be processed at each 'link' - this is the delay to process data between links [^2]
    - **queuing delay** : (also buffering) the amount of time data waits in a queue to be processed [^2]
    - **last-mile latency** : delays which involve getting a network signal from ISP's network to home or office network; as data is directed down the network hierarchy to the correct sub-network there will be more frequent and shorter 'hops' [^2]

#### **MAC address**
- (Media Access Control address [^36])
- a (unique) sequence of 6, two-digit hexadecimal numbers (e.g., `00:40:96:9d:68:0a`) assigned to every device with a NIC; used to direct Ethernet frames between network devices in a (W)LAN;  MAC address is "burned in" when manufactured;  in theory, should all be unique (may not be, but rarely causes problems) [^3] [^6] MAC addresses have a 'flat' structure [^9]q7

#### **MAC**
- (Message Authentication Code field)
- a field included in the TLS footer / trailer to provide message integrity (ensure message hasn't been altered in transit); somewhat similar to checksum fields in other PDUs[^36]
- uses a hashing algorithm: [^36]
  - sender creates a *digest* of data payload (a small amount of data derived from actual payload to be sent in the MAC field)
  - digest is created using a specific hashing algorithm with a pre-agreed hash value (determined as part of TLS handshake) (see also [TLS handshake](#tls-handshake))
  - receiver will create their own version of the digest and compare with the version sent in MAC field; if they match, integrity is confirmed

#### **Multiplexing**
- transmitting multiple signals over a single channel;  opposite:  **demultiplexing** [^10]
  - multiplexing is enabled through use of network ports [^13]

</details>


### N-Z

<details>

#### **Network**
- 1 or more computers connected in such a way that they can communicate or exchange data [^4]

#### **Network address**
- the IP address at the START of the range assigned to a single local network (see also [Broadcast Address](#broadcast-address)) [^5]

#### **Network congestion**
- when there is more data being transmitted on a network than there is network capacity to transmit the data [^12]
  - If there is congestion, excess data is lost [^12]

#### **Network edge**
- the 'entry point' into a network like a home or corporate LAN [^2]

#### **NIC**
- (Network Interface Card)
- any network-enabled device [^3]

#### **Origin**
- a combination of *scheme*, *host*, and *port* [^23]
  - scheme:  e.g., `http` vs `https`
  - host: `mysite.com` vs `anothersite.com`
  - port: `http://mysite.com` (port 80 by default) vs `http://mysite.com:4000`

#### **OSI model**
- (Open Systems Interconnection model)
- a conceptual model for general computer network communication [^8] (see also [Internet Protocol Suite](#internet-protocol-suite))
  - Layers include: [^8]
    - Application
    - Presentation
    - Session
    - Transport
    - Network
    - Data Link
    - Physical

#### **Packet**
- a PDU within the IP Protocol;  has a header and a data payload;  data payload is generally a TCP segment or UDP datagram [^5]

#### **Packet sniffing**
- Reading HTTP request/responses being sent back and forth between a client and server; finding a session id would alow someone to pose as your client and be automatically logged in without needing your username or pw [^23]

#### **PDU**
- Protocol Data Units [^1]
  - an amount or block of data transferred over a network
  - may have diffrent names within different protocols or protocol layers
  - consists of a header, data payload, trailer (or footer)
  - e.g., Ethernet Frames are a PDU that encapsulate data from the Internet/Network layer above [^3]

#### **Physical network**
- the tangible infrastructure that transmits electrical signals, light, radio waves which carry network communications [^6]

#### **Pipelining**
- similar to a Stop-and-Wait protocol, but the sender continuously sends messages in a "window" (maximum number of messages in the pipeline at any 1 time) without waiting for the acknowledgement.  If there is a time-out before an acknowledgement is received, that message will be re-sent, etc as per the Stop-and-Wait protocol [^11]
  - specific implementations are "Go-back-N" and "Selective Repeat" [^11]

#### **Port**
- (network port)
- an identifer for a specific process running on a host (will be between 0 - 65,535, some numbers are reserved) [^10]
  - 0 - 1023 : assigned to processes that provide commonly used network services
      - HTTP is port 80 (unencrypted) or port 443 (encrypted)
      - FTP is port 20
      - SMTP is port 25
  - 1024 - 49,151 : registered ports; assigned as requested by private entities; may also be *ephemeral* (temporary) ports assigned by the operating system
  - source and destination ports are included in PDU for transport layer (exact structure varies based on specific transport protocol used) [^10]

#### **POST**
- (HTTP request)
- an HTTP request that allows you to send or submit data to the server; allows sending of much larger and sensitive data to the server (such as passwords, images, videos, etc.) [^20]
  - data is sent as part of the HTTP *body*; body is optional (can be blank) [^20]

#### **Protocol**
- (network protocol)
- a system of rules governing the exchange or transission of data; various protocols have various functions (corresponding to the various 'layers' of the network) [^6]
  - there are many different protocols to address different aspects of network communication OR the same aspect, but a specific use case [^7]

#### **Query string**
- (HTTP)
- used to send data to the server; used *only* in HTTP GET requests [^18]
  - components include: [^18]
    - `?` : reserved character to mark the start of the query string
    - e.g. `search=ruby` : a parameter name/value pair
    - `&` : reserved character used when adding more parameters to the query string
    - e.g., `results=10` : another parameter name/value pair
  - limits: [^18]
    - have a max length (cannot send a lot of data)
    - all name/value pairs are visible in the URL (can't send sensitive info)
    - space and special characters can't be used (need to be URL encoded)

#### **RTT**
- (Round-Trip Time)
- a latency calculation often used in networking - the length of time for a signal to be sent, added to the length of time for an acknowledgement or response to be received [^2]

#### **Router**
- a network device;  responsible for a network 'segment' (i.e., a range of IP addresses for which the router keeps a record and can forward packets to);  routers also keep a routing table - record of other routers on the network and their network addresses [^5]

#### **Same-origin policy**
- a policy that permits unrestricted interaction between resources originating from the same origin, but restricts certain interactions between resources originating from different origins [^23] (see also [Origin](#origin))
  - typically allowed:  requests for linking, redirects, form submissions, embedding of resources from other origins (e.g., scripts, css stylesheets, images, media, fonts, iframes)
  - typically restricted: cross-origin requests (where resources are being accessed programmatically using APIs such as `XMLHttpRequest` or `fetch`)

#### **Scheme name**
- (in URI context)
- a specification for assigning identifiers within that scheme; isn't related specifically to a protocol, but it identifies which protocol should be used to access the resource;  URI scheme names are found on [IANA website](https://www.iana.org/assignments/uri-schemes/uri-schemes.xhtml) [^25]
  - generally, scheme names are in lowercase (e.g., `http`) and protocols in uppercase (e.g., `HTTP`) [^25]

#### **Session Hijacking**
- when a hacker obtains the session id and can access the web application as if they are an authenticated user; does not require the username/pw [^23]
  - countermeasures: [^23]
    - reset the session - render the old session id invalid and create a new one
    - setting expiration times on sessions (limit time a hacker has to use the session id)
    - use HTTPS (see also [HTTPS](#https))

#### **Session Identifier**
- a unique token that gets passed whenever a client makes a request to the server to allow the server to identify clients [^22]
  - when using session identifiers, for each request, the server must: [^22]
    - inspect the request for a session identifier
    - ensure the session is still valid
    - maintain rules on how to handle session expiration and how to store session data
    - retrieve session data based on the session id
    - recreate the application state (e.g., HTML for a web request) from the session data and send it back to the client as a response

#### **Socket**
- also a *communication end-point*; conceptually, it is an endpoint used for inter-process communication [^10]
  - could be a UNIX socket (mechanism for communicating between local process running on the same maching)
  - could also be an internet socket (e.g., TCP/IP socket): a mechanism for inter-process communication between networked processes (usually on different machines)
  - **the combo of an IP address and port information**; this enables end-to-end communication between specific applications (often on different machines, but could be a `localhost` and a browser on the same machine) (e.g., `216.3.128.12:8080`) [^10]
  - sockets are implemented by instantiating *socket objects* (often following the Berkeley sockets API model:  `bind()`, `listen()`, `accept()`, `connect()`, etc. Ruby, Python, Node.js use this) [^10]

#### **Stateful (simulation)**
- HTTP can simulate statefulness through techniques such as: [^27]
  - using session ids (see also [Session Identifier](#session-identifier))
  - using cookies (see also [Cookie](#cookie))
  - using AJAX (see also [AJAX](#ajax))

#### **Stateless (protocol)**
- a protocol designed such that each request/response pair is completely independent of the previous one [^17]
  - use of a stateless protocol implies that servers do not need to store info (like state) between requests; i.e., there is no "clean-up" if a request breaks en route to the server [^17]
  - each request should contain all the info necessary for the request to be fulfilled [^28]q11

#### **Status Code**
- (HTTP response)
- a 3-digit number a server sends back after receiving a request; signifies the status of the request; typically returned with status text [^21]
  - |status code | status text | meaning |
    |------------|-------------|---------|
    |200         | OK          | request handled successfully |
    |302         | Found       | requested resource has changed temporarily <br> usually redirects to another URL defined in `Location` response header|
    |404         | Not Found   | requested resource cannot be found |
    |500         | internal server error | server has encountered a generic error | 
  
#### **Stop-and-Wait protocol**
- a reliable protocol, but not very efficient - a lot of waiting for acknowledgements [^11]
  -  messages are sent with sequence numbers and a timeout; receiver sends an acknowledgement (w/ sequence number) once received; then sender sends next message in sequence (w/ sequence number) [^11]
  - if acknowledgement goes missing, sender will re-send a message (w/ sequence number) after time-out [^11]
  - if receiver gets a duplicate, it will drop it and re-send the acknowledgement [^11]

#### **Sub-net**
- when a network range (of IP addresses) is split into smaller networks (e.g., the range 109.156.106.0 - 109.156.106.255 is split into 2 smaller segments with 2 routers: 1 responsible for 109.156.106.0 - 109.156.106.127 AND another for 109.156.106.128 - 109.156.106.255) [^5]

#### **Switch**
- a network device that directs Ethernet frames to ONLY the desired MAC address;  a MAC Address Table keeps a record of ports and MAC addresses for connected devices [^3]

#### **Symmetric key encryption**
- a cryptographic system where both sender and receiver share a common encryption key, which is used to encryption or decryption [^34]
  - challenge for use over internet is how to communicate the key securely - it can't be sent in plain text (see also [Asymmetric key encryption](#asymmetric-key-encryption))

#### **TCP**
- (Transmission Control Protocol)
- provides reliable network communication (data transfer) on top of an unreliable channel [^12]
  - **Reliability is provided through *message acknowledgement* and *retransmission*, and *in-order delivery*** [^13]
  - Key focuses are: [^12]
    - data integrity (error detection [^14]q4)
    - de-duplication [^14]q4
    - in-order delivery
    - retransmission of lost data
  - also provides data encapsulation and multiplexing (through TCP segments) [^12]
  - PDUs are called "Segments" [^8] [^12]
  - **TCP is a connection-oriented protocol**, it requires a connection between application processes established through a **Three-way Handshake** (see also [Three-way Handshake](#three-way-handshake)) [^12]
  - Key aspect to know is that when establishing a connection, a sender MUST wait a full RTT (SYN sent and SYN ACK received) before sending data: this is "a lot of overhead" to establish connections; thus important to provide efficiency and reliability for retransmission of data once a connection is established through **Flow Control and Congestion Avoidance** (see also [RTT](#rtt, [Flow Control](#flow-control), [Congestion Avoidance](#congestion-avoidance)) [^12]
  - there are variations of TCP which use different algorithms or approaches for determining the size of the initial transmission window and how to vary this based on network conditions
  - Disadvantages of TCP: 
    - **HOL blocking can occur since in-order delivery of Segments is required**;  can lead to increased queuing delays; increases latency [^12]
    - **latency overhead of establishing a connection** [^13]

#### **Three-way handshake**
- a process used for establishing TCP connections [^12]
  - 1. Sender **sends SYN** (sync) Segment
  - 2. Receiver receives SYN, **responds with SYN ACK** (acknowledge) Segment
  - 3. Sender receives SYN ACK, responds with **ACK**
  - 4. Receiver receives ACK;  establishes connection
  - see also [Connection State](#connection-state) [^12]

#### **TLS**
- (Transport Layer Security)
- also called Secure Sockets Layer (SSL) which was the original name (pre-1990) [^33]
- provides security over HTTP (an unsecure channel): [^33]
  - **encryption** : encode messages for only authorized recipient [^37]
  - **authentication** : process to verify identity of a party in message exchange [^37] (see also [Certificate](#certificate))
  - **integrity** : process to detect if messages have been tampered or faked in transit [^37] (see also [MAC](#mac))
- establishes a secure connection using the TLS handshake (see also [TLS handshake](#tls-handshake))
- primarily uses symmetric key encryption for message exchange, but uses asymmetric key encryption for initial symmetric key exchange [^37] (see also [symmetric key encryption](#symmetric-key-encryption), [asymmetric key encryption](#asymmetric-key-encryption))

#### **TLS handshake**
- used to setup an initial secure TLS connection; assumes TCP is being used [^34]
- key outcomes of handshake: [^34]
  - agree on which version of TLS to use for secure connection
  - agree on what algorithms will be used in ciper suite
  - **enable exchange of symmetric keys for message encryption** [^37]
- **use of TLS will impact performance** : can add up to 2 rounds of latency (RTT) on top of existing single RTT for TCP handshake [^34]
- detailed example handshake steps: [^34]
  - takes place after the TCP handshake (i.e., after sender sends `ACK`) (see also [Three-way handshake](#three-way-handshake))
  - client sends `ClientHello` : contains max version of TLS protocol client can support and a list of cipher suites (see also [Cipher suites](#cipher-suites))
  - server receives and responds with `ServerHello` : sets protocol version, cipher suite; sends certificate (see also [Certificate](#certificate)); sends `ServerHelloDone`
  - client receives : initiates key exchange process (e.g., RSA algorithm:
    - client sends `ClientKeyExchange` ('pre-master secret' encrypted with server public key), sends `ChangeCipherSpec` (indicates use of symmetric key in future), sends `Finished` flag (to end TLS handshake)
    - server decrypts 'pre-master secret', uses agreed cipher suite to generate symmetric key (will be the same as client's) and sends `ChangeCipherSpec` and `Finished`
  
#### **TTL**
- (Time to Live)
- a value within the Packet header that defines the maximum number of network 'hops' a packet can take before being dropped; at each hop, the network router will decrement TTL by 1 [^5]

#### **UDP**
- (User Datagram Protocol)
- a **simple connectionless protocol** at the Transport layer that uses one-way data flow; its simplicity allows it to be **fast and flexible** [^12] [^13]
  - Header includes only: source port, destination port, length (of data in bits), checksum (required for IPv6, but optional for IPv4;  i.e., does provide error-checking [^14]q5 )
  - also provides multiplexing (through use of ports)
  - PDU is "Datagram" [^12]
  - provides no guarantee of message delivery (**no reliability**), message delivery order (**no in-order delivery**), **no congestion-avoidance or flow-control**, no connection state tracking (since it is a connectionless protocol) [^12] [^13]
  - Applications using UDP can start sending data without waiting for connections to be established; actual transmission is also faster (datagrams are not re-sent); latency is less of an issue; no HOL blocking
  - specific services (like in-order delivery [sequencing] or data retransmission) are left up to the developer to decide if they want to implement
  - best used for voice or video calling, online gaming; streaming - occasional dropped data will lead to glitches, but are worth the speed of the protocol, especially over long distances (high latency)
  - best practice for UDP use involves implementing congestion avoidance to prevent the network from being overwhelmed

#### **URI**
- (Uniform Resource Identifier)
- an identifier for a particular resource within an information space [^27];
  - a general concept - identifiers [^19];
  - a string of characters which identifies a particular resource; URIs mark specific points in the information space of the web [^16]

#### **URL**
- (Uniform Resource Locator) : distinct from URI [^16]; a type of URI [^19]; (see also [URI](#URI)); the most frequently used part of a URI that specifies where resources are located [^18]
  - Comprised of components: [^18]
    - scheme (e.g., `http`)
    - host (e.g., `www.example.com`)
    - port (e.g., `:88`) : optional - only required if not using the default port (default for normal HTTP requests is port `80`)
    - path (e.g., `/home`) optional - shows what local resource is being requested (could point to a specific file)
    - query string (e.g., `?item=book`) optional - made up of *query parameters* to send data to the server

#### **URL encoding**
- a technique where certain characters in an URL are replaced with an ASCII code [^27]
  - in URLs can only use standard 128-character ASCII set (single-byte UTF-8 codes) [^18]
    - if not part of the standard set, might be misinterpreted (e.g., `%`, ` `, `'`, `"`, `#`, `<`, `>`, `[`, `]`, `~`, etc.), or reserved (e.g., `&`, `/`, `?`, `:`, `@`) then it must be encoded
  
#### **Web server**
- typically a server that responds to requests for static assets: files, images, css, javascript, etc. - requests that don't require any data processing [^24] (see also [Application Server](#application-server))

#### **WLAN**
- (Wireless LAN)
- where devices are connected wirelessly to a central device (wireless hub or switch) [^4]

#### **World wide web**
- (the "web")
- a **service** that can be accessed via the internet;  an information system comprised of resources navigable using an URL [^16]

#### **XHR**
- (XMLHttpRequest)
- [^39]

#### **XSS** 
- (Cross-site Scripting)
- adding raw HTML and Javascript through available forms to 'inject' script onto a website which then gets interpreted and executed by the browser[^23]
  - e.g. attacker could use JavaScript to get session ids of all future visitors to the site; malicious code would bypass the same-origin policy since it lives on the site
  - simple example: could add `\<script>alert('an example of...')\</script>` to a comment section to have an alert pop-up
  - countermeasures: [^23]
    - 'sanitize' user input - eliminate `<script>` tags or disallow HTML / JS altogether
    - escape all user input when displaying it - so it does not get interpreted as code by the browser
      - e.g., replace `<p>` and `</p>` with `&lt;p&gt;` and `&lt;/p&gt;`


</details>


## Commands / Tools

- `traceroute google.com`  (`tracert` for Windows): displays the route and latency of a path across a network (e.g., my computer to Google server) [^2]

- `netstat -ntup` : displays all of the active network connections (including local address and foreign address as sockets [IP address:port]) for active applications

- `curl www.google.com` : a command line tool used to issue HTTP requests

- `telnet google.com 80` : a command line tool used to issue HTTP requests [^29]
  - need to follow-up with `GET /`

- `nc -vc launchschool.com 80` : `netcat` - another command line tool (similar to telnet) [^30]

- scripting in bash (executing scripts, conditionals, loops, functions) [^31]


## Summaries

#### Overall

| OSI Layer | IPS Layer   | Protocol   | PDU                 | Scope             |
|-----------|-------------|------------|---------------------|-------------------|
| Application <br> Presentation <br> Session | Application | Many (e.g., HTTP, <br>TLS [at session level] ) | |
| Transport | Transport   | TCP or UDP | Segment or Datagram | app to app        |
| Network | Internet    | IP         | Packet              | host to host      |
| Data Link <br> Physical | Link | Ethernet | Frame | router to device |

#### TCP vs UDP

|                | TCP | UDP |
|----------------|-----|-----|
|Connection-type |Connection-oriented|Connectionless|
|Multiplexing <br> Demultiplexing   |  Y  |  Y  |
|Error detection |  Y  |  Y  |
|In-order delivery|  Y  |   |
|De-duplication|  Y  |   |
|Message acknowledgement and <br>retransmission|  Y  |   |
|Advantages | reliable | - speed <br> - flexibility |
|Disadvantages | - high latency (overhead) <br> - HOL blocking| - must implement features (e.g., congestion avoidance) <br> - less reliable |


## Other articles
- https://www.linkedin.com/pulse/how-internet-works-introduction-overview-robert-rodes/?lipi=urn%3Ali%3Apage%3Ad_flagship3_publishing_published%3BM4DGpPvCQu%2B9IEJm2vTbKA%3D%3D


## References
[^1]: [https://launchschool.com/lessons/4af196b9/assignments/21ef33af](https://launchschool.com/lessons/4af196b9/assignments/21ef33af)
[^2]: [https://launchschool.com/lessons/4af196b9/assignments/097d7577](https://launchschool.com/lessons/4af196b9/assignments/097d7577)
[^3]: [https://launchschool.com/lessons/4af196b9/assignments/81df3782](https://launchschool.com/lessons/4af196b9/assignments/81df3782)
[^4]: [https://launchschool.com/lessons/4af196b9/assignments/268243e5](https://launchschool.com/lessons/4af196b9/assignments/268243e5)
[^5]: [https://launchschool.com/lessons/4af196b9/assignments/b222ecfb](https://launchschool.com/lessons/4af196b9/assignments/b222ecfb)
[^6]: [https://launchschool.com/lessons/4af196b9/assignments/6b7df8fb](https://launchschool.com/lessons/4af196b9/assignments/6b7df8fb)
[^7]: [https://launchschool.com/lessons/4af196b9/assignments/a53e65ce](https://launchschool.com/lessons/4af196b9/assignments/a53e65ce)
[^8]: [https://launchschool.com/lessons/4af196b9/assignments/21ef33af](https://launchschool.com/lessons/4af196b9/assignments/21ef33af)
[^9]: [https://launchschool.com/quizzes/18c3a173](https://launchschool.com/quizzes/18c3a173)
[^10]: [https://launchschool.com/lessons/2a6c7439/assignments/41113e98](https://launchschool.com/lessons/2a6c7439/assignments/41113e98)
[^11]: [https://launchschool.com/lessons/2a6c7439/assignments/89636ed4](https://launchschool.com/lessons/2a6c7439/assignments/89636ed4)
[^12]: [https://launchschool.com/lessons/2a6c7439/assignments/d09ddd52](https://launchschool.com/lessons/2a6c7439/assignments/d09ddd52)
[^13]: [https://launchschool.com/lessons/2a6c7439/assignments/4ab0993c](https://launchschool.com/lessons/2a6c7439/assignments/4ab0993c)
[^14]: [https://launchschool.com/quizzes/6b67f575](https://launchschool.com/quizzes/6b67f575)
[^15]: [https://launchschool.com/lessons/cc97deb5/assignments/c604eb60](https://launchschool.com/lessons/cc97deb5/assignments/c604eb60)
[^16]: [https://launchschool.com/lessons/cc97deb5/assignments/e3d85587](https://launchschool.com/lessons/cc97deb5/assignments/e3d85587)
[^17]: [https://launchschool.com/books/http/read/background](https://launchschool.com/books/http/read/background)
[^18]: [https://launchschool.com/books/http/read/what_is_a_url](https://launchschool.com/books/http/read/what_is_a_url)
[^19]: [https://danielmiessler.com/study/difference-between-uri-url/](https://danielmiessler.com/study/difference-between-uri-url/)
[^20]: [https://launchschool.com/books/http/read/making_requests](https://launchschool.com/books/http/read/making_requests)
[^21]: [https://launchschool.com/books/http/read/processing_responses](https://launchschool.com/books/http/read/processing_responses)
[^22]: [https://launchschool.com/books/http/read/statefulness](https://launchschool.com/books/http/read/statefulness)
[^23]: [https://launchschool.com/books/http/read/security](https://launchschool.com/books/http/read/security)
[^24]: [https://launchschool.com/lessons/cc97deb5/assignments/586769d9](https://launchschool.com/lessons/cc97deb5/assignments/586769d9)
[^25]: [https://launchschool.com/lessons/cc97deb5/assignments/a28ccb6f](https://launchschool.com/lessons/cc97deb5/assignments/a28ccb6f)
[^26]: [https://launchschool.com/lessons/cc97deb5/assignments/83ae67aa](https://launchschool.com/lessons/cc97deb5/assignments/83ae67aa)
[^27]: [https://launchschool.com/lessons/cc97deb5/assignments/9f4e349a](https://launchschool.com/lessons/cc97deb5/assignments/9f4e349a)
[^28]: [https://launchschool.com/quizzes/5e0dcf86](https://launchschool.com/quizzes/5e0dcf86)
[^29]: [https://launchschool.com/lessons/0e67d1ce/assignments/20d4226d](https://launchschool.com/lessons/0e67d1ce/assignments/20d4226d)
[^30]: [https://launchschool.com/lessons/0e67d1ce/assignments/ea90d10b](https://launchschool.com/lessons/0e67d1ce/assignments/ea90d10b)
[^31]: [https://launchschool.com/lessons/0e67d1ce/assignments/a0f37a79](https://launchschool.com/lessons/0e67d1ce/assignments/a0f37a79)
[^32]: [https://launchschool.com/lessons/0e67d1ce/assignments/dcae7f89](https://launchschool.com/lessons/0e67d1ce/assignments/dcae7f89)
[^33]: [https://launchschool.com/lessons/74f1325b/assignments/83bf156b](https://launchschool.com/lessons/74f1325b/assignments/83bf156b)
[^34]: [https://launchschool.com/lessons/74f1325b/assignments/54f6defc](https://launchschool.com/lessons/74f1325b/assignments/54f6defc)
[^35]: [https://launchschool.com/lessons/74f1325b/assignments/95e698ab](https://launchschool.com/lessons/74f1325b/assignments/95e698ab)
[^36]: [https://launchschool.com/lessons/74f1325b/assignments/a88271cf](https://launchschool.com/lessons/74f1325b/assignments/a88271cf)
[^37]: [https://launchschool.com/lessons/74f1325b/assignments/238ff36f](https://launchschool.com/lessons/74f1325b/assignments/238ff36f)
[^38]: [https://launchschool.com/lessons/be1304f3/assignments/98ecce1c](https://launchschool.com/lessons/be1304f3/assignments/98ecce1c)
[^39]: [https://launchschool.com/lessons/be1304f3/assignments/2b0cef9f](https://launchschool.com/lessons/be1304f3/assignments/2b0cef9f)