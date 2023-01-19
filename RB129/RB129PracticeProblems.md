### [RB129 practice problems (spot wiki)](https://docs.google.com/document/d/10JvX-ArkfF8fIWQu8wPaYt7JJHrv_5E0gM0I2uPirwI/edit)

1
What is the output and why? What does this demonstrate about instance variables that differentiates them from local variables?

```ruby
class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name
```
- The output is `nil` since the instance variable `@name` has not yet been initialized and assigned.  This is unique behaviour from local variables:  if a local variable that has not been initialized and assigned is referenced, an error will be raised.  Instance variables that have not been initialized and assigned return `nil` by default.

---

2
What is output and why? What does this demonstrate about instance variables?

```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim
```

- `nil` will be output.  When the `swim` instance method is called on the `Dog` object assigned to the local variable `teddy`, the value of the instance variable `@can_swim` is `nil`.  Since `nil` is a falsey value, the the if conditional evaluates to `false` and the string `"swimming!"` is not returned by the instance method.  Instead, `nil` is returned by the instance method which is then passed as the argument into the `p` method invocation, which outputs `nil`.

---

3
What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?

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
```

- The first line of output will be `4`, the second line of output will be `4`, and the last line of output will be an error.  The error will be raised since the module `Describable` does not define a constant `SIDES` and ==the lookup path from `Describable` will be `Object`, `Kernel`, `BasicObject`==.  The lookup path will not contain any definitions for `SIDES`, so an error will be raised.  This demonstrates that constant scope is limited to the lexical scope, and then the lookup path.  Constant scope also includes the main (top-level) scope, however there is no definition for `SIDES` within this scope, either.
- The first `self` in the method `describe_shape` references the calling object.  The second `self` within the class `Shape` and definition of instance method `self.sides` refers to the class (`Shape`).  Within the `self.sides` method, `self` refers to the class of the calling object (ultimately `Square` as invoked in the given code).  Within the `sides` instance method, `self` refers to the calling object (also, ultimately `Square` as invoked in the given code).

#### Additions
- The use of `::` to define specific classes to resolve constants is called 'explicit namespacing'

---

4
What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

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
```

- The output will be an array of 6 objects:  all of the objects will be of class `Animal` with the value of instance variable `@name` being `'Human'`, `'Dog'`, `'Cat'`, `'Eagle'`, `'Blue Jay'`, and `'Penguin'`, respectively.
- Generally, we would expect that 'adding' (concatenating) 2 objects of the same class together would return a new object of the same class.  Hence, returning an array object instead of an `AnimalClass` object is somewhat unexpected.
- The implementation of the `+` method could be adjusted by updating the method as follows below:

```ruby
  def +(other_class)
    temp_class = AnimalClass.new('New Animal Class')
    temp_class.animals = animals + other_class.animals
    temp_class
  end
```
A new object of `AnimalClass` is created, and using the setter method for the instance variable `@animals`, the existing animal arrays are concatenated together and assigned to the `@animals` instance variable of the new object.  The new object is then returned.

---

5
We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.
```

- The `change_info` method does not work as expected since it does not re-assign the instance variables (state) of the object.  Within the existing `change_info` method, new local variables (`name`, `height`, `weight`) are initialized and assigned, NOT the instance variables `@name`, `@height`, and `@weight`.  To re-assign these instance variables, they can be referred to using the `@` prefix, or by leverage the setter methods defined through the `attr_accessor` method.  To use these setter methods, the prefix `self.` should be added to each of the current local variable names.

---

6
In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`? 

```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name 
bob.change_name
p bob.name
```

- An error is raised about the line `name = name.upcase` since a new local variable `name` is being initialized.  The initial value that is trying to be assigned to this local variable is the return from a method `upcase` which is being called on the default value of `name`, which is `nil`.  Since the `nil` class does not have a method `upcase` defined, a `NoMethodError` is returned.
- The code could be adjusted to produce the desired output by referencing the instance variable `@name` (or the available getter and setter methods).  Two options are:  `self.name = name.upcase` (preferred since the setter and getter methods are available) or `@name = @name.upcase`.

---

7
What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels
p Vehicle.wheels

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels
p Car.wheels
```

- The code above outputs each of the following numbers on a separate line:  `4`, `2`, `2`, `2`, `2`, `2`.  When the class method `wheels` is first invoked, the value of class variable `@@wheels` is `4`, as defined in the first line of the class `Vehicle` definition and is what is output when `wheels` is first invoked.  However, once the class variable `@@wheels` is re-assigned to the integer value `2` by the definition of sub-class `Motorcycle`, subsequent invocations of the `wheels` class method return the new value of `@@wheels` which is `2`.
- When using inheritance (sub-classes), avoiding the use of class variables can prevent this kind of behaviour can lead to an unexpected change in value of class variables.  Where the code may be very long and multiple classes and structures are used, any addition (or removal) of code from 1 area can unexpectedly impact code in subsequent areas and may be very hard to debug.


##### comments from Spot session:
  - first initializing class variable @@wheels
  - helpful to frame why this happens is to think about how the Ruby interpreter 'parses' code : the interpreter will go from top to bottom; any expression not within a method definition will be evaluated.  class variable assignment is evaluated, but method definitions are just 'noted' but not executed as part of parsing process;  method invocations ARE evaluated through parsing - method `wheels` is invoked, which returns the value of the constant (initially assigned as 4)
  - continue parsing : then new class is defined which subclasses from Vehicle.  then `@@wheels` is reassigned - and the interpreter will evaluate the expression (not a method definition);
  - need to be very clear that scope of class variables is
- lexical scope has to do with the order in which the code appears and where it appears - lexical scope is defined in LS in RB120 that it's primarily about constant scope, but later on, the term lexical scope will be more generic
- encapsulation and dependencies are threatened by class variables (and the way they are implemented in Ruby);  hard to contain and control the values of class variables - it's hard to track and control the values of class variables;  can create dependencies (creates 'couplings') in code base (where code is)



---

8
What is output and why? What does this demonstrate about `super`?

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")
p bruno
```

