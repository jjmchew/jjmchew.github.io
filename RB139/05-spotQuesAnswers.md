# Answers to RB139 Spot Questions
https://github.com/W-Sho-Sugihara/RB139/blob/154a5266422be74bb45d3f07805f8a4614fbff98/study_questions.md

## Blocks
1
==What are closures?==

- Closures are a programming concept where a 'chunk' of code can be stored for later execution.  In Ruby, this chunk of code can be assigned to a local variable ('named') and passed around within the code (e.g., passed in as arguments to methods or returned from methods).

---

2
==What is binding?==

- Binding is the mechanism by which a closure (a 'chunk of code') maintains awareness of the various artifacts of the code environment in which it was created.  This might include references to local variables, other methods, constants are anything else required for the code to be effectively executed later.

---

3
==How does binding affect the scope of closures?==

- The scope of the closure will be related to the scope of the various artifacts in the ocde environment in which it was created.  For example, if a `proc` is created from a block, local variables in a scope outside of the block can be included within the scope of the `proc` and will be bound accordingly.

---

4
==How do blocks work?==

- Blocks are indicated through the use of `{ }` or `do end` where the code within the block is placed within the parentheses or between the `do` and `end`.  Blocks are only used as part of method invocation or in the instantiation of new `proc`s or `lambda`s along with the appropriate syntax (e.g., `Proc.new`). Blocks can access local variables and methods declared in an outer-scope, but not local variables of nested inner scopes. Block variables declared with the same name as outer-scope local variables will 'shadow' (prevent access to) those outer-scope variables.

---

5
When do we use blocks? (List the two reasons)

- Blocks are used to: 1) pass additional code for execution when a method is invoked (e.g., using a block to provide additional actions when invoking `Array#map`);  2) define what actions a new `proc` or `lambda` will have when instantiating a new `proc` or `lambda`.

---

6
Describe the two reasons we use blocks, use examples.

- 1) Passing additional code to a method during invocation:
  ```ruby
  [1, 2, 3].map { |num| num + 10 }
  ```
  - The block `{ |num| num + 10 }` indicates how each element of the array `[1, 2, 3]` should be modified when creating a new array using the `Array#map` method.

- 2) Instantiating a new `proc`:
  ```ruby
  new_proc = Proc.new { |num| num + 10 }
  ```
  - The block `{ |num| num + 10 }` indicates that when `new_proc` is called and a number argument is passed in, `10` will be added to that argument and returned.

---

7
When can you pass a block to a method? ==Why?==

- In Ruby, you can always pass a block to a method - all methods can implicitly receive a block on invocation whether it has been explicitly defined within the method definition or not. Although all methods can receive a block, not all methods have been defined to utilize that block, so the code within the block may be entirely ignored by the method.

---

8
How do we make a block argument mandatory?

- Methods can be defined in such a way as to raise an error if the block is not provided. The use of `yield` within the method without a guard clause (e.g., `yield if block_given?`) will raise a 'JumpError' if the method is invoked without a block.
- Prepending a method parameter with `&` in the method definition also makes the use of the block within the method more explicit.  For example, `def some_method(&block)` : `&block` indicates that a block passed in when invoking `some_method` will be converted to a `proc` named `block`. In the body of the method, `block.call` or `yield` can be used to execute the code that was passed in through the block.  Note that in this situation, if block is *not* passed in, no 'ArgumentError' will be raised, however if the code does not leverage a guard clause (e.g., `block.call if block_given?`) and no block is passed in, then a 'JumpError' will be raised, similar to the first situation.

---

9
How do methods access both implicit and explicit blocks passed in?

- An implicit block is accessed through the use of `yield`.  An explicit block (which will be converted to a `proc`) is accessed through the use of `Proc#call`.  Note that even if the block is made explicit by prepending a parameter with `&`, it can still be accessed as an implicit block.

---

10
What is yield in Ruby and how does it work?

- In Ruby methods, `yield` is used to indicate that the code within a block should be executed. Arguments can be passed to the block for execution through the use of parentheses.  For example `yield(3)` will pass a single integer object `3` to the block on execution.  Additional arguments can be passed when separated by `,` (e.g., `yield(3, 10, 11)`).

