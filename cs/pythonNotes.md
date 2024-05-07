# Python notes
https://docs.python.org/3/index.html
- Library Reference discusses built-in types, etc.
- Language reference discusses expressions, etc.


## Installing Pyenv
- https://medium.com/@therazmatrix/how-to-install-and-use-pyenv-in-ubuntu-22-04-fa7c28ca0b67

1. `sudo apt update`
2. `curl https://pyenv.run | bash`

  Message after running above:
    WARNING: seems you still have not added 'pyenv' to the load path.

    > Load pyenv automatically by appending
    > the following to
    > ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
    > and ~/.bashrc (for interactive shells) :

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    > Restart your shell for the changes to take effect.
    > Load pyenv-virtualenv automatically by adding
    > the following to ~/.bashrc:

    eval "$(pyenv virtualenv-init -)"

3. restart Ubuntu
4. `pyenv --version` should work
5. install additional packages (e.g., bzip2) (I had to do this since running the install line below didn't work)
```
sudo apt install build-essential libssl-dev zlib1g-dev \ 
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```
6. `pyenv install 3.12.2` (latest version according to python.org)
7. `pyenv global 3.12.2` (to set latest version to the "global" version [vs local])
8. `python` or `python3` or `python file.py`

## Types
https://docs.python.org/3/library/stdtypes.html
https://peps.python.org/pep-0008/ (style guide for Python code)

- in Python everything with a value is an object 
  - all data objuect has an associated data type
  - each type has an associated class

  - `type()` gives the class/type of the object
  - to check types:
      - `isinstance(some_var, list)` (checks if `some_var` is of type `list`)
      - `type(some_var) is list` : equivalent to above
      - `type(some_var).__name__ == 'list'` : another option

- Python types:
  - (non-primitive types are "collection types")
  - Primitive: (immutable) `int`, `float`, `bool`, `str` (text sequence)
  - Sequences:  `range`, `tuple`, (immutable)    `list` (mutable)
  - Maps: `dict` (mutable)
  - Sets: `set` (mutable)
  - Frozen set: `frozenset` (immutable)
  - functions (immutable)
  - `NoneType`: `NoneType` (immutable)

- in REPL:
  - e.g., `mystring = 'hello'`
  - then type `mystring.` and then hit tab to display all methods on string type

- strings
  - https://docs.python.org/3/library/stdtypes.html#string-methods
  - can be `'` or `"`
  - escape characters with `\`;  e.g., `'this isn\'t good'`
  - to reverse a string, use slice: `reversed_string = "hello"[::-1]` (assigns `'olleh'`)
  - `len(str)`
  - `str.upper()`
  - `str.casefold()` (more aggressive version of `lower` which works better for foreign lang)
  - `str.capitalize()` (good for 1 word)
  - `str.title()` (good for entire sentence)

  - to break-up a string into a list of characters:  `list(string)`
    - the list constructor will break up the string into individual characters
  
  - raw string literals:  don't recognize escape characters like `\`
    - e.g., `r"c:\users\xyzzy"`  (prefix string with "r")
  - f-string (formatted string literals)
    - e.g., `f"this is a {var} here"` (variables / expressions can go in {})

  - Note:  characters in a string aren't objects
    - strings aren't actual collections since the characters in a string aren't objects

  - string (array) slicing:
    - `myString[start:stop:step]`, where `start`, `stop`, `step` are indexes
      - `stop` is NOT inclusive
      - `[start:]` : goes from start to end of string
      - `[:stop]` : goes from 0 to `stop`
      - `[:]` : copies the str (array)
      - negative indices count from the end
        - e.g., `[-1]` is last item in the string / array

- multi-line strings:  `"""` to start and end
  - or use `\n` (newline, linux) `\r` (carriage return), `\t` (tab), `\\` escaped slash
  - note:  windows newline is `\r\n`

- lists (arrays)
  - https://docs.python.org/3/tutorial/datastructures.html
  - can use negative indices to count from end
  - out-of-bound indexes raise an error (either positive or negative)
    - accessing the first element of an empty list will return an `IndexError`
      - **always write checking code**
  - last element of list is `list[-1]` (note use of negative index)
  - `for word in word_list:`  (iterates each `word` in `word_list`)
  - can also iterate using:
    - `for idx, x in enumerate(myList):`

  - `==` (equality of arrays) is based upon their values (not their identity / memory location)
    ```python
    list1 = [2, 6, 4]
    list2 = [2, 6, 4]

    print(list1 == list2) # True (the values are the same)
    print(list1 is list2) # False (based on memory location, these are separate objects)
    ```
  - Note:  remember that `join` is a *string* method (not a list method)
  - `my_list.copy()` : makes a shallow copy of `my_list` (i.e., nested objects may have the same elements referenced, not copies)

  - `.reverse()` will mutate in-place (using slice `[::-1]` will return a reversed copy)

- tuples
  - e.g., `my_tuple = (3.14, 2.72, 1.41)`
  - are immutable
  - Python can perform optimizations on tuples to improve storage requirements and performance
  - creating single element tuples requires a trailing comma e.g., `my_tuple = (1, )`


- set
  - an unordered collection of unique objects (sometimes called *members* of the set)
  - members must be immutable, hashable, and unique
  - e.g., `my_set = {"dog", "cat", "pet"}`


- numbers
  - can write numbers with `_` as separators:  e.g., `2_928_933`
  - there is no limit to the size of integers
  - max size to floats can be queried: (need `import sys`)
    - `print(sys.float_info.dig)` (number of digits) 
    - `print(sys.float_info_max)` (max number)
    - `print(sys.float_info_min)` (min number)

  - to calculate exact decimal numbers in Python:
  ```python
  from decimal import Decimal
  Decimal('0.1') + Decimal('0.2') == Decimal('0.3')  # True

  # alternative
  import math
  math.isClose(0.1 + 0.2, 0.3) # True
  ```
    - always need to work with decimal strings, otherwise, you'll be using floats


- None `<class 'NoneType'>`

- dictionaries:
  - for keys, can use type:
    - strings
    - integers
    - boolean
    - floats
    - tuples
  - keys must be immutable (i.e., lists, sets, dictionaries are not allowed as keys)
    - tuple can be used (tuples are immutable) if elements in the tuple are immutable and hashable
  - keys must be hashable (consistent hash values can be computed)
    - e.g., lists are non-hashable

  - best to use `dict.get("keyName")` to retrieve values
      - if `keyName` doesn't exist in the hash, then `None` is returned
      - if using `dict['keyName']`, a non-existent key will throw an error

  - `len(my_dictionary)` : returns the number of key-value pairs
  - `for k, v in my_dictionary.items():` : allows iterating through key-value pairs
  - `for value in my_dictionary.values()` : allows interating through values
  - `.keys()` allows iterating over keys
  - `my_dict.get('key_name', 'some value')` : returns 'some value' if `my_dict['key_name']` doesn't exist

  - `del myDict[key]` : delete key from dictionary

  - from Python v3.7 and up,  key-value pairs are stored int he same order they are inserted into a dictionary
    - prior to v3.7 key-value order is unpredictable



## Syntax Notes
- **expressions** : combines values, variables, operators, calls to produce a new object;  must be evaluated to determine its value
- **statement** : an instruction that tells Python to perform an action of some kind;  don't return values

- Note: Python iterators can generally only be consumed (i.e., iterated through) once
  - an exception is `range()`

- `pass` : a statement that indicates that there is no content in a definition (e.g., class, function, block), yet

- variable naming:
  - typically uses lower_case_with_underscores (snake_case)

- falsy values:
  - zero: `0`, `0.0`, `0j`, `Decimal(0)`, `Fraction(0, 1)`
  - empty sets:  `''`, `()`, `[]`, `{}`, `set(0)`, `range(0)`
  - `False`
  - `None`

- **conditionals**
  - ternary:  e.g., `print('Yes') if True else print('No')`
      - "value1 if condition else value2"

  ```python
  match(lang, region):    # can have multiple variables to 'match'
      case ('en', 'US'):
          return 'en US'
      case ('en', 'GB'):
          return 'en GB'
      case _:
          return 'something else'

  ```

- functions:
  - must explicitly `return` a value (no implicit return)
  - functions with no return value return `None`
  - re-declared functions "overwrite" (replace) the prior definitions

  - can declare functions within functions
    - these are created and destroyed every time the outer function is executed

  - built-in functions (examples):
    - `float()`
    - `str()`
    - `list()`
    - `input()`
    - `print()`
    - `type()`
    - `len()`
    - `min()`, `max()`
    - `sum()`
    - `ord()`, `chr()`
    - `any()`, `all()`
    - `id()` : returns a unique identifier in memory for an object
        - same values may have the same space in memory through a process known as "interning" (varies by Python implementation)
    - `dir()` : returns a list of all identifiers in the current scope
    - `sorted()` : creates and returns a new sorted output
    - `reversed()` : returns a lazy sequence with elements in reversed order; use for just iterating over elements in reverse order

    - `from pprint import pp` : allows use of "pretty print";  e.g., `pp(names)`
    - `.zip()` : combines iterables into a list of tuples


- `%` operator
  - in Python, this is the modulo operator (*not* remainder)
    - modulo differs from remainder in how negative numbers are managed


- `==` : if data types are different, generally returns `False`
  - exception is numbers: all number types can be compared for equality (e.g., `1 == 1.0` is `True`)
  - comparison for standard types will be based on values
  - comparison for non-standard types will depend on implementation (see documentation)

- comparison:
  - strings are compared lexicographically (character-by-character, from left-to-right)
    - uppercase characters are LESS THAN lowercase characters (check standard ASCII table for other chars)

- coercions:
  - Python will implicitly coerce numbers to a more "complex" type, but will errors if trying to go to one with less fidelity
  - Python will coerce `True` to `1` and `False` to `0` : beware
  - use of `print` will implicitly coerce to strings
  
  - explicit:
    - `str()` : coerce to string
    - `repr()` : returns a "string representation" (will put single quotes around strings)
    - `int()` : coerce to integer
    - `float()` : coerce to float

### Comprehensions
- a way of building up a mutable collection
  - can be done with lists, sets, dicts
  - cannot be done with tuples, range, string (not mutable)

- e.g., list comprehensions
-[ expression for element in iterable if condition ]
  - expression: (optional) is typically used to perform a transformation of the elements in the existing (original) collection
  - iterable: is the original collection
  - if condition: (optional) is typically used to perform selection;  multiple criteria are possible


### Regex
- https://docs.python.org/3/library/re.html#re.search
- https://docs.python.org/3/howto/regex.html
- https://docs.python.org/3/library/re.html

- need to `import re` (import the regex module)
- typical flags (e.g., `/i` `/g` are not directly able to be entered)
  - `/i` is entered as an optional argument when using `re.compile(r'regexString', re.VERBOSE)`
  - `/g` is addressed by using a different python method (e.g., `re.finditer()`)



### Variable scope
- must initialize variables before they are accessed

- variables initialized inside a block (like an `if` statement) *are* accessible outside of that block
- variables must be initialized to be accessed
  - i.e., must be declared and assigned a value
  - otherwise, will return a 'NameError' when attempting to access

- variables declared in the top-level of code are globally accessible throughout code including inner (function) scopes
  - however, to re-declare those variables (i.e., change a variable declared *outside* of the current scope [e.g., within a function]), 
    - need to use the `global` or `nonlocal` keyword to "redeclare" that variable in the current scope
    - `global` indicates variable is in the global scope (no matter how deeply nested it is referenced)
    - `nonlocal` indicates variable is in an "outer" scope - Python will check each layer
  - otherwise, Python assumes a local variable is being referenced (and will return a 'UnboundLocalError')
  - Note:  any declaration of a shadowing inner variable within the scope will shadow access to the outer variable within the *entire* scope
  ```python
  a = 1

  def my_function():
      # global a    # if included, this line will tell Python the `a` var referenced here is in the global scope
      print(a)    # this line raises the UnboundLocalError
      a = 2       # this declaration leads to the UnboundLocalError

  my_function()
  print(a)
  ```

### Imports
- `import math` : import the `math` module for use
  - use as `math.sqrt(math.pi)`
- `import math as m` : imports `math` under the name `m`
  - use as `m.sqrt(m.pi)`
- `from math import pi, sqrt` : alternative just import parts of `math`
  - use as `sqrt(pi)`


## OOP notes
- notes:
  - constructor is always `__init__`
  - `self` must be passed into instance methods (incl. `__init__`) to access instance variables (can use any name, but 'self' is conventional)
  - to instantiate a new object of a class:
    - the *class* constructor calls `__new__` (an *object* constructor)
    - the *class* constructor then calls `__init__` (the *instance* constructor) to initialize the new instance

- `self` always represents the *calling object* for a method

```python
class GoodDog:

    def __init__(self, name):
        # self.name is an instance variable (state)
        self.name = name
        print(f'Constructor for {self.name}')

    # speak is an instance method (behavior)
    def speak(self):
        # We're using the self.name instance variable
        print(f'{self.name} says Woof!')

    # roll_over is an instance method (behavior)
    def roll_over(self):
        # We're using the self.name instance variable
        print(f'{self.name} is rolling over.')

sparky = GoodDog('Sparky') # Constructor for Sparky
sparky.speak()             # Sparky says Woof!
sparky.roll_over()         # Sparky is rolling over.

rover = GoodDog('Rover')   # Constructor for Rover
rover.speak()              # Rover says Woof!
rover.roll_over()          # Rover is rolling
```

```python
class Pet:

    def __init__(self, name):
        self.name = name
        type_name = type(self).__name__
        print(f'I am {name}, a {type_name}.')

class Dog(Pet):  # note inheritance:  Dog inherits from Pet

    # __init__ method removed
    def speak(self):
        print(f'{self.name} says Woof!')

    def roll_over(self):
        print(f'{self.name} is rolling over.')

class Cat(Pet):

    # __init__ method removed
    def speak(self):
        print(f'{self.name} says Meow!')

class Parrot(Pet):

    # __init__ method removed
    def speak(self):
        print(f'{self.name} wants a cracker!')

sparky = Dog('Sparky')
fluffy = Cat('Fluffy')
polly = Parrot('Polly')

sparky.roll_over()

for pet in [sparky, fluffy, polly]:
    pet.speak()
```

- no truly private attributes in Python
  - convention is to name private variables with `_` or `__` prepending the name
  - up to developers not to directly access private attributes
  - if `__` is used, can only change that variable using:  `instanceName._ClassName__privateVar`

```python
class GoodDog:

    def __init__(self, name, age):
        self.__name = name
        self._age = age

    def speak(self):
        return f'{self.__name} says arf!'

sparky = GoodDog('Sparky', 5)

sparky.__name = 'Fido' # this appears to work, but doesn't actually change the instance variable __name
print(sparky.__name)         # Fido
print(sparky.speak())        # Sparky says arf!

sparky._GoodDog__name = 'Fido'  # this alternate syntax is required to change the instance variable directly
print(sparky._GoodDog__name) # Fido
print(sparky.speak())        # Fido says arf!
```

### Properties
- implemented through the use of "decorators" (methods that modify other methods)
- properties should be used to:
  - strongly discourage misuse of instance variables
  - to validate data when instance variables receive new values
  - dynamically compute attributes
  - need to refactor code in a way that may be incompatible with the existing interface
  - to help improve code readability

```python
class GoodDog:

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def speak(self):
        return f'{self.name} says arf!' # note: other methods now reference the getter/setter

    @property # use of this decorator creates the @name.setter property used below;  this defines a getter
    def name(self):
        return self._name  # note only getter/setter reference the "private" instance variable

    @name.setter # this defines a setter
    def name(self, name):
        if not isinstance(name, str):
            raise TypeError('Name must be a string')

        self._name = name # note reference to "private" instance variable here

    @property
    def age(self):
        return self._age

    @age.setter
    def age(self, age):
        if not isinstance(age, int):
            raise TypeError('Age must be an integer')

        if age < 0:
            raise ValueError("Age can't be negative")

        self._age = age

sparky = GoodDog('Sparky', 5)
print(sparky.name)          # Sparky;  the getter is referenced
print(sparky.age)           # 5
sparky.name = 'Fireplug' # the setter is referenced

print(sparky.name)          # Fireplug
sparky.age = 6

print(sparky.age)           # 6

sparky.name = 42  # TypeError: Name must be a string (as per code in setter)

sparky.age = -1   # ValueError: Age can't be negative (as per code in setter)
```

### Class Methods
- are implemented using the `@classmethod` decorator

```python
class GoodCat():

    @classmethod  # defines a class method
    def what_am_i(cls):
        print("I'm a GoodCat class!")

    @classmethod
    def qux(cls):
        print('this is qux')
        cls.what_am_i()

GoodCat.what_am_i()    # I'm a GoodCat class!
```

- the example below illustrates equivalent ways to invoke class methods
  - note: that `bar` is defined on both class `Foo1` and `Foo2`
    - the choice of invocation may specifically invoke `bar` on `Foo1` and not the specific instance class

```python
class Foo1:
 
    counter = 0 # an example of a class variable

    @classmethod
    def get_counter(cls):
        return Foo1.counter

    @classmethod
    def bar(cls):
        print('this is bar in Foo1')

    def qux(self):
        type(self).bar()
        self.__class__.bar()
        self.bar()
        Foo1.bar()

    def tap(self):
        print('some other method')


class Foo2(Foo1):

    @classmethod
    def bar(cls):
        print('this is bar in Foo2')

    def qux(self):
        super().tap()  # use of `super()` allows call to instance methods in superclass

foo1 = Foo1()
foo1.qux()
# this is bar in Foo1
# this is bar in Foo1
# this is bar in Foo1
# this is bar in Foo1

foo2 = Foo2()
foo2.qux()
# this is bar in Foo2
# this is bar in Foo2
# this is bar in Foo2
# this is bar in Foo1
```

### Static methods
- **static methods**: are methods that belong to a class, but that don't need access to any class or instance attributes
  - often used for utility services to/for instance or class methods

- defined using `@staticmethod` decorator
- no need to pass the class (`cls`) as first argument into a static method

### dunder methods
- can define `__str__` and `__repr__` methods on custom classes
  - will define what the `str()` and `repr()` functions will do when called on objects of your custom class

#### Comparison methods
- comparison methods can be overwritten and defined for custom classes (like Ruby)
  - `==` : `__eq__` : equal to
  - `!=` : `__ne__` : not equal to
  - `<`  : `__lt__` : less than
  - `<=` : `__le__` : less than or equal to
  - `>`  : `__gt__` : greater than
  - `>=` : `__ge__` : greater than or equal to

- Note:  like Ruby, custom objects are only equal to each other when they are the same object
  - this is the `__eq__` inherited from the `object` class (which has no state, hence it uses object identity to assess equality)
  - hence use of `==` requires a custom definition

- for `a == b`, where `type(a)` and `type(b)` are different:
  - first try `a.__eq__(b)` (see if `__eq__` can handle the object `b`s type, i.e., doesn't return `NotImplemented`)
  - next try `b.__eq__(a)` (i.e., see if `__eq__` can handle the object `a`s type, doesn't return `NotImplemented`)
  - next try `a is b`  (usually `False`)

- when implemented own comparison dunder methods, need to test for object type (i.e., using `isinstance()`)
  ```python
  class Cat:

    def __lt__(self, other):
        if not isinstance(other, Cat):
            return NotImplemented

        return self.name < other.name
  ```


#### Arithmetic methods
- `+`  : `__add__`
- `+=` : `__iadd__`
- `-`  : `__sub__`
- `*`  : `__mul__`
- `/`  : `__truediv__` (floating division)
- `//` : `__floordiv__` (integer division)
- `-=` : `__isub__`
- `*=` : `__imul__`
- `/=` : `__itruediv__`
- `//=`: `__ifloordiv__`


- when defining `__add__`, also define `__iadd__`
  - if `__iadd__` is not defined, Python will fall back to using `__add__`

- when defining `+` and `*`:
  - ensure commutative law applies : a + b == b + a  ;  a * b = b * a
  - ensure associative law applies : a + (b + c) == (a + b) + c  ;  a * (b * c) == (a * b) * c
  
- when defining arithmetic operators for non-arithmetic classes
  - ensure operators are intuitive and consistent with Python's built-in types to prevent confusion / errors

```python
class Vector:

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, other):
        if not isinstance(other, Vector):
            return NotImplemented

        new_x = self.x + other.x
        new_y = self.y + other.y
        return Vector(new_x, new_y)

    def __iadd__(self, other):
        if not isinstance(other, Vector):
            return NotImplemented

        self.x += other.x
        self.y += other.y
        return self

    def __repr__(self):
        x = repr(self.x)
        y = repr(self.y)
        return f'Vector({x}, {y})'

v1 = Vector(5, 12)
v2 = Vector(13, -4)
print(v1 + v2)   # Vector(18, 8)
```


### dunder variables
- primarily useful for debugging and testing
- `__name__` : returns current module's name as a string
  - note: for current module being run, `__name__` returns `__main__`
- `__file__` : returns the full path of the current running program
  - can help with finding assets / resources used by program
  - e.g., `assets = os.path.abspath(f'{__file__}/../assets')`
- `__dict__` : returns a dictionary of all instance variables defined by an object


### Class inheritance
- the `super()` function:
  - provides a **proxy object** which is a placeholder that acts like an instance of the current object's superclass
  - this proxy object lets you call a method in the parent class


  ```python
  class Vehicle:

    def __init__(self, wheels):
        self._wheels = wheels
        print(f'I have {self._wheels} wheels.')

  # calling a parent class constructor
  class Car(Vehicle):

    def __init__(self):
        print('Creating a car.')
        super().__init__(4)

  ```

- Python allows **Multiple Inheritance** : a class can inherit from multiple superclasses
  - however, the rules around how Python manages inconsistencies are tricky (e.g., instance variables with the same name but different values, different methods with the same name, etc.)
  - even expert programmers are known to avoid multiple inheritance

  ```python
  class Pet:

      def play(self):
          print('I am playing')

  class Predator:

      def hunt(self):
          print('I am hunting')

  class Cat(Pet, Predator):

      def purr(self):
          print('I am purring')

  cat = Cat()
  cat.purr()          # I am purring
  cat.play()          # I am playing
  cat.hunt()          # I am hunting
  ```

- **Mix-ins**
  - in Python, these are achieved using multiple inheritance (e.g., similar to code example above)
  - note:  classes used are typically named with a "mixin" suffix (e.g., `class ColorMixin` in file `color_mixin.py`)
          - these classes are specifically named to indicate they should not be instantiated into objects, just added as "inheritance" to provide methods for other classes

### MRO
- **MRO** (Method Resolution Order)
  - the lookup path that Python uses when a method is called
  - can be determined by calling `class.mro()` method - will create a list of each class in MRO

- method lookup:
  - it starts searching for a method with the current class
      - then checks mixins of the current class
    - then checks the superclass
      - then checks mixins of the superclass
    - etc.
  - search for the method ends once (the first) method with the corresponding name has been found (based on MRO)
  - if nothing is found, return `AttributeError`
##
