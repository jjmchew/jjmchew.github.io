<b style="color: red">IS <code>super</code> A METHOD?</b>

**1. What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?**


```ruby
class Person
  attr_reader :name
    
  # def initialize
  #   set_name
  # end
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
# bob.set_name
p bob.name
```

On line 9 a new `Person` object is instantiated and assigned to the local variable `bob` and on line 10 this object invokes the `#name` getter method which returns the value assigned to its `@name` instance variable.  The `@name` instance variable has not been initialized, so `p bob.name` will output `nil`.  

An uninitialized instance variable will return `nil`, whereas an uninitialized local variable will raise a `NameError` exception. In order to initialize the `@name` instance variable, the `#set_name` instance method must be invoked, either within an added `#initialize` method in the class definition, or after the `bob` object has been instantiated outside the class.

The `Person` class definition spans lines 1 - 7.  Within the class, the `attr_reader` method is called and `:name` is passed in as an argument.  This creates a getter method which can be used to retrieve the `@name` instance variable.  The `#set_name` initializes the `@name` instance variable to the string literal "Bob".

On line 9, a new `Person` object is instantiated and assigned to the local variable `bob`.  On line 10, the instance referenced by `bob` invokes the `#name` instance method. This will output `nil` becuase `@name` is uninitialized.  In order to initialize `@name`, `bob` must first invoke `#set_name`.

Referencing an uninitialized local variable will raise a `NameError` exception, whereas referencing an unitialized instance variable will return `nil`.

**2. What is output and why? What does this demonstrate about instance variables?**


```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  # def initialize
  #   enable_swimming
  # end

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
# teddy.enable_swimming
p teddy.swim
```

On line 15 a new `Dog` object is instantiated and assigned to the local variable `teddy`, and on line 16 the `#swim` instance method is invoked on this object.  `Dog#swim` returns `"swimming"` if the `@can_swim` instance variable evaluates as true.  However, the `@can_swim` instance variable evaluates as false because it is uninitialized, and uninitialized instance variables return `nil`.  Therefore, `p teddy.swim` will output `nil`.

In order to initialize the instance variable, the `enable_swimming` method that `Dog` inherits from the `Swimmable` module must be invoked.  This can be done either in an added `#initialize` method within the `Dog` class or after the `teddy` object has been instantiated outside the class.  

The `Dog` class definition spans lines 7 - 13.  Within the class, the `include` method is invoked and the module name `Swimmable` is passed in as an argument.  This gives `Dog` objects access to all methods defined in the `Swimmable` module.  Within the instance method `#swim`, the string "swimming!" is returned if the instance variable `@can_swim` evaluates to true.

On line 15 a new `Dog` object is instantiated and assigned to the local variable `teddy`. The instance method `#swim` is invoked by the object referenced by `teddy` and the return value is passed to the `#p` method call, which will return and output `nil`.

The reason `teddy.swim` returns `nil`is because the `@can_swim` instance variable is uninitialized, and uninitiailized instance variables return `nil`.  The `@can_swim` instance variable is initialized in `#enable_swimming`, which is inherited from the `Swimmbale` module.  Therefore, once `#enable_swimming` is invoked, `@can_swim` will be initialized to `true` and `teddy.swim` will return "swimming!".  

Referencing an uninitialized local variable will raise a `NameError` exception, whereas referencing an uninitialized instance variable will return `nil`.

**3. # What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?**


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

On line 25 the `::sides` class method is invoked by the `Square` class.  When resolving a method, Ruby will first look within the calling class's defintion.  There is no `::sides` method within `Square`, so Ruby will traverse up the inheritance hierarchy until it finds the `::sides` method within the `Shape` class on lines 10 - 12.  We know this is a class method because it is prepended with `self.`.  Within this method, `self` refers to the calling class, which is referencing the constant `SIDES` by using the constant resolution operator, `::`. 

Constants have lexical scope, which means where they are defined in source code determines their availability. When trying to resolve a constant, Ruby will search lexically - it will first search the surrounding structure of the constant reference.  In this case, the lexcial scope of the constant reference is the `Square` class.  Because there is no `SIDES` constant within `Square`, Ruby will traverse up the inheritance hierarchy of `Square` and will locate the `SIDES` constant in `Quadrilateral`.  Therefore, `p Square.sides` will output `4`.

On line 26, a new `Square` object is instantiated and this new object invokes the `#sides` instance method.  Ruby will first search the calling object's class to resolve a method.  There is no `#sides` method in `Square` so Ruby will traverse up the inheritance hierarchy and will locates `#sides` within the `Shape` class on lines 14 - 16.  Within `Shape#sides`, the reserved word `self` refers the calling object.  `self` invokes the `#class` instance method which returns the calling object's class, which in this case is `Square`, and references the `SIDES` constant using the constant resolution operator `::`.   

Constants have lexical scope, which means that where they are defined within the source code determiens their availability.  When trying to resolve a constant, Ruby will search lexically, which in this case means it will start it's search in the `Square` class.  Because there is no `SIDES` constant in `Square` it will traverse up the inheritance hierarchy until it locates `SIDES` in the `Quadrilateral` class.  Therefore, `p Square.new.sides` will output `4`.

On line 27 a new `Square` object is instantiated and this new object invokes the `describe_shape` method.  Ruby will first search the calling obejct's class when trying to resolve a method.  Because there is no `describe_shape` in `Square`, Ruby will then traverse up the inheritance hierarchy until it located `describe_shape` within the `Describable` module, which is included in the `Shape` class. 

The reserved word `self` used in the interpolated string in `describe_shape` refers to the calling object's class, which in this case is `Square`.  `self` invokes the `#class` instance method, which returns `Square`.  The interpolated string also references the constant `SIDES`.  Constanrs have lexical scope, which means where they are defined in the source code determines their availability.  Ruby searches lexically when it tries to resolve a constant, so it will first search the surrounding of the constant reference, which in this case is the module `Describable`.  There is no `SIDES` constant in `Describale`, and modules do not have an inheritance hierarchy to search, so Ruby will ultimately search the top level scope for `SIDES` before raising a `NameError` exception.

To fix this code, you can either define a `SIDES` constant in the main scope or add an explicit caller to the `SIDES` reference in `Describable.describe_shape`: `self.class::SIDES`.

<b style="color:red; style:bold">QUESTION: CAN YOU INHERIT A CLASS METHOD FROM A MODULE?</b>

On line 25, the `sides` class method is invoked on the `Square` class and the return value is passed to the `#p` method call.  Ruby will try to resolve the `sides` class method by first looking at the `Square` class since that is the calling object.  Because it doesn't exist within `Square` it will traverse up the inheritance hierarchy until it locates the `::sides` method in the `Shape` class spannining lines 10 - 12.  We know this is a class method because the method name is prefixed with `self.`.  

