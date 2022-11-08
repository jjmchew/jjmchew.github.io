# ToDos

- ~~read [RegEx book](https://launchschool.com/books/regex)~~
- read [factorial posts](https://launchschool.com/posts/587959fd) in detail
- minimax: <https://en.wikipedia.org/wiki/Minimax>
  - may need to better understand recursion to better understand this
- study `Enumerable#inject` and work on using it in all it's variations  (could do Easy 2 sum or product of consecutive integers again)

#### from practice problems:
- [X] memorize array methods (pop / push, etc)
- [ ] do we need to know the formal method names.  i.e., `Array#each` vs `Enumerable#each`?
- [ ] update notes to clarify methods associated with `Enumerable`, `Array`, etc.
- [ ] remember p and puts have different return values!
  - p wil return the value of argument;  puts returns nil
  - p will show strings with quotes e.g., "string"
  - puts will NOT show strings with quotes
- [ ] check terminology:  'indexed access' to a string?  i.e., 
  ```ruby
  string = 'abcdefg'
  string[-4]
  ```
- [ ] check multiple assignments - use of arrays, etc.
- [x] need to worry about when quotes show up with string output or not?
- check ranges (0..5) vs (0...5)
  - 0..5 is inclusive of 0 and 5, 0...5 is from 0 to < 5
- [ ] array[-2] : check language on this type of access
- [ ] when predicting output, make sure to consider ALL outputs!!  including those that might be in loops
- [ ] what other 'string' methods can be called on symbols? (e.g., capitalize, etc?)
  - likely need to check symbol methods (these must be defined, since Symbol#reverse doesn't exist - NoMethodError)

### new notes (file properly)

Common array methods (all mutating)
  - |       | first element         | last element   | returns          |
    |------ |-----------------------|----------------|------------------|
    |remove | `shift`               | `pop`          | removed elements |
    |add    | `unshift` / `prepend` | `push`         | new array        |
    

