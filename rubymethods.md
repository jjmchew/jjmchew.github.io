# Ruby methods reference

Ruby has 5 types of variables:
- constants, 
- global variables, 
- class variables, 
- instance variables, 
- local variables

```Ruby
[object].object_id # returns the memory id of object
```

>>>

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

.capitalize
.downcase
.upcase
.include?"s"
.gsub!(/s/, "th")
.casecmp # case insensitive comparison;  returns integer

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

[array].pop  # removes last array element, returns element removed
[array].push( ) OR  <<  # adds new last element
[array].unshift( ) # adds new FIRST element
[array].delete_at([index])  # removes element at index 
[array].delete([value])  # deletes all instances of value in array
[array].uniq  # removes all duplicate values (returns new array)
[array].select {block}  # returns all values where block evaluates to true
[array].to_s # to print
[array].include?( )
[array].empty? # returns true if array is empty
[array].flatten
[array].each_index
[array].each_with_index
[array].sort
[array].product
[array].each # returns the original array, use for iteration
[array].map # returns the modified array, use for transformation
[array].sample # returns a random element from the array
```

## Hash

```Ruby
[hash].each { } 
[hash].delete([key])
[hash].merge!([new_hash])
[hash].empty?
[hash].key?( )  # check if hash contains key
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
```