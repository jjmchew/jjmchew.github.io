# Follow-up questions on LS170

- [ ] public and private keys: do these work in both directions? (e.g., CA signatures)
    - If I encrypt using a private key, can I also decrypt with that private key OR do I have to use the public key?
    - If I encrypt using the public key, can I also decrypt with that public key?
      - if so, couldn't I just fake the 'private' key encryption?
    - [ ] confirm:  private key encodes > ONLY public key decodes AND public key encodes > ONLY private key decodes

- [ ] MAC address - must be added by switches in the destination network, right?  so data primarily travels via IP address before it's packaged into a frame at the receiving network location?

- [ ] does Ethernet transmission require a modem?  (i.e., similar to fiber optic, old-fashioned dial-up, etc.)

- [ ] Application layer:  what does the PDU look like?  is the PDU different for each internet service (e.g., FTP, email, HTTP, etc.) OR is there a common PDU for this layer?

- [ ] Confirm - when we enter URL in a browser window, it's JUST a URL, correct?  The *browser* automatically takes that URL and 'converts' it into an actual HTTP request?

- [ ] HTTP responses - what is the "body" called?  A key-value pair?  A payload?

- [ ] Do the ciper suites include encryption algos for digital certificate verification?

- [ ] are symmetric / asymmetric key encryption considered "protocols"?

- [ ] latency - propogation delay : shouldn't this be just the delay in travelling along physical media (e.g., cables, etc); if it's the total delay from sender to receiver, it would include transmission delay, processing delay, queuing delay, etc. (https://launchschool.com/lessons/4af196b9/assignments/097d7577)

- [ ] is MAC (TLS) hashing algorithm a part of the cipher suites for TLS?

- [ ] how does the browser respond so quickly to "no domain name" found?  (e.g., when entering junk URLs)



# Assessment prep checklist
- [ ] create written study notes (based on study guide)
- [ ] read all pinned posts
- [ ] 2nd pass spot questions
- [ ] things to draw / memorize:
    - [ ] OSI vs TCP/IP layers [https://launchschool.com/lessons/4af196b9/assignments/21ef33af]
    - [ ] 
- [ ] do quizzes again
