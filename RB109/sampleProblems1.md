
##### Question 1:
-  What does the following code return? Is the output what we expected? If not, how could we change the code to get the expected output? What concept does this demonstrate?

```ruby
books = [
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

books.sort_by do |book|
  book[:title]
end

puts books
```
`[ {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'}, {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'}, {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'}, {title: 'Ulysses', author: 'James Joyce', published: '1922'},]`

If the output expected was that the books would be sorted by their titles, then the output is *unexpected* since the output to the screen is the books array with the elements in the same order.  To output a list of books sorted by `book[:title]` one option is to assign the return value of the `sort_by` method to another variable, e.g., `sorted_books` and then output this number. i.e.:
```
sorted_books = books.sort_by do |book|
  book[:title]
end

puts sorted_books
```

This demonstrates the concept of method return values, and understanding that `sort_by` is a non-mutating method, hence the array `books` and the values referenced within it will remain unchanged.

##### Question 2:
- Explain the following code. What is the output? What concept does this demonstrate?

```ruby
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop
end

puts numbers
```

A variable `numbers` is initialized and assigned to an array object with integer values which is `[1, 2, 3, 4]`.
Then, the `each` method is invoked on the array referenced by variable `numbers` with a block passed in as an argument.  In this block, for each iteration through the array `numbers`, the block parameter `number` receives each array element in turn, executes the `p` method, and then the (destructive) `pop` method on the array `numbers`.
A table of the various values of the parameters / variables during execution follows:
iteration index     number    output from `p` method      numbers (after `numbers.pop`)
0                   1         1                           [1,2,3]
1                   2         2                           [1,2]

Since the `pop` method is destructive, the number of elements within `numbers` is changing during iteration and after the 2nd iteration (index 1), execution of the `each` method stops.
The final `puts` invocation where `numbers` is passed in as an argument outputs the current contents of the referenced array, which are each output on a separate line.  Thus, the overall output is:
```
1
2
1
2
````

This code is illustrating the potentially unexpected behaviour which may occur when an array being iterated upon is mutated during iteration (this is generally not a best practice in coding).


##### Question 3:
- What does this code output? Why? What concept does this demonstrate?

```ruby
arr1 = [1, 2, 3].select { |num| p num }

arr2 = [1, 2, 3].select { |num| puts num }

p arr1
p arr2
```

```
1
2
3
1
2
3
[1, 2, 3]  # arr1
[]         # arr2
```

The local variable `arr1` is assigned to the new array returned from the `select` method. The `select` method is called on the array `[1, 2, 3]` and the block passed into the `select` method takes each number from the array, as block parameter `num`, and then passes it to the `p` method for invocation. The output from the `p` method for each iteration of the block is integer number passed into the block. The return value of the `p` method invocation is the value of the argument passed in, which for each of the array elements will be the integer value of `num`. These integer values evaluate to `true` (are 'truthy') and thus the `select` method will include each of them in the new, returned array.

For the local variable `arr2`, the same situation is occurring with 1 exception: the `puts` method invoked with each integer `num` returns `nil` which evaluates to `false` (is 'falsey') and thus no array elements are included in the returned array whichh is assigned to `arr2`.  Hence, the output of the line `p arr2` returns an empty array.

This code snippet demonstrates truthiness, and the importance of understanding what the return values are of different methods, and also how specific methods (like `select`) utilize the (implicit) return value from the block they are invoked with.


##### Question 4:
- Why don't we get an error here? What concept does this demonstrate?
```ruby
if false
  greeting = "hello world"
end

p greeting
```

As evidenced by the output `nil`, the variable `greeting` is initialized. However, no error is raised since the `if` is a control expression and the `if` branch does not create a new inner scope.  Hence the local variable `greeting` is initialized within the `if` branch, and assigned by default a value of `nil', and is accessible in the main scope for the invocation of the `p` method afterwards.  Since the `if` condition is `false` and the assignment to string object 'hello world' is never executed, the value referenced by `greeting` remains the default `nil` assigned at initialization.


##### Question 5:
- Explain the following code. What could we change to include 'jim' in our list? What concept does this demonstrate?
```ruby
def add_name(arr, name)
  arr = arr + [name]
end

names = ['bob', 'kim']
add_name(names, 'jim')
puts names.inspect
```

A method `add_name` is defined with 2 parameters, `arr` and `name`. Within this method, no mutating methods are called on the parameter `arr`.  The parameter `arr` is reassigned a new value which is the non-mutating concatenation of a new array element with value `name` to the array referenced by `arr`, but this does not (and cannot) affect the variable 'names' in the outer scope.
After the local variable `names` (outside of the scope of method `add_name`) is assigned to an array with string values, those values are not changed by method `add_name` and thus the output of the `puts` method invoked with argument `names.inspect` is the unchanged values of array referenced by `names` on initialization:  `['bob', 'kim']`.

