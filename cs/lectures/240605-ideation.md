# June 5, 2024 - Ideation lecture

## Intro
- hasura : a graphQL platform
  - graphQL: an alternative to REST in terms of architecture of API
    - REST endpoint gives you a certain data back in a certain shape
      - as someone using the API, you have no control over that endpoint 
      - you get back whatever the server gives you
    - graphQL : the client can define the shape of the data it wants back
    - benefits to graphQL:  for a mobile client, it's better to get a minimum amount of data for any particular view
      - it's easy to do this with graphQL
      - it's beneficial when you get too much data back from endpoints
    - REST puts the work on sorting through data on the front-end
    - graphQL puts the work on sorting through data on the back-end


- generally LS thinks there is little correlation between capstone project and role
  - sometimes if you have expertise in a certain area, you may perform well when interviewing with a company in that area
  - Netlify - does preview apps for websites
    - a team which worked on that tended to work at Netlify
  - your project won't prevent you from getting work in a particular area
  - you might need to spend a bit more time practicing for a specific role if your project didn't involve that area
  - a lot of roles are general software eng roles - so skills aren't too specific or specialized (unless it's a more senior position)
    - e.g., senior front-end : they'd want to see more years of experience and architecting systems


- we're only a couple of days into research: we wouldn't necessarily be able to create a project
  - it might take a few days of recursing into research to see where projects might lie
  - w/ top down research and seeing subproblems:
    - look into existing products or services that might suffer from these types of problems more than a typical app
    - asking that question may help anchor towards concrete implementations of these tools



- challenges with serverless
  - no persistent memory
  - cold starts
  - if you don't know what to do with the challenges, think about common applications of serverless functions:
    - e.g., image processing;  you might get a conference badge with your name and custom user ID number - making that badge may be a serverless function
    - a request may go to a serverless function that creates that badge (using an image stored on s3 and then email you the badge)
  - look for tutorials on "how to generate serverless functions"
    - it might help with better understanding serverless functions, highlight challenges


- could look at productHunt - you can find product launches
  - may be able to see themes of companies - these are often "micro-problems"
  - companies may be better scoped


- chatGPT can be helpful to bounce ideas off of:
  - can get you started with research
  - "could you help me understand why this tool exists"
  - "can you show me other applications that use this"
  - "why does this tool exist"


## How to shift research into a project
- think about use cases
- **use case**: a SPECIFIC scenario for a user
  - need to identify WHO is using something
  - what is their specific problem
  - how does what you're researching solve that problem
  
