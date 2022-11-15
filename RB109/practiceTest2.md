- first 22 questions from Brandi Seeley

### Question 1:
### What will the following code print? Why?

```ruby
def count_sheep
  5.times do |sheep|
    puts sheep
    if sheep >= 2
      return
    end
  end
end

p count_sheep
```
The code will output:
```ruby
0
1
2
nil
```
Overall, the main code invokes the `p` method with the `count_sheep` method passed in as an argument.  This will output to screen, the return value of a method `count_sheep` which takes no arguments. To do so, the program must first evaluate the return value from the `count_sheep` method.

Within the method `count_sheep`, the `times` method is called upon the integer `5` with a block passed in which defines a block parameter `sheep`. ==This acts like a loop, with the block parameter `sheep` receiving the integers, `0`, `1`, `2`, up to `4` for each iteration== and then executing the code within the block.

The code within the block will first invoke the `puts` method with the referenced value of `sheep` passed in.  On the next line, if the expression `sheep >= 2` evaluates to `true`, then the `return` statement will be executed which will end execution of the `count_sheep` method and return the value defined, which in this case is `nil`. Thus, the value of `sheep` - the integer numbers `0`, `1`, `2` will be output to screen, each on a separate line, as per the behaviour of `puts` and then the `if` expression will evaluate to `true`, which ends execution of the method and returns the value `nil`. The return value of the `count_sheep` method is then passed into the final `p` invocation.  This `nil` value is output to screen as 'nil', as per the final `p` method invocation.

### Question 2:
### What does the following code return? What does it output? Why? What concept does it demonstrate?

```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```
The `times` method will return `nil` based on the last line evaluated in the block which is passed in as an argument. The last line of this block invokes the method `puts`, which always returns `nil`.

Overall, the code outputs:
```ruby
5
5
4
2
```
The first 2 integers, `5`, are output from the invocation of the `times` method.  Within this method, the block variable `a` first receives the appropriate integer index from the `times` method, then this variable is reassigned to the integer value `5`, which is then passed in as an argument to the `puts` method.  The `puts` method outputs the value `5` to screen. This occurs twice as per the `times` method.

The last 2 `puts` method invocations output to screen the unchanged values of the local variables `a`, and `b` to screen, which are `4` and `2` respectively.  These local variables were initialized and assigned in the first 2 lines of code.

Of particular interest is the fact that the local variable `a` is not reassigned upon invocation of the `times` method. Both the inner-scope block parameter in the block argument passed in AND the outer-scope local variable share a common name, `a`.  'Variable shadowing' occurs when the inner-scope block variable `a` is accessed within the block, preventing access to the outer-scoped local variable `a`.  Thus, the outer-scoped local variable `a` is never reassigned.

### Question 3:
### How does count treat the block's return value? How can we find out?

```ruby
['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end
```
The `count` method will count the number of times the block passed in as an argument evaluates to `true` (i.e., is truthy). One way to determine how the block's return value has been treated is to initialize and assign the return value from count to a new local variable and then output that value to screen.

This modified first line of code would capture the return value of `count` within a new local variable `new_var`:
```ruby
new_var = ['ant', 'bat', 'caterpillar'].count do |str|
```
An additional final line of code to output that value is: `p new_var`, which will output `2` to screen.  This demonstrates that the return block from `count` has evaluated to `true` 2 times.  From looking at the code within the block argument passed into `count`, we can see that it is evaluating the length of each string being passed in and will evaluate to `true` when that length is less than `4` - once for `'ant'` and again for `'bat'`.

### Question 4:
### Our predict_weather method should output a message indicating whether a sunny or cloudy day 
# lies ahead. However, the output is the same every time the method is invoked. Why? Fix the 
# code so that it behaves as expected.

