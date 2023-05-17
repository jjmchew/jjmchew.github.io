# Follow-up questions on LS170

### Answered
- [X] MAC address - must be added by switches in the destination network, right?  so data primarily travels via IP address before it's packaged into a frame at the receiving network location?
  - A: think of frames like taxis - each time the packet 'hops' it will get packaged into a new 'frame' to travel to the next MAC address
  - [x] read: https://launchschool.com/posts/b8c4153b
  - [x] watch https://www.youtube.com/watch?v=rYodcvhh7b8
  - Ethernet frames are used to get the packet (w/ TCP segment, etc.) to the next hop. MAC address come from an ARP table. If the source device does not know the MAC address for the next hop, an ARP request is sent out (on a switch, it will send a broadcast request which floods all ports on the switch) and the device at the target IP address will respond with their MAC address. Once the frame reaches the target MAC address, a new frame will be created, if necessary (e.g., ARP table or ARP request).
  
- [X] does Ethernet transmission require a modem?  (i.e., similar to fiber optic, old-fashioned dial-up, etc.)
  - A: likely. We know ethernet uses different voltage across the line (Ben Eater youtube video) to correlate to binary data

- [X] latency - propogation delay : shouldn't this be just the delay in travelling along physical media (e.g., cables, etc); if it's the total delay from sender to receiver, it would include transmission delay, processing delay, queuing delay, etc. (https://launchschool.com/lessons/4af196b9/assignments/097d7577)
  - w/ Erik: What is the transmission delay:  google this - may be worth checking for discussions on this;  it may be like the delay in modulating / demodulating the signal
  - [X] check this post:  https://launchschool.com/posts/32b0f5f2
  - this post seems to agree - transmission delay could be delay to modulate or de-modulate signals for physical media

- [X] public and private keys: do these work in both directions? (e.g., CA signatures)
    - If I encrypt using a private key, can I also decrypt with that private key OR do I have to use the public key?
    - If I encrypt using the public key, can I also decrypt with that public key?
      - if so, couldn't I just fake the 'private' key encryption?
    - [X] confirm:  private key encodes > ONLY public key decodes AND public key encodes > ONLY private key decodes
      - A: yes:  messages encrypted with public key can **only** be decrypted with the private key; indicates that it COULD work in the other direction, although wouldn't be secure (https://launchschool.com/lessons/74f1325b/assignments/54f6defc)

- [X] Do the ciper suites include encryption algos for digital certificate verification?
  - A: likely yes: algos in cipher suites includes algos for "carrying out authentication" (https://launchschool.com/lessons/74f1325b/assignments/54f6defc)

- [X] is MAC (TLS) hashing algorithm a part of the cipher suites for TLS?
  - A: likely yes: algos in cipher suites includes algos for "checking message integrity" (https://launchschool.com/lessons/74f1325b/assignments/54f6defc)

- [X] why wouldn't changes in bandwidth improve performance?
  - Does "bandwidth" refer to physical media or entire chain (including devices, etc.)? i.e., is processing delay part of "bandwidth"?
  - A: since individual packet (limited by latency) still takes just as long
  - more bandwidth feels 'faster' since you can download faster (i.e., more Mbps), but it's about getting more in the same latency, and not necessarily getting sequential requests / responses any faster

### Unsure
- [?] HTTP responses - what is the "body" called?  A key-value pair?  A payload?
  - A:  unsure

- [?] are symmetric / asymmetric key encryption considered "protocols"?
  - A: possibly not a protocol in the same sense as TCP or HTTP

- [?] Application layer:  what does the PDU look like?  is the PDU different for each internet service (e.g., FTP, email, HTTP, etc.) OR is there a common PDU for this layer?
  - A:  Not really a PDU per-se;  blog post refers to an "application layer" PDU as a "message" (https://vahid.blog/post/2020-12-21-how-the-internet-works-part-ii-layers/)
  - A: an HTTP message is a kind of PDU - has an agreed structure so that it can be understood when transmitting info between computers

- [?] Confirm - when we enter URL in a browser window, it's JUST a URL, correct?  The *browser* automatically takes that URL and 'converts' it into an actual HTTP request?
  - A:  agreed - the browser needs to form the request
  - Also VERY likely that the request isn't actually formed and sent out until after the TCP / TLS handshake has taken place (since browsers make requests using the HTTP version that servers like - e.g., HTTP/2 or HTTP/3)

- [?] how does the browser respond so quickly to "no domain name" found?  (e.g., when entering junk URLs)
  - A:  suspect it's because DNS servers are extremely quick

### Open



# Assessment prep checklist
- [X] create written study notes (based on study guide)
- [X] read all pinned posts
- [X] 2nd pass spot questions
- [X] things to draw / memorize:
    - [X] OSI vs TCP/IP layers [https://launchschool.com/lessons/4af196b9/assignments/21ef33af]
- [X] do quizzes again


# Quiz answers (2nd time)

## Quiz1 https://launchschool.com/quizzes/18c3a173
### answers
- q1: A, B, C, D
- q2: A, B, E
- q3: A, B
- q4: B
- q5: A
- q6: A, C, D
- q7: A, C
- q8: A, D
- q9: A, B, D

## Quiz2 https://launchschool.com/quizzes/6b67f575
### answers
- q1: B
- q2: B, D, E
- q3: A, B, C, D
- q4: A, C, D, E, F, G
- q5: B, C, G
- q6: E
- q7: B
- q8: A

## Quiz3 https://launchschool.com/quizzes/5e0dcf86
### answers
- q1: C
- q2: C
- q3: A
- q4: B
- q5: C
- q6: B
- q7: B, D
- q8: A
- ==X q9: B==
- q10: A, C, D
- q11: A, B, C
- q12: A, B, C
- q13: B, C, D
### review q9

## Quiz4 https://launchschool.com/quizzes/0ff9564e
### answers
- q1: A, E, F
- q2: C
- q3: A, C, D
- q4: C
- q5: A, C
- X q6: A, ==~~B~~==, D
- q7: C
### review q6