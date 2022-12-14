# Ruby methods reference

Ruby has 5 types of variables:
- constants 
- global variables, 
- class variables, 
- instance variables, 
- local variables
>

Constants
- have *lexical scope*, behave differently than local variables
  - can be defined in blocks and available outside
  - can be accessed in methods without being passed in
>


```Ruby
[object].object_id # returns the memory id of object
p [object].inspect # displays an object
[object].class # displays class of object
```
example of `[object].tap` (helps display contents of an object):
```Ruby
(1..10)                 .tap { |x| p x }   # 1..10
 .to_a                  .tap { |x| p x }   # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
 .select {|x| x.even? } .tap { |x| p x }   # [2, 4, 6, 8, 10]
 .map {|x| x*x }        .tap { |x| p x }   # [4, 16, 36, 64, 100]
```
- `tap`:
  - is non-destructive
  - will not iterate through objects, just print them
>
- convert string to integer:  `Integer(string)` (can add `rescue false`)
- convert string to float:  `Float(string)` (can add `rescue false`)
- `format()` returns a formatted string
  - see Ruby docs [Kernel > format](https://ruby-doc.com/core/Kernel.html#method-i-format)
  - e.g., `format('%.2f')` to format float numbers with 2 decmial places
  - e.g. `format('%02d:%02d',hh,mm)` formats numbers in "hh:mm" format (2 digit number strings)
- `puts` writes each array element on a new line, no quotes for strings
  - e.g.
    ```ruby
    1
    2
    3
    ```
- `p` automatically  calls `.inspect` (e.g., out of array is `[1, 2, 3]`)
- `!<object>` turns object into opposite of boolean equivalent
- `!!<object>` turns an object into its boolean equivalent
- `(10..100).cover?(42) # true` will determine if 42 lies between 10 - 100
- multiple assignments e.g., 
  ```Ruby
    def tricky_method(a_string_param, an_array_param)
      a_string_param += "rutabaga"
      an_array_param += ["rutabaga"]
      # notice return with ,
      return a_string_param, an_array_param  
    end
    
    my_string = "pumpkins"
    my_array = ["pumpkins"]
    # notice assignment with ,
    my_string, my_array = tricky_method(my_string, my_array)
  ```

- statements are automatically evaluated by Ruby:  e.g., `color == 'blue' || color == 'green'`
- if sum of numbers is an integer, and count of numbers is an integer, then the average (sum / count) is also an integer
- `(1..10)` (Range) returns an Enumerator: can be used like an array - i.e., can run array methods like `.map` or `.each`; it is NOT an array until you iterate across it
  - `1..10` includes `1` and `10`
  - `1...10` includes `1`, but *not* `10`
- `rand()` will generate a random number
  - [docs here](https://ruby-doc.org/core-3.1.2/Kernel.html#method-i-rand) : a class > Kernel > rand
  - e.g., `rand(0..20)` : random number between 0 and 20 inclusive
  - `rand(10)` : generates a random number 0 >= number **<** 10
- for current date/time:  `Time.now` (`Time#now`)
  - can get year with `Time.now.year`
- remember `puts` writes everything to it's own line
  - e.g, each array element will go to it's own line


## Integer
```ruby
[number].between?(0, 10) # Comparable#between : returns true / false 
# (note comparable is inclusive, i.e., 0 and 10 are included)
[number].divmod([number]) # returns [quotient, modulus]
[number].even?
[number].odd?
[number].abs # returns absolute value
[number].times # loops 0 .. number -1 ;  note:  returns [number]
(1..[number]).to_a # makes an array [1, 2, 3, ... number ]
[number].downto([num]) # returns an Enumerable e.g., 7.downto(2)
[number].upto([num]) # returns an Enumerable e.g., 1.upto(10)
```
- see [course notes](https://launchschool.com/books/ruby/read/basics#divisionvsmodulo) on distinction between `remainder`, `modulo` (`%`), `divmod` : always clearest to use *positive* numbers for each of these, otherwise, signs / values could vary

## Float
- `[float].ceil( [num] )` [num] is number of decimal places to return (note this rounds *up*)
- `[float].round( )` : give the number of decimal places to round float to (e.g., `answer.round(2)`)
  - note:  if the number has no decimal places (i.e., an integer), it will default to displaying with only 1 decimal place, even if 2 are defined within round.  To always display 2 decimal places, need to use `format( )`.


## Loops

```Ruby
for i in 1..10  # note:  doesn't create local scope, returns collection of elements
  next if ...
end

for friend in friends  # where friends is an array
end

for key, value in hash
end

while ...   # note:  doesn't create local scope, returns nil
end

until ...   # note:  doesn't create local scope
end

5.times { ... }

loop do
  next if ...
  break if ...
end

[array].each   # note:  returns the original array it was called on
```

## Conditionals

```ruby
print "good to go" unless false

unless ...
else
end

if ...      # Don't need explicit returns in if blocks, just ensure
elsif ...   # last statement executed has desired return
else
end         # Don't forget this!!

case ...
  when
  else
end
```
- this is valid (can use ranges in case statements):
  ```ruby
  case result
  when 90..100 then 'A'
  when 80..89  then 'B'
  when 70..79  then 'C'
  when 60..69  then 'D'
  else              'F'
  end
  ```

## String methods

```Ruby
%Q(string content here)
%(We read "War of the Worlds".) # e.g.

var = <<-MSG
  [enter multi-line
  string here]
MSG

.ord # will return ASCII # of a character e.g., "b".ord # => 98
.capitalize
.downcase
.upcase
.swapcase
.include?("s")
.match?( ) # can enter regex here
.empty?
.start_with?(' ')
.chr # returns first character of string
.gsub!(/s/, "th") # can use [string] instead of regex (e.g., /s/)
# gsub replaces all matches ('global sub')
.sub(regex, 'replacement') # only replaces first match
.scan() # uses regex, returns Array of all matches
.casecmp # case insensitive comparison;  returns integer
.strip # removes leading / trailing whitespace
.prepend([string]) # puts [string] in front of an existing string
                   # Note:  there is not String#unshift
.index([string]) # returns the index for start of [string]
.count() # counts a set of characters
.center([num]) # adds leading/trailing spaces to a string to center it within num spaces
.chars # returns an array of [string] for each character
.size
.length
.reverse # reverses a string
.split( ) # can use regex or string
.chomp or .chomp! # removes a trailing newline
.chop or .chop! # unconditionally removes the last character
```
## Enumerable
- both arrays and hash can access these methods
- `Enumerable#any? { |el| ... }` # block should return true/false, any? returns true if 1 (first) element returns true
- `Enumerable#all? { |el| ... }` # block should return true/false, all returns true if all? elements return true
- `Enumerable#each_with_index { |el, index| ... }`
- `Enumerable#each_with_object([]) { |el, object| ... }` # object used for collection
- `Enumerable#first() # is optional, specify # of results`
  - Note:  for hashes, order is preserved (by order of insertion)
  - Note:  return of first with optional number argument is an array 
    - e.g., `[[:a, 'ant'],[:b,'bear']]` use `.to_h` to convert to hash
- `Enumerable#include?()`
  - equivalent to `Hash#key?` or `Hash#has_key?`
  - Note:  `Hash#key?` is recommended for style and explicit clarity
  - `Hash#value?` is also recommended;  equivalent to `Hash#has_value?` and `hash.values.include?( )`
- `Enumerable#partition { return true/false }` : converts current collection into 2 collections (i.e., nested array)
  - e.g., 
  ```ruby
  odd, even = [1, 2, 3].partition do |num|
    num.odd?
  end

  odd  # => [1, 3]
  even # => [2]
  ```
- ```ruby
  Enumerable.min
  Enumerable.max
  Enumerable.minmax
  Enumerable.min_by
  Enumerable.max_by
  Enumerable.minmax_by
  ```
- `Enumerable#find` : looks through each array element to see if it meets a given condition.  If so, it returns it
  - e.g., `array.find { |el| array.count(el) == 2 }` will return an element in an array that occurs twice



## Arrays
<https://ruby-doc.org/core-3.1.2/Array.html>

Common array methods (all mutating)
  - |       | first element         | last element   | returns          |
    |------ |-----------------------|----------------|------------------|
    |remove | `shift`               | `pop`          | removed elements |
    |add    | `unshift` / `prepend` | `push`         | new array        |
    

```Ruby
%w(y n) == ['y','n']

Array.new(num, content) # num is number of elements
                        # content is initial value
[array].pop  # removes last array element (destructive), returns element removed
[array].push( ) OR  <<  # adds new last element
[array].concat( ) # adds new array
[array].unshift( ) # adds new FIRST element
[array].delete_at([index])  # removes element at index 
[array].delete([value])  # deletes all instances of value in array
[array].uniq  # removes all duplicate values (returns new array)
[array].select {block}  # returns all values where block evaluates to true
[array].to_s # to print
[array].to_h # convert array in [ [key,value] ... ] format to hash
[array].include?( )
[array].empty? # returns true if array is empty
[array].any? # return true if any elements meet condition
[array].all? # return true if all elements meet condition
[array].flatten
[array].each_index
[array].each_with_index { |el, index|}
[array].each_with_object([]) { |el, array| ... } # array used for 'collection'
[array].sort
[array].sort! # note: destructive methods not available for hashes
[array].sort_by { } # block indicates what to sort with
[array].sort_by! { }
[array].product
[array].each # returns the original array, use for iteration
[array].map # returns the modified array, use for transformation.  
[array].sample # returns a random element from the array
[array].delete([element] ) # deletes by 'value' 
[array].delete_at([index]) # deletes by 'index'
[array].split() # () optional
[array].join # combines array of strings into 1 string
[array].last # return last element in array
[array].reduce { |sum, num| etc. } # sum is the 'reducer'
[array].slice([start index],[length]) # returns elements in array
  arr = [1, 2, 3, 4]
  arr.slice(3, 1) # => [4]  (new array)
  arr.slice(3)    # =>  4   (just contents)
[array].dup # make a *shallow* copy of array (objects within will be the same, when modified will affect both original and dup)
# dup will NOT preserve frozen state of array
[array].clone # same as dup, EXCEPT will preserve 'frozen' state
[array].freeze # prevents changes being made to array (will throw runtime error)
[array].frozen? # returns true / false 
[array].count([value]) # returns counts of number of [value]

```
- `Array#|` : gives the union of 2 arrays, the result contains no duplicates e.g., `array1 | array2`
## Hash

```Ruby
Hash.new([value]) # [value] is default value
[hash].each { } 
[hash].delete([key])
[hash].merge!([new_hash])
[hash].empty?
[hash].any? # return true if any elements meet condition
[hash].all? # return true if all elements meet condition

[hash].key?( )  # check if hash contains key
[hash].include?( )  # check if hash contains key
[hash].member?( ) # check if hash contains key

[hash].value?( ) # check if hash contains value
[hash].select{ }  # returns key-value pairs where block is true
[hash].keep_if { } # note returns nil if no changes were made
[hash].fetch([key]) # pass in key, get value; can specify a default if key not present
[hash].to_a  # converts hash to an array of [key,value] elements
[hash].keys # returns array of keys
[hash].map # similar to map on arrays; **returns an array (NOT a hash)**;  will return 'nil' for elements (e.g., unspecified in if block)
[hash].each_key # returns keys in sequence
[hash].values # returns array of values
[hash].values_at( key1, key2, ... ) # will return an array of values at the defined keys
[hash].each_value # returns values in sequence
[hash].delete_if { } # delete elements if block is true
[hash].each_with_index { |(key, value), idx | ... }  # iterates over each key-value pair w/ idx
# can also define key-value as { |pair, idx| ... } where pair is an array
[hash].assoc([key]) # turns hash into an array [key, value] with key = [key]
[hash].sort_by { } # block indicates what to sort with (e.g., key or value, etc.).  Note:  returns an array
```
e.g. non-destructive modification of hash
```Ruby
  greetings = { a: 'hi' }
  informal_greeting = greetings[:a].clone # makes a copy of existing hash to prevent mutating original
  informal_greeting << ' there'

  p greetings # {:a=>"hi"}
  p informal_greeting # "hi there"
```