```ruby
def predict_weather
  sunshine = ['true', 'false'].sample
  
  if sunshine
    puts "Today's weather will be sunny!"
  else
    puts "Today's weather will be cloudy!"
  end
end
```
In the current code, the local method variable `sunshine` is assigned a *string* value of `'true'` or `'false'`. A string will always evaluate to `true` (is always truthy, no matter the actual string value), so the `if` conditional always outputs `Today's weather will be sunny!`.
One possible fix is to assign *boolean* values to `sunshine` using the updated line:
`sunshine = [true, false].sample`


### Question 5:
### What is the return value of map in the following code? Why?

```ruby
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end
```
The return value of `map` in the following code will be a new *array*, based on the return value of the block passed in as argument. This block will return a string value if the length of the string is more than 3 characters in length, OR the block will return `nil`.  Thus, the output from this code will be a new array `[nil "bear"]`.

### Question 6:
### What will the following code print? Why?

```ruby
def tricky_number
  if true
    number = 1
  else
    2
  end
end

puts tricky_number
```
This code will output `1` to screen.  The final `puts` method is invoked with the return value of the method `tricky_number` passed in.  The method `tricky_number` contains an `if..else` conditional ==which will always execute the first branch== [confirm language for conditionals] (`true` alway evaluates to `true`).  Within this branch the return value of the expression is `1` when the local method variable `number` is assigned to the integer object with value `1`.  Hence the method `tricky_number` returns the value `1` which is then output to screen by the `puts` method.

### Question 7:
### The following code throws an error. Find out what is wrong and think about how you would fix it.

```ruby
colors = ['red', 'yellow', 'purple', 'green', 'dark blue', 'turquoise', 'silver', 'black']    # 8 elements
things = ['pen', 'mouse pad', 'coffee mug', 'sofa', 'surf board', 'training mat', 'notebook'] # 7 elements

colors.shuffle!
things.shuffle!

i = 0
loop do
  break if i > colors.length
  
  if i == 0
    puts 'I have a ' + colors[i] + ' ' + things[i] + '.'
  else
    puts 'And a ' + colors[i] + ' ' + things[i] + '.'
  end
  
  i += 1
  
end
```
The code is throwing an error since the array referenced by the local variable `colors` contains more elements than the array referenced by the local variable `things`.  Since the number of elements in `colors` is used to evaluate the `break` condition for the `loop` method, the value of `i` will exceed the number of elements within the array referenced by `things`. When `i` reaches `7`, `things[i]` will return `nil`, since there is no array element at index `7` within the array referenced by `things`.  Since it's not possible to concatenate `nil` to a string, the code returns a 'TypeError'.
To fix the code, I would use the shorter array, `things` within the `break` condition. The `break` condition also needs to be updated to use the ==comparison== [confirm `>=` is a comparison or operator, etc.] `>=` since array indexes are 0-based and the last valid index for the array referenced by `things` is `6` (i.e., 7 elements indexed from `0` to `6`).  The new line will be: 
`break if i > things.length`

### Question 8:
### What does the following code return? What does it output? Why? What concept does it demonstrate?

```ruby
arr = [1, 2, 3, 4]

counter = 0
sum = 0

loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end 

puts "Your total is #{sum}"
```
The output will be `Your total is 10`.  There will be a return value from the `loop` method, ==which is always `nil`== [confirm return value for loop], but is not used within the code.

This code primarily demonstrates local variable scoping rules for blocks.  There is are 2 local variables `sum` and `counter` which are initialized in the main scope.  These 2 local variables are accessible from within the block passed into the invocation of the `loop` method and are updated through the code within within the block.  This allows the updated value of `sum` to be output through string interpolation when the final `puts` method is invoked.


### Question 9:
### What is `a`? What if we called `map!` instead of `map`?

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)
```
`a` is a local variable assigned to an array object with value `['a', 'b', 'c']`. The value of `a` is not reassigned within the method `test` since no destructive (or mutating) methods are called on that array when it is passed in as an argument when the `test` method is invoked.

If `map!` - a mutating method - was called instead, then the original array referenced by `a` will be updated to `['I like the letter: a', 'I like the letter: b', 'I like the letter: c']`.  ==This is because the object referenced by the local variable `a` is modified directly by the `map!` method within the method `test`.== [may need to clarify language for mutating vs non-mutating]

### Question 10:
### What does the following code return? What does it output? Why? What concept does it demonstrate?

```ruby
def plus(x, y)
  x = x + y