Within this method, `self`, which is referencing the class, is using the namespace resolution operator `::` to reference the constant `SIDES`.  Ruby searches lexically when trying to resolve constants, which means it first searches the surrounding structure of the constant reference.  `SIDES` does not exist within `Square`, so Ruby will next look in any classes or modules that `Square` inherits from or includes.  `SIDES` does  exist within the `Quadrilateral` class.  Therefore, `Square` inherits the constant `SIDES` from `Quadrilateral` and `Square.sides` will return 4.

On line 26, a new `Square` object is instantiated and it invokes the `Square#sides`.  To resolve this instance method, Ruby will first look within the `Square` class and then traverse up the inheritance chain until it finds a `#sides` method in the `Shape` class spanning lines 14 - 16.  Within this method, `self`, refering to the calling object, invokes the `#class` method, which returns the calling object's class, which then uses the namspace resolution operator to reference the `SIDES` constant.  The `SIDES` constant exists in `Quadrilateral`, which `Square` inherits from, so `Square.new.sides` will return 4.  

On line 27, a new `Square` object is instantiated and it invokes `#describe_shape`, which is included in the `Shape` class via the `Describable` module, so `Square` inherits this method from `Quadrilateral` which inherits it from `Shape`.  Within the method, in an interpolated string, `self` which references the calling object, invokes the `#class` method, which returns the calling object's class.  ...

**4. What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?**


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

On line 26 a new `AnimalClass` object is instantiated and assigned to the local variable `mammals`.  On lines 27 - 29, three `Animal` objects are instantiated and added to the array referenced by of `mammals`'s `@animals` instance variable using the `AnimalClass#<<` method.  

On line 31 a new `AnimalClass` object is instantiated and assigned to the local variable `birds`.  On lines 32 - 34, three `Animal` objects are instantiated and added to the array referenced by the `birds`'s `@animals` instance variable using the `AnimalClass#<<` method.  

On line 36, the arrays referenced by the `@animals` instance variables in both `mammals` and `birds` are concatenated using the `AnimalsClass#+` instance method, which returns an array containing the six `Animal` objects instantiated on lines 27 - 29 and 32 - 34.  

Following examples from the standard library, like `Array#+` and `String#+`, the return value of concatenation should be of the same type as the two objects being concatenated.  Therefore, we should expect `mammals + birds` to return a new `AnimalClass` object.  To accomplish this, we would need to add the following code to `AnimalClass#+`:

```ruby
temp_obj = AnimalClass.new('temp')
temp_obj.animals = animals + other_class.animals
temp_obj
```
This new code instantiates a temporary `AnimalClass` object, reassigns its `@animals` instance variable to the return value of concatenating `animals + other_class.animals` and then returns the temporary object.  

The output is:

```ruby
[#<Animal:0x00007fdea10dc0a0 @name="Human">, #<Animal:0x00007fdea10dc028 @name="Dog">, #<Animal:0x00007fdea10dccf8 @name="Cat">, #<Animal:0x00007fdea005bd98 @name="Eagle">, #<Animal:0x00007fdea005bc30 @name="Blue Jay">, #<Animal:0x00007fdea005bbe0 @name="Penguin">]
```
Currently, `AnimalClass#+` is returning an array of `Animal` objects.  However, similar to other classes like `Array` and `String` in the standard library, the `AnimalClass#+` method should return an object of that class.  Therefore, we can instantiate a new `AnimalClass` object within `AnimalClass#+`, invoke the `animals` setter method to re-assign the new object's `@animals` instance variable to `animals + other_class.animals` and then return the new instance.

**5. We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?**


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

On line 22 a new `GoodDog` object is instantiated and assigned to the local variable `sparky` and this object invokes the `#change_info` instance method on line 23.  Based on the expected result, `GoodDog#change_info` is supposed to reassign the `@name`, `@height` and `@weight` instance variables to the arguments passed into the method call.  In it's current form, the code within the method is simply initializing local variables and setting them to the argument values.  There are two ways to achieve the method's intended goal:
1. Invoke the `name=`, `height=` and `weight=` setter methods by prepending each method name with `self.`. 
```ruby
self.name = n
self.height = h
self.weight = w
```
2. Reference the instance vairiables directly:
```ruby
@name = n
@height = h
@weight = w
```
It's generally considered best practice to invoke the setter methods, if available, because you can circumvent any validations embedded in your setter methods when referencing and reassigning instance variables dirtectly.<br><br>
<b style="color:red; style:bold">COMMENT: ELABORATE ON WHY IT IS BETTER TO INVOKE SETTER METHODS OVER REFERENCING INSTANCE VARIABLES?</b>

In order to reassign the `@name`, `@height`, `@weight` instance variables in the `#change_jnfo` method, we have to invoke the setter methods for each variable.  To do this, we need to prepend each method with `self.` to disambiguate it from initializing local variables.

**6. In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`?**


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

On line 13 a new `Person` objected is instantiated and assigned to the local variable `Bob`.  `p bob.name` on line 14 will output `"Bob"` since this value was passed in as an argument upon instantiation and assigned to the instance variable `@name`.  On line 15, the object referenced by `bob` invokes the `#change_name` instance method.  

When attempting to invoke the `name` getter method on line 9 within `#change_name` we are unintentionally referencing a local variable `name`, and because it has not yet been assigned a value, it's value is `nil`, as reflected by the `NoMethodError` message.  This means that
we initialize a local variable, and on the same line reference it via `name.upcase`, before it has
been assigned a value.  Invoking the `#upcase` method on `nil` caused the error we see.    If we intended to invoke the `name=` setter method, we would need to use `self` infront of `name` to disambiguate from local variable assignment (`self.name =` ). 

We could also reference the `@name` instance variable directly and reassign it to the return value of invoking `#upcase` on the return value of the `name` getter method. 

In order to reassign the `@name` instance variable in the `#change_name` instance method, we need to invoke the setter method `name`.  When invoking a setter method within a class, you must prepend it with `self.` to disambiguate it from initializing a local variable.  

We could also invoke the `name` getter method, which returns the value assigned to `@name`, and call the `upcase!` mutating method on it to get the same result.  

**7. What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?**


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

On line 9 the `Vehicle` class is calling the `::wheels` class method, which is defined on lines 4 - 6 and returns the value of the `@@wheels` class variable - `4`.  On line 15, the `Motorcycle` class invokes the `::wheels` class method it inherits from `Vehicle` and it returns the value of the `@@wheels` class variable, which is now `2` since it is reassigned within the `Motorcycle` class.  On line 16 `p Vehicle.wheels` will also output `2`, as will the `#p`invocations on line 20 - 22.  

