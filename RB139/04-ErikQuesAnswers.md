# Answers to Erik's questions
https://www.notion.so/kiriyama/Erik-s-RB139-Questions-3b16bdc35f444a7fbe3d97043ffd5071

1
Explain why we would want to implement our own higher-order methods like  `#each`, `#map`, and `#select` for our custom classes instead of relying on the built-in `Array#each`, `Array#map`, and `Array#select`?

- Even if the underlying data structures within our custom classes leverage are based on arrays, it makes sense to implement custom iteration methods similar to `#each`, `#map`, and `#select` to maintain encapsulation within our code base and prevent direct access to the underlying data within our custom classes.
- If the underlying array containing data within our custom class was exposed to a larger code base, future changes to how data is stored within our custom class (i.e., not using an array) would become significant breaking changes to other objects / methods / code that might access that data as an array directly.  Creating custom iteration methods allow other 'users' of our custom class to continue to interact with our custom class through a consistent interface which can prevent those breaking changes.

---

2
Without running the code, explain what will happen when `#some_method` is invoked on the last line. Why?
```ruby
def some_method(&block)
  yield
end

bl = proc { puts "hi" }

some_method(&bl)
```

- When `#some_method` is invoked, `hi` will be output to the screen.
- As indicated by the line `yield` within the body of the method `some_method`, this method will execute any code passed in with a block when `some_method` is invoked. For the invocation of `some_method` (the last line of code snippet), a `proc` (`bl`) is converted to a block by prepending it with the `&` operator and passed in as a block on invocation. Although an explicit block `block` is defined, and the resulting proc object assigned to `block` could be executed by using `block.call`, instead, the block is yielded to through the use of `yield`. This `yield` results in the invocation of the `puts` method with the string value `"hi"` being passed in and thus output to the screen.

---

3
Without running the code, explain what will happen when `#greeting` is invoked on the last line. Why?
```ruby
class Parent
  def greeting
    yield
  end
end

class Child < Parent
  def greeting
    super()
  end
end

Child.new.greeting { puts "hello" }
```

First attempt (Incorrect):
- When the last line is invoked, the code will return a 'JumpError'.  When `Child#greeting` is invoked, a block is passed in, however, the use of `super()` calls `Parent#greeting` with no arguments (or blocks) passed in and a 'JumpError' will be raised once `Parent#greeting` executes the `yield`.

Second attempt (after running the code):
- When the last line is invoked, the code will return `hello`. When `Child#greeting` is invoked a block `{ puts "hello" }` is also passed in.  This block is automatically passed by the `super()` invocation within `Child#greeting`. Thus `Parent#greeting` can yield to this block and the `puts` method is invoked with the string `"hello"` and `hello` is output to the screen.

---

4
Implement the `Cat` class so that the invocation of the `#feed` method on the last line outputs the value as shown below.
```ruby
class Cat
  # write code here
end

cat = Cat.new

def feed
  yield
end

feed(&cat) # outputs "meow"
```

- My updated `Cat` class is:
```ruby
class Cat
  def to_proc
    Proc.new { puts "meow" }
  end
end
```
- When `feed` is invoked the `&` prepending the local variable `cat` automatically tries to convert `cat` (a object instance of the custom class `Cat`) to a `proc` object by calling `Cat#to_proc`, so that it can convert that `proc` to a block for invoking the `feed` method.  By defining a custom instance method `to_proc` within the `Cat` class which returns a `proc` which creates the desired output.  This `proc` is then converted to a block, which is yielded to within the `feed` method.

---

5
Using the provided test cases for the Medium challenge Simple Linked List (https://launchschool.com/exercises/35a331cd), add your own tests for hypothetical methods `SimpleLinkedList#each`, `SimpleLinkedList#map`, and `SimpleLinkedList#select`. Design your tests so that they ensure that the hypothetical custom methods behave similarly to the built-in `Array#each`, `Array#map`, and `Array#select`.

- The updated tests for the desired hypothetical methods are shown below:
```ruby
require 'minitest/autorun'

require_relative 'simple_linked_list'

class LinkedListTest < Minitest::Test
  def setup
    @list = SimpleLinkedList.new
    @list.push(1)
    @list.push(2)
    @list.push(3)
  end

  def test_each
    new_arr = []
    @list.each { |element| new_arr << element }
    assert_equal([3, 2, 1], new_arr)
  end

  def test_map
    new_arr = @list.map { |element| element.to_s }
    assert_equal(["3", "2", "1"], new_arr.to_a)
  end

  def test_select
    new_arr = @list.select { |element| element.odd? }
    assert_equal([3, 1], new_arr.to_a)
  end

  # other tests provided are omitted
end

```

---

6
Implement `SimpleLinkedList#each`, `SimpleLinkedList#map`, `SimpleLinkedList#select` so that they pass your tests. Consider at least two different approaches.

- The following methods are additional methods to be added to the `SimpleLinkedList` class definition. Two different implementations are provided for `each`, `map` and `select`: 1 approach leverages an array of the linked list datum, the other approach uses a helper method `traverse` which returns each element of the linked list in sequence.

```ruby
  # def each
  #   self.to_a.each do |element|
  #     yield(element)
  #   end
  #   self
  # end

  def each
    self.traverse { |_, element| yield(element) }
    self
  end

  # def map
  #   new_arr = self.to_a.map { |element| yield(element) }
  #   SimpleLinkedList.from_a(new_arr)
  # end

  def map
    new_arr = []
    self.traverse { |_, element| new_arr << yield(element.datum) }
    SimpleLinkedList.from_a(new_arr)
  end

  # def select
  #   new_arr = self.to_a.select { |element| yield(element) }
  #   SimpleLinkedList.from_a(new_arr)
  # end

  def select
    new_arr = []
    self.traverse { |_, element| new_arr << element.datum if yield(element.datum) }
    SimpleLinkedList.from_a(new_arr)
  end

  def traverse
    element = @head
    counter = 1
    loop do
      yield(counter, element) if block_given?
      break if element.nil? || element.next.nil?
      element = element.next
      counter += 1
    end
  end
```