end

a = 3
b = plus(a, 2)

puts a
puts b
```
==The `plus` method== [confirm that return values only come from methods] returns an integer value (the sum of the 2 arguments provided) since upon invocation, integer values are given as arguments to the parameters `x` and `y`.

The code outputs:
```ruby
3
5
```
The `3` is output by the first `puts` method invocation when the local variable `a` is passed in. The local variable `a` cannot be mutated by the method `plus` since integers are immutable (and the `plus` method contains no destructive methods).
The `5` is output by the second `puts` method invocation when the local variable `b` is passed in. `b` is assigned to the integer return value of the `plus` method invoked with the integer values `3` and `2` passed in as arguments - the integer value `5`.

### Question 11:
### What values do `s` and `t` have? Why?

```ruby
def fix(value)
  value.upcase!
  value.concat('!')
  value
end

s = 'hello'
t = fix(s)
```
`s` and `t` will *both* have the same value `'HELLO!'` since the method `fix` will mutate the string passed in as an argument. Local variable `s` is initialized and assigned to the string object with value `'hello'`.  This local variable `s` is then ==used to pass an argument== [what's passed to methods - variables or values?] to method `fix` which effectively assigns the method variable `value` to point to the same object as local variable `s`.
The destructive methods `upcase!` and `concat` are called upon the string object referenced by `value` and make changes to the same string object referenced by both `s` and `value`.  That same string object is used as the return value for the `fix` method and is assigned to the local variable `t`.  Since all local variables reference the same string object, the values output will be the same.

### Question 12:
### What is the return value of each_with_object in the following code? Why?

```ruby
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end
```
The return value of `each_with_object` is a new =='collection' object== [confirm how each_with_object works], a hash, which has value `{"a" => "ant", "b" => "bear", "c" => "cat"}`. Which was initialized as an empty hash `{}` and was modified by the code in the block passed in as an argument ('the Block') to the invocation of the `each_with_object` method.  The code within the Block is run for each element in the array that `each_with_object` is called upon; where each element is passed into the Block as block parameter `value` and the same 'collection' object is passed into the Block as `hash`.  This collection object ('Hash') is initialized as an empty hash.
Within the Block, Hash is modified through iteration:  a hash key of a string which is the first character of each animal is created, and the corresponding value is the animal string itself.

### Question 13:
### What does the following code return? What does it output? Why? What concept does it demonstrate?

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n| 
  n + 1
  puts n
end
p new_array
```
This code returns:
```
1
2
3
4
5
6
7
8
9
10
[]
```
The numbers `1` to `10` are output as the integer elements of the array referenced by local variable `arr`.  Each of these elements is passed in as a block parameter `n` to a block ('Block') used to invoke the `select` method. Block invokes the `puts` method with block parameter `n` as an argument, which outputs that element to the screen on it's own line. Note that this `puts` method call returns `nil` which evaluates to `false` for every element.

The final empty array `[]` output to screen is the result of the `p` method invocation with `new_array` ==passed in as an argument== [confirm language].  The value of the array object referenced by `new_array` is based upon the return value of the `select` method invoked, which will include elements from the array `arr` for which Block will evaluate to `true`.  As mentioned above, each line of code within Block returns `nil`, so no elements are returned by `select`.

The concept demonstrated here is the implicit return of a code block is the ==return value of the last line of code== [confirm language], which is used by the `select` method to determine the inclusion of elements in `new_array`.

### Question 14:
### Explain the Hash#any? method and what it's doing in this code.