- **use case** (LS def'n):
  - the set of circumstances or scenarios under which a particular tool or application is a fit for a specific person (benefits and limitations)

- to find a use case, ask:
  - What are the core engineering challenges that drives this project?
  - Who experiences this problem? What are the characteristics of the application or development team?  What are their requirements?
  - What set of tradeoffs define who this project is *not* for?
  - Where does this project sit in relation to alternative solutions? For whom (or for what types of applications) would it be an optimal approach?


### Example - toothbrush
- what are the use cases of a toothbrush?
  - What is the problem that a toothbrush solves?
    - plaque buildup
    - bad breath
    - We might ask HOW does that happen?
  - Who experiences that problem?
    - All humans, animals, people w/ teeth
  - Alternative solutions?
    - swish oil in your mouth (coconut, salt water)
      - this may have existed historically
      - may be less effective, may be easier to get materials
    - mouthwash
      - solves bad breath, but not plaque problems
    - flossing
      - good for plaque, but maybe not bad breath
    - frequent visits to the dentist
      - expensive, time-consuming, complete coverage ("SaaS" / enterprise option)
  - we can roughly define the use case of a toothbrush by looking at the alternatives are
    - essentially thinking about this helps to define a project use case
    - it can be helpful to define a use case / project by looking at alternatives



- if we think we've found a use case:
  - how do we know that use case exists?
    - we don't want to invent a use case
    - by evidence:
      - by a model project:  a similar or potentially overlapping project - if that exists, it can validate that people have a valid problem
      - forum discussions (talking about chaallenges)
      - conference talks
      - blogs - may describe solutions (which hint at problems), etc.
      - articles


### Finding multiple use cases within a particular eng domain
- in a particular engineering space, it may look like everything is covered
  - multiple capstone projects may have covered the same domain, but had distinct use cases
  - e.g., feature flags (an engineering domain)
    - these let eng teams toggle functionality of app without launching new code
    - especially if you only wanted to launch that feature for a subset of users
      - can toggle it on/off through a mgmt console
    - past projects:
      - Fana: looked at setting feature flags for specific subsets of users
        - e.g., geography, age, etc.
        - audience targeting out of the box is their key
      - Tailslide:
        - focused on automated failure protection: from research, noticed that features can be easily turned off without deployment
          - if there's a bug in a feature, it can be easily removed from the app
          - they use a circuit breaker architecture to track the rate of errors and then turn off features automatically
          - created their own auto-recovery algorithm (which they researched) in an automated way
          - audience targeting is not a focus
        - Waypost:
          - focused on A/B testing
          - feature flags can render different versions of the app and then measure behaviour in each version
          - waypost included statistical modelling and analysis feature to automatically create metrics to compare A/B

- what about if there's a paid tool that already does everything?
  - e.g., husara exists and it covers that area
  - paid services may do everything (e.g., launch darkly - they've been around for a long time and they come up in discussions on alternatives in capstone projects)
  - the specificity of our capstone project is a benefit for a particular use case
    - the breadth of enterprise solutions is a tradeoff
      - enterprise systems want to pull in a broad range of users
      - that range is complexity
        - e.g., photoshop is a comprehensive tool - good for pros
        - if you've never used it and you just want to crop and add text it's probably not the right tool
      - understand that use case deeply and orient project around it
        - if you can make something specific really easy, that's a benefit


## Model projects
- projects that solve or are closely related to the problem that our team is trying to solve
- can be a number of things:
  - can be open-source
  - can be paid products
  - can be descriptions of architectural patterns or internal tools (e.g., in eng blog posts)

- each project may use model projects differently
- common patterns:
  - use them to help understand the problem space
  - serve as evidence that the problem is legitimate
  - used to help define a use case of the solution
  - they could serve as a technical benchmark (e.g., what does "performance" mean, what does "speed" mean, what does "storage size" relate to, what "features" should exist)
    - e.g., real-time apps will be different vs other apps
  - give you hands on experience using something in that problem domain
    - lets you feel the pain of that problem
    - don't let things be all theoretical

- open source projects:
  - some teams can find an open source project (use a specification)
    - can use this a specification for creating their own project
    - you might have the same use case, but you would build your own version of it
    - e.g., Laridae: reversible zero-downtime schema migration for postgresQL
      - using pattern called expand and contract
      - coordinate both app code and database to make changes
      - there was an open source project called "pgroll"
  - extending an existing project (e.g., deployment, functionality, use that tool as part of project to solve a more specific use-case)
    - e.g., conifer:  create tooling to make that open-source project easy to deploy, or extend it
      - extended Cypress E2E testse and parallelizing them (and deploy those tests across containers on AWS to make it faster)
      - not just running tests, but doing it efficiently

- paid products:
  - create an open-source version of a paid product
    - e.g., Sundial: cron job monitoring across multiple nodes (an abstraction layer)
      - roughly equivalent to "cronitor" (a paid product)
        - very basic functionality
  
  - pick a specific use case (feature) from a paid product and focus on it
    - e.g., Tinker, Snowclone (back-end as a service projects)
      - both were based on "Supabase" (a back end as a service, authentication, storage, db, etc.)
  
  - pick a short-coming of a product, or a different but related use case
    - back-end as a service:  if you just need a quick CRUD app - it's quick to develop against so you don't have to set it up yourself
    - e.g., PocketBase (paid product):  can create custom logic (but only in go)
     - e.g., Pinniped: created a pocketbase with core JS functionality (natively extendable)

- architectural pattern or internal tool
  - i.e, based on a description of something that exists
  - e.g., edamame:  load testing websockets
    - websockets are often used to exchange messages in collaboration apps
    - load testing real-time apps
    - was based on a slack engineering blog post and how slack built a tool for that testing (KoiPond)

- see basecamp notes
  - provides a top-down research path
  - how did they dig down, how did they categorize what they found
  - how did they find the model project
  - how did they use the model project


## Daily Summaries
- see basecamp notes

- document things on a daily basis
  - what problems have you collected?
  - what impressions?
  - easy to go through research and not see a lot of progress
  - book-end day with a journal entry
    - what questions do you have?  what did you find out?
  