- The output is the standard Ruby output for custom classes which identifies an object with a unique id of class `GoodDog` and instance variables `@name` and `@color`, both with the string value `"brown"`.  Both `@name` and `@color` are assigned to the same string value since when `super` is invoked with no arguments defined, all of the arguments passed into the `initialize` method of class `GoodDog` are automatically passed to the `initialize` method of class `Animal`.  Since the string value in local variable `color` is also passed to the `initialize` method of `Animal`, `"brown"` is also assigned to the instance variable `@name`.

---

9
What is output and why? What does this demonstrate about `super`?

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")
```

- An error is output since the incorrect number of arguments are passed to the `initialize` method of class `Animal`. This demonstates that `super` will pass all of the arguments provided to the `initialize` method of class `Bear` when `super` is called with no arguments.

---

10
What is the method lookup path used when invoking `#walk` on `good_dog`?

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
    # include GoodAnimals
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk
```

- The method lookup path used when invoking `walk` on `good_dog` will be: 'GoodDog', 'Danceable', 'Swimmable', 'Animal', 'Walkable', 'Object', 'Kernel', 'BasicObject'.  Any modules included within the namespace module `GoodAnimals` will not be part of the method lookup path unless the GoodAnimals module is explicitly included within one of the classes of the method lookup path.  If it is included, then modules included in modules are ordered similar to classes.  
- For example, if the module `GoodAnimals` is included as per the commented line in the code above, then the method lookup path will be:  'GoodDog', 'Danceable', 'GoodAnimals', 'Climbable', 'Swimmable', 'Animal', 'Walkable', 'Object', 'Kernel', 'BasicObject'.

---

11
What is output and why? How does this code demonstrate polymorphism?

```ruby
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end
```

- Polymorphism is when different data types can respond to the same interface (public method calls), often in different ways.  This code demonstrates polymorphism since each of the different classes `Animal`, `Fish` and `Dog` all respond to the same method invocation of `.eat`, but have different behaviours (i.e., the `puts` method invocation and different associated string arguments).  For example, the `eat` method of class `Animal` outputs `I eat.` to the screen, whereas the `eat` method of class `Fish` outputs `I eat plankton.` to the screen.

- This code demonstrates polymorphism through inheritance. `Fish` and `Dog` are both subclasses to `Animal` and inherit (though also override) the `eat` instance method. Thus, both `Fish` and `Dog` objects can invoke and respond (with different string return values) to the invocation of the `eat` instance method.

#### Additions
- The output is:

```ruby
I eat
I eat plankton
I eat kibble
```

---

12
We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object? 

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets.jump
```

- An error is raised since the `jump` method cannot be invoked on an array object, which is what `bob.pets` (the getter method for the instance variable `@pets`) returns.
- `kitty` and `bud` are collaborator objects of the `Person` object assigned to the local variable `bob` since they are stored  as part of the state of the `Person` object referenced by `bob`. `kitty` and `bud` are stored as elements within the `@pets` instance variable.

---

13
What is output and why?

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name
```
- The output is "bark! bark!  bark! bark!".  No 'name' appears when the `dog_name` method is invoked since the `initialize` method for class Dog is empty and the `initialize` method for `Animal` is never invoked (e.g., through the use of `super`).  Thus, the instance variable `@name` has a `nil` value by default which outputs nothing as part of the string interpolation in the method `dog_name`.

---
---

14
In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`? 
- Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true
```

- Currently, the comparison using the `==` method is comparing whether the first object is the same object as the second object; i.e., whether the object assigned to `al` is the same as the object assigned to `alex`.  To compare whether or the the objects have the same name (i.e., have the same value of the instance variable `@name`) the `==` method must be re-defined.  An example follows which uses the available getter method for the instance variable `@name` to compare if the value of `@name` in the current object is the same as that of another object's:

```ruby
  def ==(other)
    name == other.name
  end
```

- The string objects referenced by `al` and `alex`'s `@name` instance variables are not the same object.  The `==` method used within the updated `==` method for our custom class `Person` is actually the `String#==` method which compares string values, not string objects.  We can confirm that each of the respective `@name` values are different objects by using the `object_id` method to see if the object ids are the same, which would indicate that the same string object has been assigned to both instance variables.  This can be done with the following code:

```ruby
p al.name.object_id == alex.name.object_id
```

---

