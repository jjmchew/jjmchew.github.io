# Types of system design interview questions

    OO Design
        "Design a Parking Lot" type of questions
        Deliverable: class diagram
        flesh out use case
        extract nouns (classes) and verbs (methods)
        organize verbs into nouns (methods accessible to classes) 
    Functional System Design
        Deliverable: ERD
        similar to OO design, except don't organize verbs into nouns
            watch out for: implicit nouns (eg CartItem) and extraneous nouns
        level of detail: schema vs ERD
    Functional System Design + Scaling
        System Design Interview book
        first, do current state (ERD)
        then, use metrics and project to scaling
            use toolset (caching, load balancing, replication, etc)
    Conceptual Design
        Deliverable: component diagram
        most Capstone projects are here
        example: design how a background job processing system may work (activation email)

