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


### Questions for TAs
- do we need to know the specific error names?  e.g., NameError, NoMethodError?  Or is it okay to talk about the error more generally, i.e., an error will be returned when a variable that was initialized in an inner scope is called in an outer-scope where it cannot be accessed