15
What is output on `lines 14, 15, and 16` and why?

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

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name
```

- The output will be:

```
Bob
My name is BOB.
BOB
```

- On line 13, a new Person object is created and the string argument `'Bob'` is passed into the `initialize` method, which assigns the instance variable `@name` that string value `'Bob'`.  
- On line 14, when the `puts` method is invoked, `bob.name` is passed in as an argument.  `bob.name` invokes the getter method `name` on the `Person` object referenced by `bob` which returns the string `Bob` - the current value of the `@name` instance variable.  
- On line 15, when the `puts` method is invoked with `bob` as the argument, the `puts` method automatically calls the `to_s` method on the `Person` object which invokes the custom `to_s` method defined on lines 8 - 10.  This method will call the destructive (mutating) `upcase!` method on the instance variable `@name` which alters the value of the string object referenced by `@name` to all capitals.  This updated value of `@name` is then incorporated into the larger string `'My name is BOB.'` through string interpolation.  This larger string is what is output to the screen by the `puts` invocation on line 15.
- On line 16, when `bob.name` is again passed in as the argument for the `puts` method invocation, the updated string value `'BOB'` is output to the screen.

---

16
Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.

- It is generally safer to invoke a setter method (if available) since by consistently doing so, you create a single access point to the value of the instance variable which can incorporate any data validation or 'guardrails' that may be required.  This also supports effective encapsulation of data within the object or class and prevents accidental changes to the value of instance variables.
- For example, for a custom `Customer` class, we may want to ensure that all phone numbers are represented by 10 digits, which can be consistently enforced through a setter method, but not by accessing the instance variable directly:

```ruby
class Customer
  attr_reader :phone_number

  def phone_number=(number)
    if number.to_s.length == 10
      @phone_number = number
    else
      puts "Please enter a 10 digit number."
    end
  end
end

Customer.new.phone_number = 12345
jay = Customer.new
jay.phone_number = 1234567890
p jay.phone_number
```

---

17
Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.
- It would make sense to manually write a custom getter method if the value returned always needed to be manipulated in some way prior to being returned.  An example of this might be returning sensitive information like a bank-account number.  A public getter method can be defined to return only the last 4 digits of the bank-account number rather than the whole number.

```ruby
class BankAccount
  def initialize(number)
    @number = number
  end

  def number
    len = @number.to_s.length
    "X" * (len - 4) + @number.to_s[-4..]
  end
end

account1 = BankAccount.new(1234567890)
p account1.number

account2 = BankAccount.new(54837)
p account2.number
```

---

**18**
What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

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
```

- Executing `Triangle.sides` will return `nil`.  
- Executing `Triangle.new.sides` will return `4`.

- This illustrates how class variables are assigned their values based on how the Ruby interpreter parses code from top to bottom.  As the code is read from the top, the class variable `@@sides` is initially assigned the value of `nil` and none of the other re-assignments to `@@sides` in the `initialize` methods of class `Triangle` or class `Rectangle` are evaluated until those methods are explicitly called.  Once a new `Triangle` object is instantiated, the `initialize` method defined in class `Triangle` is evaluated and the value of `@@sides` is re-assigned to the integer `3`.  The value of `@@sides` is dependent on the order in which the code is written and executed.
- This also illustrates how a sub-class (in this case the class `Triangle`) can re-assign the value of a class variable, `@@sides` defined within the super-class `Shape`.

#### Updated part of answer:
- Executing `Triangle.sides` will return either `nil`, `3` or `4` depending on when `Triangle.sides` is invoked, relative to the order in which other code within the main scope is entered and executed.  Since the `initialize` methods of both the `Triangle` and `Quadrilateral` class re-assign the value of the class variable `@@sides`, the execution of those `initialize` methods will affect the return value from the inherited `::sides` and `sides` methods of the `Shape` class.
- Executing `Triangle.new.sides` will always return `3`, since the value of `@@sides` is assigned to an integer object with value `3` every time a new `Triangle` object is initialized.

---

##### 19
What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.
- The `attr_accessor` method takes symbols as arguments and returns getter and setter methods in the class for instance variables of the same name with a `@` prefix.  For example, invoking `attr_accessor :full_name` will return a getter method `full_name` and a setter method `full_name=`.  Use of `attr_accessor` is convenient to quickly define getter and setter methods.
- Generally though, it's best to consider whether each instance variable requires both a getter and a setter to best implement appropriate encapsulation of object data to prevent undesired changes or access to object data.  Use of method access control to make these getters and setters private or protected can help, but it's still best to consider whether those getters or setters are required in the first place.
- An example might be for confidential information - we may want to be able to set confidential information like a password and thus need a setter method, but not let that information be accessible to any other part of the code and thus not want the getter method.

---

##### 20
What is the difference between states and behaviors?
- State refers collectively to the data stored in all of the instance variables of an object.  This state is generally unique to each object and is not inherited.
- 'Behaviours' refers to the instance methods of an object, which are defined by the class and thus inheritable to sub-classes.

---

21
What is the difference between instance methods and class methods?
- Instance methods need to be called on a specific instance (a object) of a class. Class methods are called on the class itself and do not require any object to be instantiated.

#### Updated details
- Instance methods have access to both instance variables and class variables.
- Class methods do not have access to data referenced by instance variables, but do have access to class variables.  Class method are defined by using the keyword '`self.`' prepended to the method name within the class definition.

---

22
What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.
- Collaborator objects are objects that are stored as part of the state of another object.  Generally, custom objects are of the most interest, although objects like Strings and Arrays are techically also collaborator objects.
- Collaborator objects are used in OOP to help model the relationships between different object types when creating programs.
- For example we could define a `Library` custom class and a `Book` custom class.  The `Book` class may manage a variety of information such as `@title`, `@author`, etc.  Instances of the `Book` class - individual books - might then be stored within an object of the `Library` class.  Objects of `Book`class are thus collaborator objects of objects of the `Library` class.  Books might be added or removed, as appropriate, from (for example) an instance variable `@shelf` defined within the `Library` class.

