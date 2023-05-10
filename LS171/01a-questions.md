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

### Unsure
- [?] HTTP responses - what is the "body" called?  A key-value pair?  A payload?
  - A:  unsure

- [?] are symmetric / asymmetric key encryption considered "protocols"?
  - A: possibly not a protocol in the same sense as TCP or HTTP

### Open
- [ ] Application layer:  what does the PDU look like?  is the PDU different for each internet service (e.g., FTP, email, HTTP, etc.) OR is there a common PDU for this layer?

- [ ] Confirm - when we enter URL in a browser window, it's JUST a URL, correct?  The *browser* automatically takes that URL and 'converts' it into an actual HTTP request?

- [ ] how does the browser respond so quickly to "no domain name" found?  (e.g., when entering junk URLs)

- [ ] why wouldn't changes in bandwidth improve performance?
  - Does "bandwidth" refer to physical media or entire chain (including devices, etc.)? i.e., is processing delay part of "bandwidth"?
  - A: since individual packet (limited by latency) still takes just as long

# Assessment prep checklist
- [X] create written study notes (based on study guide)
- [ ] read all pinned posts
- [ ] 2nd pass spot questions
- [ ] things to draw / memorize:
    - [ ] OSI vs TCP/IP layers [https://launchschool.com/lessons/4af196b9/assignments/21ef33af]
    - [ ] 
- [ ] do quizzes again
