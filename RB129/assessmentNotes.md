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


### Questions to answer:
- [x] what is the attr_* thing called?  Is it a method?  or something else?
  - A:  `attr_accessor` is a method, `attr_reader` is a method, `attr_writer` is a method
- [ ] constant resolution operator and namespace resolution operator : same? 
- [x] is `.new` a method?
  - A:  YES.  .new is definitely a method.
- [x] can CONSTANTS be defined in methods?
  - A:  appears no:  from testing, only in class def (outside of instance method def)
- [x] what does `.eql?` do?
  - A:  compare if 2 objects have the same value and are of the same class
- [x] what does `===` do?
  - A:  if argument1 is a group, would argument2 belong in that group

