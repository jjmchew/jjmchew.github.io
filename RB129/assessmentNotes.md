- written and interview are testing you on the same aspects - demonstrate and talk about concepts; read and parse code
- work on re-writing / describing each of the concepts in the study guide until you're very comfortable
- written - be able to read code and understand what the output is, access CONSTANTS, etc.
- check SPOT wiki - lots of materials are there; there is less info available for RB120
- can use `pp` as 'pretty print' to output more formatted output to the screen

### Study Guide 
- Classes and objects
- Use `attr_*` to create setter and getter methods
- How to call setters and getters
- Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
- Instance methods vs. class methods
- Method Access Control
- Referencing and setting instance variables vs. using getters and setters
- Class inheritance, [encapsulation](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming), and [polymorphism](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- [Modules](https://launchschool.com/lessons/dfff5f6b/assignments/2cf31cc8)
- Method lookup path
- self
    - [Calling methods with self](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#callingmethodswithself)
    - [More about self](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#moreaboutself)
- Reading OO code
- Fake operators and equality
- Working with collaborator objects


### sample problem
```ruby
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes 


# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

```

### sample problem
```ruby
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?   How could you fix any errors which might occur in the code?

```
- have a 'constant resolution operator' (`::`) : will traverse the inheritance chain (as per method lookup path)
  - 'name-space resolution operator' - looks the same as 'constant resolution operator', but they are used for different things
- to resolve constant - searches lexical scope first
- 3 different levels for a constant lookup:
  - look in lexical scope first :  surrounding structure of where the method is (like Russian nesting dolls - the structure that it's in - will search each enclosing level, but not the main scope)
  - inheritance chain (up the modules, classes)
  - main (outer-most) scope (top level)


- use of the term 'lexical' - what exactly does this refer to :  just the surrounding method, or also the class above it?
  - scope of module Describable is:
    ```ruby
    module Describable
      def describe_shape
        "I am a #{self.class} and have #{SIDES} sides."
      end
    end
    ```
    - modules don't have an inheritance chain on their own
    - when included, then they form part of the method lookup chain (inheritance chain)

- inheritance chain all encompasing (the structure you look in, also called the 'ancestors chain', method lookup path (the verb - the action to look in the chain)

### sample problem

```ruby

module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk


# What is the method lookup path used when invoking `#walk
```
- unless the module is included within a path explicitly, it won't be part of the method lookup path
  e.g.,
  ```ruby
  module GoodAnimals
    include Climbable

    class GoodDog < Animal
      include GoodAnimals
      include Swimmable
      include Danceable
    end
    
    class GoodCat < Animal; end
  end
  ```
    - in the example above, the mixin Climable would be part of look-up path

- can use modules as a 'containers for behaviours' or as 'name-space'


### key concepts
- encapsulation : use of 'method access control' (public private protected methods) to manage different kinds of interfaces and restrict access to functionality from the rest of the code base
  - sub classes can invoke protected method of one of its superclasses, but not vice versa
  - private methods are inherited by subclasses

- inheritance
- polymorphism : when the same method does different things
    - ducktyping
    - inheritance
      - class inheritance
      - interface inheritance

### Problems to review:
- [Lesson 4, Easy 1](https://launchschool.com/lessons/f1c58be0/assignments/a5cfd2ae)
    - Question 3
    - Question 4 :  confirm if `.new` is a method
- [Lesson 4, Easy 2](https://launchschool.com/lessons/f1c58be0/assignments/25448951)
    - Question 3
- [Lesson 4, Easy 3](https://launchschool.com/lessons/f1c58be0/assignments/98073b61)
    - Question 1 :  review cases!
- [Lesson 4, Hard 1](https://launchschool.com/lessons/f1c58be0/assignments/928366dd)
    - Question 1 : do again later for review
    - Question 2 : do again later for review
    - Question 3 : do again later for review
- [Debugging exercises Q10](https://launchschool.com/exercises/d1b5ac33)
    - do again later for review!
- [medium 1 q6](https://launchschool.com/exercises/e4b17f84)
    - could be good practice to do this again - given solution much cleaner
- [quiz 5](https://launchschool.com/quizzes/d0e9e9d9)
    - need to do this again - all of it could use review



### random notes:
  - can call `.instance_variables` to check for instance variables on class objects
  - ancestors are also called the 'lookup chain' [source q3](https://launchschool.com/lessons/f1c58be0/assignments/25448951)
  - remember to remove direct access to instance variables if getter methods are available
  - get comfortable with using super to modify things;  don't re-copy and recalculate things if you don't need to, especially if there is some hierarchy
- from TA [source](https://launchschool.com/posts/c279b82b) I think of things this way:

    - An instance variable is named by the class, but each object created from the class creates its own copy of the instance variable, and its value contributes to the overall state of the object. With this definition, note in particular that the instance variable is actually not part of the class; therefore, it can't be inherited. The subclass does know about the name, but it's merely using that name as a handle for the value it contains.

    - An ==attribute is an instance variable name and value==. More specifically, an attribute must be accessible outside the methods defined by the class; this means you need either a getter or setter method, or both. If both are missing, you only have an instance variable and a value (you can think of this as a "private attribute" if you want, but it doesn't really help). An attribute's getter and setter methods will be inherited by a superclass, but, the instance variable name and value behind the attribute do not participate in inheritance.

    - Every object has state. State is the collection of all instance variables and their values defined for an object. Since state is part of the object, not the class, state is not inherited.

    - The following list should keep you out of trouble, at least for now:
        - A subclass inherits the methods of the superclass.
        - Instance variables and their values are not inheritable.
        - Attribute getters and setters are methods, so they are inheritable
        - Attribute names and their values are just instance variables and values, so they are not inheritable
        State is a tied directly to individual objects, so is not inheritable.

### notes from Spot session (Jan 12)
- written and interview assessments are quite similar - for both assessments, be comfortable with concepts and syntax to be able to teach them to someone else - 
- our goal in written assessment:  concept-based questions and code-based questions;  see how well we understand and can explain;  in code - show we are fluent in syntax and structure of OOP in Ruby - explain and ilustrate with code
- interview is the same - should feel the same - explain concepts, expect us to illustrate what we're talking about;  be comfortable with explaining and coding;  should feel like a conversation
- coordination between explaining and illustrating with code:  try first explaining, then coding.  e.g., polymorphism
  - first talk about polymorphism and explain concisely
  - then show some simple code and describe and comment on things that seem relevant
- another way:  could create code example first, then explain your code
- another way:  could code and talk at the same time
- interview feels like a conversation - but there is a longer question at the end;  but try and keep a mental clock going - you may need to manage time on your own (can ask the TA about whether or not they had any other questions)
  - may help to start with a general answer - the method look-up path is.....,  then spend a bit of time talking about the code example


question:
```ruby
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak
```
- How to refer to the invocation of the `speak` method?
  - be specific with language:  "the method `speak` is invoked on the daisy object"
  - the instance method `speak` , that the `Cow` class inherits from the `Animal` class 
    - the `speak` instance method is defined in the `Animal` class

- polymorphism is ability to invoke a method of the same name on different class / object types
  - can use duck-typing : create the same method name in different classes
  - can use inheritance / override
  - can use modules (interface inheritance) - include modules on different objects and have access to same methods


### TA question

```ruby
class Dog
  def initialize(name)
    @name = name
  end
end

puppy = Dog.new('Benji')
another_puppy = Dog.new('Benji')

# What will this output? Why?

p puppy == another_puppy

```


### Notes from Jan 19, 2023 RB129 TA-led study session
- assessment: around 20 questions / 3 hrs
  - with 129 - both parts (written and interview) are similar - scope and structure is similar;  this is different from 109 assessment
  - 129 - can prepare for both parts in a similar way, since focus and scope are similar
  - competencies and skills LS is assessing for in written and interview are the same
  - code example:  we should be familiar with the code from 109:
  ```ruby
  num = 1;

  loop do
    num = 2
    break
  end

  puts num # 2
  ```
  - code example for 129:  there are more abstractions - need to have better mental models;  know what a class is, what the difference between a class and an object;  need to understand instance variables, understand the accessor and a getter method;  need to understand what's hidden away - be able to build mental models around abstract concepts (inheritance, encapsulation, etc.)
  - abstraction will come up a lot as we go through the program - need to think abstractly and work with abstractions
  - frameworks are another layer of abstraction over code 'underneath'
  - need to be able to explain concepts clearly and then create examples
  - need to be able to read code and understand the concepts and how they're working in the background
  - more like a conversation and use code examples to explain
  - it's less problem-solving in a PEDAC way
  - explain / update code and explain with your mental models
  ```ruby
  class Person
    attr_accessor :name

    def introduce
      puts "Hi, my name is #{name}."
    end
  end

  karl = Person.new
  karl.name = 'Karl'
  karl.introduce
  ```

- preparation for the written assessment: check topics of interest - concepts in course are important;  may be able to break things down a bit more - e.g., method access control : private, protected, public;  etc.  be prepared to explain concepts in isolation and get detailed;  make sure you have examples for all of them
- be able to write explanations and use code examples that support your explanations
- for interview, need to explain stuff out loud
- practice using code examples to support your explanations
- reading OOO code - is more of a code-based problem;  can be hard to prepare for;  can go back through coding assignments and break down the concepts and explain the code (e.g., is inheritance being used, is encapsulation used, etc.)
- worth practicing for interview mindset after the written assessment.  written test is open book (can refer to notes), but can't do that for interview;  explaining concepts out loud can be a bit harder, so worth practicing that
- ability to type code example along with explanations can be a bit harder - practice this
- interview:  there will be a bit of 'back and forth' - not just ask and sit quietly;  they're trying to assess the strength of your mental models - make sure you really explain a concept;  the interviewer may focus on a particular part of your answer or ask for more details, etc.  it's not just us presenting.
- a lot of the concepts might be related, so it's hard to think about how much detail to go into or where to stop.  don't be afraid to ask the interviewer if you've answered their question, etc.;  like a regular interview: "stop and check in to see how things are going"
- test mental models in 2 broad ways :  'theoretical' questions - explain a concept and use code to explain;     code-based questions:  they give code and ask you to modify or explain code

- what is the output and why?  How to update to make the `==` return true
```ruby
class Dog
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

  def ==(other)
    @name == other.name
  end
end

puppy = Dog.new('Benji')
another_puppy = Dog.new('Benji')

# What will this output? Why?

p puppy == another_puppy # true

```
`==` is a 'fake operator' - in other languages it might be an operator;  so could make things clear - talk about fake operators:  puppy.==(another_puppy)
- initially there is a `BasicObject` version, then we override it to create a Dog#== and then we call the String#==
- all 'custom objects' inherit from `Object`, `Kernel`, `BasicObject` - `==` compares object_id

- Another example:  "talk about method access control and provide a few examples to demonstrate different levels of method access control"
  - technically 'private', 'protected' 'public' : these are **methods**!  not keywords.  all the methods under the word are arguments to the method.  referring to 'private' as a keyword might lose you some marks - **be careful**

  - How many questions do we have in the interview?  We need to manage time a little bit?
    - there are 5 key topic areas:  hard to define how long these will take
    - quickest 129 interview took 25 minutes;  most people don't go over an hour;  so don't worry too much about time;  can ask interviewer about time
    - questions on code tend to take longer - they're more similar to problem-solving questions from 109;
    - don't worry too much about time

- what is output and why?
  ```ruby
  class Parent
    def hello(subject="World")
      puts "Hello, #{subject}"
    end
  end

  class Child < Parent
    def hello(subject)
      puts "How are you today?"
    end
  end

  child = Child.new
  child.hello('Bob')
  ```
  - follow-up question:  how could we change the code to output
  # Hello, Bob
  # How are you today?
  - follow-up follow-up question:  how could we change the code to output
  # Hello, World
  # How are you today?

- there are always a few concepts at play - helpful to 'name' those concepts (e.g., inheritance);  be careful of terminology 'parameters' vs 'arguments' - you might lose a few points,  e.g., `super()` - invoking this method and passing no *arguments*, not parameters.
- once you set context with explanations, don't need to repeat.  e.g., 'an object of the Child class' - only need to say that once


### Questions from Erik Wiens
```ruby
module Automotive
  TIRES = 6

  class Vehicle
    TIRES = 4
  end

  class Car < Vehicle
    def num_of_tires
      p Module.nesting
      TIRES
    end
  end
end

car = Automotive::Car.new
p car.num_of_tires
```
- scope of constants:  lexical scope - class definition doesn't get parsed (my interpretation)
- inheritance - multiple classes required?  e.g., Cat < Animal ?
- logical inheritance structure?
- duck-typing : dog bark, tree bark - not a great example





### Questions to answer:
- [x] what is the attr_* thing called?  Is it a method?  or something else?
  - A:  `attr_accessor` is a method, `attr_reader` is a method, `attr_writer` is a method
- [x] constant resolution operator and namespace resolution operator : same? 
  - A:  yes - name varies depending on the usage
- [x] is `.new` a method?
  - A:  YES.  .new is definitely a method.
- [x] can CONSTANTS be defined in methods?
  - A:  appears no:  from testing, only in class def (outside of instance method def)
- [x] what does `.eql?` do?
  - A:  compare if 2 objects have the same value and are of the same class
- [x] what does `===` do?
  - A:  if argument1 is a group, would argument2 belong in that group

- [x] Quiz 5, question 7:  Why wouldn't answer C work - theoretically, the `burger`, `side`, and `drink` getter methods could query the OPTIONS hash and return the appropriate value
  - A:  could work;  might still need to create a `cost` method for `MenuItem`
  - [ ] could be best to just try it.  ;)

- [x] review:  Object, Kernel, BasicObject - IN THAT ORDER!
- [ ] confirm practice problems question #3 : what is the lookup path from Describable?
  - A:  from modules, the lookup path will NOT include the class that included the module, it stops at the module and doesn't go further up (if namespace resolution operator isn't used)
  - lookup path for instance methods always starts with the calling object / class (i.e., will start at the bottom again)
    ```ruby
    module Describable
      SIDES = 1

      def describe_shape
        p self.class
        p self.class.ancestors
        new_method
        "I am a #{self.class} and have #{SIDES} sides."
      end
    end

    class Geometry
      SIDES = 2

      def new_method
        p "I'm part of class #{self.class}"
      end
    end

    class Shape < Geometry
      SIDES = 3
      include Describable

      def self.sides
        self::SIDES
      end
      
      def sides
        self.class::SIDES
      end

      # def new_method
      #   p "I'm part of class Shape"
      # end
    end

    class Quadrilateral < Shape
      SIDES = 4

      # def new_method
      #   p "I'm part of class Quadrilateral"
      # end
    end

    class Square < Quadrilateral; 
      SIDES = 5

      # def new_method
      #   p "I'm part of class Square"
      # end
    end

    p Square.sides 
    p Square.new.sides 
    p Square.new.describe_shape
    ```

- [x] practice problems question 7 : possible to 'reset' `@@wheels`?  Why isn't it reset when class `Vehicles` is interacted with?
  - A:  propose that class variables are assigned their values based upon the lexical (?) order in which classes or sub-classes define new values for the class variable.  i.e., if there is a subsequent re-definition of a class or a sub-class which inherits the class variable redefines the value of the class variable, then subsequent references to that class variable will contain the new value
  - [ ] How do you say this?
```ruby
class Vehicle
  @@wheels = 4
  
  def self.wheels
    @@wheels
  end

  def self.pizza
    "I like pizza"
  end
end

p Vehicle.wheels
p Vehicle.pizza

class Motorcycle < Vehicle
  @@wheels = 2
end

p Vehicle.wheels
p Motorcycle.wheels

class Car < Vehicle
  @@wheels = 3
end

p Vehicle.wheels

class Motorcycle
  def self.wheels
    p "new def!"
    @@wheels
  end
end

p Vehicle.wheels
p Motorcycle.wheels
p Car.pizza

class Cart #< Vehicle
  @@wheels = 7
end

p Vehicle.wheels
```

-[x] what happens when classes are 're-defined' later in the code?
  - A: class variables can have values re-defined;  class methods will not be 'lost', but can be over-written

- [ ] are inheritances available to all levels of sub classes?  i.e., multiple levels down
- [x] when string variables are passed into object constructors and assigned to instance variables, is it the VALUE that is assigned, or is it the actual OBJECT that is assigned?
  - A:  it is the actual OBJECT that is assigned.  Use of a mutating / destructive method on it will change the actual value referenced by other local variables pointing to the same object.
  ```ruby
  class Person
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      "My name is #{name.upcase!}."
    end
  end

  a = 'Bob'
  puts a.object_id

  bob = Person.new(a)
  puts bob.name
  puts bob
  puts bob.name

  puts a
  puts bob.name.object_id
  ```

- [x] Are class methods inherited?
  - A:  YES.  The 'reference' is automatically applicable to the names of sub-classes.  e.g., `Shape` defines the class method, but it can be called on the subclass `Triangle`
  ```ruby
  class Shape
    @@sides = nil

    def self.sides
      @@sides
    end

    def sides
      @@sides
    end
  end

  class Triangle < Shape
    def initialize
      @@sides = 3
    end
  end

  class Quadrilateral < Shape
    def initialize
      @@sides = 4
    end
  end

  p Triangle.sides
  p Triangle.new.sides
  ```

- [ ] Practice Problems: Question 19 - why not use getters and setters all the time?
- [ ] Practice Problems: Question 20 - difference between state and behaviours
  - [x] What happens if the same (e.g.) string object is used to instantiate multiple custom objects? Then the state would be dependent on the value of that object
    - A:  yes.
    ```ruby
    class Person
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end

    a = "Bob"

    thing1 = Person.new(a)
    thing2 = Person.new(a)

    p thing1.name
    p thing2.name

    a.upcase!

    p thing1.name
    p thing2.name
    ```

- [ ] Practice Problems:  Question 26 - instance variable scope - w/ inheritance and mixins :  can modules access instance variables?
  - [ ] what is the right language to use for this - how to talk about it?

- [x] in the default representation of custom class object (format #<[ClassName]:[string]>), what does [string] represent?
  - A: "object's class and an encoding of the object id" [answer to q6](https://launchschool.com/lessons/f1c58be0/assignments/a5cfd2ae)
- [ ] "private", "public", "protected" :  are these 'keywords'?  LS notes refer to them as "access modifiers"
- [x] can subclass invoke private methods?  Is this access inherited (how many levels?)
  - A:  yes - tested
- [ ] review definitions of encapsulation, inheritance
    - A:  encapsulation :  about intentionality - to prevent inadvertent changes
- [ ] review - Why OOP?
  - A:  also check [q10](https://launchschool.com/lessons/f1c58be0/assignments/25448951)
- [x] is 'super' a 'keyword'?  or a method?  What is it?
  - A : super is a **keyword**
  - A : super is also a method that can be invoked [source](https://launchschool.com/exercises/6a35145d)
- [x] practice problems Q44 : instance 1 of `self` - what does it refer to?  Does it do anything?  Is it useful?
  - A : code in that spot will be executed anytime the class is 'interacted' with (e.g., instantiate an object, etc.).  However, that `self` is not particularly useful
- [ ] practice problems q47 : beware of nested inheritance!  Need to check each 'super'
- [X] practice problems q49 : double check methods - 'Integer', 'Array', 'Range'?
  - A: def use `===` operator ('three-quel' operator), the specific `===` uses will depend on the data type being compared to
    - the 2nd one `10, 20, 30` is NOT an array!  
- [ ] practice problems q50 : double check scope of various variable types (constant, class, instance)