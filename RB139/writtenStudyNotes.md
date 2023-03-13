# Blocks

<details>
<summary>Closures, binding, and scope</summary>

### Closures
- A closure is a general programming concept involving saving a "chunk of code" to be executed later [1]
  - can be thought of as a method you can pass around and execute, but that is not defined with an explicit name
- In Ruby, 3 main ways to work with closures: [1]
  1. instantiating an object from the `Proc` class
  2. using lambdas
  3. using blocks

### Binding
- Binding refers to the references a closure (chunk of code) makes to its surrounding artifacts [1]
- Binding is the awareness a `Proc` has of the surrounding environment / context [6]
  - this includes:  local variables, method references, constants, anything else required to execute correctly [6]
  - e.g., example below will keep track of local variable `name` since it was assigned before the `Proc` was created [6]
  ```ruby
  def call_me(some_code)
    some_code.call
  end

  name = "Robert"
  chunk_of_code = Proc.new {puts "hi #{name}"}
  name = "Griffin III"        # re-assign name after Proc initialization

  call_me(chunk_of_code)
  ```
  - if `name` initialization and assignment is removed, then code will return a NameError - the `Proc` has no knowledge of the `name` local variable used in the block [6]


### Scope ==???==

</details>

---

<details>
<summary>How blocks work, and when we want to use them</summary>

### Blocks
- Blocks are identified by `do`... `end` or `{`...`}` [2]
- Blocks are often passed in as arguments to a method call (e.g., `Array#each`) [2]
- blocks are used to add flexibility to what a method does when invoked [3]

### When to use blocks
- to defer some implementation code to method invocation decision [3]
  - i.e., let the method user decide what to do (vs the method implementer)(e.g., `Array#select` is flexible - user can decide what to select) [3]
- methods with 'before' and 'after' actions ("sandwich code") [3]
  - e.g., a 'timing' method that measures how long tasks take - can implement a start time log and compare to finish time;  code to time is passed in as a block [3]
  - e.g., file operations:  file open, block execution, then file close [3]
- may want to write custom collection classes (e.g., TodoList is a collection of 'Todo's - uses an array, but is not itself an array) [4] and then create iterators for them to maintain encapsulation (not expose internal structure of TodoList) [5]

</details>

---

<details>
<summary>Blocks and variable scope</summary>

- `|var|` within the block is a *block local variable* - a special type of local variable whose scope is constrained to the block [3]
- if a block local variable has the same name as a local variable in the outside scope, **variable shadowing** will occur and prevent access to the outer-scoped local variable [3]
- blocks can access local variables in an outer scope (and modify them) [3]
  - e.g.,:
  ```ruby
  def for_each_in(arr)
    arr.each { |element| yield element }
  end

  arr = [1, 2, 3, 4, 5]
  results = [0]

  for_each_in(arr) do |number|
    total = results[-1] + number
    results.push(total)
  end

  p results # => [0, 1, 3, 6, 10, 15]
  ```
- blocks create new scope for local variables (inner and outer): only outer local variables are accessible to inner blocks (also applies to nested blocks) [6]
-  
</details>

---

<details>
<summary>Write methods that use blocks and procs</summary>

- using `yield` with no conditional (`Kernel#block_given?`) will *require* a block (i.e., if no block is passed in, a "LocalJumpError" will be raised) [3]
- use `yield` to execute code within a block argument [3]
  - the method implementation "yields to the block" and then continues [3]
  - execution "jumps to line ...", where something happens [3]
- blocks pass in additional code for method invocation (i.e., code additional to method implementation) [3]

- e.g., implement the following methods:  'times', 'each', 'select', 'reduce', 
</details>

---

<details>
<summary>Understand that methods and blocks can return chunks of code (closures)</summary>