This code demonstates that it can be dangerous working with class variables in inheritance because there is only one copy of a class variable shared across all subclasses, and if a class variable is reassigned in a subclass it will affect that variable in the superclass as well as in all other subclasses.  This is why using class variables in inheritance is discouraged.

*class variables are not encapsulated inside a method definition so they will be evaluated before invokinfg the `::wheels` method.*

*class variables are scoped within the class-hierarchy level*

On line 9, the `Vehicle` class is invoking the class method `:wheels`, which returns the value assigned to the class variable `@@wheels` within `Vehicle` - 4.  On line 15, the `Motorcycle` class is invoking the class method `::wheels`, which it inherits from its parent class, `Vehicle`.  The class variable `@@wheels` has been reassigned within `Motorcycle` to the integer 2, so `Motorcyle.wheels` and `Vehicle.wheels` on line 16 will both returns 2.  

This code demonstrates that there is only one copy of a class variable across all subclasses.  Therefore, reassigning a class variable within a subclass will affect that class variable in the superclass and all other subclasses. For this reason, we should avoid using class variables when working with inheritance.  

**8. # What is output and why? What does this demonstrate about `super`?**


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

On line 16 a new `GoodDog` object is instantiated and assigned to the local variable `bruno`.  On line 16, `p bruno` will return the class name of the object referenced by `bruno`, an encoding of its object id, and the names and corresponding values of its instance variables: `@name = "brown"; @color = brown`

The reserved word `super` allows us to invoke commonly named methods earlier in the method lookup path.  In this case, `super` is used within `GoodDog#initialize` to invoke the `#initialize` method in `GoodDog`'s parent class, `Animal`.  When `super` is used with no arguments passed to it, it will forward all arguments that are passed to the method from which it is called. Therefore, the `@name` instance variable in `Animal#initialize` will be set to `"brown"` and the `@color` instance variable in `GoodDog#initialize` will also be set to `"brown"`.

On line 16 a new `GoodDog` object is instantiated with the string "brown" passed into the `::new` class method as an argument.   This new object is assigned to the local variable `bruno` which is then passed to the `#p` invocation on line 17 as an argument.  This will output the name of `bruno`'s object class, an encoding of its object_id, and its instance variables and their corrresponding values `@name = "brown, @color = "brown"`.

The reserved word `super` is used in `GoodDog#initialize` to invoke the `#initialize` method within it's parent class `Animal`.  When `super` is called without any arguments, it forwards all arguments passed to the `#initialize` method from which its called to the method in the superclass. So the `@name` instance variable will be set to the `color`  argument to `#initialize`. `GoodDog#initialize` then adds extra functionality by initializing another instance variable, `@color` and setting it to the same local variable, `color`.  Therefore, when we inspect `bruno`, we see that both `@name` and `@color` are set to the string "brown" that was passed in as an argument upon instantiation.

**9. What is output and why? What does this demonstrate about `super`?**


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

Within `Bear#initialize` the reserved word `super` is used to invoke a commonly named method earlier in the method lookup path, which in this case is `Animal#initialize`.  When `super` is used with no arguments passed to it, it automatically forward all arguments passed to the method from which it is called.  

Therefore, the `color` argument will be passed to `Animal#initialize` upon instantiation of a new `Bear` object on line 13.  This will output an `ArgumentError` message becaude `Animal#initialize` does not accept any arguments.  To correct this, we would need to change how `super` is used to `super()`.  This allows us to call `Animal#initialize` with no arguments.  

One of the main reasons to use `super` is to override a method in a superclass, while still maintaining access to functionality from the superclass.  In this case, `Animal#initialize` does not contain any added functionality that is not in `Bear#initialize`, so we could also remove `super` from `Bear#initialize`.

Within `Bear#initialize` the reserved word `super` is used with no arguments passed to it.  `super` will search the method lookup path for a method in a parent class with the same name, which it finds in `Animal#initialize`, and it will forward all arguments from `Bear#initialize` to `Animal#initialize`.  However, `Animal#initialize` does not accept any arguments, so when the `:new` method is invoked on line 13 by the `Bear` class, it will trigger `Bear#intialize` and `super` will invoke `Animal#initialize` which will raise an `ArgumentError` exception.

**10. # What is the method lookup path used when invoking `#walk` on `good_dog`?**


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
```

When resolving a method, Ruby will first search the class definition of the calling object, which in this case if `GoodAninals::GoodDog`.  There is no `#walk` instance method within `GoodDog`, so Ruby will first check the modules includes `GoodDog`, starting with `Danceable` since it is the last one incliuded.  Not finding it in either module, Ruby will traverse up the inheritance hierarchy, considering any parent classes and their included modules, to locate `#walk`.  `GoodDog`'s parent class is `Animal`, and `Animal` includes the `Walkable` module, where the `walk` method is located.  Once Ruby finds this method in `Walkable` it will stop its search. So the method lookup path for invoking `GoodDog#walk` is:<br>
- `GoodAnimals::GoodDog`
- `Danceable`
- `Swimmable`
- `Animals`
- `Walkable`

- `GoodAnimals::GoodDog`
- `Danceable`
- `Swimmable`
- `Animal`
- `Walkable`

**11. What is output and why? How does this code demonstrate polymorphism?**


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

On line 23, the local variabel `array_of_animals` is initialized to an array containing three objects of three different classes.  On line 24 the array referenced by `array_of_animals` invokes the `#each` method and each object from the calling array is assigned to the block parameter `animal`. `feed_animal` is called within the block and the object referenced by local block variable `animal` is passed in as an argument.  Within `feed_animal`, the object passed in as an argument calls the `eat` method.  

Polymorphism is the ability of objects of different types to respond to a common interface or method invocation.  In this example, we have objects from the `Animnal`, `Fish` and `Dog` classes all invoking a method with the same name - `eat`.  More specifically, this code demonstrates polymophism through class inheritance because the `Fish` and `Dog` objects both inherit the `eat` behavior from the `Animal` class and can therefore respond to the method invocation, even though each of their implementations are different.

On line 23, the local variable `array_of_animals` is initialized to an array containing an `Animal`, a `Fish` and a `Dog` object.  On line 24, `#each` is invoked on the array referenced by `array_of_animals`, a `do..end` block is passed in as an argument, and each object within the array is assigned to the block parameter `animal`.  Within the block, the `feed_animal` method is invoked, which invokes the `eat` method on the object assigned to the the local block variable `animal`.  This code will output:
```
"I eat."
"I eat plankton."
"I eat kibble."
```
This code demonstrates polymorphism because different data types are responding to a common interface, in this case the method `eat`.  This is an example of polymorphism through inheritance because the `Fish` and `Dog` classes inherit the `#eat` method from  `Animal` and override it to provie their own custom implementations.

