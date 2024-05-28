# NoSQL notes

## From intro video:
- https://www.youtube.com/watch?v=qI_g07C_Q5I

### History
- mid 1980's:  rise of relational dbs (SQL)
  - SQL problems:  to save things you have to take a logical structure and split it up into bits:  "impedance mismatch problem"
    - leads to ORM frameworks
- mid 1990's: object dbs were introduced, but never really took off
    - SQL dbs were used for integrating different business domains
- web 3:  lots of data
  - use of many distributed servers become the norm
  - it's very hard to spread relational dbs across many computers
- NoSQL was designed to be easy to spread data among many computers
  - the name came from a twitter hashtag for a meetup

- NoSQL : it cannot be defined
  - common characteristics:
    - non-relational
    - open-source (generally)
    - cluster-friendly (generally)
    - 21st century web
    - schema-less

- data model:
  - key-value store
    - like a hash map
    - there can be additional meta-data that is stored with data

  - document
    - each document is a complex data structure
    - generally json (popular)
    - more transparent than key-value store
    - there is an implicit schema
    - there may be id's included
  
  - key-value and document are very similar
    - can be called "aggregate-oriented" non-relational dbs
  
  - column-family db
    - have a key (row key) - within that we store columns that fit together
      - the columns are an aggregate
      - columns: have key and value - like a table
      - more complex data model
      - easier to pull individual columns out, etc.

  - there is also a "graph" type of non-relational dbs
    - not aggregate-oriented
    - based on graphs : nodes, edges
    - good at hierarchies
    - also schema-less

- when distributing data - aggregates are shared together
  - aggregate orientation determine how to store things together on a cluster

- to do analytics with these dbs, will typically use MapReduce to reorient data


- aggregate-oriented : work with the same aggregates
- graph-oriented : model complex relationships between entities
- relational dbs : tabular data structure

- BASE : not super-useful

- graph dbs: are ACID
- aggregate-oriented dbs : aggregates are within transaction-boundaries
  - aggregates tend to be atomic, consistent, etc.
  - if you work across aggregates, then you might not be ACID

- resolving conflicts:
  - when making changes, provide a version indicator with changes
    - then you can determine which change came first

- consistency:
  - logical consistency
  - replication consistency


- when to use a NoSQL db
  - when you have a lot of data - especially more data than will fit on 1 computer
  - most people think NoSQL is easier to develop with
    - e.g., an article is a natural aggregate to push into a db
    - depending on the data, non-relational dbs are easier
  - many people now integrate using a service-oriented architecture to share information, rather than use a relational db for integration
  - data analytics
    - when collecting unstructured data, noSQL dbs help
      - can use graphs, etc.

 - future is likely "polyglot persistence"
  - many dbs will be the norm

