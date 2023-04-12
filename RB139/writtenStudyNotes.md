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

  a_proc = { |name| "My name is #{name}" }
  p my_method('Joe', &a_proc)
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

<details>
<summary>
<strong>Ruby</strong>
</summary>

- Ruby may be pre-installed with your system OS [21]
- use `which ruby` to check where it is installed [21]
  - `/usr/bin/ruby` is the system ruby
  - a directory tree with `/.rvm/` will be managed by RVM
  - a directory tree with `/rbenv/` or `/shims/` will be managed by rbenv
- use `ruby -v` to check what version is currently being used [21]
- a default Ruby installation includes: [21]
  - core library (always available code library)
  - standard library (additional code library - needs include)
  - `irb` (REPL - Read Evaluate Print Loop)
  - `rake` (utility tool for automation)
  - `gem` (manage RubyGems)
  - `rdoc` and `ri` (documentation tools)

</details>

<details>
<summary>
<strong>Rubygems</strong>
</summary>

- also called 'Gems' [22]
- Gems are packages of code you can download, install and use in Ruby program or command line using `gem` command [22]
- `gem` is a *package manager* for Ruby [from running `gem` command]
  - each version of Ruby installed on your system will have it's own version of `gem`
- Gem examples: [22]
  - `rubocop`
  - `pry`
  - `sequel`
  - `rails`
- to use: [22]
  1. find Gems on RubyGems website:  https://rubygems.org/
  2. run `gem install [gem name here]` e.g., `gem install pry`
- to check gems on local environment, run `gem env` [22]
  - can also use `gem list` (output may vary depending on version of ruby used, e.g., w/ RVM) [23]
- to debug loaded gems: [22]
  - within ruby code, add `puts $LOADED_FEATURES.grep(/freewill\.rb/)` (replace freewill with the name of the gem you want to query)
  - command will search the `$LOADED_FEATURES` array for entries that match the regex

- to create a Rubygem: [28]
  - prepare `README.md`
  - write documentation, if necessary
  - need to create a `.gemspec` file
  - add `gemspec` to the `Gemfile`
  - update `Rakefile` to include standard Rubygem tasks (`require "bundler/gem_tasks"`)
    - adds `rake build`, `rake install`, `rake release` for prepping and distributing your own Rubygem

- sample `.gemspec` file (`todolist_project.gemspec`): [28]
```ruby
Gem::Specification.new do |s|
  s.name        = 'todolist_project'
  s.version     = '1.0.0'
  s.summary     = 'Todo List Manager!'
  s.description = 'This is a simple todo list manager!'
  s.authors     = ['Pete Williams']
  s.email       = 'pw@example.com'
  s.homepage    = 'http://example.com/todolist_project'
  s.files       = ['lib/todolist_project.rb', 'test/todolist_project_test.rb']
end
```

</details>

<details>
<summary>
<strong>Ruby Version Managers</strong>
</summary>

- generically referred to as "Ruby Version Managers" [22]
- Ruby Version Managers let you install, manage and use multiple versions of Ruby [23]
  - some programs / projects may require a specific version of Ruby
- rbenv may work better on a Mac [23]
- utilities like `irb` are specific to each version of ruby [23]

##### RVM
- RVM uses a 'shell function' named `rvm` to modify your environment (e.g., change `PATH` variable to load correct ver of ruby) (a disk-based command cannot do this) [23]
  - `rvm install 2.7.5` : installs ruby 2.7.5 [23]
  - `rvm use 2.7.5` : switches ruby versions [23]
  - `rvm use 2.7.5 --default` : sets the default version of ruby [23]
  - `rvm use default` : use the default version of ruby [23]
  - `rvm --ruby-version use 2.2.2` : creates a `.ruby-version` file in the directory which automatically sets ruby versions (modifies the `cd` shell command); this takes precedence over setting ruby versions in Gemfiles
- troubleshooting w/ RVM:  [23]
  - make sure there are no spaces in directory names (not supported)
  - make sure `cd` and `rvm` are functions:  `type cd | head -1 ; type rvm | head -1`
  - make sure RVM paths are listed before other similar paths (e.g., system ruby paths):  `echo $PATH`
  - check RVM environment:  `rvm info`  (similar to `gem env`)
  - check active ver of ruby `rvm current`
  - fix permissions:  `rvm fix-permissions`
  - repair files:  `rvm repair all`

##### Rbenv
- works by creating a `shims` directory which runs scripts called 'shims'; these execute `rbenv exec PROGRAM` to execute the correct version of ruby desired [23]
- easiest to install additional ruby versions usinig `ruby-build` (an rbenv plugin) [23]
  - once `ruby-build` is installed, can install rubies with `rbenv install 2.2.2`
