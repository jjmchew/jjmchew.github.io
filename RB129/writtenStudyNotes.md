### Study Guide Notes

---
<details >
<summary>Classes and objects</summary>

#### Classes
- are like "molds" that create objects:  basic outlines that define what an object should be made of and what it can do
- convention:  use CamelCase [source](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects)

- define a class by thinking about:  states and behaviours  [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#statesandbehaviors)
  - state is the data associated to an individual object, state is tracked by instance variables
  - behaviours are defined by the instance methods of a class;  instance methods defined by a class are available to all instances of that class
- the `initialize` method of a class is also called a *constructor* [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#initializinganewobject)

 
#### Objects

- anything that can be said to have a value is an object (e.g., numbers, strings, arrays, classes, modules) [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects)
  - methods, blocks, variables are not objects
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

- 

</details>

---

<details >
<summary>Use `attr_*` to create setter and getter methods</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
- `attr_accessor` creates both getter and setter methods based on the symbol object(s) passed in
- `attr_writer` creates only setter methods based on symbol object(s) passed in
- `attr_reader` creates only getter methods based on symbol object(s) passed in

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

- instance variables have '`@`' symbol in front of them [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#instancevariables)
  - instance variables only exist if the object instance exists;  helps to tie data to objects;  lives on until the object is destroyed
  - actual instance variables are not inherited (i.e., values stored in instance variables - state - will be different for each object which is an instance of the same class) [source](https://launchschool.com/lessons/b5948548/assignments/fd4d12cb)
- class variables have '`@@`' symbol in front of then [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classvariables)
  - class variables can be accessed within instance methods (e.g., `initialize` is an instance method)
- constants are defined using an uppercase letter at the beginning of the variable name (convention is to use all caps) [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#constants)
  - these are variables which you never want to change (during run-time)

</details>

---

<details >
<summary>Instance methods vs. class methods</summary>

- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#classmethods)
  - class methods are 'class-level' (vs 'object-level') and are called on the *class*
    - defined by adding 'self.' to the method definition
    - e.g., `def self.what_am_i`
    - used for functionality that doesn't pertain to individual objects (i.e., doesn't deal with state)

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


#### Encapsulation
- hiding functionality and making it unavailable to the rest of the code base [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- a form of data protection
- accomplished by creating objects and exposing interfaces (i.e., methods) to interact with those objects

#### Polymorphism
- ability for different data types to respond to a common interface [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
- can be accomplished through inheritance (and override)
- can also be accomplished by creating objects which have methods of the same name (so they can exhibit similar behaviours)


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

</details>

---

<details >
<summary>Method lookup path</summary>

- defines where Ruby will look to find a particular method when it is invoked [source](https://launchschool.com/books/oo_ruby/read/the_object_model#methodlookup)
- also called 'method lookup chain'
- can be determined by calling `ancestors` on the *class*
- standard parts of the lookup chain (at the end) are :  `Object`, `Kernel`, `BasicObject`

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
    - Ruby style convention:  avoid 'self' where not required
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

      p Walkable::count_steps(3)
      p Walkable.output_self
      p Walkable::CONST
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

- more notes here

</details>

---

<details >
<summary>Working with collaborator objects</summary>

- more notes here

</details>

---

<details >
<summary>Other notes</summary>

#### to_s method
- [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#theto_smethod)
  - is built-in to every class in Ruby (instance method), but can be overridden to define the output when `puts` is invoked on an object of the class
    - the `puts` method automatically calls `to_s` for any argument that is *not* an array.  For an array, it writes on separate line the result of calling `to_s` on each element of the array
    - `to_s` is also automatically called in string interpolation


</details>

---