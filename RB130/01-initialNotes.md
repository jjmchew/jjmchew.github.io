#### Blocks
[source](https://launchschool.com/lessons/c0400a9c/assignments/ff802368)
- any code with `do...end` or `{ ... }` is a block
- blocks are **passed into** methods (like any argument)
- depending on how a method is implemented, it may use the block or ignore it completely

[source](https://launchschool.com/lessons/c0400a9c/assignments/5a060a20)
- you can always a pass a block into a method call (no need to 'define it' like a parameter)
- `yield` will execute the block
  - if `yield` is used and no block is given it will raise a "LocalJumpError"
  - can use `Kernel#block_given?` to conditionally execute `yield`:  i.e., `yield if block_given?`
  - can execute `yield` with arguments : e.g., `yield(num + 1)`
- method invocation : executing the method
  - with blocks, method invocation may have more lines than implementation
- method implementation : defining the method (i.e., using `def`)
- review:
  ```ruby
      do |num|
    puts num
  end
  ```
  - the `|num|` is the *block parameter* (or "parameter for the block") - a special type of local variable where scope is constrained to the block
- **arity** : the rule regarding the number of arguments that you must pass to a block, proc, or lambda
  - in Ruby:  blocks and procs have *lenient arity* - will not enforce the number of arguments passed
  - in Ruby:  methods and lambdas have *strict arity* - must pass exact number of arguments
- the return value of the block can be used within a method: e.g.
  ```ruby
  def compare(str)
    puts "Before: #{str}"
    after = yield(str)
    puts "After: #{after}"
  end

  # method invocation
  compare('hello') { |word| word.upcase }
  # Before: hello
  # After: HELLO
  # => nil
  ```
- method implementor and method user may be 2 different people : can decide on percentage of decision-making ability (e.g., 100% implementor, 0% user  OR  90% implementor, 10% user, etc.)
  - if methods are called from multiple places with one little tweak in each case, a generic method which yields to a block could be best (e.g., `select` method)
  - "before" and "after" code may also benefit from blocks
    - e.g., timing, logging, notification systems, resource management (e.g., with OS - i.e., setup resource, then execute code, then clean-up code - can reduce bugs like system crashes, memory leaks, file system corruption, etc.)

- explicit blocks:  creates a variable that represents the block so it can be passed to another method
  - prepend a parameter with `&` (e.g., `def test(&block)` defines a method test which takes an explicit block called `block`
  - the `&` converts the `block` local variable to a `Proc` object
  - Ruby converts blocks passed in as explicit blocks to a simple `Proc` object (hence need to use `#call` to invoke the `Proc` object)
  - can execute that block using `block.call` or pass to another method (once it's a `Proc`, don't need to use `&`, again)

- closures:  a way to pass around unnamed "chunks of code" to be executed later (e.g., counter example)
- one way Ruby implements closures is through blocks
- blocks can return a chunk of code to be executed later by returning a `Proc` or a `lambda`

[source](https://launchschool.com/lessons/c0400a9c/assignments/490f885c)
  - where possible, it makes sense to limit access to internal instance variables and create external methods (e.g., a custom `each` method for `TodoList`) to interact with elements rather than expose `@todos` and iterate directly.

[source](https://launchschool.com/lessons/c0400a9c/assignments/fd86ea2e)
- blocks create a new variable scope - outer local variables are accessible, but local variables initialized in the block are not available outside of the block
  - "inner scopes can access outer scopes"
- beware of methods - they don't follow this rule
- `Proc`s will keep track of their surrounding context and 'drag it around' wherever the chunk of code is passed to
  - "binding" is the name of the context surrounding a `Proc` - it includes local variables, method references, constants, other artifacts in the code needed to execute correctly
  - all local variables that are required must be initialized *before* the closure is created (unless the local variable is explicitly passed as an argument when executed)

[source](https://launchschool.com/lessons/c0400a9c/assignments/26d715d8)
- e.g., `[1, 2, 3].map(&:to_s)` : uses the `&` operator on the object (symbol `:to_s`) to convert the object to a block
- Ruby can convert Procs to blocks easily;  if object is not a `Proc`, need to call `Symbol#to_proc` on the object which returns a `Proc`

[source](https://launchschool.com/lessons/dd2ae827/assignments/3a8a5aa5)
- RSpec is another test library, it uses **Domain Specific Language** (DSL) for testing
- Minitest uses Ruby
- "Test Suite"  :  all of the tests associated with program or application
- "Test"  :  a situation or context for tests to be run.  A test can contain multiple assertions.  e.g., test to get an error on login when using the wrong password
- "Assertion"  :  the verification step to confirm the data returned by program is expected