- returning a `Proc` will return an executable chunk of code (e.g., that retains it's own private copy of associated local variables) [3]
  ```ruby
  def sequence
    counter = 0
    Proc.new { counter += 1 }
  end

  s1 = sequence
  p s1.call           # 1
  p s1.call           # 2
  p s1.call           # 3
  puts

  s2 = sequence
  p s2.call           # 1
  p s1.call           # 4 (note: this is s1)
  p s2.call           # 2
  ```
</details>

---

<details>
<summary>Methods with an explicit block parameter</summary>

- an explicit block is a block that is treated as a named object - can be reassigned, pased to other methods, invoked many times [3]
- an explicit block (to a method) is defined by using `&` before parameter name (`&` converts the block, passed in as an argument, to a `Proc`) [3]
  - e.g., below defines a method `test` which has an explicit block `block` [3]
  ```ruby
  def test(&block)
    puts "What's &block? #{block}"
  end
  ```
- explicit block is executed using `#call` [3]

- personal code example:  explicit blocks still work with `Kernel#block_given?`
  ```ruby
  def call_me(name, age, &some_code)
    some_code.call(name) if block_given?
    puts "age: #{age}"
  end

  name = "Robert"
  # chunk_of_code = Proc.new {puts "hi #{name}"}
  name = "Griffin III"        # re-assign name after Proc initialization

  # call_me(chunk_of_code)
  # chunk_of_code.call

  # call_me(name, 34) { |name| puts "hi #{name}" }
  call_me(name, 34)
  ```

</details>

---

<details>
<summary>Arguments and return values with blocks</summary>

 - Depending on how methods are implemented, the block may or may not affect the return value of the method (e.g., `Array#each` vs `Array#map`) [2]
- blocks are like methods, the return value is determined based on the last expression in the block [3]

</details>

---

<details>
<summary>When can you pass a block to a method</summary>

- in Ruby, every method can take an optional block as an argument [3]


</details>

---

<details>
<summary>`&:symbol`</summary>

- e.g. `[1, 2, 3, 4, 5].map(&:to_s) # => ["1", "2", "3", "4", "5"]` [7]
- `&` must be followed by a symbol that corresponds to a method name that can be invoked on each element *and* that doesn't take arguments [7]
- this is **not** an explicit block - different use of only `&` [7]
  - e.g., 
  ```ruby
  def my_method(name, &proc)
    proc.call(name)
  end

  a_proc = Proc.new { |name| "My name is #{name}" }
  p my_method('Joe', &a_proc)
  ```
  OR
  ```ruby
  def my_method(name)
    yield(name)
  end

  a_block = { |name| "My name is #{name}" }
  p my_method('Joe', &a_block)
  ```
- this `&` indicates that Ruby will try and convert an object to a block [7]
  - automatically will first call `Symbol#to_proc` if the symbol is not already a 'Proc';  then Ruby automatically converts the `Proc` to a block [7]

- ```ruby
  def my_method
    yield(2)
  end

  # turns the symbol into a Proc, then & turns the Proc into a block
  my_method(&:to_s)               # => "2"

  # above is equivalent to:
  a_proc = :to_s.to_proc          # explicitly call to_proc on the symbol
  my_method(&a_proc)              # convert Proc into block, then pass block in. Returns "2"
  ```

</details>

---

<details>
<summary>Arity of blocks and methods</summary>

- arity is the number of arguments you must pass to a block, `proc`, or `lambda` [3]
- In Ruby, blocks and `procs` have **lenient arity** (can pass any number of arguments) [3]
- In Ruby, methods and `lambda`s have **strict arity** (must pass the exact number of arguments required) [3]

</details>

---

# Testing with MiniTest

<details>
<summary>Testing terminology</summary>
</details>

---

<details>
<summary>Minitest vs RSpec</summary>
</details>

---

<details>
<summary>SEAT approach</summary>
</details>

---

<details>
<summary>Assertions</summary>
</details>

---

# Core Tools / Packaging Code

<details>
<summary>Purpose of core tools</summary>
</details>

---

<details>
<summary>Gemfiles</summary>
</details>

---

# Misc
- to make private class methods, can use `class << self` which lets you operate on the class itself as if it were an object (`private` doesn't work on class methods - only on instance methods) [8]
  ```ruby
  class PerfectNumber
    # rest of class here

    class << self
      private

      def get_divisors(num)
        # method goes here
      end
    end
  end
  ```

# References
[1](https://launchschool.com/lessons/c0400a9c/assignments/0a7a9177)
[2](https://launchschool.com/lessons/c0400a9c/assignments/ff802368)
[3](https://launchschool.com/lessons/c0400a9c/assignments/5a060a20)
[4](https://launchschool.com/lessons/c0400a9c/assignments/b2926256)
[5](https://launchschool.com/lessons/c0400a9c/assignments/490f885c)
[6](https://launchschool.com/lessons/c0400a9c/assignments/fd86ea2e)
[7](https://launchschool.com/lessons/c0400a9c/assignments/26d715d8)
[8](https://launchschool.com/exercises/48ffdb7b)
