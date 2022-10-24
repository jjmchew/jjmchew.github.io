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
\

```Ruby
[object].object_id # returns the memory id of object
p [object].inspect # displays an object
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


## Integer
```ruby
[number].between?(0..10) # Comparable#between : returns true / false
[number].divmod([number])# returns [quotient, modulus]

```

## Float
- `[float].ceil( [num] )` [num] is number of decimal places to return (note this rounds *up*)


## Loops

```Ruby
for i in 1..10  # note:  doesn't create local scope, returns collection of elements
  next if ...
end

for friend in friends  # where friends is an array
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

## String methods

```Ruby
%Q(string content here)

var = <<-MSG
  [enter multi-line
  string here]
MSG

.capitalize
.downcase
.upcase
.swapcase
.include?("s")
.match?( )
.empty?
.start_with?(' ')
.gsub!(/s/, "th") # can use [string] instead of regex (e.g., /s/)
.casecmp # case insensitive comparison;  returns integer
.strip # removes leading / trailing whitespace
.prepend([string]) # puts [string] in front of an existing string
.index([string]) # returns the index for start of [string]
.count() # counts a set of characters
.center([num]) # adds leading/trailing spaces to a string to center it within num spaces
.chars # returns an array of [string] for each character
.size
.length
.reverse # reverses a string

print "good to go" unless false

unless ...
else
end

if ...
elsif ...
else
end

case ...
  when
  else
end
```

## Arrays
<https://ruby-doc.org/core-3.1.2/Array.html>

```Ruby
%w(y n) == ['y','n']

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
[array].flatten
[array].each_index
[array].each_with_index
[array].sort
[array].product
[array].each # returns the original array, use for iteration
[array].map # returns the modified array, use for transformation.  
[array].sample # returns a random element from the array
[array].delete([element] ) # deletes by 'value' 
[array].delete_at([index]) # deletes by 'index'
[array].join # combines array of strings into 1 string
[array].last # return last element in array
[array].reduce { |sum, num| etc. } # sum is the 'reducer'
[array].slice([start index],[length]) # returns elements in array
  arr = [1, 2, 3, 4]
  arr.slice(3, 1) # => [4]  (new array)
  arr.slice(3)    # =>  4   (just contents)
```

## Hash

```Ruby
[hash].each { } 
[hash].delete([key])
[hash].merge!([new_hash])
[hash].empty?

[hash].key?( )  # check if hash contains key
[hash].include?( )  # check if hash contains key
[hash].member?( ) # check if hash contains key

[hash].value?( ) # check if hash contains value
[hash].select{ }  # returns key-value pairs where block is true
[hash].fetch([key]) # pass in key, get value; can specify a default if key not present
[hash].to_a  # converts hash to an array of [key,value] elements
[hash].keys # returns array of keys
[hash].map # similar to map on arrays; returns an array (NOT a hash)
[hash].each_key # returns keys in sequence
[hash].values # returns array of values
[hash].each_value # returns values in sequence
[hash].delete_if { } # delete elements if block is true
[hash].each_with_index { |(key, value), idx | ... }  # iterates over each key-value pair w/ idx
[hash].assoc([key]) # turns hash into an array [key, value] with key = [key]
```
e.g. non-destructive modification of hash
```Ruby
  greetings = { a: 'hi' }
  informal_greeting = greetings[:a].clone # makes a copy of existing hash to prevent mutate original
  informal_greeting << ' there'
  p greetings # {:a=>"hi"}
  p informal_greeting # "hi there"
```
