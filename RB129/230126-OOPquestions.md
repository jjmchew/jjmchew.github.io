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
- Encapsulation is the segregation of parts of the code from the rest of the code base.  This includes hiding bit of functionality or the internal representation of an object and making it unavailable to the rest of the code base. 
- The public interface of a class is a critical aspect of segregation since it defines how an object interacts with the rest of the code base.  Only public methods can be invoked by other objects within the code.  Thus, the public interface is the way in which methods and properties of an object are exposed to the rest of the code base.

# What is an object? How do you initialize a new object / How do you create an instance of a class? What is instantiation? 
- An object is like a package of code that stores data and can be interacted with in specific ways.
- Objects are created from classes.  Specifically, the `BasicObject::new` method is invoked on a class (with the required  arguments passed in) and a new object of the class on which `new` was invoked will be created.
- Creating an instance of a class (i.e., a new object of that class) is 'instantiation'.

# What is a constructor method? 
- A constructor method is a method that is automatically invoked upon instantiation of a new object.  In Ruby, it's the `initialize` method, which is automatically invoked (if it has been defined) when a new object is instantiated.

# What is an instance variable, and how is it related to an object? 
- An instance variable is a type of variable which is associated with an object.
- Instance variables are unique to each object and the values referenced by those instance variables are not inherited.
- The instance variables associated with each object are defined by the class, but the actual instance variable does not exist until it has been initialized within a specific object.

# What is an instance method? What is the scoping rule for instance variables?
- An instance method is a method that can be invoked on a specific object (and can retrieve or assign instance variables).
- Instance variables are scoped at the object-level and are available to all instance methods of that object without needing to be explicitly passed into that instance method as an argument.

# How do you see if an object has instance variables?
- If the `inspect` method is invoked on an object, any instance variables associated with that object will be displayed.
- You can also invoke `instance_variables` on an object to get a list of the instance variables belonging to that object.

# What is a class? What is the relationship between a class and an object? 
- A class is like a blueprint for an object - it defines what instance (or class) variables may exist and how to interact with those variables.  Classes are used to instantiate new objects of that class.  Each object will inherit the behaviours (instance methods) defined by the class and can initialize instance variables consistent with the class definition.

# How is defining a class different from defining a method?
- Defining a class creates a blueprint for an object - something that can hold and manipulate data.  Defining a method creates a set of instructions for Ruby that can be executed and may evaluate to a value.
- Defining a class uses the reserved word 'class' instead of 'def'.  By convention, classes are named with CamelCase whereas methods are named with snake_case.

# When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts? 
- State refers to the collective values of the instance variables associated with an object.  Different objects will have different instance variables, which generally have different values.
- Behaviours are the instance methods of an object.  These define what an object can "do", often with the data stored in the instance variables.  All instances of the same class will have the same instance behaviours.
- State is not inherited, whereas behaviours are.

# Objects do not share state between other objects, but do share behaviors. The values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviors) defined in the class. Explain the idea that a class groups behaviors.
- The instance variables available within an object and the instance methods of that object are defined by the associated class. Since all objects of the same class inherit the same behaviours, using a class is an easy way to group behaviours.

# How do objects encapsulate state?
- Objects encapsulate state within the instance variables defined for the class.  The way in which other objects or code can interact with that state is defined through the instance methods of the class, specifically the public methods. Through the application of method access control, undesired changes to state (the values of the instance variables of an object) can be prevented.

# What is the difference between classes and objects?
- Classes are the blueprints or 'molds' that define objects.
- Objects are the product or result of creating a new object from a class (instantiation of a new object).

# How can we expose information about the state of the object using instance methods?
- Methods which expose the information contained in instance variables are a specific type of instance method referred to as 'getter' methods.  A getter method can specific what information is available to what kinds of objects and what form that information is presented in.

# What is a collaborator object, and what is the purpose of using collaborator objects in
- A collaborator object is an object that is stored within the state of another object.  
- Collaborator objects are used to indicate the relationship between different object types.


# Can super be used to invoke methods more than 1 "parent" up the ancestor chain?
- yes.
- for example: 
```ruby
class Animal
  def move
    "I'm a moving Animal"
  end
end

class Dog < Animal
  def move
    "I'm a moving Dog"
  end
end

class Dog2 < Dog
end

class Bulldog < Dog2
  def move
    super + " I'm a moving Bulldog"
  end
end

p Bulldog.new.move
```

# Accidental method overriding
- Accidental method overriding occurs when an instance method defined for a custom class has the same name as an instance method of an ancestor class - typically from the `Object` class.  The `Object` class contains instance methods such as `display`, `send`, `inspect`, `freeze`, `extend` which all have a specific purpose and may be commonly used.  It's a good idea to avoid naming instance methods with these names to prevent accidental method overriding.

# Can uninitialized class variables be referenced?
- e.g., 
```ruby
class Person
  # @@legs = 2

  def self.legs
    @@legs
  end
end

p Person.legs
```
- no.  Ruby returns an error (NameError)
