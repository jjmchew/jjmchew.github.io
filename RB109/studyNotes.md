### Notes on Study Guide

---
<details >
<summary>Local variable scope (incl. how variables interact with method invocations w/ blocks and method definitions)</summary>

##### Local variable scope
- [source](https://launchschool.com/lessons/3ce27abc/assignments/cd8e4629)
  - local variable scoping rules in Ruby: specifically the fact that a local variable initialized outside of a block is accessible inside the block

- [source](https://launchschool.com/lessons/a0f3cd44/assignments/9e9e907c)
  - a block is defined by `{ }` or `do...end`
  - **method definition** sets a scope for local variables in terms of the parameters of that method definition
  - **method invocation** *uses* the scope set by the method definition
  - method definitions *cannot* directly access local variables initialized outside of the method definition
    - methods can access local variables passed in as arguments
  - local variables initialized outside of the method definition cannot be reassigned from within it
  - *blocks* can access local variables initialized outside the block and re-assign those variables
    - methods can access local variables through interactions with blocks

- Note:  `loop` is invoked with a block (creates a local scope):
  - <https://launchschool.com/books/ruby/read/loops_iterators#simpleloop>

  
</details>

---
<details >
<summary>Method definition and method invocation</summary>

##### Method definition
- in Ruby, (custom) methods are defined using the keyword `def` and `end`
- methods are also defined within the Ruby Core API or core library
- methods are defined with *parameters*
- methods must be defined before they are executed (in main code)
  - However, 1 method may call another defined after it (Ruby reads through all `def` statements in main code and will read the method definition into memory)
  - i.e., the following *will* work:
    ```ruby
    def top
      bottom
    end

    def bottom
      puts "Reached the bottom"
    end

    top
    ```


##### Method invocation
- methods are invoked (or called) with *arguments*
  - reference the method name to invoke / call it
- any method can be called with a block (i.e., the block is an argument and the block becomes *part* of the method invocation), but block will only be used if the method is defined in a way that uses that block
  - definition of a block is a `do..end` immediately following a method invocation
  - adding `yield` allows blocks that are passed in to be executed
- method invocation adds it to Ruby's call stack ('stack')
  - call stack example:
  ```ruby
  def first                 # 1 
    puts "first method"     # 2
  end                       # 3
                            # 4
  def second                # 5     MAX call stack snapshot below:
    first                   # 6
    puts "second method"    # 7     puts
  end                       # 8     first (line 2)
                            # 9     second (line 6)
  second                    # 10    main (line 10)
  ```
  
- method calls can be passed as arguments to other methods (the returned value from the method will be used as the argument value)
- e.g., `puts "hello"` : is a method invocation where you're passing in a string 'hello' as an argument
- if methods have the same name as local variables, then local variables will be accessed *first*
  - e.g.
  ```ruby
  str = 'a string'

  def str
    "a method"
  end

  p str     # will out 'a string' (local variable before method)
  p str()   # will now invoke the method (explict call with parentheses)
  ```
- e.g., `bob.name = 'bob'` is **not** normal assignment (using `=`), it's actually a method invocation
  - e.g. `bob.name=('bob')` which can be formally defined as:
    ```ruby
    class Person
      attr_accessor :name

      def name=(new_name)
      end
    end
    ```

</details>

---
<details >
<summary>Implicit return value of method invocations and blocks</summary>

##### return
- in Ruby:  methods *always* return the evaluated result of the last line of the expression *unless* an explicit return comes before it
  - can use `return` to explicitly return a value
e.g.,
```ruby
def str
  "a method"
end

p str  # prints out the return value of the method invocation
```
vs
```ruby
str = 'a string'
p str  # printing out the value of the str variable
```

</details>

---
<details >
<summary>Mutating vs non-mutating methods, pass-by-reference vs pass-by-value</summary>

##### Mutating vs non-mutating methods
- [source](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
- Mutating method: lines of code that **mutate the caller** and modify the value stored at the address space
  - any other variables that also point to that object (at the same address space) will also be affected
- Non-mutating method:  make the variable point to a different address space (do not mutate the caller)

- [source](https://launchschool.medium.com/variable-references-and-mutability-of-ruby-objects-4046bd5b6717)
  - objects can be *mutable* or *immutable*
    - immutable objects cannot be mutated (changed) - they can only be reassigned
    - in Ruby:  numbers, boolean, `nil`, Range objects (e.g., `1..10`) are immutable
      - any class can be immutable if no methods are provided to alter its state
      - assignment of these values will bind to different objects
      - simple assignment never mutates an immutable object
  - Setter methods (e.g., `Array#[]=` method to change 1 element of an array) changes the value of objects in the array (i.e., each element), without changing the *array*
    - the array itself has an `object_id` that is distinct and unique from the `object_id` of the elements
  - "pass-by-*value*" : making a *copy* of the info in an object (i.e., method will be non-mutating)
  - "pass-by-*reference*" : the reference can used to mutate the original object
- [source](https://launchschool.medium.com/ruby-objects-mutating-and-non-mutating-methods-78023d849a5f)
  - e.g., `String#sub!` is mutating with respect to calling String, but non-mutating with respect to its arguments
  - very few methods mutate the arguments
  - `String#concat`, `#[]=`, `#<<` (for strings, arrays), setter methods (e.g., for a hash:  `person.name = 'Bill'`) are mutating
    - `<<` may also be used for other operations (e.g., 'bit shift' operations, which may be non-mutating)
  ```ruby
  def fix(value)
    value.upcase! # mutating    
      # value = value.upcase    # non-mutating (assignment)
      # value = value.upcase!   # still mutating (assignment re-bound the 
                                # original mutated object)
    value.concat('!')
    value
  end
  
  s = 'hello'
  t = fix(s)
  ```
- [source](https://launchschool.medium.com/object-passing-in-ruby-pass-by-reference-or-pass-by-value-6886e8cdc34a)
  - `+`, `*`, `[]`, `!` are all methods;  `=` acts like a method
  - Ruby uses *strict evaluation* : every expression is evaluated and converted to an object before it is passed to a method
  - Ruby isn't purely *pass-by-reference* (passing immutable objects, like numbers will pass a 'reference') since **assignment** isn't a mutating operation
    - in Ruby, assignment changes the pointer causing a variable to be bound to a different object
    - in a method, can change the object a variable points to, but cannot change the binding of the original arguments
      - can change the object (if mutable), but the original references are immutable
    - Ruby is a bit like *pass-by-reference-**value***


</details>

---
<details >
<summary>Variables as pointers</summary>

- [source](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
- variables act as pointers to a **physical memory address** (or 'physical space in memory')
- variables can be assigned to a completely different address in memory
- [source](https://launchschool.medium.com/variable-references-and-mutability-of-ruby-objects-4046bd5b6717)
  - a variable is said to *reference* (or *point to*, or *bound to*) an object
  - use `.object_id` to reference the actual object (can see if it changes through assignment, mutation, etc.)

</details>

---
<details >
<summary>Working w/ collections (Array, Hash, String)</summary>



</details>

---
<details >
<summary>puts vs return</summary>

- e.g., `puts "hello world"` : 'the method invocation outputs the string hello world and returns nil'
- if `puts` is the last line of a method with no explicit return, that method will return `nil`

</details>

---
<details >
<summary>false vs nil and 'truthiness'</summary>

- `true` and *evaluates to true* are different things:  only `true` is `true` other objects can **evaluate to true**
- every value other than `false` and `nil` **evaluate to true** (i.e., are **truthy**) in a boolean context
- `false` and `nil` evaluate to false (i.e., are **falsey**) in a boolean context

</details>

---
<details >
<summary>How the Array#sort method works</summary>



</details>

---
### Assessment prep
- `a = 'hello'`
  - the local variable `a` is *initialized*
  - a string object with a value `hello` is *assigned* to the local variable
  - objects are physical spaces in memory
  - the local variable now *references* this object, a space in memory
- `a = 'goodbye'`
  - local variable `a` is being *reassigned* to a different string object with a different value (`goodbye`)
- ```ruby
  def example(str)
    i = 3
    loop do
      puts str
      i -= 1
      break if i == 0
    end
  end

  example('hello')
  ```
  - the method 'example' is defined with 1 *parameter* on the first line and is being invoked (called) with 1 *argument* (the string `hello`)
  - a local variable `i` is being initialized and the integer value `3` is assigned to it
  - the `loop` method is called and a `do...end` block is *passed in* as an argument to the method call
  - the method `puts` is being called / invoked with the local variable `str`being passed in as an argument
  - line 5:  local variable `i` is being reassigned to the return value of a method call to `Integer#-` on the local variable `i` with integer `1` passed in as an argument
  - line 6:  break out of loop using the keyword `break` when the value of the object referenced by local variable `i` is equal to 0
  - the code *outputs* the string `hello` 3 times and *returns* `nil`
    - there is no explicit `return` within the loop method so the last evaluated *expression* is `break if i == 0` which returns `nil`
- ```ruby
  a = 4

  loop do
    a = 5
    b = 3
    break
  end

  puts a
  puts b
  ```
  - In the first line, the variable `a` is initialized to the memory object with integer value `4`. In line 3, a loop method is invoked with the `do ... end` block passed in as an argument.  Within this block (line 4), the same local var `a` is re-assigned to another memory address with the integer value `5`.  We know this is a different memory address since integers are immutable.  We also know this is the same var `a` as initialized in line 1 since variables initialized outside the scope of the `do...end` block can be accessed within the scope of the `do...end` block.  In line 5, another var, `b`, is initialized and assigned to a memory address with integer value `3`.  This variable is scoped *only* to the `do...end` block.  On line 9, when the `put` method is invoked with argument `a`, the value at the current memory address assigned to `a` is output - `5`.  However, on line 10, when the `puts` method is invoked again with the variable `b` passed in, there is an error, since `b` was originally initialized within the scope of the `do...end` block and is only accessible within that block.
    - ==Local variables that are initialized in an inner scope **can't** be accessed in the outer scope, but local variables that are initialized in the outer scope **can** be access in an inner scope.==
#### Q. What will the following code output?
```ruby
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b

# 3
# 2
```
##### Why?
- On line 3 the local var `a` is initialized and assigned to memory address with integer value `4`.  Within the `do...end` block passed into the `loop` method as an argumet for invocation (lines 6 - 10), that same local var `a` is accessed again and assigned to the same memory address as an inner-scope var `c`.  This memory address has integer value `3` - so var `a` is currently referencing a memory address with the integer value `3`.  No further changes are made and outside of the `do...end` block on line 12, when the `puts` method is invoked with variable `a` as argument, the output to the screen is the integer value at the last assigned memory address: `3`.


#### Q. What will the following code output?
```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b

# 4
# 2
```
##### Why?
- On line 24, a new local variable `a` is initialized and assigned to a memory address with integer value `4`.  On lines 27 - 30 the `times` method is invoked with a `do...end` block passed in as an argument.  Within this block, a parameter `a` is also defined, however this is a different local variable `a`, scoped only to the `do...end` block which happens to share the same name as the outer-scoped variable `a`.  Within the `do...end` block, this parameter `a` creates *variable shadowing* which prevents access to the outer-scope variable `a`.  Within the `do...end` block, any reference to a variable `a` will affect the inner-scoped variable `a` and *not* the outer-scoped variable `a`.  Effectively, any assignments which take place within the block on lines 27 - 30 have no impact on the outer-scoped variable `a`.  Thus, on line 32, when the method `puts` is invoked with variable `a`, the output is the (unchanged) value at the memory address the variable was originally initialized at: `4`.

### `Array#each` method
- this method iterates through an array object passing each element of the array to the block argument it was invoked with
  - once it has finished every iteration, it returns the original array

### `Array#map` method
- iterates through the array object, passing each element of the array to the block
  - it actually takes the return value of the block and moves it into a new array at the same index
  - once it has finished every iteration, it returns this NEW array

### `Array#select` method
- iterates through the array object it was invoked on, passing each element to the block and runs the block
  - it takes the return value of the block and if it **evalutes to** `true` (i.e., is truthy), then it takes that element and puts it into a new array.  If the return value doesn't evaluate to `true`, then it does nothing
  - once it has finished every iteration, it returns the NEW array (which might be empty)

  ### Mutating / non-mutating methods
  - mutating methods are those methods which change the value of a calling object (i.e., the `.object_id` will NOT change, although the value might chnage)
  - e.g.,
    ```ruby
    a = 'hello'
    puts a           # => hello
    puts a.object_id # => e.g., 58

    a.upcase!
    puts a           # => HELLO
    puts a.object_id # => e.g., 58 (i.e., unchanged!)
    ```
    - on line 101 a new local variable `a` is initialized and assigned to a string object with value `hello`.
    - on line 105 the method `String#upcase!` is called on the object variable `a` is pointing to (or referencing).  This method is a mutating method which means it changes the value of the object that is calling it (i.e., `a`).  i.e., The `.object_id` does not change, which shows that the variable `a` is still referencing the same object, however, the value of the object being referenced has now changed to `HELLO`.
    - the "bang" `!` generally indicate a mutating method, however, not all mutating methods may have a bang (e.g., `Array#pop`)

### Object IDs
```ruby
a = 'name'
b = 'name'
c = 'name'

# Are these three local variables pointing to the same object?
# NO - there are 3 different local variables initialized to 3 different string objects, which happen to have the same value `hello`

puts a.object_id
puts b.object_id
puts c.object_id

# And when we add these two lines of code... ?

a = c
b = a

puts a.object_id
puts b.object_id
puts c.object_id

# line 128 re-assigns local variable `a` to the SAME string object as local variable `c`
# line 129 re-assigns local variable `b` to the SAME string object as local variable `a` was just assigned to (which is the same string object that local variable `c` is assigned to)

# What about now?
a = 5
b = 5
c = 5

puts a.object_id
puts b.object_id
puts c.object_id

# this is similar to the original initialization and assigments on lines 115 - 117 : each of the local variables `a`, `b`, `c`, are being re-assigned to integer objects.  However, it is NOT the SAME as before.  Before they were different string objects, here they are the SAME integer object.  i.e., object_id's will all be the SAME
```
- in Ruby:  integers and symbols with the same values occupy the same physical space in memory (they are the same objects)

### Re-assignment operator
- `+=` is the same as `=`
  - i.e.,
  ```ruby
  a = 'hello'
  puts a             # hello
  puts a.object_id   # e.g., 180

  a += 'world'       # same as a = a + 'world'
  puts a             # helloworld
  puts a.object_id   # e.g., 200
  ```


### Additional resources
- Control expressions - things which do not techically create 'blocks'
  - <https://docs.ruby-lang.org/en/2.4.0/syntax/control_expressions_rdoc.html>