---

11
How do we check if a block is passed into a method?

- We can check if a block is passed into a method using the method `block_given?`. This method will return `true` if a block has been passed in, or `false` if a block has not been passed in.

---

12
==Why is it important to know that methods and blocks can return closures?==

- Closures can be used to help encapsulate and create reusable chunks of code. They are helpful and may be more common in functional programming.

---

13
What are the benefits of explicit blocks?

- Explicit blocks are helpful in that the block is named and can be manipulated more easily (e.g., passed around, returned, etc.) within a method. It may also be helpful for other developers to easily recognize that a defined method requires a block for execution - this argument will be prepended by `&` in the method definition.

---

14
Describe the arity differences of blocks, procs, methods and lambdas.

- Arity can be 'strict' or 'lenient' and refers to whether or not Ruby will raise an error if an unexpected number of arguments are provided when the code is invoked.
- Methods and lambdas have strict arity - if the number of arguments provided on execution does not exactly match the number of arguments required by the definition then Ruby will raise an 'ArgumentError'.
- Blocks and procs have lenient arity - if the number of arguments provided on execution does not exactly match the number of arguments required by the definition, Ruby will not raise any errors and will assume the value of those arguments which were not provided to be `nil` or ignore any extra arguments provided.

---

15
==What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)==

- Lambdas can only be created using `lambda`; `Lambda.new` will not work.  However, lambdas can also be created using the `->` syntax.  Lambdas are a specific type of proc.
- Procs can be created using `proc` or `Proc.new`.

---

16
What does `&` do when in a method parameter?
```ruby
def method(&var); end
```

- The use of `&` indicates an 'explicit block' : any block passed in on invocation of `method` will be converted to a proc and assigned to a local method variable `var`.

---

17
What does & do when in a method invocation argument?
```ruby
method(&var)
```

- The use of `&` indicates that `var` will be converted to a block and then passed in to `method` on invocation.  If `var` is a proc, then it will be directly converted to a block.  If `var` is not a proc, Ruby will attempt to call `to_proc` on that object (e.g., using `Symbol#to_proc`) to first convert `var` to a proc before converting to a block.

---

18
==What is happening in the code below?==
```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
```

- The `&` operator is being used to convert `:to_s` to a block to be passed in to the invocation of `Array#map`.  The symbol `:to_s` references a method (`Integer#to_s` in this case, since the array elements are integers).  The `&` operator converts that method to a proc (similar to `proc { |num| num.to_s }`) and then a block to be passed in to `Array#map`.
- As a result, the output from the invocation of the `p` method will be:  `["1", "2", "3", "4", "5"]`.

---

19
How do we get the desired output without altering the method or the method invocations?
```ruby
def call_this
  yield(2)
end

# your code here

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

- The desired output can be obtained by adding definitions for 2 procs named 'to_s' and 'to_i'.  One way to define these procs is by adding the code:
```ruby
to_s = proc { |num| num.to_i } # OR   to_s = :to_i.to_proc
to_i = proc { |num| num.to_s } # OR   to_i = :to_s.to_proc
```

---

20
How do we invoke an explicit block passed into a method using &? Provide example.

- Explicit blocks passed into a method are invoked using `call`.
- For example:
```ruby
def a_method(&chunk)
  chunk.call
end

a_method { puts "You got me!" }
```
- The block `{ puts "You got me!" }` is passed into `a_method`, converted to a `proc` and assigned to the local method variable `chunk`.  `chunk.call` then executes that `proc` which invokes the `put` method with the string `"You got me!"` passed in.  This outputs `You got me!` to the screen.

---

21
What concept does the following code demonstrate?
```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```

- This code demonstrates 'sandwich code' : a method is defined where some actions are executed 'before' (`time_before = Time.now`) and also 'after' (`time_after= Time.now` and `puts "It took #{time_after - time_before} seconds."`) the code passed in through a block are executed (as indicated by the `yield` 'sandwiched' between the 'before' and 'after' code).

---

22
What will be outputted from the method invocation `block_method('turtle')` below? Why does/doesn't it raise an error?
```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