- other commands: [23]
  - `rbenv global 2.3.1` : sets default version of ruby to 2.3.1
  - `rbenv local 2.0.0` : sets local version (i.e., version for the current directory) to 2.0.0
    - (this creates and uses the SAME `.ruby-version` file that RVM would use)
  - `rbenv root` : identifies the 'root' folder for all rbenv installations
  - `rbenv version` : display current version
  - `rbenv which COMMAND` : identify disk location for COMMAND (e.g., `irb`, `ruby`, `rubocop`)
  - `rbenv rehash` : rebuild `shim` directory
  - `rbenv shims` : display list of current `shims`

</details>

<details>
<summary>
<strong>Bundler</strong>
</summary>

- Bundler is a *dependency manager* (and also a Gem for Ruby) [24]
  - it is installed automatically in Ruby 2.5 and higher
  - if necessary: `gem install bundler`
- create `Gemfile`, then run `bundle install` (produces `Gemfile.lock`) [24]
- ** in ruby program, before requiring other Gems, add:  `require bundler/setup` [24]
  - this also prevents Gems that aren't listed in the Gemfile from being included [26]
  - bundler will manually add paths for required gems to $LOAD_PATH [24]
- `bundle exec` command: [24]
  - runs commands in an environment defined according to `Gemfile.lock`
  - e.g., can run `bundle exec env` vs `env` : the environments will be different
  - typically used to run commands from installed gems (e.g., rake, pry, rackup)
  - often used to resolve version errors in commands (e.g., rake)
    - i.e., if you run rake from command line, it will run the default version
    - if the program needs a different version of rake, you'll get an error
- `binstubs` directory: [24]
  - alternative feature to `bundle exec` (i.e., used instead of `bundle exec`)
  - can create a directory called `bin` (or something else if you use `bin`) which contains ruby script (wrappers) with same names as executables installed by gems
  - troubleshooting: [24]
    - "in require: cannot load such file -- ... " : add gem to `Gemfile`, run `bundle install` again
    - make sure you're using the version of Bundler that corresponds to the Ruby version
    - generate a new `Gemfile.lock`:  delete `Gemfile.lock` and re-run `bundle install`
    - remove `.bundle` directory and re-run `bundle install`
    - re-install Bundler:  `gem uninstall bundler` then `gem install bundler`
    - make sure `rubygems-bundler` and `open_gem` are **not** installed
    - `rm Gemfile.lock ; DEBUG_RESOLVER=1 bundle install`  (runs `bundle install` after removing the existing Gemfile.lock with additional debug information)
- make sure all gems used (including rake, etc.) are added to `Gemfile` [27]


</details>

<details>
<summary>
<strong>Rake</strong>
</summary>

- Rake is a Rubygem that automates common functions to build, test, package, install programs [25]
  - included in Ruby
- can automate: [25]
  - creating directories / files
  - setting up databases
  - run tests
  - package app and files for distribution
  - install apps
  - perform common git tasks
  - rebuild files / directories based on changes to other files / directories
- example:  could create a Rakefile to: [25]
  - run all tests associated with the program
  - increment the version number
  - create release notes
  - make a complete backup of local repo
- create a Rakefile in project directory (a ruby program) [25]
  - `desc` and `task` are method calls in a rake DSL

##### Commands
- run `bundle exec rake -T` : lists tasks (bundle exec uses the `Gemfile.lock` environment)

##### Rakefiles
- `sh` method : runs commands [27]
- e.g.
```ruby
desc 'Say hello'
task :hello do
  puts "Hello there.  task 1"
end

desc 'Say goodbye'
task :bye do
  puts "bye.  task 2"
end

desc 'do everything'
task :default => [:hello, :bye]
```

</details>


</details>

---

<details>
<summary>Gemfiles</summary>

- `Gemfile` : a text file using a DSL (domain specific language) to define Ruby versions and gems [24]
  - need to create this file
  - then run `bundle install` to install gems / dependencies and produce `Gemfile.lock`
  - add 'gemspec' if there is a `.gemspec` file (e.g., `todolist_project.gemspec`) [26] [28]
- sample Gemfile: [24]
  ```
  source 'https://rubygems.org'
  ruby '2.3.1'
  gem 'sinatra'
  gem 'erubis'
  gem 'rack'
  gem 'rake'
  gem 'minitest', '~> 5.10'
  ```
- `'~> 5.10'` : indicates to Bundler that we want *at least* version 5.10 of minitest, but NOT v6.0 or higher