```ruby
```

---

23
How and why would we implement a fake operator in a custom class? Give an example.
- Fake operators are defined like any other instance method in a custom class.  Defining the operator within the custom class using the same name will override any existing definitions which may exist within ancestors to this class (e.g., `Object`, `Kernel`, `BasicObject`).
- We may want to (re-)implement a fake operator in a custom class to define appropriate outcomes for the use of that operator.
- A common example is the `==` 'operator' - considered a fake operator since it's actually an inherited method.  We may want to define the `==` operator to compare values stored within an instance variable, rather than the default behaviour of looking at the whether or not the objects themselves are the same.

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end

bob1 = Person.new("Bob")
bob2 = Person.new("Bob")

p bob1 == bob2
p bob1.equal? bob2 # checks if the actual objects themselves are the same; mimics the default behaviour of `==` for custom classes
```

#### Additions
- Fake operators are commonly used elements of expressions typically used for math, logical comparisons, or indexed assignment that are actually invocable methods.  These 'fake operators' may not appear to be methods, but this is because of Ruby's syntactical sugar, which allows methods to be invoked without parentheses.  Common example are `+`, `-`, `==`, `>`, `<=`, `[]`, `[]=` but there are many more.


---

##### 24
What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.
- Depending on how `self` is used, it can indicate class methods, refer to the object itself, refer to the class itself, and also to refer to available setter methods within a class.

```ruby
class Shape
  SIDES = "any number of"

  def self.describe
    "I have #{self::SIDES} side(s)."
  end

  def to_s
    "#{self.class}"
  end

  def what_am_i
    "I am a #{self}"
  end
end

class Circle < Shape
  SIDES = 1
end

class Triangle < Shape
  attr_accessor :length

  SIDES = 3

  def initialize
    self.length = 1
  end

  def grow_sides(num)
    self.length = length * num
  end
end

p Shape.describe
p Circle.describe
p Triangle.describe

p Circle.new.what_am_i

obj = Triangle.new
p obj.length
obj.grow_sides(5)
p obj.length
p obj.what_am_i
```

- Line `def self.describe` :  in this line, `self` refers to the class itself and is used to define a class method which is invoked on the class.
- Line `"#{self.class}"` : in this line, `self` refers to the object itself, on which we call the `class` method to be able to return the class name.
- Line `"I have #{self::SIDES} side(s)."` : in this line, `self` refers to the class itself and is used with the constant resolution operator to ensure that subclasses of `Shape` can access the correct value of the constant `SIDES` defined within each sub-class.
- Line `self.length = 1` : in this line, `self` indicates to Ruby that we intend to use (invoke) the available setter method for instance variable `@length` rather than initialize and assign a new local variable called `length`.

---

##### 25
What does the above code demonstrate about how instance variables are scoped?

```ruby
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"
```

- Instance variables are scoped at the object (instance) level.  All methods defined within the same class will have access to the value of that instance variable and the values of those instance variables are generally unique between instances.

#### Additions:
- Instance variables exist as long as the object instance that contains them exists. Instance variables can be accessed by instance methods even those variables are not initialized or explicitly passed to instance methods.

---

##### 26
How do class inheritance and mixing in modules affect instance variable scope? Give an example.
- Instance variables defined by a super class are also available to sub classes.
- When modules are included within a class (or super class), the methods within that module will also be able to access the instance variables of that class.

```ruby
module Displayable
  def up_name
    @name.upcase
  end
end

class Person
  def initialize(name)
    @name = name
  end
end

class Adult < Person
  include Displayable

  def show_name
    puts @name
  end
end

james = Adult.new("James")
james.show_name
puts james.up_name
```

- In the code above, the instance variable `@name` is only defined within the super-class `Person` and not explicitly defined within the `Adult` sub-class.  However, when the method `show_name` is invoked, `@name` is accessible by the `Adult` object referenced by `james` and `James` is output to the screen.
- To demonstrate that instance variables are also available within included modules, the `Displayable` module includes a method `up_name` which takes the instance variable `@name` and converts the letters (non-destructively) to uppercase. Invoking this method `up_name` on the `Adult` object `james` and passing the returned value as an argument to the `puts` method outputs `JAMES` to the screen and demonstrates how the instance variable is accessible to methods in the module.

---

##### 27
How does encapsulation relate to the public interface of a class?
- Encapsulation is the ability to segregate or separate code within a class from the rest of the code in a program.  Part of encapsulation is limiting access to the methods or data within a class object.
- The public interface of a class refers to the public methods of a class that are available for the rest of the code outside of an object to use.  This interface determines whether or not and how data and methods within an object can be accessed or manipulated.

#### Additions:
- The use of the access modifiers 'Public', 'Private' and 'Protected' are one of the primary ways to achieve encapsulation in Ruby - defining what instance methods of the object are exposed for the rest of the code base to access.

---

28
What is output and why? How could we output a message of our choice instead?

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky
```

- The default output for representing a custom class object as a string is the default output of the `to_s` method.  The output has a structure similar to: '#<[class name]:[some string]>', where [class name] is the name of the class and [some string] is a series of numbers and letters.
- To output a message of our choice, the default `to_s` method can be overridden within our custom class to output what we choose.