- The output on screen will be `This is a turtle and a .`
- The code does not raise an error since blocks have lenient arity.  The block is represented by
```ruby
do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```
- This block defines 2 block parameters `turtle` and `seal`.  However, since blocks in Ruby have lenient arity, execution of the block does not require both arguments to be passed in.
- When `block_method` is invoked, only 1 argument `'turtle'` is passed in and then passed to the block. Thus, the block parameter `turtle` is assigned to the string object with value `'turtle'` and the block parameter `seal` is assigned to the object `nil`. When the block is executed the `nil` object is output through string interpolation as nothing.

---

23
What will be outputted if we add the follow code to the code above? Why?
```ruby
block_method('turtle') { puts "This is a #{animal}."}
```

- The addition of the line above will return a 'NameError' since the block passed in on invocation of `block_method` contains a reference to a local variable (or method) `animal` which is not otherwise defined.

---

24
What will the method call `call_me` output? Why?
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

- The output will be `hi Griffin`.  This is because when the proc `chunk_of_code` is defined, it references a outer-scope local variable `name` and creates a binding to it.  When `name` is re-assigned to `"Griffin"`, the new value of `name` is used when the proc is called by the `call_me` method.

---

25
What happens when we change the code as such:
```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

- Since the local variable `name` is now not defined when the `proc` assigned to the `chunk_of_code` is declared, Ruby will raise a 'NameError'.

---

26
What will the method call `call_me` output? Why?
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"

def name
  "Joe"
end

chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```

- The code will output `hi Robert` to the screen. 
- Ruby will first look for a local variable `name` when referenced within the proc `chunk_of_code`.  Since `name` references both a local variable and a method, to explicitly call the method `name`, the use of parentheses would be required (e.g., `name()`).

---

27
Why does the following raise an error?
```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
```

- An error is raised since the use of the `&` in the method invocation will try to convert `a` into a block - the string object `'friend'` cannot be converted into a block (e.g., no `String#to_proc` exists) and thus an error is raised.

---

28
Why does the following code raise an error?
```ruby
def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```

- An error is raised as a result of this line `bl = { puts "hi" }` : blocks can only be defined when invoking methods, or creating procs (or lambdas), they cannot be created an assigned to the local variable `bl`.

---

29
Why does the following code output false?
```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
```

- The method `some_method` invokes `block_given?`, which will return `true` if a block has been passed into when `some_method` is invoked.  When `some_method` in invoked, a *proc* (named `bloc`) is passed in as an argument, but is never converted to a block by prepending it with `&`, hence `block_given?` returns `false`.

---

30
How do we fix the following code so the output is true? Explain
```ruby
def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

- The desired output can be obtained by prepending `bloc` with `&` when `some_method` is invoked (to convert the proc `bloc` into a block). Additionally, once `bloc` is converted to a block, the method definition for `some_method` also needs to be updated to remove the required parameter `block` (which will not be passed in when `bloc` is converted to a block). This can be done by removing `block` from the method definition entirely, OR prepending `block` with `&` to indicate the use of an explicit block.
- The updated code could be:
```ruby
def some_method  # OR  def some_method(&block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(&bloc)
```

---

31
==How does `Kernel#block_given?` work?==

- The method `block_given?` will return `true` when a block has been passed in to a method or `false` when no block has been pased in to a method.

---

32
Why do we get a LocalJumpError when executing the below code? & How do we fix it so the output is hi? (2 possible ways)
```ruby
def some(block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```

- The LocalJumpError occurs since the method `some` uses `yield` to execute code passed in with a block.  However, when `some` is invoked, no block is passed in - only a proc `bloc`.  With no block passed in, the use of `yield` raises the LocalJumpError.
- To fix the code and generate the desired output the proc can be converted to a block by updating the code with the use of `&` as follows:
```ruby
def some(&block) # updated to indicate an explicit block
  yield
end

bloc = proc { p "hi" } # do not alter

some(&bloc) # updated to convert proc `bloc` to a block
```
- OR the method can be updated to executed the proc `block` as follows:
```ruby
def some(block)
  block.call # updated to call the proc `block`
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```

