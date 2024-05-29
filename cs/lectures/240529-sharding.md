# Sharding & Consistent Hashing


## Benefits of Sharding a Database

    faster reads
        more effective DB caching
        smaller table
        better join performance (as long as it's not cross-shard)
    faster writes
        index maintenance is faster
    helps with the single point of failure problem for whole system
        if one server is down, just that subset of users/products/accounts is unavailable
    provides an alternative to replication based scaling, only under specific situations


## Problems of Sharding a Database

    ACID compromises
    cross-shard queries are more complicated. They're either very expensive to do (ship data around) or have to be done on the application level.
        who are the users that live in Houston?
        lack of global indexes
        constraints
        joins
        single point of failure for any one node
            (if the failure of one shard is considered to fail the entire system, this magnifies single point of failure)
    schema structure evolution
    development complexity
        the code now has to also take into consideration on infrastructure and topology, in addition to business logic
        much more complicated error cases

## Don't shard until you have to!

## Sharding Algorithms

A Naive Sharding Algorithm - Modulo of Integer IDs

    when a new node is added, it causes a lot of disruption - a lot of data has to be moved!

Other shading algorithms

    range
    geography
    alphabetical
    consistent hashing


Desired Properties of Sharding Algorithms

    uniform distribution of keys
    random distribution of keys to avoid the hotspot problem
    consistent and fast key -> node look up when the system is scaled up or down
    minimum re-distribution of data when nodes are added (scale up) or removed (scale down)


## Consistent Hashing

    Hash data keys into a limited value space
        SHA1, for example, gives 2^160 possible values
    Generate hash values for the Nodes so that they also map into this range
        for example, SHA1(node's IP address)
    [Use a ring to represent the hash value space](https://highlyscalable.files.wordpress.com/2012/09/consistent-hashing.png), and put the hash values of nodes on the ring
    With a key, to find the node that contains the node, "walk the ring" from the hash value of the key, to find the first node it sees
        doesn't necessarily mean linear probe; ie, "walking the ring" conceptually not imperatively
        can be just a range map
    Adding / removing nodes won't change all but the neighbor partitions
    use multiple hashing functions on servers to create "virtual nodes" to more evenly distribute servers in the ring

