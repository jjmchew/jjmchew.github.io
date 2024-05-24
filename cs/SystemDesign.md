# System design notes

## Scaling "progression"
- everything on 1 webserver
- 1 webserver and 1 DB "server"
- Load balancer - multiple webservers
- DB replication (i.e., primary/replica for write/read)
- Add (db) cache
:w
  - LRU:  least-recently-used
  - LFU:  least-frequently used
  - FIFO:  first-in-first-out
- CDN (content delivery network) for static files
- "Stateless web tier" : add NoSQL db for state (session, user, etc.) data
    - this way, individual requests can be routed to ANY web server
- web tier:  adding data centers (to support geographical regions)
    - adding "message queue" for async communication of components
        - this creates separation of "producers" and "consumers" (workers to fulfill requests)
    - logging, metrics, monitoring, automation
- data tier:
    - horizontal scaling is called "sharding" - adding more servers, each shard contains part of the data of the entire database; data on each shard is unique
    - use a hash function to help with sharding data (i.e., hash of user_id will determine which server contains the data)
    - also called "sharding key" or "partition key" - the key which determines how data is distributed
    - non-relational db may also be added to reduce relational db load


## Technical challenges
- traffic redirection in multi-data center setup
  - data synchronization (e.g., data replication across multiple data centers)
  - automated deployment and testing across multiple data centers
  - de-coupling different components of the system to scale independently (e.g., use of messaing queue)

- horizontal scaling of dbs
  - e.g., resharding data (when a shard can no longer hold enough data, "shard exhaustion")
  - "celebrity problem" (or hotspot key problem) : excessive access to a specific shard can overload a server
  - join and de-normalization : hard to perform join operations across multiple servers
      - dbs are typically "de-normalized" to perform queries in a single table


# Chapter 2
- 1 byte = 8 bits
  - an ASCII char is 8 bits
- KB:  kilobyte: 10^3                    1,000 bytes
- MB:  megabyte: 10^6                1,000,000 bytes (million)
- GB:  gigabyte: 10^9            1,000,000,000 bytes (billion)
- TB:  terabyte: 10^12       1,000,000,000,000 bytes (trillion)
- PB:  petabyte: 10^15   1,000,000,000,000,000 bytes (quadrillion)


- latency numbers (2020):
  - L1 cache:  1 ns
  - L2 cache:  4 ns
  - main memory reference:  100 ns
  - compress 1K bytes with Zippy: 2 microseconds
  - send 2k bytes over 1 Gbps netwtork:  44 nanoseconds
  - read 1 mb sequentially from memory: 3 microseconds
  - round trip within the same data center: 500 microseconds
  - disk seek: 2 ms
  - read 1 mb sequentially from disk:    825 microseconds
  - send packet from california > netherlands > california: 150 ms

- memory is fast, disk is slow
- avoid disk seeks
- simple compression algos are fast
- compress data before sending it over the internet, if possible
- it takes time to send data between data centers

- 99% availability: 3.65 days / year downtime
- 99.9% : 8.77 hours / yr downtime
- 99.99% : 52.60 mins / yr
- 99.999% : 5.26 mins / yr
- 99.9999% : 31.56 seconds


- typical to round seconds / day (86,400 s / day) to 100,000 (or 1 x 10^5)



## Questions
- [ ] setting cache TTL (time-to-live) (db cache, cdn) i.e., when to expire assets
      - system design interview states "not too long, not too short" - how best to determine?
- [ ] ch 2 example (estimate twitter QPS) (pg 51):
      - why is peak QPS = 2 * QPS?   is this commonly accepted?