**12. We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?**


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

On line 20, a new `Person` object is instantiated and assigned to the local variable `bob`.  On lines 22 and 23, new `Cat` and `BullDog` objects are instantiated and assigned to the local variables `kitty` and `bud`, respecitively.  On line 25 and 26, the object referenced by local variable `bob` invokes the `pets` getter method which returns the an empty array assigned to its `@pets` instance variable.  Then `Array#<<` is invoked to append the objects assigned to `kitty` and `bud` to the `@pets` array.  

On line 28, the `#pets` getter method is invoked which returns the array assigned to `bob`'s `@pets` instance variable and then `jump` is called on this array.  This raises a `NoMethodError` because the `Array` class does not have a `#jump` instance method.  To correct this, we could invoke `#each` on `bob.pets` and call `#jump` on the `Cat` and `BullDog` objects in that array: `bob.pets.each(&:jump)`.  `Cat` and `BullDog` both inherit the `#jump` method from the `Pet` superclass, so this method call will output "I'm jumping!" twice.

`kitty` and `bud` represent collaborator objects because they are stored as state - in this case as elements in an array assigned to the `@pets` instance variable- within the `Person` object, `bob`.

On line 20, a new `Person` object is instantiated and assigned to the local variable `bob`.  On lines 22 and 23, a `Cat` and `BullDog` object are instantiated and assigned to the local variables `kitty` and `bud`, respectively.  On lines 25 and 26, the getter method `Bob#gets` is invokes, which returns the array that the instance variable `@pets` was initialized to in the `bob` object and the `Cat` and `BullDog` objects referenced by `kitty` and `bud` are appended to the array.  On line 28, the `#jump` method invocation will raise a `NoMethod` exception because the array that `bob.pets` returns does not have a `jump` method.  

`kitty` and `bud` represent collaborative object in relation to `bob` because they are objects from the `Cat` and `BullDog` classes that are stored as state in the array referenced by the instance variable `@pets` in the `Person` object assigned to `bob`.

**13. # What is output and why?**


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

On line 15 a new `Dog` object is instantiated and assigned to the local variable `teddy`.  On line line 16 the object reference by `teddy` invokes `Dog#dog_name`.  The `Dog` class overrides the `#initialize` method it inherits from `Animal`.  `Dog#initialize` accepts an argument, `name`, but it doesn't initialize the `@name` instance variable to the argument value.  Therefore, when `@name` is referenced in `#dog_name` it will return `nil`, so `puts teddy.dog_name` will output `"bark! bark!  bark! bark!"`

To fix this, we can delete `Dog`'s custom implementation of `#initialize` so that it inherits `Animal#initialize` and the `@name` instance variable is initialized upon instantiation of a new `Dog` object.

On line 15, a new `Dog` object is instantiated and assigned to the local variable `teddy`.  The object referenced by `teddy` then invokes `Dog#dog_name`.  Within `Dog#dog_name` there is an interpolated string which referenced the instance variable `@name`.  However, `@name` is never initialized within `Dog#initialize`, so the reference to `@name` will return `nil`, and `puts teddy.dog_name` will output `"bark! bark!  bark! bark!"`

**14. In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`?**

**Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?**


```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
    
  # def ==(other)
  #   name == other.name
  # end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true
```

To compare whether the two objects have the same name, we need to add a `==` instance method which uses `String#==` to compare the `@name` instance variables of two `Person` objects.  The method would look like this:
```ruby
def ==(other)
  name == other.name
end
```
`al.name == alex.name` is using `String#==` to compare the **values** of the objects referenced by `al` and `alex`'s `@name` instance variable.  If we wanted to check whether these instance variables point to the same object we could:
1. Compare their object id's: `alex.name.object_id = al.name.object_id` 
2. Invoke the `equal?` method on the string referenced by `alex.name` and pass in `al.name` as an argument: `alex.name.equal?(al.name)`.  `equal?` checks whether two objects have the same value and if whether they point to the same object.

Both comparisons (method calls) will return `false` because, even though the string's have the same values, they point to different spaces in memory.

The `==` method that I implemented in the `Person` class uses `String#==` to check two Person instances `@name` instance variables are set to the same value.  To check whether the String objects referenced by `al` and `alex`'s `@name` instance variable are the same object, we could invoke the `#object_id` method on each string object or compare the two strings with the `#equal?` method.

**15. # What is output on `lines 14, 15, and 16` and why?**


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

On line 13 a new `Person` object is instantiated and assigned to the local variable `bob`.  On line 14 the object referenced by `bob` invokes the `#name` getter method, which returns the value of the `@name` instance variable.  Therefore, `puts bob.name` will output `"Bob"`.  

One line 15 the object referenced by `bob` is passed to `#puts` as an argument.  By default, `#puts` calls `#to_s` on its arguments.  The `#to_s` method that all classes inherit from `Object` is overridden in `Person`.  In `Person#to_s`, the `#name` getter method is invoked, which returns the value assigned to `@name`, and this object invokes `String#upcase!`, a mutating method which changes the value of `@name` in place.  Therefore, `puts bob` will output `"My name is BOB."`

Because the value assigned to `@name` within the object referenced by local variable `bob` was mutated upon the `#puts` invocation on line 15, `puts bob.name` on line 16 will output the updated value of the `@name` instance variable - `"BOB"`

On line 13, a new `Person` object is instatiated with it's `@name` instance variable set to "Bob".  This object is assigned to the local variable `bob`.  On line 14 the object referenced by `bob` invokes the `#name` getter method, which is created by the `attr_reader :name` within the `Person` class.  The method call's return value is passed to `#puts` and will output `"Bob"`. 

On line 15, the object referenced by `bob` is passed to `#puts`.  The `#puts` method call automatically calls `#to_s` on it's arguments.  Within the `Person` class, the `#to_s` method has been overriden to return an interpolated string.  Within this string, `String#upcase!` is called on the return value of `#name`, which in this case is "Bob".  This method call will mutate the value assigned to `@name` within the `bob` object and `#puts` will output `"My name is BOB."`

On line 16, the object referenced by `bob` invokes `#name` again, which will return the value of the `@name` instance variable.  Because `@name` was mutated by the `#to_s` method call, `#puts` will now output `"BOB"`. 

**16. Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.**

When handling data, sometimes it makes sense to format, or even validate, the data immediately. For instance, in the initial example, we're given the string `'eLiZaBeTh'` and asked to format it while assigning it to the instance variable `@name`. This isn't an unrealistic request, due to the fact that first names are typically capitalized.

