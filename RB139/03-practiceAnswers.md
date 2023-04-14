# RB139 practice problems - answers

1
Modify the following method definition and create a (Minitest) test file to automate the testing of both valid and invalid user input.

```ruby
class SimpleGame
  def get_guess
    guess = nil
    loop do
      puts "Guess a number between 1 and 200 inclusive."
      guess = gets.chomp.to_i
      break if (1..200).cover?(guess)
      puts "Invalid guess.  Try again."
    end
    guess
  end
end
```

###### Answer

```ruby
# simple_game.rb
class SimpleGame
  def get_guess(input: $stdin, output: $stdout)
    guess = nil
    loop do
      output.puts "Guess a number between 1 and 200 inclusive."
      guess = input.gets.chomp.to_i
      break if (1..200).cover?(guess)
      output.puts "Invalid guess.  Try again."
    end
    guess
  end
end
```

```ruby
# simple_game_test.rb
require 'minitest/autorun'
require_relative 'simple_game'

class SimpleGameTest < Minitest::Test
  def setup
    @game = SimpleGame.new
  end

  def test_good_input_1
    exp = 200
    user_input = StringIO.new(exp.to_s + "\n")
    output = StringIO.new
    actual = @game.get_guess(input: user_input, output: output)
    assert_equal(exp, actual)
  end

  def test_bad_then_good_input
    exp = 156
    user_input = StringIO.new("-1\n204\n5940\n" + exp.to_s + "\n")
    output = StringIO.new
    actual = @game.get_guess(input: user_input, output: output)
    assert_equal(exp, actual)
  end
end
```

---

2
How do `procs` and `blocks` differ?  Provide a code example of each being used.

### `procs`
1. can be assigned to local variables ('named') and executed later
2. can be passed into methods, or returned from methods
3. use `.call` to execute a proc
4. can test using `proc.class == Proc` (i.e., `chunk.call if chunk.class == Proc`)


### vs

### `blocks`
1. cannot be assigned to local variables (unless converted to procs) and executed later
2. only used on invocation of methods (or when instantiating procs / lambdas), cannot be passed on
3. use `yield` to execute a block (when passed into a method)
4. can test using `block_given?` (i.e., `yield if block_given?`)


### Similarities
- same arity (lenient)
- can be created using `{ }` or `do end` syntax
- `&` can convert block to proc OR a proc to a block
- return value of block (or proc) is the return value of last expression evaluated

---

3
Create a test file to test the output of the following code:

```ruby
def complicated_output(*array)
  puts "Let me introduce:"
  array.each_with_index { |element, idx| puts " #{idx} >> #{element} << " }
  puts "========="
end

complicated_output("Chris", "Pat", "Tyler")
```

ruby test file:
```ruby
# complicated_output_test.rb
require 'minitest/autorun'
require_relative 'complicated_output.rb'

class OutputTest < Minitest::Test
  def test_output
    exp = <<~OUTPUT
    Let me introduce:
     0 >> Chris << 
     1 >> Pat << 
     2 >> Tyler << 
    =========
    OUTPUT
    assert_output(exp, nil) do
      complicated_output("Chris", "Pat", "Tyler")
    end
  end
end

```

---

4
What are the various uses of `&`?

- `&` prepending a block (argument) converts it to a `proc`
- `&` prepending a proc converts it to a `block`
- `&` prepending a symbol (which is a method) converts it to a `block` (`to_proc` is automatically called on the symbol)

---

5
What does the following code output, and why?  What 1 line can be changed to create the (assumed) desired output?

```ruby
def my_method(string, &chunk)
  proc { "you said #{string} and >#{chunk}<" }
end

var = my_method("hello") { "goodbye" }

p var.call
```

- The code will initially output:
`you said hello and >#<Proc:0x000002222a3 filename.rb:5><`
- This is because `chunk` is a `Proc` and the default string representation of a `Proc` is similar to that of a custom object class - except the name of the custom object class is replaced with the string `Proc`(i.e., before the encoding of the memory address of the `Proc`) and the filename and line number where the `Proc` is defined is included afterwards.
- Changing the return value of `my_method` where `chunk` is replaced with `chunk.call` will create the output: `you said hello and >goodbye<`.

---

6
What does the following code output, and why?

```ruby
def make_greeting(name, &phrase)
  "#{name}, #{phrase}"
end

p make_greeting("Joe")
```

- The provided code outputs `Joe, `.  Since no block is passed into the invocation of `make_greeting`, the 'explicit block' has the value `nil` and thus nothing is output after the `, ` in the return value of `make_greeting`.  Explicit blocks are not required parameters and not passing them into the invocation of a method with an explicit block defined does not raise an ArgumentError.



---

7
What is "unit testing" and why is it useful?

- "Unit testing", as defined within the LS curriculum, is testing for the purposes of preventing 'regression' in our code.  i.e., unit testing is conducted to ensure that when changes or updates are made to our code, something that was previously working doesn't stop working.
- This testing is not done manually, but is instead defined within test files which are run, similar to ruby program files, to conduct the defined tests and produce an output which identifies the number of tests conducted and whether or not they passed.
- Since unit tests can be defined within test files and do not need to be run manually, it greatly speeds the process of ensuring that the code developed is still functional and meets requirements.  As requirements are added, tests can also be added or updated and thus the code being developed can continuously and quickly be verified against objective measures.

---

8
What is a Gemfile used for?  What information is included in a Gemfile?

- A Gemfile is used to track the dependencies a particular Ruby program may have.  These dependencies include specific versions of Ruby that may be required and gems used and their versions.
- This Gemfile is used by bundler (a dependency manager) to ensure that the correct version of all required gems (and their respective dependencies) are installed and available within the development environment.  Bundler generates the `Gemfile.lock` file from the `Gemfile`.
- Information required in the `Gemfile` includes:  the source of gems (typically https://rubygems.org, but may also be proprietary databases or folders), the version of Ruby the application was developed in, specific gems that are required by the application (and specific versions of the gems that may be required).

---

9
What are some common tasks you can automate with Rake?

- Common tasks that can be automated with Rake include:
  - Creating directories
  - Running tests (and test files)
  - Installing apps / gems
  - Initializing databases
  - Listing files within a directory
  - Executing shell commands (e.g., github commands)
  - Output messages to screen

---

10
What are the typical steps required to create a new Rubygem?

- To create a new Rubygem you must:
  - prepare a 'README.md' file
  - write documentation, if necessary
  - create the `Gemfile` (with `gemspec` included)
  - create the `.gemspec` file (gem specifications file)
  - add `require "bundler/gem_tasks"` in `Rakefile`
  - use `rake build` (to create the `.gem` file for distribution)
  - use `rake install` (to test the packaged gem by installing it in your project directory)
  - use `rake release` (to send the `.gem` file to Rubygem library and publish the Rubygem)

---