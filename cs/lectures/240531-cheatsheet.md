# Final System Design Cheatsheet

The Famous Jeff Bezos email that kicked off AWS:

    All teams will henceforth expose their data and functionality through service interfaces.

        Teams must communicate with each other through these interfaces.
        There will be no other form of interprocess communication allowed: no direct linking, no direct reads of another team’s data store, no shared-memory model, no back-doors whatsoever. The only communication allowed is via service interface calls over the network.
        It doesn’t matter what technology they use. HTTP, Corba, Pubsub, custom protocols — doesn’t matter.
        All service interfaces, without exception, must be designed from the ground up to be externalizable. That is to say, the team must plan and design to be able to expose the interface to developers in the outside world. No exceptions.
        Anyone who doesn’t do this will be fired.

    Thank you; have a nice day!



## Interview Prep
[System Design Interview Guide](https://interviewing.io/guides/system-design-interview)

    Fantastic guide to review right before/as you start your job hunt. It's definitely geared towards more senior-level engineers, so don't psych yourself out feeling like you have to know everything.
    Section 1 talks about a lot of the "meta" of the system design interview, including how to approach it, common do's and don'ts, etc.
    Section 2 has a couple of long videos, one of two engineers designing the same system, and the second deconstructing what happened in the first. Super helpful to recognize that two people designing the same system will come up with two very different designs (and that's ok!), as well as how these folks think about system design interviews and how to approach them
    The rest of section 2 is a quick review of technical topics. The one on web security is probably the most helpful as we don't cover it much, but the rest can be a good refresher.
    Section 3 and 4 talk about the structure of the interview itself with some detailed examples. You'll notice some similarities between what we teach and what they describe, but some differences as well (and that's ok too!). Don't get hung up on the nitty gritty, focus on the big picture and what works well for you when considering a framework to approach these interviews with.


Watch - [System Design Introduction for Interviews](https://www.youtube.com/watch?v=UzLMhqg3_Wc) (Tushar) - Super quick overview of a ton of topics, great for a refresher.

    ABCD
        Ask good questions
        don't use Buzzwords
        Clear and organized thinking
        Drive discussion (80/20 rule)


Read - [System Design Primer](https://github.com/donnemartin/system-design-primer) - this is a pretty extensive resource, so make sure not to get bogged down in the details. Consider it a good resource to skim to refresh yourself on system design topics, zooming in to single topics only when needed.

Watch - [Design Twitter's API](https://github.com/donnemartin/system-design-primer)

    Designing an API is another direction you can see system design interviews go, where you're designing the interface to the data rather than modeling the data schema itself
    Most of the same rules and strategies still apply as what we did with thinking about use cases and ERDs!


Read - System Design Interview (purchased during Capstone Prep)

    There are several popular system design interview scenarios, although if we had to pick some to focus on it would be the below. 
    Remember that in a real system design interview, you'll likely only need 50% or less of this, but use it for high level review. 
        URL Shortener (chapter 8)
        Youtube (chapter 14)
        Rate Limiter (chapter 4)


## Continued Learning
To get an idea of the various problems in large scale systems, read "Chapter 8: The Trouble with Distributed Systems" in DDIA.

Additionally, this article ["Notes on Distributed Systems for Young Bloods"](https://www.somethingsimilar.com/2013/01/14/notes-on-distributed-systems-for-young-bloods/) gives great practical guidance and tips for operating large distributed systems on a daily basis. Bringing up some of these topics during an interview will get you brownie points.

With all the services that providers like AWS offers, it can seem like the cloud is the natural final destination for applications (hint - it's not). Here are two stories that talk about a company's journey [from Heroku to Digital Ocean to AWS](https://ghiculescu.substack.com/p/11-years-of-hosting-a-saas), and another company's journey [migrating off AWS to on-premise servers](https://world.hey.com/dhh/we-have-left-the-cloud-251760fb).