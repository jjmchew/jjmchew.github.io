### OOP questions for studying
[source](https://docs.google.com/document/d/10Lg5TfMMqtADcHlPKiDUBqPDMB6Q63_Fs_uVGQG3ybQ/edit)

- reference answers from Erik:  https://www.notion.so/kiriyama/RB129-Practice-Problems-Set-2-ba6ca8fedbd04d248a2f52cd67933815


# What is OOP and why is it important?
- OOP or "Object Oriented Programming" is a programming paradigm created to address coding challenges with larger, more complex programs.  In these types of programs, increasing complexity created dependencies within the code where 1 change (or error) would ripple throughout the program making code hard to debug and maintain.  Encapsulation and polymorphism are 2 key concepts of OOP.  Well-written OOP code should be more reusuable and easier to update since the interactions between various parts of the code are specifically defined.
- Encapsulation is where parts of the code are segrated from other parts.  Each segregated segment of code is an object and the way in which objects can be interacted with is specifically defined.
- Polymorphism is where different code objects can respond to the same commands or method invocations.  This can help simplify the structure of the code and create re-usuable objects which can be more easily changed and updated.
- Inheritance is defining a hierarchical relationship between various objects to help define general behaviours and increasingly more granular behaviours, as appropriate - thus changes which may need to be made to all objects within an hierarchy are easier to make.

# What is a spike?
- A spike is an initial exploratory code structure used to test a possible solution to a coding challenge.  The spike will outline class structures for various objects and the relationships between those objects.  A spike might demonstrate class or instance methods, class inheritance, collaborator objects and required modules.
- Spikes are generally an initial braindump of ideas which can get organized into classes and methods.  They are not intended to be permanent code and code quality is not a concern.

# When writing a program, what is a sign that you’re missing a class?
- Generally, objects in code represent nouns within the problem space that you are coding a solution for.  If a particular noun keeps arising which is not associated with it's own unique object, it may be a sign that a new class could be created.
- For example, in a tic-tac-toe game, a "move" is a common noun.  Although a move may not be a physical object, it could become a class object within the code and this abstraction might help to simplify or clarify behaviours in the code.  These kinds of behaviours might include comparing moves or displaying moves in a user-friendly way.

# What are some rules/guidelines when writing programs in OOP?
- Generally, nouns within the problem space become classes and associated objects.  Similarly, verbs within the problem space generally become methods associated with those classes.  It's best to carefully consider the dependencies and collaboration between objects since unnecessary dependencies can make code more complex rather than simplify it.  Specifically considering which instance methods will be publically available is also a best practice to prevent unwanted manipulation of data within an object and to create consistency in how that data is interacted with.
- Creating a spike is a good practice to better understand the problem space and the relationships between various potential objects.
- Repeated nouns may be a sign that you're missing an object.
- Don't include the class name within instance method names.  This is to reduce repetition when invoking instance methods (e.g., `family.display_family` is not ideal, `family.display` would be much better).
- Generally, it's best to avoid long method invocation chains (e.g., `player.move.compare.display`), especially if the chain is dependent upon different collaborator objects.  Creating method invocation chains with more than 3 methods can make it harder to debug the code, especially if there is a potential for `nil` return values within the chain.
- Avoid design patterns - for now.  Premature optimization of code can increase complexity when it's not required.  Beginners should learn why and when to use various design patterns before you start to apply them.

---

# What is encapsulation? How does encapsulation relate to the public interface of a class?
- Encapsulation is the segregation of parts of the code from the rest of the code base.  The public interface of a class is a critical aspect of segregation since it defines how an object interacts with the rest of the code base.  Only public methods can be invoked by other objects within the code.

# What is an object? How do you initialize a new object/
# How do you create an instance of a class? What is instantiation? 

# What is a constructor method? 
# What is an instance variable, and how is it related to an object? 
# What is an instance method? What is the scoping rule for instance variables?




