### Notes on Study Guide

---
<details >
<summary>Local variable scope (incl. how variables interact with method invocations w/ blocks and method definitions)</summary>

##### Local variable scope
- [source](https://launchschool.com/lessons/3ce27abc/assignments/cd8e4629)
  - local variable scoping rules in Ruby: specifically the fact that a local variable initialized outside of a block is accessible inside the block

- [source](https://launchschool.com/books/ruby/read/variables#variablescope)
  - methods have self-contained local variable scope: only variables initialized within the method's body can be referenced or modified from within the method's body
    - variables initialized within the method's body are not available outside the method's body
  - a **block** is a piece of code that follows a method's invocation, delimited by `{}` or `do...end`
    - variables initialized in an outer scope to a block **can** be accessed
    - variables initialized within the block **cannot** be accessed outside the block 
    - nested blocks create nested scope
    - blocks may have a "block argument" (in pipes) [21:20](https://launchschool.medium.com/live-session-beginning-ruby-part-3-61180782f721)

- [source](https://launchschool.com/lessons/a0f3cd44/assignments/9e9e907c)
  - a block is defined by `{ }` or `do...end`
  - **method definition** sets a scope for local variables in terms of the parameters of that method definition
  - **method invocation** *uses* the scope set by the method definition
  - method definitions *cannot* directly access local variables initialized outside of the method definition
    - methods can access local variables passed in as arguments
  - local variables initialized outside of the method definition cannot be reassigned from within it
  - *blocks* can access local variables initialized outside the block and re-assign those variables
    - methods can access local variables through interactions with blocks

- language to refer to method invocation with arguments (from [course notes](https://launchschool.com/lessons/a0f3cd44/assignments/fff0b9db))
  - e.g.:
  ```ruby
  def some_method(a)
    puts a
  end

  some_method(5)  # => 5
  ```
  - the integer `5` is passed into `some_method` as an argument, assigned to method parameter `a`, and thus made available to the method body as a local variable

- Note:  `loop` is invoked with a block (creates a local scope):
  - <https://launchschool.com/books/ruby/read/loops_iterators#simpleloop>

- [control expressions](https://docs.ruby-lang.org/en/2.4.0/syntax/control_expressions_rdoc.html) do not require / create a block for execution, and thus do not create a new variable scope
  - they are **not methods**
  - `if`, `unless`, `case`, `while`(loop), `until`(loop), `for`(loop) 
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
  - methods, blocks, procs, lambdas all use the same call stack
  
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

- language to use when referring to values / arguments, etc:
  - e.g.:
  ```ruby
  def greetings(str)
    puts str
    puts "Goodbye"
  end

  word = "Hello"

  greetings(word)

  # Outputs 'Hello'
  # Outputs 'Goodbye'
  ```
  - the method is defined with a parameter `str`.  When the method is invoked, it can access the string `"Hello"` since it is passed in as an argument in the form of the local variable `word`
- if a method is invoked with a block, but the method is not defined to use a block in any way, the block will not be executed
  - adding the `yield` keyword can return control to execute a block that is passed in

- 'block variables': the thing between the `| |`
- discussion and language around method invocation [source](https://launchschool.medium.com/live-session-beginning-ruby-part-2-f87d821ce926)
  ```ruby
  def amethod(param)
    param += " universe"
    param << " world"
  end

  str = 'hello'
  amethod(str) # 'passing str to amethod'

  p str  # What is the output?
  ```
  - after  `amethod` is invoked and str is passed to amethod; on the first line, `param` is assigned to `str`:   is where the `param` method local variable is initialized (equivalent to `param = str`)
  - next line is re-assignment;  the value doesn't matter here since param - the implicit return value of the method - is never used; after this line, `param` is no longer pointing to `str` and changes to `param` do not affect `str`
  - we're thinking about the side-effect of `str` being passed into `amethod`

- methods can generally do 3 things:  return value, execute side-effects, output something [37:30](https://launchschool.medium.com/live-session-beginning-ruby-part-3-61180782f721)

</details>

---
<details >
<summary>Implicit return value of method invocations and blocks</summary>

##### return
- in Ruby:  methods *always* return the evaluated result of the last line of the expression *unless* an explicit return comes before it [source](https://launchschool.com/books/ruby/read/methods#whataremethodsandwhydoweneedthem)
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
- consider if a method:  returns a value, has side-effects, or both
  - side-effects:  e.g., displaying something or mutating an object
  - try to avoid methods with both meaningful return values AND a side-effect

- technically we wouldn't say that `if...else` returns something since *methods* return values; expressions *evaluate to* a value [from slack discussion](https://launchschool.slack.com/archives/C04A1813JRF/p1668105608401989?thread_ts=1668101173.152629&cid=C04A1813JRF)

- rememeber:  `loop` returns the last expression evaluated within the block; `each` returns the original object it was called on
</details>

---
<details >
<summary>Mutating vs non-mutating methods, pass-by-reference vs pass-by-value</summary>

##### Mutating vs non-mutating methods
- [source](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
- Mutating method: lines of code that **mutate the caller** and modify the value stored at the address space
  - any other variables that also point to that object (at the same address space) will also be affected
- Non-mutating method:  make the variable point to a different address space (do not mutate the caller)
  - when we use variables to pass arguments to a method, we're essentially assigning the value of the original variable to a variable inside the method

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
    - re-assigning the object within a method doesn't affect the object outside the method
  - "pass-by-*reference*" : the reference can used to mutate the original object
    - e.g., pass a string value through a local variable in outer scope, and the method is able to update that string value (and thus the value referenced by the local variable).  e.g.:
      ```ruby
      def cap(str)
        str.capitalize!   # does this affect the object outside the method?
      end

      name = "jim"
      cap(name)
      puts name           # => Jim
      ```
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
  - "we pass `s` to `fix`; this binds the String represented by `'hello'` to `value`. `s` and `value` are now aliases for the String
- [source](https://launchschool.medium.com/object-passing-in-ruby-pass-by-reference-or-pass-by-value-6886e8cdc34a)
  - `+`, `*`, `[]`, `!` are all methods;  `=` acts like a method
  - Ruby uses *strict evaluation* : every expression is evaluated and converted to an object before it is passed to a method
  - Ruby isn't purely *pass-by-reference* (passing immutable objects, like numbers will pass a 'reference') since **assignment** isn't a mutating operation
    - in Ruby, assignment changes the pointer causing a variable to be bound to a different object
    - in a method, can change the object a variable points to, but cannot change the binding of the original arguments
      - can change the object (if mutable), but the original references are immutable
    - Ruby is a bit like *pass-by-reference-**value***

- note:  string concatenation is *non-mutating* **method** (it returns a new string)
  - `param + " world"` is the same as `param.+("world")` (it's not an operator)

- example from [video](https://launchschool.medium.com/live-session-beginning-ruby-part-2-f87d821ce926):
  ```ruby
  def amethod(param)
    param += " universe"
    param << " world"
  end

  str = 'hello'
  amethod(str)

  p str  # What is the output?
  ```

  - mutating an object can be dangerous - be careful
    - use the `!` to indicate a destructive method
  - don't return a value AND create a side-effect (causing a change, e.g. mutate the caller)

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

- in nested data structures, 'variables as pointer' behaviour is also exhibited ([course notes](https://launchschool.com/lessons/c53f2250/assignments/1a6a2665))
  - e.g., 
    ```ruby
    a = [1, 3]
    b = [2]
    arr = [a, b]
    arr # => [[1, 3], [2]]

    a[1] = 5  #  same as arr[0][1] = 5
    arr # => [[1, 5], [2]]
    ```
    when elements in array `a` are changed, the same changes are reflected in `arr` - both `a` and `arr` point to the same object

- `dup` and `clone` create shallow copies of objects ('sharing' nested objects)
- `clone` preserves the frozen state from `.freeze` 
  - `dup` doesn't preserve the frozen state
  - `.freeze` prevents the direct object from being changed (but nested objects could still be changed)
    - e.g., 
      ```ruby
      arr = [[1], [2], [3]].freeze
      arr[2] << 4
      arr # => [[1], [2], [3, 4]]
      ```
    - use `.frozen?` to check frozen status

- Regarding physical space in memory:  *is* it an object?  or does it *contain* an object?
 - probably better to say that the same in memory *contains* an object
    - variables act as pointers to an addres space in memory that contains a value [source](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
    - local variables can point to array objects, adding local variables [to an array] *looks the same* as adding the actual array objects they're pointing to into the array, [but the nesting creates 2 ways to access the elements within]  [source](https://launchschool.com/lessons/c53f2250/assignments/1a6a2665)
    - initializing a variable creates a *reference* or *points to* a String object with value `'etc'`. The String object represented by literal `'etc'` is assigned to a variable that has the name of the variable by storing it's `object_id` [source](https://launchschool.medium.com/variable-references-and-mutability-of-ruby-objects-4046bd5b6717)
  - "objects are things that live in memory, that take up space in memory" [~17:20](https://launchschool.medium.com/live-session-beginning-ruby-part-2-f87d821ce926)

- when variables point to objects, they can retrieve the value or they can update the value [8:20](https://launchschool.medium.com/live-session-beginning-ruby-part-3-61180782f721)

</details>

---
<details >
<summary>Working w/ collections (Array, Hash, String)</summary>

- `each` : iterates over each element in a collection
  - the return value is the original collection
- `select` : evalutes the return value of the block and includes elements for which the block evalutes to `true` within a new collection
  - the return value is the new collection
- `map` :  performs transformation based on the return value of the block : it takes the return value of the block and places it in a new collection for each element of the original collection
  - the return value is the new collection

- [courrse notes on negative indices](https://launchschool.com/lessons/85376b6d/assignments/39c98ed0)
  - `String` and `Array` objects can be referenced using negative indices:  the last index in the collection is `-1`, the next element to the left is `-2`, and continues to increment towards the left

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


</details>

---
<details >
<summary>puts vs return</summary>

- e.g., `puts "hello world"` : 'the method invocation outputs the string hello world and returns nil'
- if `puts` is the last line of a method with no explicit return, that method will return `nil`

#### returns
- `if` can return a value - depends on what is in each branch
  e.g. 
  ```ruby
  answer = if true
            'yes'
          else
            'no'
          end
  puts answer       # => yes
  ```

</details>

---
<details >
<summary>false vs nil and 'truthiness'</summary>

- `true` and *evaluates to true* are different things:  only `true` is `true` other objects can **evaluate to true**
- every value other than `false` and `nil` **evaluate to true** (i.e., are **truthy**) in a boolean context
  - remember `0` evaluates to `true`
- `false` and `nil` evaluate to false (i.e., are **falsey**) in a boolean context

- in conditionals, we are evaluating **expressions** that should evaluate to `true` or `false`

</details>

---
<details >
<summary>How the Array#sort method works</summary>

- [course notes](https://launchschool.com/lessons/c53f2250/assignments/2831d0e1)
- sorting requires a comparison, typically uses `<=>`
  - `a <=> b` compares `a` to `b`
  - there are different versions of `<=>` (i.e., `String#<=>` is different from `Integer<=>`)
  - `2 <=> 1`   # => 1 (first is bigger than second)
  - `1 <=> 2`   # => -1 (first is smaller than second)
  - `1 <=> 1`   # => 0 (first is the same as second)
  - `1 <=> 'a'` # => `nil` (first cannot be compared to second)

- e.g., `[2, 5, 3, 4, 1].sort` => `[1, 2, 3, 4, 5]`
- e.g., `[2, 5, 3, 4, 1].sort { |a,b| b <=> a }` => `[5, 4, 3, 2, 1]`

- `Enumerable#sort_by` needs to be called with a block
  - Note:  there is an `Array#sort_by!` (which is distinct from the `Enumerable` version)
  - e.g., `['cot', 'bed', 'mat'].sort_by { |word| word[1] }` => `['mat', bed', cot']` (i.e., sorted by 2nd letter of each word)
  - `sort_by` always returns an array (even if a hash is sorted)
    - need to call `to_h` on the output to create a hash (if desired)
- [course notes](https://launchschool.com/lessons/c53f2250/assignments/c633cf37)
  - when arrays are compared using `Array<=>` ([docs](https://ruby-doc.org/core-3.1.2/Array.html#method-i-3C-3D-3E)):
    - each corresponding element is compared
    - additional array elements are not compared, if not necessary - - if all initial elements are equal, then the shorter array comes first (is 'less than')


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
  - the method `puts` is being called / invoked with the local variable `str` being passed in as an argument
  - line 5:  local variable `i` is being reassigned to the return value of a method call to `Integer#-` on the local variable `i` with integer `1` passed in as an argument
  - line 6:  break out of loop using the keyword `break` when the value of the object referenced by local variable `i` is equal to 0
  - the code *outputs* the string `hello` 3 times and *returns* `nil` [source](https://medium.com/how-i-started-learning-coding-from-scratch/advice-for-109-written-assessment-part-2-594060594f6e)
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

# this is similar to the original initialization and assigments on lines 115 - 117 : 
# each of the local variables `a`, `b`, `c`, are being re-assigned to integer objects.  
# However, it is NOT the SAME as before.  
# Before they were different string objects, here they are the SAME integer object.  i.e., object_id's will all be the SAME
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

### Logical operators
- `&&` will only return `true` if both *expressions* evaluated are `true`
  - can chain expressions and each will be evaluated left to right
  - 'short-circuits' once it encounters the first `false`
- `||` will return `true` if either of evaluated expressions is `true`.  
  - will only return `false` if all expressions are `false`
  - short-circuits once it encounters the first `true`
- both `&&` and `||` exhibit **'short-circuiting'** behaviour : they will stop evaluating once a guaranteed result can be returned
- bad example (can be unclear that `if` branch will return false if find_name does not return a name):
  ```ruby
  if name = find_name
    puts "got a name"
  else
    puts "couldn't find it"
  end
  ```
- better example:
  ```ruby
  name = find_name

  if name && name.valid?
    puts "great name!"
  else
    puts "either couldn't find name or it's invalid"
  end
  ```

### Operator precedence
- <https://ruby-doc.org/core-3.1.2/doc/syntax/precedence_rdoc.html>
- [original course notes](https://launchschool.com/lessons/a0f3cd44/assignments/f76e5b21)
- e.g. `3 + 5 * 7` : `+`, `*` are operators;  `3`, `5` are operands
- operator precedence is based on how tightly an operator '*binds*' to its operands.  A higher precedence operator binds more tightly to its operands.
  - if precedence is the same, then use evaluation order:
    - method invocations happen first to get values
    - then operators evaluated (with precendence considered), generally left-to-right
    - with multiple assignments, evaluation is *right-to-left* (however, generally bad practice)
      - e.g.
      ```ruby
      a = b = c = 3
      puts a if a == b if a == c
      ```
- precedence of `{}` is slightly higher than `do..end` which can create unexpected behaviour:
  - e.g., `{}` block has slightly higher precendence and is bound to `array.map`first, then `p` is executed
  ```ruby
  p array.map { |num| num + 1 }      #  outputs [2, 3, 4]
                                     #  => [2, 3, 4]
  # same as p(array.map { |n| n+1 })
  ```
  vs `do...end` has precendence and `array.map` is bound `p` first (which returns an `Enumerator`, the block is ignored by `p`)
  ```ruby
  p array.map do |num|
    num + 1                 #  outputs #<Enumerator: [1, 2, 3]:map>
  end                       #  => #<Enumerator: [1, 2, 3]:map>
  # same as p(array.map) do |n|
  #           n + 1
  #         end
  ```

### Variable shadowing
- when a block-scoped variable (parameter) has the same name as a local variable in an outer scope, it prevents access to the outer scope variable

### Constant scope
- [course notes](https://launchschool.com/lessons/a0f3cd44/assignments/fff0b9db)
- constants have *lexical scope*
- constants (all caps) are accessible within methods
- constants can be initialized within a block and available in an outer scope

### `p` vs `puts` vs `print`
- e.g., `a = ["1", "2", "3"]`
  - `p a` : `["1", "2", "3"]` (returns value of argument)
  - `p "#{a}"` : `"[\"1\", \"2\", \"3\"]"` (note quotes added to sting, and escaped `"`)
  - `puts a` : (see below, returns `nil`)
    ```ruby
    1
    2
    3
    ```
    (note no quotes, each element on a different line)
  - `print a` outputs similar to `p a`, but does not include a newline afterwards

- `p` calls the `inspect` method on its argument
  - `p nil` : `nil`
- `print` just outputs the contents
  - `print nil` : ` ` (shows blank, also returns `nil`)
- |       | returns                  | displays for `nil` | displays for strings |
  |------ |--------------------------|--------------------|----------------------|
  |`p`    | value passed as argument | `nil`              | shows `""`           |
  |`print`| `nil`                    | ` ` (same line)    | no `""`, same line   | 
  |`puts` | `nil`                    | [blank line]       | no `""`              |
  - `puts` method outputs a string representation of the integer. [source](https://launchschool.com/lessons/c53f2250/assignments/c633cf37)

### Accessing strings

- e.g., `str = 'abcdefghi'` : using `str[2,3] # 'cde'` is actually using `String#slice` (`str.slice(2,3)`)
  - called 'string element reference' or 'string character reference'
  - the return is a brand new string (with different object_id)
    - `char1 = str[2] # => "c"`
    - `char2 = str[2] # => "c"`
    - but `char1` and `char2` will have different object_ids
      - this behaviour is not the same as true collections
  - note:  `String#slice` and `Array#slice` are both totally different methods and will behave differently (e.g., return values, etc.)

### Nested data strutures
- [course notes](https://launchschool.com/lessons/c53f2250/ assignments/1a6a2665)
- e.g.,
  ```ruby
  arr = [[1, 3], [2]]
  arr[0][1] = 5
  ```
  - `arr[0]` is an element reference which returns `[1, 3]`
  - `[1] = 5` looks like reference, but is *not* - it's array element update (i.e., `[1,3][1] = 5` which is a destructive action - a permanent change)

### Mutability
- Immutable objects in Ruby:  integers, boolean, ranges, `nil`

### Expressions
- any chunk of code that evaluates down to 1 value

### Additional resources
- Control expressions - things which do not techically create 'blocks'
  - <https://docs.ruby-lang.org/en/2.4.0/syntax/control_expressions_rdoc.html>
- assessment language:  <https://drive.google.com/file/d/16Q32xXRoJ0wFMwiA8CojhdqfwCgE9rjj/view>