To accomplish this, we need to manually write the setter method. Normally, we would use Ruby's built in accessor methods, but since we have to add extra functionality to the method, we're forced to implement our own.


```ruby
class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize
  end
end
```

<b style="color:red; style:bold">COMMENT: FIND A GOOD EXPLANATION AND EXAMPLE FOR THIS QUESTION.</b>

It is generally better to invoke the setter method vs. referencing the instance variable directly when trying to set an instance variable with the class because there are situations where you might add extra functionality to a setter method and this can be only be done by manually implementing the method.  For example, if you create a bank class with one state, `@balance` and an instance method `#withdraw`.  

Within `#withdraw`, you use want to reassign the `@balance` state by substracting the amount withdrawn.  However, you want to prevent any withdrawal that will result in a negative account balance.  This can be accomplished by implementing a `#balance=` setter method which only allows `@balance` to be reassigned to a number greater or equal to 0 and invoking this setter method within `#withdrawal`.  Implementing this extra validation would not be possible if we referenced the `@balance` instance variable instead of the setter method.


```ruby
class Account
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def balance=(b)
    if b >= 0
      @balance = b
    else
      puts "Withdrawal of #{balance - b} unsuccessful!"
    end
  end

  def withdraw(amount)
    self.balance -= amount
  end
end

account = Account.new(500)
p account.balance
account.withdraw(250)
p account.balance
account.withdraw(350)
p account.balance
```

**17.  Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.**

When you want don't want to expose the raw data associated with an attribute of the class.  Instead of referencing a `ssn` getter method, we could manually write a custom getter method which changes the value of the instance variable before exposing it. 


```ruby
class Person
  def initialize(ssn)
    @ssn = ssn
  end

  def ssn
    # convert '123-45-6789' to 'xxx-xx-6789'
    'xxx-xx-' + @ssn.split('-').last
  end
end

p Person.new('000-000-1111').ssn


# class Person
#   attr_writer :name

#   def name
#     "Mr. #{@name}"
#   end
# end

# person1 = Person.new
# person1.name = 'James'
# puts person1.name

# To accomplish this, we need to manually implement the getter method. 
# As mentioned in the last exercise, we can't use the built in accessor 
# methods because we need extra functionality. 
```

**18. What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?**


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

Executing `Triangle.sides` will return either `nil`, `3` or `4`. The `Triangle` class inherits the `::sides` class method from `Shape`.  This method returns the value of the `@@sides` class variable. If you execute `Triangle.sides` without instantiating a new `Triangle` or `Quadrilateral` object then it will will return `nil`.  If you instantiate a new `Triangle` object immediately before executing `Triangle.sides` then it will return `3` because `Triangle#initialize` reassigns the `@@sides` class variable to 3.  If you instantiate a new `Quadrilateral` object before executing `Triangle.sides` it will return 4 because `Quadrilateral#initialize` reassigns `@@sides` to 4.  

These different results demonstrate that all subclasses share one copy of a class variable, and reassigning a class variable in a subclass will affect that variable in the parent/superclass.  

`Triangle.new.sides` will always always return 3.  This is because `Triangle.new` instantiates a new `Triangle` object and triggers `Triangle#initialize` wherein the `@@sides` class variable is reassigned to 3.  The `Triangle` class inherits the `#sides` instance method from `Shape`, which returns the value assigned to `@@sides` - 3.   

`Triangle.sides` can return `nil`, 3 or 4.  This occurs because the class variable `@@sides` is initialized to `nil` in the `Shape` class but it is reassigned whenever an object of one of its subclasses is instantiated.  

`Triangle.new.sides` will always return 3 because the `Triangle::new` method call will trigger `Triangle#initialize` which reassigns `@@sides` to 3.  

This demonstrates that there is one copy of a class variable across all subclasses and if a class variable is reassigned within a subclass it will affect the class varialbe in the superclass and all other subclasses.

**19. What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.**

*The `attr_accessor` method is Ruby's built-in method for creating getter and setter methods.  Getter and setter methdos allow us to expose and change an object's state.*

*We wouldn't want to add a `attr_accessor` method for every instance variable because we want to be intentional about what methods we include in our class's interface.  For example ...*

When adding getters and setters, it's easy to get carried away and simply add `#attr_accessor` for every instance variable. However, doing this can have negative implications. In the initial example, `#attr_accessor` is used for `@phone_number`. This means that `@phone_number` can be modified from outside the class, which we don't want.

We need to ensure that `@phone_number` cannot be modified from outside the class. To do this, we simply need to remove the setter method by changing `#attr_accessor` to `#attr_reader`. This still lets us set the value of the `@phone_number` instance variable when instantiating the object, and lets us read its value from outside of the class, but doesn't let us modify it from outside the class.

<b style="color:red; style:bold">COMMENT: FIND A GOOD EXAMPLE FOR THIS QUESTION.</b>


```ruby
class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number
```

When handling data within a class, sometimes certain data needs to be kept private, meaning that only the object knows what the data is. In this case, we want to control access to `@last_name`. We only want to allow the `Person` to retrieve that value.

To accomplish this, we place `#attr_reader` after the call to private. This means that only `Person` has access to this method. Public methods, like `first_equals_last?`, can be used to access `@last_name` through the private accessor method. However, `last_name` can't be invoked outside the class.


```ruby
class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?
```

`attr_accessor` is Ruby's built-in way to automatically create getter and setter method.  You only want to create getter methods for instance variables that you want exposed in the public interface and setter methods for instance 


...

**20. What is the difference between states and behaviors?**

States is the data associated with an object and they are tracked by an object's instance variables.  Behaviors are what the object is capable of doing and an object's behavior are exposed by its intance methods.  Two objects of the same class might have different states but they will always have the same behaviors.

States is the data asscociated with an object and they are tracked by the instance variables of the object.  Behaviors are what the object is capable of doing and they are exposed by an object's instance methods.  Two instances of the same class might have different have different states but they will have the same behaviors.

**21. What is the difference between instance methods and class methods?**


Instance methods can be invoked by individual objects of a class.  They have access to both instance variables and class variables.  

Class methods are prepended with `self.` and are invoked by the class itself, without having to instantiate an object from that class and they are where we put functionality that does not pertain to an individual object.  Class methods only have access to class variables.

Instance methods can be invoked by a calling object and class methods can be invoked by the class itself without having to instantiate an object.  Instance methods can access both instance variables and class variables, where class methods can only access class variables.  Class methods are prepended with the reserved word `self.` whereas instance variables have no prefix.  

**22.  What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.**

<b style="color:red; style:bold">COMMENT: REVIEW THIS TOPIC</b>

**23. How and why would we implement a fake operator in a custom class? Give an example.**