To include 'jim' a mutating method must be called on parameter `arr` within method `add_name`.  e.g.
`arr << name`.  The line within the method could be updated to `arr = arr << name`. Note that the element pushed to `arr` by the shover operator is a string and not itself an array (which would create a nested array element within `arr`).

This concept illustrates the concept of mutating vs non-mutating methods and how the argument in the given code would behave as 'pass-by-value' since non-mutating methods were invoked within the method.

---

#### 1. 

```ruby
arr1 =  ["a",  "b",  "c"] 
arr2 = arr1.dup 
arr2[1].upcase!
```
- What is the output for arr2? What if arr1 was a string and not an array?
- What concept is at work here?


["a", "B", "c"]
If `arr1` referenced a string with value `'abc'` and not an array, `arr2` would be unchanged and output `'abc'`.
The concept at work here is mutating methods - when `upcase!` is invoked on the 2nd element of the array referenced by `arr2`, the string object that is referenced by the 2nd element of the array is updated to the uppercase character. If `arr1` was inspected, we would find that it has also been updated, since it contains references to the same string objects as array `arr2`.


#### 2.
```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
```
- What does the return look like? How would you change the code to sort numerically?


`[['1', '8', '9'], ['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15']]`
The code is sorting numerically ( `num.to_i` converts the string elements of the sub-array into integers for sorting).  No further changes need to be made.


#### 3.
```ruby
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a
```
- What are the final values of a and b? What core concept is at work here?

`a # 2` since the indexed assignment of arr[0] involves a re-assignment of that array element to a new integer value of 4; the variable `a` is never reassigned. Integers are immutable and thus the value of that array element must be assigned to a new integer object, which does not affect the initial assignment of local variable `a` to the object with integer value 2.

`b # [3, 8]` The indexed assignment on line 151 is equivalent to `arr[1][0] = arr[1][0] - a`, which mutates the array `b` by updating the value of its first element. Since the value referenced by local variable `a` is 2, the first element of nested array, `b` is changed to `5 - 3` which is `2`.

#### 4.
```ruby
def  word_cap(string, num)
  string.split.map { |word| word.capitalize }.join(" ")
end

p  word_cap('four score and seven') == 'Four Score And Seven'
```
```Traceback (most recent call last):
        1: from extra.rb:5:in `<main>'
extra.rb:1:in `word_cap': wrong number of arguments (given 1, expected 2) (ArgumentError)
```
- The given code throws the above error. What would you change to make the code work?

An additional argument needs to be given when the method `word_cap` is invoked - any value (it appears a number is expected) will suffice since it isn't used within the method. e.g.,
`p  word_cap('four score and seven',13) == 'Four Score And Seven'``


#### 5.
```ruby
def  mess_with_it(some_number) 
answer =  42  
some_number +=  8  
end 

new_answer =  mess_with_it(answer) 