- corresponding `Gemfile.lock` (lists 'specs', platforms, dependencies, 'bundled with') [24]
  ```
  GEM
    remote: https://RubyGems.org/
    specs:
      erubis (2.7.0)
      rack (1.6.4)
      rack-protection (1.5.3)
        rack
      rake (10.4.2)
      sinatra (1.4.7)
        rack (~> 1.5)
        rack-protection (~> 1.4)
        tilt (>= 1.3, < 3)
      tilt (2.0.5)

  PLATFORMS
    ruby

  DEPENDENCIES
    erubis
    rack
    rake
    sinatra

  RUBY VERSION
    ruby 2.3.1p112

  BUNDLED WITH
    1.13.6
  ```

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
[21](https://launchschool.com/books/core_ruby_tools/read/your_ruby_installation)
[22](https://launchschool.com/books/core_ruby_tools/read/gems)
[23](https://launchschool.com/books/core_ruby_tools/read/ruby_version_managers)
[24](https://launchschool.com/books/core_ruby_tools/read/bundler)
[25](https://launchschool.com/books/core_ruby_tools/read/rake)
[26](https://launchschool.com/lessons/2fdb1ef0/assignments/61b773fd)
[27](https://launchschool.com/lessons/2fdb1ef0/assignments/f0ffb4db)
[28](https://launchschool.com/lessons/2fdb1ef0/assignments/918536a2)


# Follow-up Questions

- [X] When might I want to return a proc or a block from a method?
  - Procs are definitely a kind of 'encapsulation' - why not just use a new class / object (e.g., sequence example from notes)
  - A (from discussions):  not really sure, may not be that important to RB139 written assessment; may be more important in functional programming vs OOP programming (i.e., can encapsulate without creating a new object / class)
  - [x] Can 'blocks' be returned from code, or only procs?  i.e., procs are a WAY of returning a block (code to be executed as a closure)
  - [x] Blocks can only be used at method invocation (i.e., not a named object)
  - [x] Explicit blocks aren't actually blocks; they are converted to procs by unary `&`
- [X] is `&` a method?
    - A:  **not** a method;  it's an **operator** 
- [X] How do we convert a proc to a block
    - A: use `&` to convert a proc back to a block
- [X] the car test class - the "test suite" - what if you have multiple test files?
    - A:  test suite can be in multiple files
- [X] play around with binding for constants
    - A:  should obey the same scoping rules for methods / blocks (i.e., for blocks, inner scope can access things defined in outer-scope;  methods create their own scope and cannot access things in outer-scope)
- [X] definition of methods and ability to run methods defined afterwards (in closures - it works, in normal 'procedural' code it doesn't)
    - A:  for purposes of closures, definitely a different behaviour - just know that it is specific to closures;  don't need to know why
- [X] when an explicit block is defined in a method, why does it not adhere to strict arity rules?  i.e., why is it not necessary to pass a block in as an argument? (e.g., practiceProblems #6)
    - A:  it's NOT "method arity";  blocks aren't strictly referred to as an 'argument' in LS
- [X] should 'explicit blocks' be called 'procs' instead?  Since they're technically converted via the `&`
    - A:  know that the block AND the proc are BOTH available within the method - i.e., could do a `.call` OR a `yield` as desired;  hence they are still 'explicit blocks' (since the block still exists)
- [ ] Review the posts and discussion at the start of the lesson
- [ ] need to run rubocop! on the challenge problem solutions
- [ ] review terminology of code coverage (i.e., what is it, why, etc.)
- [ ] is `yield` a keyword?
- [ ] is it `Proc#call`?  confirm if `call` is a method
- [ ] is `block_given?` a method?
- [ ] are 'blocks', 'procs', 'methods', 'lambdas' OBJECTS?  what do we refer to these things as?
- [ ] review syntax for creating lambdas
- [ ] follow-up on return from lambda's vs procs (spot ques #34)


To review:
- [ ] https://launchschool.com/posts/281eea2f
- [ ] https://launchschool.com/posts/08e14621
- [ ] https://launchschool.com/posts/a744f590
- [ ] https://launchschool.slack.com/archives/C48A338P3/p1674832095088829
- [ ] https://github.com/gcpinckert/rb130_139
- [ ] https://github.com/W-Sho-Sugihara/RB139


### Sample questions from Spot session w/ Sherece
```ruby
def a_method(&expecting_a_block)
  expecting_a_block.call    #can call the proc
  yield                     #can yield to the block
end

p a_method {puts "I'm a block" }
```

```ruby

# why does this code raise an error? What are some ways you can fix it?
def a_method(pro)
  pro.call
end

a = 'friend' 
a_method(&a)

# ruby automatically searches for a ___#to_proc method, but there is no String#to_proc method;  but there is a Symbol#to_proc

```
