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

- "a closure retains knowledge of the lexical environment at the time it was defined" [from Joseph]

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

- explicit blocks are named, but are **not** required parameters (i.e., not passing in a block will not raise an ArgumentError) [from experiments]

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

- ```ruby
  def any?(arr)
    arr.each do |ele|
      return true if yield(ele)
    end
    false
  end

  def none?(arr, &chunk)
    !any?(arr, &chunk) # use `&` to convert proc back to block and pass into #any?
  end

  p any?([1, 3, 5]) { |ele| ele.odd? }
  p none?([2, 2, 4]) { |ele| ele.odd? }
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

<details>
<summary>Lambdas (extra)</summary>

- lambdas are a type of proc with strict arity (i.e,. # of arguments required is stricly enforced ) [12]
- **cannot** call `Lambda.new` to create a new lambda, can only use:
  - `my_lambda = lambda { |var| puts var }` OR 
  - `my_lambda = -> (thing) { puts thing }`

</details>

---

# Testing with MiniTest

<details>
<summary>Testing terminology</summary>

- regression: 'breaking' something when we make changes in our code [14]
- as beginners:  write tests so that we don't need to manually verify our code still works when we make changes (call it "unit testing" for this lesson)  [14]

- Test Suite:  *all* of the tests for a project (entire set of tests that accompanies the program / application) [15]
  - can span an entire class, a subset of a class, a combo of classes, or the complete application.  May be in 1 or multiple files [17]
  - typically filenames contain "_test" at the end (e.g., `to_do_test.rb`) but no universal convention [17]
  - typically test files are stored in a `/test` directory;  actual code is stored in a `/lib` directory [17]
- Test: a situation or context in which a test is run (e.g., get an error for entering the wrong password).  A test can contain multiple assertions. [15]
  - also called "Test Case": combines any required actions (e.g., reation of a to-do object, method calls, etc) and the actual assertion.  Some devs like having only 1 test step per test case [17]
  - Minitest requires all test methods to begin with `test_` [17]
- Assertion:  the actual verification step to confirm the expected value returned by program is actually returned.  A test will contain 1 or more assertions. [15]
  - Also called 'test step' - most basic level of testing [17]

- Seed: in Minitest - used to generate the "random" order in which tests are run.  Can be used to replicate the order in which tests are run if there are tricky bugs for specific situations. [15]
  - use command `--seed ####` (e.g., `ruby test/tests.rb --seed 51859`) [17]
- Failure (of a test):  when an expected assertion does not pass (i.e., expected value is not match the actual value) [15]
- Test Sequence: the order in which multiple tests are run (typically in a random order) [17]

- Test Driven Development (TDD) : ideally tests are written before writing any code [17]
  - "Red-Green-Refactor" [17]:
  - 1. create a test that fails
  - 2. write just enough code to implement change or new feature
  - 3. refactor and improve things, repeat tests


</details>

---

<details>
<summary>Minitest vs RSpec</summary>

- Minitest is Ruby's default testing library, part of Ruby's standard library (a bundled gem - shipped with default Ruby installation, but maintained outside of Ruby core team) [15]
- Minitest can do everything RSpec can, syntax is different (can use a DSL or plain Ruby - a matter of 'style') [15]
  - alternate syntax is called "expectation" or "spec-style" syntax [15]
  ```ruby
  describe 'Car#wheels' do
    it 'has 4 wheels' do
      car = Car.new
      _(car.wheels).must_equal 4           # this is the expectation
    end
  end
  ```
- RSpec uses "Domain Specific Language" (DSL) - reads like English [15]
- 

</details>

---

<details>
<summary>SEAT approach</summary>

- S : Setup necessary objects [18]
- E : Execute code against testing objects [18]
- A : Assert code did the right thing [18]
- T : Teardown lingering artifacts [18]

- for Setup / Teardown:  Setup / Teardown is run for each test case [17]
  ```ruby
  class DatabaseTest < Minitest::Test
    def setup  # setup items here
    end

    def test_something # actual test case here
    end

    def teardown # clean-up items here
    end
  end
  ```
</details>

---

<details>
<summary>Assertions</summary>

- `assert_equal(exp, act)` fails unless `exp == act` (i.e., passes if...) [15][16]
  - may need to override `==` for custom class to be able to use `assert_equal` (otherwise, will default to looking at whether or not the object is exactly the same) [19]
- `assert(test)` fails unless `test` is truthy [16]
- `assert_nil(obj)` fails unless `obj` is `nil` [16]
- `assert_raises(*exp) { ... }` fails unless block raises one of `*exp` [16]
- `assert_instance_of(class, obj)` fails unless `obj` is an instance of `cls` [16]
- `assert_includes(collection, obj)` fails unless `obj` is a part of `collection` [16]