How is the output above different than the output of the code below, and why?
- The output below is different since the `p` method will automatically invoke the `inspect` method on the object passed in.  In contrast, the `puts` method will automatically invoke the `to_s` method on the object passed in.  Both methods can be overridden in custom classes, but generally `inspect` is not overridden.

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky
```

#### Additions:
- The default `to_s` method is inherited from class `Object` and returns a string representation of the object with the structure described (#<[class name]:[id encoding]>)

---

##### 29
When does accidental method overriding occur, and why? Give an example.
- Accidental method overriding occurs when we define an instance method in a custom class which has the same name as a method defined within an ancestor. It occurs because of the method lookup path that Ruby uses when a method is invoked.  Ruby first searches the class of the object on which the method was invoked for the method definition.  If it finds that method definition then it will stop searching and methods with the same name farther along the method lookup chain are ignored. These are method names that are typically defined within ancestor classes like `Object`, `Kernel`, or `BasicObject`.  
- Examples might include methods `send`, `inspect`, `display`, `trust`, `method`, `methods` (defined within `Object`).  

---

##### 30
How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.
- Method Access Control is implemented in Ruby using the access modifiers "public", "private" or "protected".
- Public methods are methods that can be accessed by any object or code invoked within the program outside of the current object and class.  **addition** Public methods are inherited.
- Private methods can only be invoked by other methods within the same object. **addition** Private methods are inherited by subclasses.
- Protected methods can be invoked by other methods within the same object, or other objects of the same class (and sub-class).

```ruby
class Person
  def initialize(name, salary, secret)
    @name = name
    @salary = salary
    @secret = secret
  end

  public
  attr_reader :name

  def >(other)
    @salary > other.salary
  end

  def big_secret?
    secret.length > 10
  end

  def compare_secrets(other)
    secret.length > other.secret.length
  end

  protected
  attr_reader :salary

  private
  attr_reader :secret
end

john = Person.new('John', 50000, "I hate pineapples")
bob = Person.new('Bob', 20000, "")

p john.name
p john.big_secret?

p bob.name
p bob.big_secret?

p john > bob
p john.compare_secrets(bob)

p john.salary
p john.secret
```

- In the code above, information such as somebody's name, as represented by the instance variable `@name` are freely available to access since it is defined as 'public'.
- However, somebody's salary info, as represented by the instance variable `@salary` is only available to other instances of class `Person` for comparison purposes.  The exact salary number is not freely accessible from code outside of the object as demonstrated by the error which is raised when trying to access the getter method `salary` in the main scope.
- The `@secret` instance variable is only accessible within the existing object:  the `big_secret?` method can access the value of `@secret` and indicate the length, but it isn't possible for another `Person` object to access that secret, such as attempted in the `compare_secrets` method.  Attempting to access the getter method `secret` from the main scope also returns an error.

---

##### 31
Describe the distinction between modules and classes.
- Modules are used to group methods for mixin, or to create a namespace for other classes and methods. In contrast, classes define the behaviours and attributes of instantiated objects.  Modules cannot be used to instantiate an object, whereas classes are intended to be used to instantiate other objects.
- Classes can also be used to create a hierarchy, but modules are either included or not included within classes.

#### Additions
- Classes can only inherit from 1 class.  However, modules can be included into an unlimited number of classes, and an unlimited number of modules can be included into each class.

---

##### 32
What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.
- Polymorphism is the ability to invoke a method with the same name on different object types.
- Polymorphism can be implemented through inheritance, use of modules or duck-typing.

```ruby
module WindPowered
  def move
    "with the wind"
  end
end

class Animal
  def move
  end
end

class Fish < Animal
  def move
    "with fins and tail"
  end
end

class Dog < Animal
  def move
    "with legs"
  end
end

class Truck
  def move
    "with engine"
  end
end

class Ball
  def move
    "by rolling"
  end
end

class Sailboat
  include WindPowered
end

class Kite
  include WindPowered
end

p Fish.new.move
p Dog.new.move
p Truck.new.move
p Sailboat.new.move
p Kite.new.move
p Ball.new.move
```

- In the code above, the classes `Fish` and `Dog` both inherit the ability to move from `Animal`, although the `move` method is overridden in both `Fish` and `Dog` to represent behaviour specific to those classes respectively. This is an example of polymorphism through inheritance.
- The classes `Sailboat` and `Kite` can also invoke the `move` method, however, this is accomplished through the `WindPowered` module which is included in both of these classes which share a common behaviour.  
- An example of duck-typing is found in the `Truck` and `Ball` classes.  These classes can also invoke the `move` method, however, these methods were defined manually in each class and share very limited characteristics in their movement behaviour.

#### Additions:
- Duck-typing is an informal way of ascribing type to an object.  In duck-typing, we don't worry about the type or class of an object, only whether or not that object has a particular behaviour (i.e., a method of the same name can be invoked on objects of different types in the same way).

---

##### 33
What is encapsulation, and why is it important in Ruby? Give an example.
- Encapsulation is segregating and hiding some of the functionality of the code from the rest of the code-base.  Encapsulation is one of the basic benefits of object-oriented programming and one of the key features of an object-oriented programming language like Ruby.
- An example might be the creation of a `Machine` class which can complete very complex tasks automatically, however the key actions (or interfaces) for a user might primarily involve `switch_on`, `switch_off`, `check`. Using objects allows the inner functioning of that `Machine` to be hidden from the rest of the code base and only the 'switch' and 'check' made available to interact with.  In the code below, `operation` can be implemented in many different ways, however, the public interface of `switch_on`, `switch_off` and `check` can remain consistent

```ruby
class Machine
  def switch_on
    @on = true
  end

  def switch_off
    @on = false
  end

  def check
    return operation if @on
    "no reading"
  end

  private
  def operation
    rand(1000)
  end
