# ToDos

- ~~read [RegEx book](https://launchschool.com/books/regex)~~
- read [factorial posts](https://launchschool.com/posts/587959fd) in detail
- minimax: <https://en.wikipedia.org/wiki/Minimax>
  - may need to better understand recursion to better understand this
- study `Enumerable#inject` and work on using it in all it's variations  (could do Easy 2 sum or product of consecutive integers again)

#### from practice problems:
- [X] memorize array methods (pop / push, etc)
- [X] do we need to know the formal method names.  i.e., `Array#each` vs `Enumerable#each`?
- [ ] update notes to clarify methods associated with `Enumerable`, `Array`, etc.
- [x] remember p and puts have different return values!
  - p wil return the value of argument;  puts returns nil
  - p will show strings with quotes e.g., "string"
  - puts will NOT show strings with quotes
- [x] check terminology:  'indexed access' to a string?  i.e., 
  ```ruby
  string = 'abcdefg'
  string[-4]
  ```
    - it's called 'string element reference' (using a negative index)
- [x] check multiple assignments - use of arrays, etc.
- [x] need to worry about when quotes show up with string output or not?
- check ranges (0..5) vs (0...5)
  - 0..5 is inclusive of 0 and 5, 0...5 is from 0 to < 5
- [x] array[-2] : check language on this type of access
- [ ] when predicting output, make sure to consider ALL outputs!!  including those that might be in loops
- [x] what other 'string' methods can be called on symbols? (e.g., capitalize, etc?)
- [ ] likely need to check symbol methods (these must be defined, since Symbol#reverse doesn't exist - NoMethodError)

### new notes (file properly)



- [x] what is an expression vs operators / operands / methods
    - expression - needs to evaluate to something
    - method invocation is an expression, but method definition is not an expression
    - any chunk that evaluates down to 1 value
- [X] confirm:  if...else evaluates to something - it doesn't return anything (but the method may return something)
  - Ruby is acting as if it's a pass-by-reference, if the object it passes can be mutated 
  - if the method does not mutate, it acts like a pass-by-value 
  - technically we wouldn't say that `if...else` returns something since *methods* return values; expressions *evaluate to* a value

- [X] the language 'referencing' (is it just used for referencing a variable in code - i.e., for a return?  see Daniel Singer - Slack msg)
- [X] what do variables 'reference'?
- [X] the space in memory - does it *contain* an object?  *is* it an object?    What's the right language?  (e.g., Rowan's "variables in ruby act as pointers to a space in memory, an object.")
    - it's okay to say that the same in memory *contains* an object
    - variables act as pointers to an addres space in memory that contains a value [source](https://launchschool.com/books/ruby/read/more_stuff#variables_as_pointers)
    - local variables can point to array objects, adding local variables [to an array] *looks the same* as adding the actual array objects they're pointing to into the array, [but the nesting creates 2 ways to access the elements within]  [source](https://launchschool.com/lessons/c53f2250/assignments/1a6a2665)
    - initializing a variable creates a *reference* or *points to* a String object with value `'etc'`. The String object represented by literal `'etc'` is assigned to a variable that has the name of the variable by storing it's `object_id` [source](https://launchschool.medium.com/variable-references-and-mutability-of-ruby-objects-4046bd5b6717)

#### From practiceTest2
- [x] `times` method : what's the right language to use?  A loop?  An iterator?
    - you can refer to it as a '`times` loop' [source](https://launchschool.com/books/ruby/read/variables#whatisavariable)
    - e.g.,'in the first 4 iterations of the loops' the `break` was not executed.  On the 5th iteration, the `if` statement evaluated as `true` so the code within the `if` statement was executed. [source](https://launchschool.com/books/ruby/read/loops_iterators#simpleloop)
- [X] How to refer to 'block parameters' and iteration?
  - from James D:
      - Each element from the calling array is passed to the block in the form of an argument, {name_of_argument}
      - Each element from the calling array is passed to the block and assigned to the local variable {name_of_variable}
      - [source](https://launchschool.com/lessons/c53f2250/assignments/c633cf37)
        - 'each inner array is passed to the block in turn and assigned to the local variable `arr`
- [x] language to use when 'executing' conditional branches - what to say?
    - the code within the `if` is `run` or `not run` [source](https://launchschool.com/books/ruby/read/basics#literals)
    - e.g., `if x == 3` :  is the '`if` condition' [source](https://launchschool.com/books/ruby/read/flow_control#conditionals)
    - 'the code within the `if` statement was executed' [source](https://launchschool.com/books/ruby/read/loops_iterators#simpleloop)
- [x] is `>=` an operator?  what is it called?  how is it used? (what language to use)
  - it's a 'comparison operator' that takes expressions or values as its *operand* to return a boolean value [source](https://launchschool.com/books/ruby/read/flow_control#conditionals)
- [x] confirm return values from `loop` method
    - generally `nil`, but can return other things (e.g., enumerator, values stored in exceptions) [source](https://docs.ruby-lang.org/en/master/Kernel.html#method-i-loop)
- [X] confirm language around mutating methods :  do they 'mutate the caller'?  how else could it be referred to?
    - do *not* use the term 'mutating the caller';  more correct to say mutating the argument (when a method is called)
    - need to be careful about whether the 'caller' is being mutated or not;  better to just refer to a *mutating* vs *non-mutating* method
- [x] confirm that return values only come from methods
    - **no**  :  Ruby expressions always return a value (even if error or `nil`).  An expression is anything that can be evaluated (pretty mch everything in Ruby is an expression). [source](https://launchschool.com/books/ruby/read/basics#literals)
    - only use `return` keyword to define an explicit return value for a method
      - expressions **do** something and also **return** something
      - e.g, `return number + 3` : the 'evaluated result' of `number + 3` is returned
    - fairly confident that only methods use the keyword `return` [source](https://launchschool.com/books/ruby/read/methods#putsvsreturnthesequel)
- [X] what is passed to method arguments - variables or values?
  - 'a local variable is passed to a method as an argument at invocation' [source](https://launchschool.com/lessons/a0f3cd44/assignments/9e9e907c)
  - later in the same article, they indicate that the 'string `'Hello'` is passed in as an argument at method invocation in the form of the local variable `word`' (a method parameter)
- [x] language to be used when passing values to blocks
  - from James D:
    - Each element from the calling array is passed to the block in the form of an argument, {name_of_argument}
    - Each element from the calling array is passed to the block and assigned to the local variable {name_of_variable}
    - [source](https://launchschool.com/lessons/c53f2250/assignments/c633cf37)
      - 'each inner array is passed to the block in turn and assigned to the local variable `arr`

- [X] confirm language for `each_with_object`
  - e.g., 'calling `each_with_object` on the object with value ...' [source](https://launchschool.com/books/ruby/read/methods#chainingmethods)
  - can be called a collection object [source](https://launchschool.com/lessons/85376b6d/assignments/d86be6b5)
  - the docs call it a **memo-object** [source](https://docs.ruby-lang.org/en/master/Enumerable.html#method-i-each_with_object)
- [X] language to use when a `p` method is invoked and a local variable is passed in - what is passed?  variable?  value?  etc.
    - can just say 'when we call `p variable` ...' [source](https://launchschool.com/books/ruby/read/variables#whatisavariable)

    - e.g.,
      ```ruby
      def say(words)
        puts words + '.'    ## <= We only make the change here!
      end

      say("hello")
      ``` 
  - When we call say("hello"), we pass in the string "hello" as the argument in place for the words parameter. Then the code within the method definition is executed with the `words` local variable evaluated to "hello". 
  - [source](https://launchschool.com/books/ruby/read/methods#whataremethodsandwhydoweneedthem)

- [x] confirm language for 'implicit return' (i.e., last line of code is evaluated?  return value of last line of code? )
  - in Ruby, every method returns the evaluated result of the last line that is executed. [source](https://launchschool.com/books/ruby/read/methods#putsvsreturnthesequel)
- [X] language for access a hash (e.g., `hash[key]` ) - indexed reference?
    - retrieving a hash value by it's key [source](https://launchschool.com/books/ruby/read/basics#literals)
    - "hash values are retrieved by by keys" [source](https://launchschool.com/lessons/85376b6d/assignments/d86be6b5)
- [X] review language in https://launchschool.com/lessons/c53f2250/assignments/c633cf37

### Things to remember at test time
- [ ] remember to answer all parts of question - e.g., what concept - could be 'pass by value' or 'pass by reference', etc.
- [ ] when predicting output, make sure to consider ALL outputs!!  including those that might be in loops
- [ ] remember to scan for debugging questions that might take longer and leave enough time to address them
- [ ] keep a list of questions to go back and double-check / expand
- [ ] need to be careful with loop counters and conditionals
  - *take the time to carefully review edges (start and end)*


