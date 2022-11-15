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

- [ ] what's the 