---

33
What does the following code tell us about lambda's? (probably not assessed on this but good to know)
```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

- This code indicates that:
  - lambdas are actually a special type of Proc and 
  - lambdas cannot be instantiated through the use of the `Lambda.new` syntax.

---

34
==What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assessed on this, but good to know ;)==
```ruby
def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."
```

- This code indicates that a method can execute further code after returning from a lambda, but NOT after returning from a proc.

---

35
What will `#p` output below? Why is this the case and what is this code demonstrating?
```ruby
def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

arr = retained_array
arr.call('one')
arr.call('two')
p arr.call('three')
```

- The `#p` call will return `['one', 'two', 'three']` which is the array returned by calling the proc returned by the `retained_array` method.
- The local variable `arr` is assigned to the return value of the `retained_array` method, which happens to be a `proc`.  Every time this `proc` is called, it adds the argument it was called with to an array (using `<<`, i.e., `Array#push`) and then returns that array.
- On the 3rd call to the `proc`, the return value of the `proc` (the array, now with 3 elements) is passed as the argument to the `#p` method which outputs that array to the screen.

---

## TESTING WITH MINITEST

36
What is a test suite?

- A test suite is the complete set of tests which accompany a program.  The test suite may be in 1 or multiple test files and will contain a number of different tests (each which will contain 1 or more assertions).

---

37
==What is a test?==

- A test is one specific aspect of a program which requires validation to ensure it is functioning appropriately.  A test will be comprised of 1 or more assertions.

- CHECK:  https://launchschool.com/lessons/dd2ae827/assignments/b6169bec

38
What is an assertion?

- An assertion is a specific comparison or verification step that helps to verify if a test has passed or not.  Typically assertions provide an explicit expectation which is compared to actual program output to determine if the assertion passes.

---

39
What do testing framworks provide?

- Testing frameworks provide the structure and language to help conduct testing on programs.  This includes: defining tests, setting-up code and related objects, executing tests, asserting validations and then tearing-down (cleaning-up) artifacts created during testing.

---

40
What are the differences of Minitest vs RSpec

- Minitest is a default Rubygem included with modern Ruby installations.  Tests in Minitest can be defined with both Ruby language or a Domain Specific Language (DSL) which reads similarly to RSpec.  RSpec is another Rubygem for testing which only uses a DSL to define and conduct tests. RSpec is not a default Rubygem and must be installed separately.
- Otherwise, Minitest and RSpec offer similar functionality.

---

41
What is Domain Specific Language (DSL)?

- A DSL is a a separate syntax, similar to a coding language, which is used for a specific purpose.  For example, RSpec has a DSL that is distinct from Ruby and which is used to define and execute tests on Ruby code.  The RSpec DSL may read a bit more similarly to English, but is a kind of coding language specific to RSpec.

---

42
==What is the difference of assertion vs refutation methods?==

- Assertion methods pass when the returned value is `true`.  Whereas, refutation methods pass when the returned value is `false'.
- For example, `assert_equal(exp, act)` passes when `exp` == `act` returns `true` (i.e., the expected value is equal to the actual value).  Howevr, `refute_equal(exp, act)` passes when `exp` == `act` returns `false` (i.e., when the expected value does *not* equal the actual value).

---

43
How does assert_equal compare its arguments?

- `assert_equal` uses the `==` (fake) operator to compare it's arguments. The appropriate version of `==` will be used depending on the class of the arguments being compared.  For example, if both expected and actual values are integers, then `assert_equal` will use `Integer#==`.  For objects of a custom classes, `BasicObject#==` will be used unless the custom class defines an overridden `==` method.

---

44
What is the SEAT approach and what are its benefits?

- SEAT is a testing approach that defines steps in the overall testing process:
  - S : set-up testing objects
  - E : execute tests
  - A : assert validations
  - T : tear-down testing objects
- The benefit to this approach is that it is systematic, can minimize unnecessary repetition in test code (e.g., the use of set-up), and minimizes system resources (e.g., the use of tear-down).  Structure and organized tests (i.e., structured according to Execution of tests on a specific aspect of the program with its corresponding assertions) can make debugging and fixing code easier to understand, as well.

