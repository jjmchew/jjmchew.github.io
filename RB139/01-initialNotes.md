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

[source](https://launchschool.com/exercises/d69b88d6)
- when using `assert_equal` : always maintain convention for arguments - first *expected* value, then *actual* value to be tested 

Other test assertions
- `assert_nil`  [source](https://launchschool.com/exercises/e1183a98)
- `assert_empty` uses `#empty?` [source](https://launchschool.com/exercises/eaa85d07)
- `assert_includes` [source](https://launchschool.com/exercises/12b78daf)
- `assert_raises` [source](https://launchschool.com/exercises/82b73047)
- `assert_instance_of` uses `Object#instance_of?` [source](https://launchschool.com/exercises/92e1ef71)
- `assert_kind_of` uses `Object#kind_of?`  [source](https://launchschool.com/exercises/098fba0b)
- `assert_same` uses `#equal?`  [source](https://launchschool.com/exercises/9eed2942) (tests to see if 2 objects are the same - i.e,. same ID)
- `refute_includes` is opposite of `assert_includes` [source](https://launchschool.com/exercises/4ac8e502)
- `assert_output` [source](https://launchschool.medium.com/assert-yourself-a-detailed-minitest-tutorial-f186acf50960)

Misc Notes
- Always close files after you open them [source](https://launchschool.com/exercises/c618c0e4)
- `$stdin` (Standard Input Stream) is a global variable used to represent default source of input (usually keyboard) [source](https://launchschool.com/exercises/64799839)
  - can use `StringIO` object to simulate keyboard input
- `$stdout` (Standard Output [screen]) [source](https://launchschool.com/exercises/e2b66911)
- using files [source](https://launchschool.com/exercises/c618c0e4):
  ```ruby
  f = File.open('filename.txt', 'r')
  f.read # read file contents;  can be assigned to a variable
  f.close
  f.closed? # returns true if file is closed
  ```
- test approach:  SEAT [source](https://launchschool.com/lessons/dd2ae827/assignments/5c80633e)
  - Setup
  - Execute (code for testing)
  - Assert (that executed code did the right thing)
  - Teardown

## Ruby Tools
- 

```ruby
chmod +x calorie_program/today_cals.rb
add `#! /usr/bin/env ruby` to line 1 of today_cals.rb
```

## Misc problems
```ruby
=begin
Consider a character set consisting of letters, a space and a point.  

Words consist of one or more, but at most 20 letters.  

An input text consists of one or more words separated by one or more
spaces and terminated by 0 or more space terminating points.  

The output text is to be produced such that successive words are
separated by a single space with the last word being terminated by a single 
point.

Odd words are copied in reverse order while even words are merely echoed.
For example, the input string:

"whats the matter with kansas."
becomes
"whats eht matter htiw kansas."

BONUS POINTS: The characters must be read and printed out one at a tine.
=end
```


```ruby
# *Inside a preschool there are children, teachers, class assistants, a principal, janitors, and cafeteria workers. 
# *Both teachers and assistants can help a student with schoolwork and watch them on the playground. 
# *A teacher teaches and an assistant helps kids with any bathroom emergencies. 
# *Kids themselves can learn and play. 
# *A teacher and principle can supervise a class. 
# *Only the principal has the ability to expel a kid. 
# *Janitors have the ability to clean. 
# *Cafeteria workers have the ability to serve food. 
# # *Children, teachers, class assistants, principals, janitors and cafeteria workers all have the ability to eat lunch.

=begin 
Nouns: preschool, children, teachers, class assistants, principal, janitors, cafeteria workers, homework, playground, bathroom, lunch, class

verbs: help, watch, learn, play, supervise, expel, clean, serve, eat 

preschool has all the people
children: play,learn, eat
teachers: help, watch, teaches, supervise, eat
class assistants: help, watch, help(bathroom), eat
principals: supervise, expel, eat
Janitors: clean, eat
cafeteria workers: serve, eat

=end

module Helpable
  def help_with_work
  end
end

module Watchable
  def watch
  end
end

module Supervisable
  def supervise
  end
end

class Preschool 
  def eat 
  end
end

class Child < Class_of_children
  def play; end
  def learn; end
end

class Teachers < Preschool
  include Helpable
  
  def teach; end  
end

class Class_assistants < Preschool 
  include Helpable
  def help_with_bathroom
  end
end

class Principal < Preschool
  def expel; end
end

class Janitors < Preschool
  def clean; end 
end

class Cafeteria_workers < Preschool
  def serve; end 
end

#######################
module Preschool
  class Participant
    def eat(object); end
  end

  module Supervisable
    def supervise(object); end
  end

  module Helpable
    def help_with(object); end
  end

  class Child < Participant
    def learn; end

    def play(object); end
  end

  class Teacher < Participant
    include Supervisable
    include Helpable
    include Watchable
    
    def teach; end
  end

  class ClassAssistant < Participant
    include Helpable
    include Watchable
  end

  class Principal < Participant
    include Supervisable

    def expel; end
  end

  class Janitor < Participant
    def clean

    end
  end

  class Cafeteria_Worker < Participant
    def serve(object)

    end
  end

  class Homework

  end

  class Playground

  end

  class Bathroom

  end

  class Food

  end

  class Lunch < Food

  end

  class ClassofKids

  end

  
end
```