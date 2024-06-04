# June 3, 2024 Ideation lecture (Nick Miller)

## Capstone projects

### What is a Capstone project?
- work as a team to build a *production-grade open source project* that expresses a set of *architectural tradeoffs* to solve *engineering challenges* for a specific *use case*


- production-grade project:
  - meet high standards around scalability, quality, reliability, etc.
    - this is a subjective term
    - should be deployable to production systems


- key questions about "production-grade":
  - is it reliable and stable?
  - is the code high quality?
  - is it deployed? deployable?
  - does it have live users? (not a requirement)
  - how does it scale?  what are the bottlenecks to scaling?
  - is it secure?
  - how is it tested?

  - it should be ready-to-use for live users so they can try it out right now


- architectural trade-offs:
  - eng projects are centrally concerned with tradeoffs, not features
  - a tradeoff is a benefit that comes with an associated limitation or cost
  - eng conversations are driven by discussions of tradeoffs and bottlenecks, not features
  - main conversations we'll have about capstone project is about those tradeoffs and benefits, not about features
  - no tool or application is best for everyone - focus on the specific circumstances your app's tradeoffs are best suited for


- use case:
  - the use case is the circumstances where the benefits of a project's architecture outweigh the limitiations
  - it might not be the only fit
    - it may not be a unique use case : other products may serve that use case, also, just make sure your project is making a distinct set of tradeoffs
      - would need to talk about when those circumstances might arise
  - clarity around use case will help guide architectural decisions and help explain project during interviews

- e.g., Edamame project:  get-edamame.com/case-study
  - the definition helps to exclude users from the scope of the project
  - e.g., 200k virtual users is another constraint of the project

  - capstone write-ups should talk about existing solutions to clarify tradeoffs and choices that the project is making relative to other products
  - limitations help to specific the project and benefits


- engineering challenges:
  - e.g., performance, data consistency, concurrency, complexity, reliability, etc.
  - we won't be solving user / consumer challenges or business challenges
    e.g., team connectivity, fun, revenue, etc.
  - even if targeted audience isn't developers, we should still focus on talking about the technical challenges
  - this can be a subtle distinction

  - e.g., building a collaborative text editor

    - eng challenge
      - pushing latency down
      - supporting dozens of simultaneous users

    - consumer challenge
      - easily edits to github (could be easy from point of engineering)
      - having a great file system
      - etc



### Why do a Capstone Project?
- expose us to the same types of problems engineers encounter on a day-to-day basis
  - the assumption for hiring is that people who have been exposed to production systems will be exposed to certain types of problems
  - we should demonstrate:
    - depth of subject matter expertise in a specific domain
    - identify and discuss problems in terms of architecural tradeoffs
    - ability to ramp up on topics and deliver results
    - experience with prodution concerns
    - ability to work productively as a team


### Defining your project
- key steps:
  - domain research
  - prototyping
  - use case definition and project proposal
  - implementation

- you may not move linearly through those steps

- wk 5:  going wide to explore various domains
  - identify eng domains and topics that interest you
  - should fill in map of cloud architecture as a whole
  - research and write up 1 page summaries of the work we're doing
  - get used to defining and explaining eng topics from a problem-centric standpoint


- wk 6: narrowing down and going hands-on in specific domains
  - might continue research
  - should be building prototypes to play with various technologies
  - use the tools and services - make mini-projects
  - might find existing products / projects
    - use these as "model projects"

- wk 7: prototyping towards a use case
  - should start to clarify and "hammer out" a use case for the project
  - use model projects to use as a guide to explore those projects themselves
  - should try and understand "reasonable defaults"
    - e.g., should latency be 50 ms or 2 s?  will depend on problem domain, etc.
  - should craft a distinct use case from model projects
  - should start to define project proposal


- wk 8: refine proposal and beginning to build architecture
  - we'll get a project mentor
  - share our proposal, refine towards final version


### How to begin research
- broad pattern:
  - pick a topic you're interested in
  - define what it is and what problem it solves
  - how does anyone end up with that problem?  when do they encounter that problem?
  - what are the benefits and limitations of solutions in this space?
  - at what scale do teams encounter this?
    - e.g., 1000s of users, millions of users? etc
    - question of severity?

- e.g., websocket research
  - first:  background: what leads to the websocket problem
  - define what websockets are
  - how does websockets address the problem established?
  - what are the use cases?
    - under what scenarios might someone encounter this problem?
  - trade-offs / limitations / challenges
  - alternatives

- research avenues
  - see basecamp doc
  - start with popular solutions and build naive versions
  - cloud platforms
  - new / recent services on AWS and Cloudflare
    - ask: why does this tool exist?  what are use cases?  why would someone use this vs other tools?
  - how does [product or service I like] work?
    - can be a fun way to dig deeper into topics you've wondered about
    - e.g., slack:  how do they enable real-time communication, how do they have multiple channels, etc.

  - deployment or application of LLMs
    - can think about how to add AI-based featuers (like pirate-speak)
    - can think about simplifying things, common patterns, prompting methods, etc.
    - note that there are fewer experts and existing model projects to work off of


- quastor:  has interesting stories
  - note that these typically come from companies with 100s of millions of users
  - but companies with 100s of thousands of users may not have the same problems
  - it will be hard to implement for 100s of millions of users



### Observations on researching as a team
- debate is positive, defensiveness is not
  - if something isn't clear, or claims sound incorrect then questioning and examining is helpful - communicate here
  - problems occur when egos are attached and people get defensive instead of focusing on the topic discussed
  - the goal should be clarity of ideas
    - don't get personal


- use prototypes, demos and experiments as a means of moving forward
  - it's impossible to understand these topics until you start building with them
  - some teams may spin their wheels by trying to research their way through problems
    - prototyping is sometimes better
    - just build a demo or model project in that space to help answer questions about it
    - use code, demos, experiments, etc.
  - just research is limited


- moving together as a team is better than just being "right" on every point
  - some things may not be technically optimal, but it may not matter
  - trying to make the optimal choice at every point can lead to less team cohesion and investment in the project by everyone
  - dont' just focus on your own vision


- not every decision is critical
  - lower the stakes and let yourself have fun learning about these topics
  - don't feel pressure about getting the right or best project
  - just learn a bunch of stuff - about technologies, projects, etc.
    - this can be fun
    - don't be anxious about finding the right project and get combative about just exploring


- be curious, rather than certain
  - a "tell" of a more experienced engineer is being uncertain about topics
  - keep an open mind
  - approach unfamiliar or less interesting topics to learn more
    - if nothing, you'll better understand that topic domain - good for learning


- notice who has been quiet and ask for their opinion
  - pay attention to who is speaking and who isn't speaking
  - dynamics and group communication may inhibit people from talking


- use staff and mentors as sounding boards
  - can help elaborate
  - can serve as tie-breakers
  - don't under-utilize staff/mentors (especially in slack)
  - don't feel like we're off on our own

  - feeling uncomfortable with ambiguity is part of the process




## Homework
  - draft 10-20 engineering domains that the team is interested in
    - starting with a big list is key
    - eng topics and domains - brainstorm anything
  - research and write 1-page reports on the tpics of your choice
    - each team member should write
  - come together and share what we've learned with each other
  - need to teach each other what we've learned
  - repeat: either discuss topics or dive deeper into topics of interest
