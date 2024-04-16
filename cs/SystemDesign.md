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



## Questions
- [ ] setting cache TTL (time-to-live) (db cache, cdn) i.e., when to expire assets
      - system design interview states "not too long, not too short" - how best to determine?