# Notes from practice session with Matic
- started 10:15 am-ish
- why encapsulate?  e.g., give different output - not bad



- method access control - asked about other kinds
- 
- ask about interface
- ask about comparisons
- ask about overriding
- modules, mixin


- work on examples
- `== is in BasicObject;  
- not specialized class - call it a subclass


# Notes from practice session with Mohammed

- question on uninitialized instance variables
- question on using super more than 1 level of inheritance up
- question about mutation of string objects referenced by instance variables




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