- `assert_in_delta(exp, actual, delta)` [17]
- `assert_same(exp, obj)` fails unless `exp.equal?(obj)` (are the exact same object) (be wary of potentially overwritten `BasicObject#equal?` methods) [17]
- `assert_empty(collection)` fails unless `collection` is empty [17]
- generally there is a `refute` assertion for each `assert` : will be the opposite of the `assert` (e.g., passes if 'falsy' or if not equal to, etc.) [16]
- `assert_match(/regex/, msg)` fails if regex does not match in `msg` [17]
- `assert_silent {block}` fails if output goes to `stdout` or `stderr` [17]
- `assert_output(stdout, stderr) { block }` fails if when block runs, standard output doesn't match `str` or standard error doesn't match `err` [17]
- `assert_kind_of(class, obj)` fails if `obj` is not class or subclass of `class` [17]
- `assert_respond_to(object, method)` fails if `object` cannot call `method` (e.g., `assert_respond_to(object, :empty?)` [17]




</details>

---

<details>
<summary>Other</summary>

- Automating user input for testing [9]
  - in method definition:  e.g. `def prompt_for_payment(input: $stdin)`
  - in method (getting actual user input):  e.g., `answer = input.gets.chomp.to_f`
  - for testing:  e.g.,
    ```ruby
    input = StringIO.new("30.4\n")
    prompt_for_payment(input: input)
    ```

- Consuming output to terminal (as part of testing - if NOT using `assert_output`) [10]
  - in method definition:  e.g., `def prompt_for_payment(output: $stdout)`
  - in method (modifying `puts`):  e.g., `output.puts "You owe ${item_cost}."`
  - for testing:  e.g.,
    ```ruby
    output_var = StringIO.new
    prompt_for_payment(output: output_var)
    ```

- multi-line strings (e.g., for defining output for testing using `assert_output`) [11]
  - can use interpolation the same way as regular strings (i.e., `"add #{var_name} here"`)
  ```ruby
  output = <<-OUTPUT.chomp.gsub /^\s+/, ""  # this removes the leading spaces for each line
  Desired output here
  formatted correctly
  OUTPUT
  ```
  OR
  ```ruby
  output = <<~OUTPUT.chomp # `~` removes leading spaces; `chomp` removes the trailing newline
  Multiline output here
  OUTPUT
  ```

- for colour in minitest output [15]:
  ```ruby
  # before using
  gem install minitest-reporters

  # to use:
  require 'minitest/autorun'
  require 'minitest/reporters'
  Minitest::Reporters.use!

  # ...
  ```


- don't create tests that must be run in a specific order - this is bad practice [17]
</details>

- code coverage:  use 'simplecov' [20]
  - `gem instal simplecov`
  - in ruby file, add:  `require 'simplecov'` (must be very first line)
  - also add: `SimpleCov.start`
  - will create a folder called 'coverage' with `index.html` file with report
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
- can seed random numbers (to make them less random) for testing purposes using `Kernel.srand 3948`, where `3948` is the desired seed;  use `rand(1..5)` to get a random number in desired range [13]
- closures / binding are the way in which local variables declared in an outer scope are accessible to an inner scope.  Note that methods are different than local variables (`my_method` can be defined after block, but is still accessible - Ruby interpreter deals with methods differently)
  ```ruby
  def for_each_in(arr)
    arr.each { |element| yield element }
  end

  arr = [*1..5]
  results = [0]

  for_each_in(arr) do |number|
    total = results[-1] + number + my_method # closure (binding) allows this block to access `results`
    # my_method is available in this block
    results.push(total)
  end

  def my_method
    3
  end

  p results
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
[9](https://launchschool.com/exercises/64799839)
[10](https://launchschool.com/exercises/e2b66911)
[11](https://launchschool.com/lessons/dd2ae827/assignments/cf0f8d58)
[12](https://launchschool.com/exercises/753d0323)
[13](https://launchschool.com/exercises/9302dd42)
[14](https://launchschool.com/lessons/dd2ae827/assignments/554f5ac5)
[15](https://launchschool.com/lessons/dd2ae827/assignments/3a8a5aa5)
[16](https://launchschool.com/lessons/dd2ae827/assignments/fe2ff54a)
[17](https://launchschool.medium.com/assert-yourself-a-detailed-minitest-tutorial-f186acf50960)
[18](https://launchschool.com/lessons/dd2ae827/assignments/5c80633e)
[19](https://launchschool.com/lessons/dd2ae827/assignments/bcce2222)
[20](https://launchschool.com/lessons/dd2ae827/assignments/9f7c1f7c)



# Follow-up Questions

- [ ] When might I want to return a proc or a block from a method?
  - Procs are definitely a kind of 'encapsulation' - why not just use a new class / object (e.g., sequence example from notes)
  - [x] Can 'blocks' be returned from code, or only procs?  i.e., procs are a WAY of returning a block (code to be executed as a closure)
  - [x] Blocks can only be used at method invocation (i.e., not a named object)
  - [x] Explicit blocks aren't actually blocks; they are converted to procs by unary `&`
- [ ] is `&` a method?
- [X] How do we convert a proc to a block
    - A: use `&` to convert a proc back to a block
- [ ] Review the posts and discussion at the start of the lesson
- [ ] the car test class - the "test suite" - what if you have multiple test files?
- [ ] play around with binding for constants
- [ ] definition of methods and ability to run methods defined afterwards (in closures - it works, in normal 'procedural' code it doesn't)


To review:
- [ ] https://launchschool.com/posts/281eea2f
- [ ] https://launchschool.com/posts/08e14621
- [ ] https://launchschool.com/posts/a744f590
- [ ] https://launchschool.slack.com/archives/C48A338P3/p1674832095088829
- [ ] https://github.com/gcpinckert/rb130_139
- [ ] https://github.com/W-Sho-Sugihara/RB139







