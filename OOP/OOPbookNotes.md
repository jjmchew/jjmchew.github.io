### OOP notes

- encapsulation:  [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whyobjectorientedprogramming)
  - hiding functionality to make it unavailable to the rest of the code base
  - 'data protection' :  data cannot be manipulated or changed without obvious intention
  - 'interfaces' are *methods* which allow you to interact with *objects*
- objects are represented as 'nouns', methods describe represented behaviour
- polymorphism:  
  - allow different data to respond to a common interface
  - 'poly':  many;  'morph' : forms
  - e.g., could `move` (a method) on human, can, car, etc.
  - allows different object types to respond to the same method invocation in different ways (if desired) [source](https://launchschool.com/lessons/dfff5f6b/assignments/8c6b8604)
    - can occur through inheritance (all subclasses have the same method, but through override, those methods may do different things)
    - can occur through duck typing (unrelated objects both respond to the same method name, informal was to classify type to objects - i.e., on the basis of behavior) - i.e., we only care about behaviour, not class structure, etc.
      - need to create intent for polymorphism to occur (e.g., 'draw' blinds and 'draw' circle have no relationship and would likely not have the intent of being polymorphic)
- class:
  - parent is 'superclass'
  - sibling is 'subclass'
  - a class inherits from the superclass, subclasses inherit from class
  - can also 'mixin' a `Module`
- in Ruby:  methods, blocks, variables are NOT objects;  anything said to have a value *is* an object (e.g., numbers, strings, arrays, classes, modules)
    - [source](https://launchschool.com/books/oo_ruby/read/the_object_model#whatareobjects)
  - objects are created from classes, each object is an 'instance' of the class
  - define class names in CamelCase
  - define filenames in snake_case
- instantiation [source](https://launchschool.com/books/oo_ruby/read/the_object_model#classesdefineobjects)
  - creating a new object or instance from a class
- *module* is a collection of behaviours that is usuable in other classes via *mixins* [source](https://launchschool.com/books/oo_ruby/read/the_object_model#modules)
  - a little bit like cutting and pasting the method into the class
- method lookup [source](https://launchschool.com/books/oo_ruby/read/the_object_model#methodlookup)
  - a distinct path that Ruby follows to find a method that is called

- *state* refers to the data associated to an individual object;  *behaviours* are what an object can do
  - 'state' is tracked with *instance variables* : scoped at object (instance) level
  - 'behaviours' are defined by *instance methods* : available to all objects (instances) of that class
  - [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#statesandbehaviors)
- `initialize` method is a constructor
- language to use when describing initialization of instance variables:  https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#instancevariables
- `@name` in an object (instance) is an *instance variable*.  However, `@name` in a class is an *attribute signifier* [[source](https://medium.com/launch-school/towards-a-conceptual-model-of-object-oriented-programming-118eb971659f)]
- setter methods always return the the value passed in as as argument [source blue box](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethods)
  - other attempted return values are ignored
  - `attr_accessor` : creates getter and setter methods associated with symbol arguments
  - `attr_reader` : creates only getter methods associated with symbol arguments
  - `attr_writer` : creates only setter methods associated with symbol arguments
- notes:  getter and setter methods are not required;  can just define instance variables through constructor (`initialize`), however, can be defined for convenience
- `to_s` is automatically called on objects (classes) during string interpolation or when using `puts`
  - [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#theto_smethod)
- `self` [source](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part2#moreaboutself)
  - inside of an instance method:  references the instance(object) that called the method
  - outside of an instance method:  references the class, can be used to define class methods
  - 'self' refers to the calling objects [source](https://launchschool.com/exercises/09447cd6)
  - `self` outside of an instance method references the class (and **not** the instance) [Q17](https://launchschool.com/quizzes/5a6ad223)
- class inheritance vs mixin modules [source](https://launchschool.com/books/oo_ruby/read/inheritance#inheritancevsmodules)
  - for 'is-a' relationships (e.g., Dog is-a Mammal) use class inheritance
  - for 'has-a' relationahips (e.g., Dog has-a Tail) use 'interface' inheritance (e.g., use a module)
  - note:  cannot instantiate modules 
  - classes inherit from other classes;  objects **don't** inherit methods [Q2](https://launchschool.com/quizzes/5a6ad223)
  - modules share behaviours *not* attributes [Q3](https://launchschool.com/quizzes/5a6ad223)
- use `.ancestors` to check method lookup path (the path Ruby takes to find a method)
  - method lookup path [source](https://launchschool.com/books/oo_ruby/read/inheritance#methodlookup)
  - language around method lookup path:  [Q4](https://launchschool.com/lessons/dfff5f6b/assignments/69729798)
- an *interface* is how other classes and objects interact with a class and its objects [source](https://launchschool.com/books/oo_ruby/read/inheritance#privateprotectedandpublic)
- `private` methods : available only to other methods within the same class (instance)
- `protected` methods : available by other objects of the same class (other instances)
- using `super` without providing arguments will pass all arguments from the current method to the `super` method.  [source](https://launchschool.com/exercises/6a35145d)
  - arguments for superclass are always listed first
- collaborator objects  [[source](https://launchschool.com/lessons/dfff5f6b/assignments/4228f149)]
  - objects stored as state within another object are "collaborator objects" : they work in collaboration with the class they are associated with
    - e.g., `bob` has a collaborator object stored in `@pet` 
    ```ruby
    bob = Person.new("Robert")
    bud = Bulldog.new

    bob.pet = bud
    ```
  - the collaborative relationship exists in the design (or intention) of our code [[source](https://medium.com/launch-school/no-object-is-an-island-707e59ffedb4)]
  - the collaborator object must be assigned to another object, it's not the 'receving object that had an object assigned to it ([source q8](https://launchschool.com/quizzes/0762dc7a))