end

device = Machine.new
p device.check
device.switch_on
p device.check
p device.check
p device.check
device.switch_off
p device.check
p device.check
```

---

34
What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?

```ruby
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk

kitty = Cat.new("Kitty")
p kitty.walk
```
- The output is:

```
Mike strolls forward
Kitty saunters forward
```

- It makes sense to use a mixin module here since the method is exactly the same for both class `Cat` and class `Person`.  Use of the module minimizes repetition of code and is generally used when the method represents a "has-a" relationship with the class.  In this example, both `Cat` and `Person` would "have-a" walk.  Class inheritance is generally used with a "is-a" relationship.  In our current example, '`Cat` is-a walk' would not make sense, hence inheritance is not the best choice of code structure.

---

##### 35
What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?

- Object Oriented Programming is a programming paradigm which uses programming 'objects', defined through 'classes' to help encapsulate (segregate) pieces of code to help organize and structure code, reduce dependencies and code conflicts, and increase reusability of code snippets.  Especially in larger codebases where there is an increased likelihood of variables or functions having the same name and creating errors, the ability to separate various parts of the code and ensure they do not conflict becomes important.  Also, with larger distributed teams, the need to define clear 'interfaces' for different parts of the code ensured that dependencies between different areas of code could be more clearly tracked and reduced.

#### Additions:
- OOP is a programming paradigm created to help manage complexity of large software systems by creating programs as an interaction of small parts (objects), rather than a big 'blob' of dependency.
- As complexity grows, software becomes harder to maintain because of dependencies in the code base - even small changes could ripple throughout the program creating errors.
- OOP uses encapsulation, polymorphism, and inheritance to help make code more flexible and reusuable

---

##### 36
What is the relationship between classes and objects in Ruby?

- Classes are like a 'blueprint' for objects and define what attributes and behaviours objects will have.  Objects are instantiated from classes and have the instance methods and instance variables defined by the class definition.  The actual values of the instance variables within each object may vary depending on what arguments may have been passed in when the object was first instantiated and how that object may have been manipulated within the larger codebase.

---

##### 37
When should we use class inheritance vs. interface inheritance?

- Class inheritance is most appropriate for objects that have a hierarchical, "is-a" relationship.  For example, when thinking about animals, cats can be thought of as a subset of animals, i.e., a cat *is an* animal, hence the use of class inheritance may be appropriate.  However, if thinking about cats and considering an "ability to climb", there is a different type of relationship.  An "ability to climb" is *not* a cat, and thus an inheritance relationship may not be appropriate.  In this situation, the relationship is a "has-a" relationship; i.e., a cat *has an* ability to climb.  These "has-a" relationships may be better represented using interface inheritance and can be easily implemented through the use of mixin modules.

---

38
If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?

```ruby
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new
```

- If we use the `==` method to compare individual `Cat` objects in the code above, the return value will be `false`.  This is because when custom class objects are compared using the `==` method, by default the method will compare the actual objects themselves are the same (i.e., have the same object id).  Since each new instance of the `Cat` class will create a new object with a distinct object id, the `==` method will return `false` when comparing these objects with each other.
- This demonstrates that although objects may share a common class, each object is unique (and assigned a different location in memory).

#### Additions:
- `==` is inherited from 'BasicObject' class
---

39
Describe the inheritance structure in the code above, and identify all the superclasses.

```ruby
class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end
```

- In the code above, class `Thing`, as a custom class, inherits from `Object`, class `AnotherThing` inherits from `Thing`, and class `SomethingElse` inherits from `AnotherThing`.  Thus, the superclasses are `Object`, `Thing` and `AnotherThing`.

---

40
What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.

```ruby
module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly
```

- The method lookup path when the instance method `fly` is invoked will be:  `Penguin`, `Migratory`, `Aquatic`, `Bird`, `Animal`, `Object`, `Kernel`, `BasicObject`.  Since the module `Flight` is not part of the method lookup path, invoking the `fly` method on a `Penguin` object will return an error.
- This can be verified by calling the `ancestors` method on the `Penguin` class and viewing the return value using the code: `p Penguin.ancestors`.

---

41
What does this code output and why?

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

- This code will output `Daisy says moooooooooooo!` to the screen.  The `speak` method is invoked on `daisy`, which references a `Cow` object which was instantiated with the string value `"Daisy"` passed in as an argument. 
- Regarding the instantiation of the `Cow` object referenced by `daisy`:  since the `Cow` class does not define an `initialize` method, Ruby looked up the inheritance hierarchy to the `Animal` class for an `initialize` method (a constructor).  Since a constructor is defined for the `Animal` class, this string value `"Daisy"` was assigned to the instance variable `@name` by the constructor defined within the `Animal` class as part of the state associated with the `Cow` object referenced by `daisy`.
- Regarding the invocation of the `speak` method on `daisy`:  Ruby will traverse the method lookup path looking for the `speak` method starting with the `Cow` class.  Since there is no method definition for `speak` within the `Cow` class, Ruby will next check the `Animal` class.  Since `speak` is defined within the `Animal` class, Ruby will execute it.  The `speak` method invokes the `puts` method with `sound` (another method passed in as an argument).  To evaluate `sound`, Ruby will again search the method lookup path starting with the object's `Cow` class.  Since `sound` is defined within the `Cow` class, Ruby will evaluate the method.  Within the `Cow#sound` method, the return value is a string which is concatenated from the output of `Animal#sound`, as indicated by the method `super` and also the string `"moooooooooooo!"`.  Evaluating `Animal#sound` will return a string with the value of the instance variable `@name` interpolated into the string `"Daisy says "`.  Concatenating the string output of `Animal#sound` with `"moooooooooooo!"` gives the final string, `"Daisy says moooooooooooo!"`, which is passed to the `puts` method for output to the screen.