All custom class inherit the `==` method from the `BasicObject` class.  By default `BasicObject#==` does not perform an equality check; instead it returns `true` if two objects are the same object.  You would add a custom implementation of `==` to override `BasicObject#==` and provide a more meaningful way to compare two objects of your class.

For example, if we havre two objects from a `Person` class that are considered equal if the values assigned to their `@name` instance variables are the same, we could implement `==` in our class like this:


```ruby
class Person
  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end

  protected

  attr_reader :name
end

p Person.new("Alex") == Person.new("Alex")
```

**24. What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.**

When the reserved word `self` is used in a class definition outside of an instance method it refers to the class itself.   For example, when `self` is used to prepend a class method, it is referencing the class itself.
```ruby
class Student
    @@year = 1998
    
    def self.year
      @@year
    end
end
```

When `self` is used inside of an instance method definition, it refers to the calling object of the class.  An example of this is how we invoke a setter method within a class's instance method to disambiguate it from intiializing a local variable.

```ruby
class Person
  attr_accessor :height

  def initialize(height)
    @height = height
  end

  def change_height(new_height)
    self.height = new_height
  end
end
```

**25.  # What does the above code demonstrate about how instance variables are scoped?**


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

Instance variables are scoped at the object level.  These variables exist as long the object instance exists.  Unlike local variables, instance methods can access instance variables even if they are not initialized or passed to the method as arguments.  Instance methods can be used to expose an object's state (or the values assigned to its instance variables).

Instance variables are scoped at the object level and can only be accessed by instant methods.  The `Person` class has the `#get_name` method which `bob` uses to expose the value assigned to its `@name` instance variable.

<b style="color:red; style:bold">QUESTION: IS THERE ANYTHING TO ADD HERE?</b>

**26. How do class inheritance and mixing in modules affect instance variable scope? Give an example.**

<b style="color:red; style:bold">COMMENT: REVIEW THIS QUESTION AND FIND EXAMPLE</b>

**27. How does encapsulation relate to the public interface of a class?**

Encapsulation allows a programmer to hide pieces of functionality and make them unavailable to the rest of the code base.  It is a form of data protection so that data cannot be manipulated or changed without obvious intention.  Encapsulation is used to hide the internal representation of an object and only the properties and  methods that are neeeded by programmer are exposed.  Ruby accomplishes this task by creating objects and exposing interfaces (public methods) to interact with those objects.  This is done by using  mainly through the use of method access control - the access modifiers `public`, `private` and `protected` - to expose the properties and methods through the public interface of a class - its public methods.

**28 a. # What is output and why? How could we output a message of our choice instead?**


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

On line 12 a new `GoodDog` object is instantiated and assigned to the local variable `sparky`.  The `#puts` method automatically calls `#to_s` on its arguments, except for when the argument is an array, in which case it will call `#to_s` on every element in the array.  By default, `Object#to_s` output the argument's class name and an encoding of it's object id.  

To output a message of our choice we would need to override the `to_s` method within `GoodDog`:
```ruby
def to_s
  "#{name} is #{age} years old."
end
```

**28 b.How is the output above different than the output of the code below, and why?**


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

The output differs from the previous code because, along with the object's class name and an encoding of its object id, the object's instance variables and their associated values are also displayed.  We see this output because the `GoodDog` object referenced by `sparky` is being passed to the `#p` method invocation, which automatically calls `#inspect` on its arguments.  `Object#inspect` returns a string containing a human-readable representation of an object. The default inspect shows the object's class name, an encoding of the object id, and a list of the instance variables and their values.

<b style="color:red; style:bold">QUESTION: ANY DIFFERENCE BETWEEN INVOKING SETTER METHODS VS REFERENCING INSTANCE VARIABLES IN <code>#initialize</code>?</b>

**29. When does accidental method overriding occur, and why? Give an example.**

Method overriding occurs when a method that exists in a parent/superclass is rewritten in a subclass.  Every class you create inherently subclasses from the class `Object`.  This means that methods defined in `Object` are available in all classes.  Accidental method overriding can occur if you rewrite a method in a subclass that exists in the `Object` class.  For example, `send` is an instance method in `Object` which serves as a way for objects to call methods by passing in the method name as a symbol or string.  If you define a new `send` instance method in you class, all objects of your class will use the custom `send` method instead of the one inherited from `Object`.


```ruby
class Person
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end
end

lad = Person.new
p lad.send :say_hi
```


    ArgumentError: wrong number of arguments (given 1, expected 0)

    (irb):5:in `send'

    (irb):11:in `irb_binding'


**30. How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.**

Method access control allows us to allow and restrict access to method within a class.  Method Access Control is implemented in Ruby by using the `public`, `protected` and `private` access modifiers.  All methods in a custom class are public by default.  If you want to definea public method and another access modifier has already been invoked in the class, you can either insert you method above the access modifier or explicitly invoke `public` below the other access modifier and define your new method below the `public` method call.  

Private methods are only available to methods within a class and cannot be invoked outside of the class.  You define private methods by using the `private` method call and any methods defined below are private.

```ruby
class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?
```

Similar to private methods, proteced methods are only available to other methods within a class and cannot be invoked outside the class.  Where protected methods differ from private methods is that they are accessible between instances of the same class.  This allows for controlled, but wider accesss between objects of the same class.  
```ruby
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected 

  attr_reader :amount
end
```

**31. Describe the distinction between modules and classes.**

Modules and classes are both used as a way to group common behaviors which allow programmers to build more powerful, flexibilty and DRY design.  In class inheritance, one class will inherit the behaviors of another class and this new class becomes a specialized type of the superclass.  In interface inheritance, we use modules to mix in behaviors to a class.  The class doesn't inherit from another type, but instead inherits the interface provided by the mixin module.  

The two main differences between modules and classes is:
1. You cannot instantiate a module; an object cannot be created from a module.
2. You can only subclass from one superclass but you can include as as many modules in your class as you need.

**32. What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.**

Polymorphism is the ability of objects of different classes to respond to a common interface. In Ruby, polymorphism is implemented in three ways:<br><br>
<b><u>1. Polymorphism through class inheritance</u></b>

Polymorphism through class inheritance occurs when the interface of class hierarchy allows us to work with a set of different types in the same way even though the implementations may be different.  In the following example, we have objects of different classes that share a common ancestor.  They inherit the behaviors of the superclass, but override the method so that the implementation of those methods differs between the classes.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def speak
    "The dog says arf!"
  end
end

class Cat < Animal
  def speak
    "The cat says meow!"
  end