```ruby
{ a: "ant", b: "bear", c: "cat" }.any? do |key, value|
  value.size > 4
end
```
The `Hash#any?` will execute the code within the block passed in as argument for each key-value pair of the hash it is called on ('Calling Hash'). If the block evaluates to `true` for any element, then `any?` will return `true`, otherwise, it will return `false`.
In this code, the block looks at the length of each string value for each key-value pair in Calling Hash and evaluates to `true` if the length of the string is greater than `4`.  Since there are no string values within Calling Hash that are 5 or more characters, `any?` will return `false`.


### Question 15:
### We want to iterate through the numbers array and return a new array containing only the even numbers. 
# However, our code isn't producing the expected output. Why not? How can we change it to produce the expected result?

```ruby
numbers = [5, 2, 9, 6, 3, 1, 8]

even_numbers = numbers.map do |n|
  n if n.even?
end

p even_numbers # expected output: [2, 6, 8]
```
The code is not producing the desired result since the wrong method is being called on the collection. The `map` method will use the return value of the block it is called with as the new value for each element in a new array.  It can be thought of as `transforming` each element of the array it is called on.  The desired output has fewer elements than the initial collection and can be achieved using the `select` method which will use the 'truthiness' of the return value of the block it is called with to determine if each element of the initial array should be included in a new returned array.  Elements for which the block evaluates to `true` are included in the new returned array.

### Question 16:
### What will the following code print, and why?

```ruby
a = 7

def my_value(b)
  b = a + a
end

my_value(a)
puts a
```
The code will output an error since within the method `my_value` it tries to access a local variable `a` which does not exist with the scope of the method. Methods have a self-contained variable scope and cannot access local variables in outer scopes, such as the local variable `a`.

### Question 17:
### The output of the code below tells you that you have around $70. However, 
# you expected your bank account to have about $238. What did we do wrong?

```ruby
# Financially, you started the year with a clean slate.
balance = 0

# Here's what you earned and spent during the first three months.

january = {
  income: [ 1200, 75 ],
  expenses: [ 650, 140, 33.2, 100, 26.9, 78 ]
}

february = {
  income: [ 1200 ],
  expenses: [ 650, 140, 320, 46.7, 122.5 ]
}

march = {
  income: [ 1200, 10, 75 ],
  expenses: [ 650, 140, 350, 12, 59.9, 2.5 ]
}

# Let's see how much you've got now...

def calculate_balance(month)
  plus  = month[:income].sum
  minus = month[:expenses].sum
  
  plus - minus
end

[january, february, march].each do |month|
  balance = calculate_balance(month)
end

puts balance
```
The balance output (~$70) is the same as the monthly balance for `march`. As the balance for each month is being calculated, the program is not carrying over the balance from the prior month.  The calculation of balance should be changed to `balance += calculate_balance(month)`.

==Remember to look for debugging questions - these will take longer==

### Question 18:
### What does the following code return? What does it output? Why? What concept does it demonstrate?

```ruby
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b
```
The `loop` method will return `nil`.
The code will output to screen:
```ruby
3
2
```
The number `3` is output by the first `puts` invocation where local variable `a` is passed in.  The integer value `3` is the result of the reassignment of local variable `a` from it's initial assignment to integer value `4` to `3` by the block pased into the `loop` method invocation.

The number `2` is output by the second `puts` invocation where local variable `b` is passed in.  The integer value referenced by `b` remains unchanged from it's initial assignment to integer value `4`.

This code illustrates local variable scoping rules for blocks.  Within the block passed into the `loop` method, the outer-scope variable `a` is re-assigned to the integer value `3` (via an interim inner-scoped block variable `c`).

### Question 19:
### We started writing an RPG game, but we have already run into an error message. Find the problem and fix it.

```ruby
# Each player starts with the same basic stats.

player = { strength: 10, dexterity: 10, charisma: 10, stamina: 10 }

# Then the player picks a character class and gets an upgrade accordingly.

character_classes = {
  warrior: { strength:  20 },
  thief:   { dexterity: 20 },
  scout:   { stamina:   20 },
  mage:    { charisma:  20 }
}

puts 'Please type your class (warrior, thief, scout, mage):'
input = gets.chomp.downcase

player.merge(character_classes[input])

puts 'Your character stats:'
puts player
```
There are 2 problems with the code given.

