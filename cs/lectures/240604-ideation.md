# June 4, 2024, Ideation day 2 lectures

## Research strategies
- end-goal is to understand the narrative of your problem
- clarify the "path to the problem"
- should be able to explain how do we arrive at a problem or solution

- mental model:
  - there may be layers of solutions / sub-problems
  - it will feel like recursion and digging down recursively through solutions/problems

- a solution should exist out there - a sign that it's a real problem
  - you should ask yourself when you find something if it's really a problem
  - if people aren't trying to solve it, it may not be a real problem



### Top-down research
- the most general level of problems / topics / solutions / ideas in software engineering
- starting big and then zooming in

- start with a general domain
  - ask : what is this?
  - why and under what circumstances would I use this?
  - what are the alternatives?  (why might I want to use this / them?)
  - what new challenges / problems does this create?

- when you get to a subproblem:
  - who experiences this and why?
  - what are the various solutions to this problem?
  (why would someone encounter this roadblock?)

- we're not necessarily looking for novel solutions
  - we shouldn't be trying to solve something that no one else has tried since it's not important
  - we also shouldn't trying to be solving something that hasn't yet been solved (we only have a few weeks/months) - otherwise, we may not be able to solve it
  - we SHOULD be looking at other solutions we come across
    - see how they solved it, and under what conditions

 - sub-problems may not be clear
  - we may need to hunt
  - e.g., looking at noSql dbs: marketing copy was not apparent when trying to understand these dbs
    - need to go to other sources to better understand 
  - eventually, if we keep digging, we'll find a specific subproblem that we can dig into


- example:  microservices communication:
  - can use message queues, gRPC, service mesh : first level of solutions
  - can then dig into: message queues:
    - sub problems:  poison pill (consumer can't process messages), head-of-line blocking, ordering (how to guarantee ordering)
  - then dig into solutions, e.g., to poison pill:
    - could use DLQ, drop message, consumer proxy
  - then dig into next level of problems: (e.g., for DLQ)
    - re-drive messages, message retention (what rules exist to manage this), notifications (e.g., when stuff is in the DLQ)
  - solutions to re-drive messages:
    - serverless360, cerebrata, cogin
    - can take a look at these and then perhaps try to implement a prototype, etc. to better understand it

- the example is pretty clean - don't assume your research will be this clean
  - keep a journal : daily summaries 
  - writing down what you've done with research can help
    - articulate what you've done, why, etc. to put it in context



### Bottom-up research
- the most specific sub-problem (or product that solves those sub-problems)
- starting small and zooming out

- start with an existing solution at the product-level and recurse upwards

- e.g., start with an existing solution:
  - what eng problem does it solve?
    - some product may solve lots of problems
    - may need to look at features to understand what kind of users might need what features
  - what eng subdomain does this belong to?
  - what did life look like before this solution?
    - how did people solve this problem before this solution?
  - what set of problems would an engineer have so that this would be the solution?
    - try to visualize the person and the situation where they would reach for this thing on the shelf

  - try to understand the subdomain
- then recurse upwards:
  - how would a team arrive at this particular subdomain?
  - characteristics of this team's application?
  - what other totols?
  - what broader eng domains does this belong to?

- e.g., neon.tech website:
  - "ship faster with postgres"
  - check features:
    - branching : can check what does this mean?
      - looks like there is some performance benefit
      - some benefit to CI/CD
      - some linkage to production data - copying it and using it staging and test environments
        - can start to think about this
        - may not be great for sensitive data
        - but may be useful for getting real life data for testing
      - can see prod data for each dev
      - a "PR preview" : the system will automatically spin up an instance of the app for you to see how it works
      - can start to see why using dumps for dbs can be a problem
    - looking at docs can help to understand an app
      - can look at branching and autoscaling
      - docs will typically have less marketing speak
      - might be able to pick out specific use cases
    
    - autoscaling : can check this
      - can check docs on this to help clarify
      - can vertically scale the db on demand

      - autosuspend:
        - looks like it could be interesting: don't need to pay for servers not being used
        - docs include mention of "cold starts" : this gives us something to dig into
          - a "cold start" is provisioning something from nothing - the time it takes to provision resources from scratch

    - won't look at these for now
      - cli
      - on-demand storage
      - ai

  - can look at branching data (a problem domain)
    - this might occur for testing:
      - getting high-quality dev data
      - e.g., how to test destructive queries
      - how to prevent data loss

  - this is related to isolated environments, related to testing, etc.

  - customer stories can be helpful to give you an idea of how other end users use the tool to do something


### why 2 strategies?
- different people like different methods
  - looking at it through tools can be helpful
    - then work to understand where that tool sits

- you don't need to start at the top or bottom
  - sometimes you start in the middle
  - e.g., webhooks are kind of in the middle: there are things 'upstream' and 'downstream'
    - why webhooks?  may want to PUSH data in HTTP
      - which is part of event-driven architecture and communication patterns
    - downstream:  could look at webhook failures, too many requests
      - could look at retry mechanisms or error handling
      - sub problems could be when to stop retries or how to preserve ordering in the event of retries

### prototyping
- try building or using something!
  - it will help you better understand the problem or the solution
  - building a basic app to integrate it can be really helpful
  - e.g., requestbin:
    - you understand it from reading about it
    - but when you start building it, you understand MUCH better
      - we now better understand the engineering challenges

### QA
- it can be easiest to just take 1 feature from products - trying to understand all features is probably too much
  - don't be afraid to start in pieces
  - platforms (like AWS) is much too big than trying to research the entire platform
  - a lot of commercial services will have multiple solution offerings
    - so broadly understanding the service may be helpful
    - but getting specific may be easier 
    - e.g., a feature flag service:  (launch darkly)
      - might want to start with some bottom up research
      - any single feature could provide a starting point for research to understand specific use cases

- have a bias for getting more specific rather than more general
  - it will make this easier
  - keep drilling down
  - who has this problem?  who is this for?
  - look at comments, look at why, etc. to better understand it
    - dig for the use case
    - it might not be for you, but who has the problems that this solution is supplying
    - any product that claims to be for "everyone" - you should be suspicious

- write-up (the 1 pagers):
  - we're trying to setup the problem statement of a capstone write-up
  - we're essentially trying to create the problem setup, introduce the specific project and interesting challenges which are associated with that project
    - we're trying to work on that initial background / context
    - e.g., start with an app using microservices, because we use microservices, we'll have some problems - those problems are ..., here's how we might address that

  - look at the 1 pg webhooks sample - try to mirror that
    - background:  roughly upstream of the problem
    - then talks about how websockets address that problem
    - then trade-offs is roughly downstream concerns
    - alternatives is roughly "sibling" options (moving laterally) in the top/down diagram
    - automatic caching (for websockets) is a trade-off that you could write another 1 pager on the next day


## HW
- see basecamp notes
- make sure when you compare things (e.g., faster, easier, slower, etc.):
  - always define what you're comparing to - this will point towards what you may need to research