end
```
<b><u>2. Polymorphism through interface inheritance</u></b>

When objects of different classes have a common behavior that is defined in a common source (a module) they all include.  In the following example, the classes are not inheriting from another type or class, but instead they are  **inheriting the interface** of a module that is not hierarchically related to them.

```ruby
module Walkable
  def walk
    puts "#{name} #{gait} forward"
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

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end
```

<b><u>3. Polymorphism through duck typing</u></b>

When objects of different, unrelated classes respond to a common method invocation.  With duck typing, we don't care about the type or class of an object, we are only concerned about whether the object has a particular behavior.  So long as the objects involved are capable of using the same method name and those methods accept the same number of arguments, then we can treat the object as belonging to a specific category of objects.  In this way, duck typing is an informal way of ascribing a type to an object (classes are the formal way).  
```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    #implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end
```

**33. What is encapsulation, and why is it important in Ruby? Give an example.**

Encapsulation is the hiding of certain pieces of functionality and making them unavailable to the rest of the code base.  It is a form of data protection so that data cannot be manipulated or changed without obvious intention.  Encapsulation allows us to hide the internal representation of an objects and only expose the properties and methods that users of the object need.  We can use method access control in Ruby to expose these methods and properties through a class's public interface.  Encapsulation is important in Ruby because it simplifies using a class and it protects data from undersired changes from the outer world.

<b style="color:red" >COMMENT: FIND EXAMPLE FOR ENCAPSULATION.</b>

**34. What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?**


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


```ruby

```

**35. What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?**


```ruby

```

**36. What is the relationship between classes and objects in Ruby?**


```ruby

```

**37. When should we use class inheritance vs. interface inheritance?**


```ruby

```

**38. If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?**


```ruby
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new
```

If we were to use `==` to compare the `Cat` objects in this code, the return value would be `false`.  All classes inherit the `==` from the `BasicObject` class.  `BasicObject#==` does not perform an equality check; instead it checks if two objects are the same object.  The `Cat` objects referenced by local variables `whiskers`, `ginger`, and `paws` all point to separare addresses in memory even though they are all objects of the `Cat` class.  

<b style="color:red" >QUESTION: WHAT DOES THIS DEMONSTRATE ABOUT CLASSES AND OBJECTS?.</b>

**39. Describe the inheritance structure in the code above, and identify all the superclasses.**


```ruby
class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end
```

`SomethingElse <- AnotherThing <- Thing <- Object <- Kernel <- BasicObject`

Superclasses:
- `AnotherThing`
- `Thing`
- `Object` 
- `Kernel`    <b style="color:red">IS <code>kernel</code>A SUPERCLASS?</b>
- `BasicObject`

**40. What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.**


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

When trying to resolve a method, Ruby will first look in the calling object's class.  There is no `#fly` instance method in `Penguin`, so Ruby will then search any modules included in the class, starting with the last one to be included.  There is no `fly` method in `Migratory` or `Aquatic`, so Ruby will then traverse up the inheritance hierarchy and search `Bird` and `Animal`.  Finally, Ruby will search the `Object` class, the `Kernel` module and the `BasicObject` class before raising a `NoMethodError` exception because it was unable to locate `fly` on the method lookup path.

- `Penguin`
- `Migratory`
- `Aquatic`
- `Bird`
- `Animal`
- `Object`
- `Kernel`
- `BasicObject`

**41. # What does this code output and why?**


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

On line 21 a new `Cow` object is instantiated and assigned to the local variable `daisy`.  The object referenced by `daisy` then invokes `speak` on line 22.  When trying to resolve a method, Ruby will first search the calling object's class.  There is no `#speak` method in `Cow`, so Ruby will traverse up the inheritance hierarchy and search `Cow`'s parent class `Animal`, where it will locate `#speak` on lines 6 - 8.  

In the body of `Animal#speak`, the `#sound` instance method is invoked and the return value is passed to a `#puts` method call.  Within the body of `Cow#sound`, the keyword word `super` is used, which invokes a method with the same name in a parent class, in this case `Animal#sound`.  `Animal#sound` returns the interpolated string `"Daisy says "`.  `Cow#sound` concatenates this return value to the string `"moooooooooooo!"`.  So `daisy.speak` will output `"Daisy says moooooooooooo!"`

<b style="color: red">CHECK LANGUAGE ON THIS WRT INHERITANCE</b>

**42. Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.**


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

In Ruby, instance methods expose behaviors for an object.  Two objects of the same class will always have the same instance methods, so the `Cat` objects referenced by `max` and `molly` have the same behaviors.  

Instance variables are responsible for tracking the state of an object.  `max`'s instance variables are both pointing to different objects than `molly`'s corresponding instance variables, therefore both objects have different states.  This demonstrates that in Ruby, while two objects of the same class may have different states, they will always have the same behaviors.

**43. In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?**


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

On line 14 a new `Student` object is instatiated and assigned to the local variable `priya`.  On line 15 the object referenced by `priya` invokes the `#change_grade` method and passed in the string `"A"` as an argument.  `Student#change_grade` is defined on lines 9 - 11 with the `Student` class.  To adjust this method to produce the desired result, we would need to invoke the `grade=` setter method by replacing `grade` with `self.grade`.  Prepending `grade` with `self.` disambiguates this code from initializing a local variable `grade`.   Invoking the `gradee=` setter method will allows us to reassign the `@grade` instance variable, so that when we invoke the `grade` getter method on line 16 it will return `"A"`.

**44. # What does each `self` refer to in the above code snippet?**


```ruby
class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new
```

When used within a class defintion, `self` refers to the class, unless it is used within an instance method, in which case it refers to the calling object (an object instantiated from that class).  The `self` on line 2 refers to the class, `MeMyselfandI`.  The `self` on line 4 prepends the `::me` class method and refers to the class, as does the `self` in the `::me` method body.  The `self` on line 9 is used within an instance method and refers to the calling object or an instance of the class.

**45. Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?**


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

On line 9 a new `Student` object is instantiated and assigned to the local variable `ade`.  On line 10 the object referenced by `ade` is passed to a `#p` invocation, which outputs a human-readable representation of an object, including the object's class name, an encoding of the object id, and the instance variable `@name` and its value `"Adewale"`.  

The `@grade` instance variable is not included in the output because it is never initialized in `Student#initialize`.  `Student#initialize` has two parameters, and the `grade` parameter is given a default value of `nil`.  However, the `@grade` instance variable must be initialized to that default value in order for it to be considered part of the state of the `Student` object referenced by `ade`.
```ruby
def initialize(name, grade=nil)
  @name = name
  @grade = grade
end
```

This code demonstrates that uninitialized instance variables will return `nil` and that only initialized instance variables can be considered part of an object's state.

**46. What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`?**


```ruby
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    # "#{@name} is speaking."
    "#{name} is speaking"
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