The initial error 'TypeError' occurs since the hash `character_classes` is initialized using symbols as keys. Thus, when `input` - a string - is used to ==access== [confirm wording - 'indexed access'?] `character_classes` the value returned is `nil` since there are no string keys within `character_classes`. The `merge` method returns the error since it cannot merge the hash `player` with `nil`.

The second error is that the updated stats for each character type are not applied to the hash `player`.  This occurs since the `merge` method is non-destructive and the returned value of an updated hash with modified character stats is not captured.  This can be fixed by re-assigning `player` to the merged output of the `merge` method.

Both errors can be fixed through the updated line:  `player = player.merge(character_classes[input.to_sym])`.  This line converts the input to a symbol through the use of the `.to_sym` method which converts the string input to a symbol to be used to access the hash `character_classes`. This line is also updated to capture the updated merged values of the `player` with `character_classes` and reassign it to the local variable `player`.

### Question 20:
### Explain Hash#each_with_object method and what it's doing in this code.

```ruby
{ a: "ant", b: "bear", c: "cat" }.each_with_object([]) do |pair, array|
  array << pair.last
end
```
The method `Hash#each_with_object` iterates across the hash it is called on ('Calling Hash'), passing in each key-value pair, and returns a 'collection' object which is updated by the code within a block passed in as an argument (the 'Block'). 

In this code, on each iteration, each key-value pair is passed into Block as an array which is assigned to block variable `pair` along with the collection object `array` (which was initialized as an empty array `[]`). For each iteration the array `pair` will take the form `[key, value]` where `key` will a symbol used as the key, and `value` will the the corresponding string value from Calling Hash.  Within Block, each string value (returned by the `last` method called on `pair`) is added to `array` via the shovel operator `<<`.  Thus, the return value from `each_with_object` will be an array with value `["ant", "bear", "cat"]`.

### Question 21:
### What will the following code print, and why?

```ruby
a = 7
array = [1, 2, 3]

array.each do |a|
  a += 1
end

puts a
```
The code will output `7` since the local variable `a` in the main scope is unchanged by the `each` method called on local variable `array`.  As a result of variable shadowing, the block parameter `a` in the block passed in during invocation of `each` on `array` prevents the outer-scoped local variable `a` from being changed.

### Question 22:
### Magdalena has just adopted a new pet! She wants to add her new dog, Bowser, to the pets hash. 
# After doing so, she realizes that her dogs Sparky and Fido have been mistakenly removed. Help 
# Magdalena fix her code so that all three of her dogs' names will be associated with the 
# key :dog in the pets hash.

```ruby
pets = { cat: 'fluffy', dog: ['sparky', 'fido'], fish: 'oscar' }

pets[:dog] = 'bowser'

p pets #=> {:cat=>"fluffy", :dog=>"bowser", :fish=>"oscar"}
```
The line `pets[:dog] = 'bowser'` reassigns the value for key `:dog` to `'bowser'`, replacing the array that was the original value.  To add `'bowser'` to this array, Magdalena should add `'bowser'` to the original array, rather than replacing it.  One way is with `<<`:  the updated line would be `pets[:dog] << 'bowser'`.

### Lesson 4 Quiz
- 1:  D
- 2:  not A, B, C, D
- 3:  A, not B, C, D
- 4:  A
- 5:  B
- 6:  B
- 7:  C
- 8:  B, C, D
- 9:  B, C
- 10: A, B, C
- 11: B, C
- 12: B
- 13: D
- 14: C
- 15: A
- 16: A, C
- 17: D
- 18: A, B, C
- 19: A, B, C
- 20: B, D

### Lesson 2 Quiz
- 1:  B
- 2:  C
- 3:  A, B, C, D
- 4:  A
- 5:  B
- 6:  A, B, C
- 7:  C
- 8:  