p answer 
```
- What is output by the code? What concept is demonstrated?

An exception error will be thrown by the code since a local variable `answer`, which hasn't yet been initialized, is given as the argument for invoking the method `mess_with_it`. Within the method `mess_with_it` a local variable `answer`, with only inner scope, is initialized and assigned a value, however this variable is not accessible within the outer scope.
This demonstrates local variable scope, specifically, how methods create a separate scope within which local variables defined within the method are *not* available in the outside scope and local variables outside the method are not accessible within the method (unless passed in as parameters).

---

##### JC problem 1
```ruby
arr1 = ["bob", "sue", "jim"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

p arr1
p arr2
```
- What does the code output?  Why?

```
['bob', 'sue', 'jim']
['BOB', 'SUE', 'JIM']
```
After local variable `arr2` is initialized and assigned a shallow copy of the value of `arr1`, a mutating method `map!` is called on `arr2`.  This mutating method updates each of the elements within the array referenced by `arr2` with the return value of the block passed in.  This block takes each array element (a string) as block parameter `char` and returns a string with all characters changed to uppercase, which is used as the updated element of the array referenced by `arr2`.


##### JC problem 2
```ruby
a = [1, 3]
b = [2]
arr = [a, b]
p arr 

arr[0][1] = 8

p a
p arr
```
- What does the code output?
- Is there another way we could make the same output appear?

`[[1, 3], [2]]`
`[1, 8]`
`[[1, 8], [2]]`

The same output could be created by changing final reassignment to `a[1] = 8`.

##### JC problem 3
```ruby
string = 'abcdefg'
5.times { |num| str[-num] = "x" }
p string
```
- What does the code output?  Why?

This code returns an error. Within the block passed into the `times` method as an argument, it tries to access a local variable `str` but no such local variables has been previously initialized.


##### JC problem 4
```ruby
def hello
  "I'm a method"
end

hello = "I'm a local variable"

p hello
```
- What does the code output?  Why?

`I'm a local variable`
In the above code, there is both a local variable and a method named `hello`. When the `p` method is invoked with the argument `hello` provided, Ruby will look first for a local variable named `hello` for invocation. If desired, the method `hello` can be explicitly invoked using parentheses, e.g., `p hello()`

##### JC problem 5
```ruby
def new_value(array)
  array += ['baseball']
end

array = ['soccer']
p array
```
- What does the following code output?  Why?

`['soccer']`

The defined method `new_value` is never invoked within the code.  When local variable `array` is initialized and assigned to array object `['soccer']` it remains unchanged and that is what is output when the `p` method is invoked with `array` as argument.

---

##### 1 Describe the code, what is returned from the method separate_name?
```ruby
def separate_name(full_name)
  full_name.split(' ')
end

first_name, second_name = separate_name('John Doe')
p first_name
p second_name
```

A method `separate_name` is defined which takes a parameter `full_name`.  This method returns an array where each element is a space-delimited 'word' of the string argument provided.

When the method is invoked with string argument `'John Doe'` provided, a multiple assignment is used which initializes 2 variables `first_name`, and `second_name` and assigns to them the first element and second element, respectively of the return array from method `separate_name`.
Thus, the output of the `p` method invoked on `first_name` and `second_name` outputs `'John'` and `'Doe'`, respectively.


##### 2 Is USER_NAME accessible to the methods scope? If so why?
```ruby
USER_NAME = 'Jeanie'

def welcome_user
  puts "Welcome #{USER_NAME}!"
end

welcome_user
```

Yes. Ruby interprets local variables that begin with a capital letter as constants, which are available within methods without needing to be passed in as arguments. Ruby style convention is that constants are identified with all-capitals.

##### 3 Where is the error and why can't it be printed? Comment the error out and describe what prints
```ruby
first = "This is first!"

3.times do
  second = "This is second"
  1.times do
    third = "this is third"
    p first
  end
  p second
end
p first
p third
```

The last line will return an error since the local variable `third` is intialized within the scope of the inner-most block associated with the `1.times` loop and is not accessible in outer scopes.  This line can be commented out.
The remaining code outputs:
```
This is first!
This is second
This is first!
This is second
This is first!
This is second
This is first!
```

##### 4 Describe what is printed for each of the three puts and why they are different

```ruby
arr = [0, 1, 'a', 'b', 10]
puts arr[2..-1]
puts arr[2...-1]
puts arr[-2]
```

For `arr[2..-1]`:  The range indicated by `..` includes both the start and the finish elements (and everything in between, which are `'a'`, `'b'`, and `10`. 
``` 
a
b
10
```

For 'arr[2...-1]':  This range, `...` does not include the finish element, `10`.
```
a
b
```

For arr[-2]:  An index beginning with a `-` indicates counting from the end of the array.  In this case, the output is the 2nd last element of the array.
`b`


##### 5 Describe the code. Does this work without the #to_s method and what is capitalized names with out it?
```ruby
family = {
  john: 'Fater',
  jane: 'Mother',
  lyle: 'Son',
  lily: 'Daughter'
}

capitalized_names = family.keys.map do |name|
  name.capitalize
end
p capitalized_names
```

There is a local variable `family` which is initialized and assigned to a hash.  This hash contains key-value pairs where the key is a name (as a symbol) and the value is a string indicating a family role.
Another local variable `capitalized_names` is initialized and assigned to the return value of some chained method calls on the hash `family`.  `family.keys` returns an array containing all of the keys in the hash `family`.  The method `map` is called on this array with a block argument passed in which defines a block parameter `name`.  Within this block, each key (a symbol) is assigned the block parameter `name` which is then converted to a string with the `to_s` method, and then capitalized.  This capitalized string is the return value of the block which is used as each element for the array returned and assigned to `capitalized_names`.
The `p` method invoked with argument `capitalized_names` then returns the referenced array which is:
`['John', 'Jane', 'Lyle', 'Lily']`

The code does work without the `to_s` method since the `capitalize` method can be called on symbols, and will return a symbol with the first character capitalized (e.g., `:john` will be returned as `:John`). Without the `to_s` method, the return array will be: `[:John, :Jane, :Lyle, :Lily]`.