On line 19 a new `Knight` object is instantiated and assigned to the local variable `sir_gallant`.  On line the object referenced by `sir_gallant` invokes the `#name` instance method defined on lines 14 - 16 in the `knight` class.  The body uses the reserved word `super` to invoke the `name` getter method in it's parent class `Character`, which return the value assigned to its instance variable `@name`. `Knight#name` concatenates `"Sir "` with this return value, therefore `p sir_gallant.speak` will output `"Sir Gallant"`.

On line 21, the object referenced by `sir_gallant` invokes the `#speak` instance method.  Ruby will first search the calling object's class when resolving a method.  There is no `#speak` in `Knight`, so Ruby will traverse up the inheritance hierarchy and locate `#speak` in the `Animal` class.  The body of `#speak` uses string interpolation to return the value assigned to the `@name` instance variable concatenated with `" is speaking"`, so `p sir_gallant.speak` will output `"Gallant is speaking"`.  

To have the last line output `"Sir Gallant is speaking"` we would need to make a change to `Character#speak`.  Instead of referencing the `@name` instance variable, we will instead invoke the `name` getter method,  so that when we invoke `#speak` on a `Knight` object, the `name` method call will return `Sir Gallant` concatenated with `" is speaking."`.  

**47. What is output and why?**


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

p Sheep.new.speak
p Lamb.new.speak
p Cow.new.speak 
```

 On line 25 a new `Sheep` object is instantiated and it invokes the `#speak` instance method.  `Sheep#speak` uses the reserved word `super` to invoke a method with the same name in `Sheep`'s parent class, `FarmAnimal`.  The `self` in the method body of `FarmAnimal#speak` refers to the calling object, and `#to_s` is automatically invoked in string interpolation, so `FarmAnimal#speak` will return a string containing the calling object's class name, an encoding of its object id and the word `"says"`.  Therefore, `p Sheep.new.speak` will output `"#<Sheep:0x00007f9f480713b0> says baa!"`.

<b style="color:red">FINISH THIS QUESTION</b>

**48. What are the collaborator objects in the above code snippet, and what makes them collaborator objects?**


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

On line 14 a new `Person` object is instiated and assigned to the local variable `sara`.  The string literal `"Sara"` is passed to `::new` upon instantiation of the object referenced by `sara`, so `sara`'s `@name` istance variable now references `"Sara"`.  

On line 15 a new `Cat` object is instatiated and assigned to the local variable `fluffy`.  The string `"fluffy"` and the `Person` object assigned to `sara` are passed to `::new` upon instantiation of the object referenced by `fluffly`, so `fluffy`'s `@name` instance variable now referenced `"Fluffly"` and its `@owner` instance variable now points to the object referenced by `sara`.  

Collaborator objects are objects that are stored as state in other objects.  In this code, `"Sara"` is a collaborator object with `sara` and `"Fluffy"` and `sara` are collaborator objects with `fluffy`.  

**49. What methods does this `case` statement use to determine which `when` clause is executed?**



```ruby
number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end
```

`===` is a method that is used implicity by a `case` statement.  `Integer#===` is used on lines 4 and 5 when comparing each when clause with `number` and `Range#===` is used on line 6 to compare the `40..49` to `number`.

<b style="color: red">IS <code>Integer#===</code> USED ON LINE 5?</b>

**50. # What are the scopes of each of the different variables in the above code?**


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

- `TITLES` is a constant so it has lexical scope.
- `@@total` is a class variable so it is scoped at the class level
- `@name` and `@age` are instance variables so they are scoped at the object or instance level.

**51. The following is a short description of an application that lets a customer place an order for a meal:**
```
# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.
```


```ruby

```

**52. In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?**


```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

In `Cat#make_one_year_older` we use the `self.` prefix to invoke the `age=` setter method so that we can reassign the `@age` instance variable.  Instead of invoking the setter method, we could also reference the `@age` instance variable directly like so:
```ruby
def make_one_year_older
  @age += 1
end
```
In is considered best practice to invoke the setter, if available, to reassign an instance variable.  There can be certain validations built in to a custom setter method that can be circumvented if we referenced the instance variable directly.  For example, if we wanted to write a setter method in `Cat` that sets an age limit at 5 for the `@age` instance variable, we could implement it like this:
```ruby
class Cat
  attr_accessor :type
  attr_reader :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def age=(a)
    if a > 5
      puts 'Age limit exceeded'
    else
      @age = a
    end
  end

  def make_one_year_older
    self.age += 1
  end
end

my_cat = Cat.new("scruffy")
6.times do 
  my_cat.make_one_year_older
  p my_cat.age
end
```

**53.  What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?**


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

```
This is basic ruby mixin functionality that makes ruby so special. While extend turns module methods into class methods, include turns module methods into instance methods in the including/extending class or module.

module SomeClassMethods
  def a_class_method
    'I´m a class method'
  end
end

module SomeInstanceMethods
  def an_instance_method
   'I´m an instance method!'
  end
end

class SomeClass
  include SomeInstanceMethods
  extend SomeClassMethods
end

instance = SomeClass.new
instance.an_instance_method => 'I´m an instance method!'

SomeClass.a_class_method => 'I´m a class method'

https://stackoverflow.com/questions/4699355/ruby-is-it-possible-to-define-a-class-method-in-a-module
```

**54. What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?**


```ruby
class House
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

```
The Comparable mixin is used by classes whose objects may be ordered. The class must define the <=> operator, which compares the receiver against another object, returning a value less than 0, returning 0, or returning a value greater than 0, depending on whether the receiver is less than, equal to, or greater than the other object. If the other object is not comparable then the <=> operator should return nil. Comparable uses <=> to implement the conventional comparison operators (<, <=, ==, >=, and >) and the method between?.
```

_____


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

**super**


```ruby
class Person
  @@total_people = 0
  def initialize
    # @name = name
    @@total_people += 1
  end
end

class Student < Person
  def initialize(student_number)
    super()
    @student_number = student_number
  end
end
```


```ruby
# module WindPowered
#   def move
#     "with the wind"
#   end
# end

# class Animal
#   def move
#     "with muscles"
#   end
# end

# class Fish < Animal
#   def move
#     "with fins and tail"
#   end
# end

# class Dog < Animal
#   def move
#     "with legs"
#   end
# end

# class Truck
#   def move
#     "with engine"
#   end
# end

# class Ball
#   def move
#     "by rolling"
#   end
# end

# class Sailboat
#   include WindPowered
# end

# class Kite
#   include WindPowered
# end

# p Fish.new.move
# p Dog.new.move
# p Truck.new.move
# p Sailboat.new.move
# p Kite.new.move
# p Ball.new.move
```
