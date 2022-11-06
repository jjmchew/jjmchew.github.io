# JC problem 1
# What does the following code output?  Why?

arr1 = ["bob", "sue", "jim"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

p arr1
p arr2


# JC problem 2
# What does the following code output?
# Is there another way we could make the same output appear?

a = [1, 3]
b = [2]
arr = [a, b]
p arr 

arr[0][1] = 8

p a
p arr


# JC problem 3
# What does the following code output?  Why?

string = 'abcdefg'
5.times { |num| str[-num] = "x" }
p string


# JC problem 4
# What does the following code output?  Why?

def hello
  "I'm a method"
end

hello = "I'm a local variable"

p hello


# JC problem 5
# What does the following code output?  Why?

def new_value(array)
  array += ['baseball']
end

array = ['soccer']
p array