---

42
Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.

```ruby
class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")
```

- `max` and `molly` have different states, but the same behaviours. State, which refers to the collective values of the instance variables in each object, will be different between `max` and `molly` since they were both instantiated with different string values for `name` and `coloring`.  After instantiation, `max` has instance variable `@name` referencing string object `"Max"` and `@coloring` referencing `"tabby"`.  However, `molly` has instance variable `@name` referencing string object `"Molly"` and `@coloring` referencing `"gray"`.  Behaviours, which refers to the instance methods available within each `Cat` object will be the same, as defined by the class definition for `Cat`.  Both `Cat` objects `max` and `molly` will have `purr`, `jump`, `sleep`, and `eat` methods available for invocation (although these methods currently do nothing).
- This demonstrates that instance methods are shared by all objects of a common class, but that state is unique to each individual object.

---

43
In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?

```ruby
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
  
  def change_grade(new_grade)
    grade = new_grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade
```

- As provided, the code will return `nil` when `priya.grade` is evaluated. The `grade` getter method will return the value referenced by instance variable `@grade` which is assigned the value of `nil` when the `Student` object referenced by `priya` is instantiated.  The `change_grade` method assigns the string value `'A'` to a new local variable `grade`, but does not re-assign the value of the instance variable `@grade`.
- Updating the `change_grade` method to re-assign the instance variable `@grade` would produce the desired result.  This can be done by updating the line within `change_grade` to this:  `self.grade = new_grade`.  Prepending `self` to `grade` indicates to Ruby that the available setter method for `@grade` should be accessed, rather than initializing and assigning a new local variable `grade`.

---

##### 44
What does each `self` refer to in the above code snippet?

```ruby
class MeMyselfAndI
  self          # instance 1

  def self.me   # instance 2
    self        # instance 3
  end

  def myself
    self        # instance 4
  end
end

i = MeMyselfAndI.new
```

- In instance 1 (indicated by comments above), `self` refers to the class `MeMyselfAndI`.
- In instance 2, `self` also refers to the calling class and is used to indicate that the `me` method is a class method (and not an instance method).
- In instance 3, `self` also refers to the calling class.
- In instance 4, `self` refers to the calling object (since `myself` is an instance method and must be called on an object of class `MeMyselfAndI`).

---

45
Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?

```ruby
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end 
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
```

- The output of the code above will differ from the desired output since the instance variable `@grade` is never initialized when a new `Student` object is instantiated.  As a result, the `@grade` instance variable is not indicated as being part of the state of the `ade` object when it is passed into the `p` method as an argument.
- Adding the line `@grade = grade` to the `initialize` method will fix this problem.  If the line is inserted as the first line of the `initialize` method, then the instance variables will be ordered in the output, as desired.
- This indicates that although instance variables may be defined within a class and 'available' within an object, they don't really 'exist' within an object until it they have been initialized.

---

46
What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`?

```ruby
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name 
p sir_gallant.speak
```

- The output is:

```
Sir Gallant
Gallant is speaking.
```

- To achieve the desired output for the last line, a `speak` method should also be defined within the `Knight` class:

```ruby
  def speak
    "Sir " + super
  end
```

#### Addition (need to explain 'why')
- The first line of output is from the invocation of the `Knight#name` method.  This method returns a string which is the concatenation of `"Sir "` and the return from `Character#name` getter method provided by the `attr_accessor` method of the `Character` class. The `Character#name` method returns the value of the `@name` instance variable of the `Knight` object, hence the output of the first line is `Sir Gallant`.
- the second line of output is from the invocation of the `speak` method.  Since there is no definition of `speak` within the `Knight` class, Ruby will look at the superclass `Character` and execute the `speak` method found there.  This method uses string interpolation to return a string which contains the string value of the `@name` instance variable of the the `Knight` object referenced by the local variable `sir_gallant`.  Thus, the string passed into the `p` method invocation is `"Gallant is speaking."` which is output to the screen.

---

47
What is output and why?

```ruby
class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak   # output line 1
p Lamb.new.speak    # output line 2
p Cow.new.speak     # output line 3
```

- Output line 1 (as indicated by comments in code above) will output `#<Sheep:[alphanumeric string]> says baa!`, where [alphanumeric string] is some combination of letters or numbers which will be unique to each instance of the Ruby interpreter.
- Output line 2 will output `#<Lamb:[alphanumeric string]> says baa!baaaaaaa!`, where [alphanumeric string] is similar to above, but will be different.
- Output line 3 will output `#<Cow:[alphanumeric string]> says mooooooo!`, where [alphanumeric string] is similar to above, but will also be different.

