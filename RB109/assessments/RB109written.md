### Written assessment notes (Nov 17, 2022)

9:11 start
X - check Q 7 :  names of methods.
X - check Q 8 :  could update pass by value example to integer?
X - check Q 9:  immutable - shouldn't be able to change 'int'?
- check wording Q11


question 15 - write code - may need to come back to this - a bit confusing.
question 16 - check this!  confirm if elsif 's will be evaluated even if the first if branch is evaluated





## Question 1
The structure defined by the `do...end` is a block, which is passed in as an argument to the `each` method invocation.  Based on local variable scoping rules in Ruby, local variables defined outside of a block are accessible within the block, but local variables defined within a block are not accessible outside of that block.  

Hence, the local variable `a` initialized and assigned to the value of block variable `x`, is defined within the block and is not accessible outside of the block on line 7, when the `puts` method is invoked with local variable `a` passed in as an argument.



## Question 2
This code presents a series of nested invocations of the `loop` method, each invoked with a block passed in which initializes and assigns several different local variables.  Based on which block these variables are initialized in, they may not be accessible within an outer block.

The `loop` on line 1 is invoked with a block from lines 2-22 and forms the outer-most loop ('Loop 1').  Within Loop 1, on line 2, a local variable `a` is initialized and assigned to an integer object with value `1`.  `a` is accessible within all of the subsequent `loop` invocations and their associated inner blocks.  

Within Loop 1, a another nested `loop` method is invoked on line 4 and the block passed in as its argument is from lines 5-18 ('Loop 2').  Within Loop 2, on line 5, a new local variable `b` is initialized and assigned to an integer object with value '2'.  `b` is not accessible within Loop 1, but will be accessible within the subsequent 'inner' `loop` invocations and their associated inner blocks.

Within Loop 2, another nested `loop` method is invoked on line 7 and the block passed in as its argument is from lines 8 to 15 ('Loop 3').  Within Loop 3, on line 8, a new local variable `c` is initialized and assigned to an integer object with value '3'.  `c` is only accessible within Loop 3.

On line 9, `a` is re-assigned to point to the same integer object as `b`, which has value `2`.
On line 10, `b` is re-assigned to point to the same integer object as `c`, which has value `3`.
On line 11, 'c' is re-assigned to point to a new integer object which has value `4`.
On line 13 of Loop 3, another local variable `arr` is initialized and assigned to an array object with elements `a`, `b`, `c`.  
Hence, on line 14, when the `puts` method is invoked with `arr` passed in as an argument, it will output the current integer values of `arr`, each on its own line:  `2`, `3`, `4`.



## Question 3:
When this code is executed, it will return an error (NameError) since the local variable `x` is initialized and assigned outside of the scope of the method `add_five`.  Methods form their own self-contained scope, access to local variables outside of a method need to be passed in as arguments, and the method needs to define parameters to accept these arguments.  Since the method `add_five` was not defined with any parameters and local variable `x` was not passed in as an argument upon invocation of `add_five`, the code returns an error.

One method to fix this is to define a parameter for `add_five` and pass in the integer value referenced by `x` when invoking `add_five`.  Note that `add_five` will return the desired sum, but that this integer value needs to be re-assigned to local variable `x` in order for the output from line 9 to be correct.  The new code would look like:
```ruby
x = 10

def add_five(x)
  sum = x + 5
  x = sum
end

x = add_five(x)
puts x
```


## 5
The error on line 14 occurs since `first_num` is initialized and assigned within a block, which is passed into the `loop` method on invocation (lines 10-11, the 'Loop Block').  From local variable block scoping rules, `first_num` is not accessible outside of Loop Block.

`first_num` is different than `last_num` since `first_num` is declared inside of a block (Loop Block), whereas `last_num` is NOT declared inside of a block.  Although lines 3 to 5 include a `do...end`, this does not form a block, since the `for` loop is not a method, and the `do...end` do NOT form a block.  Thus, `last_num` is considered to be a part of the main scope and the invocation on line 7 does not return an error.

To fix the bug, we could initialize and assign a value to `first_num` on line 8, outside of Loop Block:  `first_num = nil`.

## 13
The following code will currently output nothing to the screen, since the `puts` method invoked on line 4 occurs after the `return` keyword on line 3 of the method - line 4 is never run.