---

45
When does setup and tear down happen when testing?

- Setup and teardown happen for each test (each separate 'test_' method) which is executed.  Setup code is executed before tests are run and tear down code is executed after tests are run.

---

46
What is code coverage?

- Code coverage is a concept which describes how much of the program has corresponding tests defined within the test suite.  Generally, the higher the level (e.g., percentage) of code coverage, the higher to confidence a developer can have that the code is functioning as expected. If all aspects of the program have tests defined, then there is a high-level of code coverage which can correspond to a high level of confidence in the code.  Note that the quality of tests defined may still vary and thus code coverage is not the only contributor to code confidence.

---

47
What is regression testing?

- Regression testing is testing for the purposes of ensuring that updates to the code do not create errors or bugs. If automated tests defining the expected behaviour of code are defined, then as code is updated, tests can be run to confirm that no errors have been introduced.

---

## CORE TOOLS

48
What are the purposes of core tools?

- There are a number of core tools associated with Ruby programming:
  - Ruby itself : the core Ruby interpreter and any default gems included on installation
  - Ruby version managers (e.g., RVM or Rbenv) : these tools help to manage multiple versions of Ruby on a system 
  - RubyGems (the `gem` executable) : additional Ruby libraries which may provide useful tools others have created to incorporate into Ruby programs
  - Bundler (the `bundle` executable) : a dependency manager to help manage specific Ruby or RubyGem versions which may be required to run the Ruby program or the RubyGems used
  - Rake (the `rake` executable) : an automation tool that can help automate common tasks (e.g., running tests, setting up files, managing git repositories, etc.)

---

49
What are RubyGems and why are they useful?

- RubyGems are packaged libraries of Ruby code that can be downloaded and incorporated into Ruby programs. The most common source of RubyGems is from https://rubygems.org. Other developers create these RubyGems to help simplify or automate various coding tasks.  Common examples are `pry` for debugging or `minitest` for testing.  Other examples might include specific libraries which simplify the display of dates (like 'stamp') or add colour to screen output.

---

50
What are Version Managers and why are they useful?

- Version Managers (like RVM or Rbenv) allow multiple versions of Ruby to be installed on your system. This is useful since different projects may require different versions of Ruby in order to run smoothly (since commands, syntax, etc. within the language are evolving and changing).  Version managers allow the version of Ruby being used to be easily changed and corresponding gems and their versions to also be managed separately.

---

51
What is Bundler and why is it useful?

- Bundler is a dependency manager for Ruby programs - it helps to track the dependencies associated with your Ruby program.  For example, your program may require a specific version of Ruby, specific RubyGems or specific versions of RubyGems.  Each RubyGem that you use may also have specific dependencies.  Bundler will scan the dependencies associated with each of your program dependencies and document and install all of the associated versions to ensure that your program can be easily installed and run on different systems.

---

52
What is Rake and why is it useful?

- Rake is an automation tool for Ruby programs.  It uses the Ruby language to define common tasks which can be executed from the command line.  Tasks such as preparing files, creating or editing documentation, running tests, executing shell commands (like git commands), or packaging code are all tasks that Rake can help automate. Pre-defining these tasks makes it easier to maintain consistency, reduce human error, and reduce overall effort in completing tasks in a specific way and in an specific order.  Use of a `Rakefile` can be especially helpful when collaborating with a distributed team.

---

53
==What constitutes a Ruby project?==

- The components of a Ruby project are up to the developer.  Personal projects may only involve the Ruby interpreter and the associated program files.  However, in order to share programs and collaborate with others, typical Ruby projects will have:
  - the Ruby program files (organized in specific folders)
  - associated test files (to ensure the program is functioning as expected)
  - a `Gemfile` which defines dependencies and is used to create the `Gemfile.lock` (to manage dependencies)
  - a `Rakefile` to automate common tasks associated with the development or distribution process
  - a `README.md` file and/or other documentation
  - a `.gemspec` file (if the project is anticipated to be distributed as a RubyGem)