All of the different lines will output the object instance itself using the default string output ("#<[ClassName]:[alphanumeric string]>") since a specific `to_s` method is not defined within any of the classes.  The `speak` method is defined in each of the `Sheep`, `Lamb`, and `Cow` classes, and thus the output of invoking `speak` on objects of each of these classes will be unique.  In each of the `speak` methods, `super` is called which will invoke the `speak` method defined in `FarmAnimal`, which returns a string representation of the object itself concatenated with the string `" says "`, a unique string is then also added: for `Sheep`, `Lamb` and `Cow` the string added will be `'baa!'`, `"baaaaaaa!"`, and `"mooooooo!"` respectively.  In the case of output line 2 (for `Lamb`), when `Lamb#speak` is invoked, `super` will reference `Sheep#speak`, which then also refernces `FarmAnimal#speak`, hence the final output will concatenate strings from `FarmAnimal#speak` (`"#<Lamb:[alphanumeric string]> says "`), then `Sheep#speak` (`"baa!"`), then `Lamb#speak` (`"baaaaaaa!"`).

---

48
What are the collaborator objects in the above code snippet, and what makes them collaborator objects?

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)
```

- The most interesting collaboration is between `sara` and `fluffy`:  `sara` is a collaborator object to `fluffy`, since `sara` is a `Person` object that is stored in the state of `fluffy` the `Cat` object (i.e, `sara` is referenced by the instance variable `@owner` of `fluffy`).  The strings `"Sara"` and `"Fluffy"` are also collaborator objects, which are stored in the state of the `Person` object `sara` and the `Cat` object `fluffy` respectively.
- Collectively, these collaborator objects help to establish useful relationships between important objects such as `Person` and `Cat`, i.e., the `Cat` has an owner who is a `Person`.

---

##### 49
What methods does this `case` statement use to determine which `when` clause is executed?

```ruby
number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end
```

- The `case` statement will use the `===` method to evaluate each branch.  The specific `===` used will depend on the object type being compared:  e.g., in the 'first' case branch the `Integer#===` method will be used, and in the 'third' case branch, the `Range#===` will be used.


---

##### 50
What are the scopes of each of the different variables in the above code?

```ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end
```

- The constant `TITLES` has class and 'class-hierarchy' scope (i.e., the constant will be available to objects of the same class or sub-classes).
- The class variable `@@total_people` has class and 'class-hierarchy' scope.
- the instance variables `@name` and `@age` have object scope.

#### Additions
- Constants have **lexical scope**, but are also available within the inheritance hierarchy of the structure that accesses the constant
---

##### 51
The following is a short description of an application that lets a customer place an order for a meal:

- A meal always has three meal items: a burger, a side, and drink.
- For each meal item, the customer must choose an option.
- The application must compute the total cost of the order.

1. Identify the nouns and verbs we need in order to model our classes and methods.
2. Create an outline in code (a spike) of the structure of this application.
3. Place methods in the appropriate classes to correspond with various verbs.

- Nouns:  meal, meal item, burger, side, drink, customer, order
- Verbs:  choose, total

```ruby
class Meal
  def initialize(burger, side, drink)
    @burger = burger
    @side = side
    @drink = drink
  end
end

class MealItem
  def choose_option
  end
end

class Burger < MealItem
  OPTIONS = {}
end

class Side < MealItem
  OPTIONS = {}
end

class Drink < MealItem
  OPTIONS = {}
end

class Order
  def initialize(meal)
    @meal = meal
  end

  def total_cost
  end
end

class Customer
  def initialize(order)
    @order = order
  end
end
```

---

52
In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1         # line to update
  end
end
```

- The method `make_one_year_older` could also be updated so that the only line in this method reads `@age += 1`.  This would reference the instance variable `@age` directly, rather than using the available setter method `age=` which is referenced by `self.age=` in the code to disambiguate from the initialization and assignment of a new local variable `age`.
- Based on Ruby best practice, it's best to use setter methods, if they are available to ensure a single point of access when setting instance variables.  These setter methods may be defined to include guardrails or data validation which will not be available when accessing the instance variable directly.

---

##### 53
What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?

```ruby
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```

- An error is output from the above code, since the `drive` method as defined within the module `Drivable` is not a typical instance method.  As define, the `drive` method needs to be called on the module `Drivable` itself, i.e., with the line `Drivable.drive`.  This may be helpful for name-spacing, but does not allow the `drive` method to be called on an instance of `Car`, as desired in the code.
- Methods that are intended to be called on object instances should not have their name prepended with `self.`.

---

##### 54
What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?

```ruby
class House
  include Comparable  # added

  attr_reader :price

  def initialize(price)
    @price = price
  end

end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive
```

- As a custom class, Ruby will not be able to compare different `House` objects.  In order to define how to compare `House` objects, specific methods, such as `<` and `>` must be defined.  One way of doing this is to just define both `<` and `>` instance methods to indicate how the comparison should be conducted.  However, another way to achieve this is to include the `Comparable` module and then define how the `<=>` method should compare values using the method to be added to the `House` class below:

```ruby
def <=>(other)
  price <=> other.price
end
```

This method indicates that the instance variable `@price` should be used when comparing `House` objects, which will be used for the `==` (`!=`), `<`, and `>` methods.

---
