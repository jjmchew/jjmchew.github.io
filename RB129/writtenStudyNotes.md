### Study Guide Notes

---
<details >
<summary>Classes and objects</summary>

#### Classes
- are like "molds" that create objects:  basic outlines that define what an object should be made of and what it can do
- convention:  use CamelCase [source](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects)

- define a class by thinking about:  states and behaviours  [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#statesandbehaviors)
  - state is the data associated to an individual object, state is tracked by instance variables
    - state is a collection of all 'instance variables' [source](https://medium.com/launch-school/towards-a-conceptual-model-of-object-oriented-programming-118eb971659f)
  - behaviours are defined by the instance methods of a class;  instance methods defined by a class are available to all instances of that class
- class definitions also referred to as defining behaviours and *attributes* [source](https://medium.com/launch-school/towards-a-conceptual-model-of-object-oriented-programming-118eb971659f)
  - classes have *attribute signifiers* within their definitions, not strictly 'instance variables'

- the `initialize` method of a class is also called a *constructor* [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#initializinganewobject)

- instance variables don't exist prior to an object being created and a value assigned to them [source](https://medium.com/launch-school/towards-a-conceptual-model-of-object-oriented-programming-118eb971659f)
  - instance variables that have been defined, but haven't yet been initialized (i.e., a specific value assigned to them) have the value `nil`

- 'getters' and 'setters' are 'contingent properties' of a class - need to be defined appropriately to be available [source](https://medium.com/launch-school/towards-a-conceptual-model-of-object-oriented-programming-118eb971659f);  not available by default
  - gives programmer flexibility to define what can/can't be changed (encapsulation)

#### Objects

- anything that can be said to have a value is an object (e.g., numbers, strings, arrays, classes, modules) [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects)
  - methods, blocks, variables are not objects
  - `if` statements, argument lists are also NOT objects [source](https://launchschool.com/lessons/d2f05460/assignments/9cadd494)
- objects are created from classes; objects are instances of the class they are created from
- can call `.class` on each object to see what class it is an instance of
- creating a new object from a class is 'instantiation' [source](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects)
  - =="we create an instance of the `GoodDog` class and assign the local variable `sparky` to it".==  `sparky` is an object or instance of the class `GoodDog`.
    ```ruby
    class GoodDog; end

    sparky = GoodDog.new
    ```
  - the string `'Sparky'` is passed from the `new` method through to the `initialize` method and is assigned to the local variable `name`.  Within the constructor (or `initialize` method) we set the instance variable `@name` to `name` (the string `'Sparky'` is assigned to the `@name` instance variable)
    ```ruby
    class GoodDog
      def initialize(name)
        @name = name
      end
    end

    sparky = GoodDog.new("Sparky")
    ```
- [source](https://launchschool.com/lessons/b5948548/assignments/fd4d12cb)
  - attributes
      - characteristics that make up an object (e.g., for a `Laptop` object: colour, make, dimensions, didsplay, etc.)
      - are generally accessed and manipulated from outside the object
      - could refer to just characteristic names OR names *and* values attributed to the object
    - generally refers in Ruby to *instance variables*, which generally have accessor methods (but these aren't required)


</details>

---

<details >
<summary>Use `attr_*` to create setter and getter methods</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
  - the `attr_accessor` *method* is used to automatically create getter and setter methods
    - it takes 1 or more symbol(s) as arguments and creates methods for getters and setters

- `attr_accessor` *method* creates both getter and setter methods based on the symbol object(s) passed in
- `attr_writer` *method* creates only setter methods based on symbol object(s) passed in
- `attr_reader` *method* creates only getter methods based on symbol object(s) passed in

</details>

---

<details >
<summary>How to call setters and getters</summary>

- called like any other method:  [instance].[instance method name]
- by convention, method name is the same as instance variable it returns (e.g., `name` and `name=`)
- getters are methods used to return instance variables [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
- setters are methods used to change the value of instance variables
  - need to be defined as [name]=  e.g., `def set_name=(argument_name)`
  - Ruby syntactical sugar lets us call it without brackets:  `sparky.set_name = "new name"`
  - note:  setters always return the value that is passed in as an argument (in custom setters, any other return value defined will be ignored)

</details>

---

<details >
<summary>Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope</summary>

##### Instance Variables
- instance variables have '`@`' symbol in front of them [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#instancevariables)
  - instance variables only exist if the object instance exists;  helps to tie data to objects;  lives on until the object is destroyed
  - actual instance variables are not inherited (i.e., values stored in instance variables - state - will be different for each object which is an instance of the same class) [source](https://launchschool.com/lessons/b5948548/assignments/fd4d12cb)
  - instance variables need to be initialized within instance methods [source](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7)
    - if initialized within the class, they are 'class instance variables' - entirely different
  - scope is at object level, accessible to all instance methods (without being explicitly passed in) [source](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7)
  - sub classes inherit the definitions for instance variables [source](https://launchschool.com/lessons/d2f05460/assignments/b8928e96)
    - uninitialized instance variables will still return `nil`
    - any uninitialized instance variable (even if not previously defined) will return `nil` (based upon experimentation)
    - instance variables and their values are NOT inherited [source](https://launchschool.com/lessons/d2f05460/assignments/b8928e96)

##### Class Variables
- class variables have '`@@`' symbol in front of them [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classvariables)
  - class variables can be accessed within instance methods (e.g., `initialize` is an instance method)
  - these are scoped at the class level [source](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7)
    - can be accessed by class methods as long as the class variable has been initialized prior to being called
  - class variables are accessible to sub-classes [source](https://launchschool.com/lessons/d2f05460/assignments/b8928e96)
    - NOTE:  sub-classes can re-define class variables and this will affect all instances of the class / super-class
    - e.g., are available to the class 'hierarchy-level' - not just available to the same class; available to all sub classes
      ```ruby
      
      ```
  - from testing:  can assign class variables anywhere within the class (i.e., within methods is also okay)
    - NOTE:  if class variable is initialized within an instance method (e.g., `initialize`) and that method hasn't yet been executed (e.g., no instance of class has been created and thus `initialize` executed), there will be an error (NameError) when trying to reference that class variable
    - for example:  need to instantiate `GoodDog` before class method `how_many` will work
    ```ruby
    class GoodDog
      TEETH = 23
      
      def initialize(name)
        @@legs = 4
        @name = name
      end
      
      def self.how_many
        p @@legs
        p TEETH
      end
    end

    sparky = GoodDog.new('Sparky') # without this line, the next doesn't work

    GoodDog.how_many

    p GoodDog::TEETH
    ```

##### Constants
- constants are defined using an uppercase letter at the beginning of the variable name (convention is to use all caps) [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#constants)
  - these are variables which you never want to change (during run-time)
  - have *lexical scope* : where the constant is defined in the source code determines where it is available [source](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7)
    - the surrounding code structure is the lexical scope
    - can use "namespace resolution operator" `::` to access other classes (outside of lexical scope)
- Ruby attempts to resolve constants first through: [source](https://launchschool.com/lessons/d2f05460/assignments/b8928e96)
  - lexical scope (which doesn't include the main / top-level scope)
  - then inheritance hierarchy (i.e., ancestors) of the **structure that references the constant**
  - main scope is checked last
- example [source](https://launchschool.com/lessons/d2f05460/assignments/b8928e96):
  - module defines a constant; that module is included in a class; an instance method from a super-class is invoked which references the constant defined in the module. However, the module included in the class is NOT accessible from the *super-class* where the method was invoked
  ```ruby
  module FourWheeler
    WHEELS = 4
  end

  class Vehicle
    def maintenance
      "Changing #{WHEELS} tires."
    end
  end

  class Car < Vehicle
    include FourWheeler

    def wheels
      WHEELS
    end
  end

  car = Car.new
  puts car.wheels        # => 4
  puts car.maintenance   # => NameError: uninitialized constant Vehicle::WHEELS
  ```
  - from testing:  should not assign *constants* within methods (class or instance) - only within the class
</details>

---

<details >
<summary>Instance methods vs. class methods</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classmethods)
  - class methods are 'class-level' (vs 'object-level') and are called on the *class*
    - defined by adding 'self.' to the method definition
    - e.g., `def self.what_am_i`
    - used for functionality that doesn't pertain to individual objects (i.e., doesn't deal with state)
- [source](https://launchschool.com/lessons/d2f05460/assignments/b4f9e5b7)
  - can refer to class methods as (e.g.,) `Person::greetings`
    ```ruby
    class Person
      GREETINGS = ['Hello', 'Hi', 'Hey']

      def self.greetings
        GREETINGS.join(', ')
      end

      def greet
        GREETINGS.sample
      end
    end

    puts Person.greetings          # => "Hello, Hi, Hey"
    puts Person.new.greet          # => "Hi" (output may vary)
    ```
</details>

---

<details >
<summary>Method Access Control</summary>

- [source](https://launchschool.com/books/oo_ruby/read/inheritance#privateprotectedandpublic)
  - use **access modifiers** to implement *method access control*
  - `public`
    - method is available to anyone who knows the class or object's name (depending on whether it's a class or instance method)
    - these methods form the 'interface' of the class
  - `private`
    - methods that do work within a class, but don't need to be available to the rest of the program
    - before Ruby 2.7:  cannot call a private method using `self.method_name` (this syntax used to call public methods), can only call it using `method_name` (i.e., within the current object)
    - from Ruby 2.7: can use `self.method_name` to call private methods (but only within the current object)
  - `protected`
    - allow access by other class instances (e.g., when used for comparators)
    - similar to `private` methods - they cannot be invoked from outside of the class, but other instances of the same class (*or subclass*) can invoke protected methods
      - note *super class* cannot invoke protected methods of its subclass

</details>

---

<details >
<summary>Referencing and setting instance variables vs. using getters and setters</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
  - using `@` references the instance variable directly
  - to use getter, remove `@`
  - to use setter, use `self.` ("to disambiguate from creating a local variable")
    - Ruby style convention:  avoid 'self' where not required
- best to consistently use getter (and setter) methods (once defined) to create a single access to instance variables, which makes update of code easier / more consistent

</details>

---

<details >
<summary>Class inheritance, encapsulation, and polymorphism</summary>

#### Class inheritance
- where a class inherits the behaviours of another class (a *superclass*) [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- use the '`<`' symbol to indicate inheritance [source](https://launchschool.com/books/oo_ruby/read/inheritance#classinheritance)
  - all methods from superclass are available in subclass
  - if a method in a subclass has the same name as a method in the superclass it will *override* the method in the superclass
    - i.e., when called, the method defined in the class of the calling object will be executed
    - use `super` to execute the code of a method with the same name in a superclass
      - this is common in `initialize` methods
      - super will automatically forward the arguments that were passed to the method from which `super` is called if no arguments are specified [source](https://launchschool.com/books/oo_ruby/read/inheritance#super)
      - can use `super()` to call the method in superclass with no arguments specified
- check common `Object` methods to prevent accidental method overriding [source](https://launchschool.com/books/oo_ruby/read/inheritance#accidentalmethodoverriding)
  - e.g., `.send`, `.instance_of`, `display`, `inspect`, `trust`, `method`, `methods`
- can only inherit from 1 class [source](https://launchschool.com/books/oo_ruby/read/inheritance#inheritancevsmodules)
- class inheritance is typically used for "is a" relationships (e.g., Dog is a Mammal)
- can call `.superclass` on a class to find the superclass [source](https://launchschool.com/books/oo_ruby/read/inheritance#accidentalmethodoverriding)
- Ruby has only *single inheritance* (can only inherit from 1 super class) [source](https://launchschool.com/lessons/dfff5f6b/assignments/2cf31cc8)

#### Encapsulation
- hiding functionality and making it unavailable to the rest of the code base [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- a form of data protection
- accomplished by creating objects and exposing interfaces (i.e., methods) to interact with those objects
- can use method access control to achieve this [source](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)

#### Polymorphism
- ability for different data types to respond to a common interface [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- ability of different object types to respond to the same method invocation, often, but not always, in different ways [source](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)
  - different data can respond to a common interface
- can be accomplished through inheritance (and override) [source](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)
  - can define a generic (empty, if necessary) method in the superclass which is inherited by all subclasses
  - as required, override the generic method to define subclass-specific behaviours (e.g., `move` method of class `Animal` may be diferent for `Fish` class vs `Coral` class)
- can also be accomplished by creating objects which have methods of the same name (so they can exhibit similar behaviours) [source](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)
  - "duck-typing" : when *unrelated* types both respond to the same method name, take the same number of arguments
  - methods should be intentionally related by design to be polymorphic (e.g., `draw` in `Circle` class should NOT be related to `draw` in `Blinds` class)


</details>

---

<details >
<summary>Modules</summary>

- a collection of behaviours that is usuable in other classes (via *mixins*) [source](https://launchschool.com/books/oo_ruby/read/the_object_model#modules)
- mixin by invoking the `include` method
- modules can help with keeping code DRY (don't repeat yourself) [source](https://launchschool.com/books/oo_ruby/read/inheritance#mixinginmodules)
  - i.e., can share behaviours (methods) among classes that don't share common inheritance
- [source](https://launchschool.com/books/oo_ruby/read/inheritance#inheritancevsmodules)
  - using modules to create common behaviours among different classes is sometimes called **interface inheritance** 
  - interface inheritance is typically used for "has a" relationships (e.g., Dog has an ability to swim)
  - objects cannot be created from modules
- also used for 'name-spacing' [source](https://launchschool.com/books/oo_ruby/read/inheritance#moremodules)
  - name-spacing is organizing (grouping) similar classes or methods under a module (i.e., use module as a 'container' for classes)
  - grouping classes:
    ```ruby
    module Mammal
      class Dog
        def speak(sound)
          p "#{sound}"
        end
      end

      class Cat
        def say_name(name)
          p "#{name}"
        end
      end
    end
    # invoke using:
    buddy = Mammal::Dog.new
    kitty = Mammal::Cat.new
    buddy.speak('Arf!')           # => "Arf!"
    kitty.say_name('kitty')       # => "kitty"
    ```
  - grouping methods:
    ```ruby
    module Mammal
      def self.some_out_of_place_method(num) # note these are like 'class' methods, but `self` refers to the module, not the class
        num ** 2
      end
    end
    # invoke using:
    value = Mammal.some_out_of_place_method(4)  # preferred method
    value = Mammal::some_out_of_place_method(4) # alternate method

    ```
- modules are Ruby's answer to multiple inheritances (not allowed) - but can *mixin* a module [source](https://launchschool.com/lessons/dfff5f6b/assignments/2cf31cc8)
  - mixing in a module is equivalent to cutting and pasting those methods into a class
</details>

---

<details >
<summary>Method lookup path</summary>

- defines where Ruby will look to find a particular method when it is invoked [source](https://launchschool.com/books/oo_ruby/read/the_object_model#methodlookup)
- also called 'method lookup chain'
- can be determined by calling `ancestors` on the *class*
- standard parts of the lookup chain (at the end) are :  `Object`, `Kernel`, `BasicObject`

- [additional source q 4](https://launchschool.com/lessons/dfff5f6b/assignments/69729798)

- [source](https://launchschool.com/books/oo_ruby/read/inheritance#methodlookup)
  - current class first
  - then included modules (from last defined to first defined)
  - then superclasses
  - then included modules of superclasses
  - then 'Object', 'Kernel', 'BasicObject'
- Ruby will look until it finds the required method, and then look no further (hence creates 'override' behaviour)

</details>

---

<details >
<summary>self</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
  - to use setter, use `self.` ("to disambiguate from creating a local variable")
    - Ruby style convention:  avoid 'self' where not required [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#callingmethodswithself)
- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#moreaboutself)
    - `self` will refer to different things depending on where it is used
    - when an instance method uses `self`, it references the **calling object**
      - e.g., when calling setter methods within the class to distinguish from local variables      
      - i.e., from within an instance method, calling `self.name=` is the same as calling `sparky.name=` from outside the class
    - `self` for class method definitions:  when inside a class, but outside an instance method, `self` references the class name
- [source](https://launchschool.com/books/oo_ruby/read/inheritance#moremodules)
    - `self` in a module refers to the module
    - e.g., 
      ```ruby
      module Walkable
        CONST = self
        def self.count_steps(num)
          "I walked #{num} steps"
        end

        def self.output_self
          self
        end
      end

      p Walkable::count_steps(3) # "I walked 3 steps"
      p Walkable.output_self     # Walkable
      p Walkable::CONST          # Walkable
      ```

</details>

---

<details >
<summary>Reading OO code</summary>

- more notes here

</details>

---

<details >
<summary>Fake operators and equality</summary>

- using `==` : it's a(n instance) method ('fake operator') [source](https://launchschool.com/lessons/d2f05460/assignments/9cadd494)
  - will compare objects based upon their 'value', or however the `==` has been defined (Ruby core library defines `==` to compare values for Array, String, Integer, etc.)
  - original `==` method is defined in `BasicObject` class : default for this is to determine if 2 objects are the same object
  - re-defining `==` method also gives you the `!=` method
  - the `===` method is implicitly used in `case` statements (e.g., used to compare ranges in `case` statements)
    - `===` asks: if argument1 is a group, would argument2 belong in that group? returns `true` or `false` (note:  Ruby `===` is VERY different than JavaScript `===`)
    - see Q7 Quiz 3 [link](https://launchschool.com/quizzes/ac459ccb) : case statements use `===` to check equality, technically not `==`
- to determine if the actual object is the same (and not just the value), can use `equal?` method [source](https://launchschool.com/lessons/d2f05460/assignments/9cadd494)
  - e.g., `str1.equal? str2`
- `.eql?` method is used in comparisons by `Hash` class : determines if 2 objects contain the same value and if they're of the same class

- fake operators reference table : https://launchschool.com/lessons/d2f05460/assignments/9a7db2ee
  - Fake operators (are methods): `[]` `[]=` `**` `==` `!` `~` `+` `-` `*` `%` `/` `+@` `-@` `<<` `>>` `&` `^` `|` `<=` `<` `>` `>=` `<=>` `===` `!=` `=~` `!~`
  - NOT methods: `.` `::` `&&` `||` `..` `...` `? :` `=` `%=` `/=` `-=` `+=` `|=` `&=` `>>=` `<<=` `*=` `&&=` `||=` `**=` `{`
  - any fake operators can be redefined in custom classes
  - make sure that re-definitions make sense and are consistent with expected Ruby behaviour (e.g., don't redefine `==` and `!=` and create inconsistencies, don't make `<<` not add to a collection, ensure `+` when used for collections returns the *same object type* along with a concatenation of elements)
</details>

---

<details >
<summary>Working with collaborator objects</summary>

- collaborator object:  an object that is stored as state within another object [source](https://launchschool.com/lessons/dfff5f6b/assignments/4228f149)
  - these objects work in conjunction / collaboration with the class they are associated with
  - collaborator objects are usually custom objects (defined by the programmer, but can be any object - strings, integers, arrays, hashes since these are all objects)
  - collaborator objects represent connections between various actors in programs
  - e.g.,  `bud` is the collaborator object - it's part of the state of `bob`
    ```ruby
    class Person
      attr_accessor :name, :pet

      def initialize(name)
        @name = name
      end
    end

    bob = Person.new("Robert")
    bud = Bulldog.new             # assume Bulldog class from previous assignment

    bob.pet = bud
    ```
- collaboration is a way of modelling (associative) relationships between different objects [source](https://medium.com/launch-school/no-object-is-an-island-707e59ffedb4)
  - *not* inheritance relationships
  - relationship may be defined within `initialize` method, or elsewhere within the class
  - the actual collaboration occurs when the actual object is added to the state:
      - may be set within `initialize` method
      - could also use a setter method elsewhere in the program to define the collaborator object
</details>

---

<details >
<summary>Other notes</summary>

- typical approach to OOP: [source](https://launchschool.com/lessons/dfff5f6b/assignments/180e267e)
  - write a textual description of the problem or exercise
  - extract the major nouns and verbs from the description
  - organize and associate the verbs with the nouns
  - nouns are the classes and the verbs are the behaviours or methods
  - example - TTT:  don't think about game flow initially, focus on organizing / modularizing code into cohesive class structure

- OOP architecture [source](https://launchschool.com/lessons/dfff5f6b/assignments/ff0b0ded)
  - there are always trade-offs between flexible code and indirection
  - i.e., if all code is in place it's not very flexible;  splitting code up can make it more flexible and easier to maintain, but's it's harder to understand (may have more classes, etc.)
  - a 'spike' is exploratory code to play around with the problem [source](https://launchschool.com/lessons/dfff5f6b/assignments/d632a90f)
    - don't worry about code quality; just play - an initial brain dump
  - if nouns keep coming up, it might be an indication a new class is required (e.g., `Move` in rock, paper, scissors)

#### CRC cards
- Class Responsibility Collaborator (CRC) cards [source](https://launchschool.com/lessons/dfff5f6b/assignments/3b584726):
  - list the 'class name' (indicate super / sub classes)
  - underneath:  'responsibilities' (public behaviours / methods), 'collaborators' (other objects)
  
#### to_s method
- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#theto_smethod)
  - is built-in to every class in Ruby (instance method), but can be overridden to define the output when `puts` is invoked on an object of the class
    - the `puts` method automatically calls `to_s` for any argument that is *not* an array.  For an array, it writes on separate line the result of calling `to_s` on each element of the array
    - `to_s` is also automatically called in string interpolation

#### exceptions
- [source](https://launchschool.medium.com/getting-started-with-ruby-exceptions-d6318975b8d1)
  - exceptions are raised when code behaves unexpectedly
  - Ruby has built-in classes to handle exceptions (abbreviated list):
    - `Exception`
      - `ScriptError`
        - `SyntaxError`
      - `SignalException`
        - `Interrupt`  (e.g., using `ctrl-c` to exit a program)
      - `StandardError`
        - `ArgumentError`
        - `NameError`
          - `NoMethodError`
        - `RuntimeError`
        - `TypeError`
        - `ZeroDivisionError`
      - `NoMemoryError`
  - best to handle errors in a 'specific' way and not just handle all errors at `Exception`-level
  - can handle with `begin` / `rescue` block:
    ```ruby
    begin
      # code to try
    rescue TypeError  # if specific error type is not defined, will default to `StandardError`
      # action to take for rescue
    rescue NoMethodError, ArgumentError # optional to list additional rescue blocks for specific error types, or multiple error types separated w/ comma
      retry ...  #can add conditional or other code here to be executed
    rescue ZeroDivisonError => e
      puts e.message # standard exception object will include `Exception#message` and `Exception#backtrace`
    ensure
      # code here always runs (w or w/o exception);  clean up code can go here
      # note:  if an exception is raised here, it will 'mask' earlier exceptions
    end
    ```
  - can use `Kernel#raise` to throw custom errors
    - will default to `RuntimeError` unless otherwise specified (e.g., `raise TypeError.new("message here")` )
  - can create custom exception classes that inherit from built-in exception classes (best to subclass from `StandardError`):
    - e.g., `class ValidateAgeError < StandardError; end`
    - will include existing objects defined under `StandardError` including `Exception#message` and `Exception#backtrace`


#### `Struct`
- classes that contain ONLY data and no behaviours can be defined using `Struct` [source](https://launchschool.com/lessons/97babc46/assignments/348a722b)
  ```ruby
  Pet = Struct.new('Pet', :kind, :name, :age)
  asta = Pet.new('dog', 'Asta', 10)
  cocoa = Pet.new('cat', 'Cocoa', 2)
  p asta.age          # => 10
  cocoa.age = 3
  p cocoa.age         # => 3
  ```

</details>

---