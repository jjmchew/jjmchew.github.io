### first live coding session with Aaron
good
- took time to think through problem
- looked at test case in detail
- using PEDAC process
- tested different approaches (irb to test sort)
- recognized confusion - good - recognized confusion with map
- recognized need to go back to algorithm

confused:
- 'iterator value'

suggestions
- deleted one of the '=' as part of the test case
- for PEDAC - stay method agnostic
- figure out key steps - tried to address many steps at once; e.g., sorting, counting, iterating, etc.  size of array vs info to find, etc.
- separate methods from desired output (e.g., tried to use map originally, but may not be necessary)
- worry less about time for practice?
- could better define what info is necessary (e.g., I wasn't sure why max_value was necessary)
- separate discrete steps to code later
- need to keep track of which arrays - i.e., sorted vs not sorted (may have been some syntax confusion)
- hardest thing might be not worrying about time - moving methodically

feedback for me:
- need to communicate more - not just talk out loud
- don't hack and slash - don't just 'try things'
- should know my methods pretty cold
- are we allowed to look up methods?  (e.g., each_with_index, each_index? )


---
awesome - building structure first
  - going back to different sections was great

caution:
- jump to conclusions on mutated string - don't think the problem defines that - could be either
- got hung up on pseudo code format - might need to work with it and find something consistent that you can rely on (might speed things up a little bit)
- watch out for zero-based indexes
- watch out for term 'mutated' - mutated involves changing the memory address?
- common patterns - always just .join(" ")
- think about why 1 approach vs another - with sample problems in lesson
- each doesn't mutate
- be careful what and where you print - at end of method it will change method output

### second live coding session w/ Brandi

array of digits or string of digits?
- good job checking stuff in irb
- good job checking code as you go


### 3rd live coding session w/ Aaron
- index access of single element vs multiple elements
- could help to work through an example
- might help to say you're having trouble, need a moment to think
- 

```ruby
=begin
Given a list of integers and a single sum value, return the first two values (parse from the left please) in order of appearance that add up to form the sum.

If there are two or more pairs with the required sum, the pair whose second element has the smallest index is the solution.

sum_pairs([11, 3, 7, 5],         10)
#              ^--^      3 + 7 = 10
== [3, 7]

sum_pairs([4, 3, 2, 3, 4],         6)
#          ^-----^         4 + 2 = 6, indices: 0, 2 *
#             ^-----^      3 + 3 = 6, indices: 1, 3
#                ^-----^   2 + 4 = 6, indices: 2, 4
#  * the correct answer is the pair whose second value has the smallest index
== [4, 2]

sum_pairs([0, 0, -2, 3], 2)
#  there are no pairs of values that can be added to produce 2.
== None/nil/undefined (Based on the language)

sum_pairs([10, 5, 2, 3, 7, 5],         10)
#              ^-----------^   5 + 5 = 10, indices: 1, 5
#                    ^--^      3 + 7 = 10, indices: 3, 4 *
#  * the correct answer is the pair whose second value has the smallest index
== [3, 7]

Input: array of integers, target value
Output: array of two integers that add up to the target value with the 
2nd having the lowest Index

Rules:
If no pairs match, return Nil
If multiples match, we take the pair that has the lowest 2nd index 

Algorithm: 
Create a new array to collect all possible pairs
Create an array with all possible pairs of numbers from the given Array
See what pairs sum to the target value
If there are multiple pairs that sum, choose the pair with the lowest 2nd index

=end

def sum_pairs(array, target)
  
  pairs = []
  array.each do |num1|
    array.each do |num2|
      pairs << [num1, num2].sort if num1 != num2
    end
  end
  pairs.uniq!

  result = []

  pairs.each do |subarr|
    p subarr
    result << subarr if subarr.sum == target
  end
  result.empty? ? nil : result
end

p sum_pairs([11, 3, 7, 5], 10) #== [3, 7]
p sum_pairs([4, 3, 2, 3, 4], 6) #== [4, 2]
# p sum_pairs([0, 0, -2, 3], 2) #== nil
# p sum_pairs([10, 5, 2, 3, 7, 5], 10) #== [3, 7]
```

### Notes from session with Rosa
Feedback for Rosa:
- may not be worth creating PEDAC in output - may not be used for any real interviews
- great to point out helper methods vs main
- use of code in pseudo code?
- declarative vs imperative?
- could call your sub method from main method to reduce time - re-creating test cases, etc
- can use `next` in any loop to skip substrings that don't start with a vowel ?
- watch typos
- use of iterators?  destructive vs non-destructive?

### Feedback for me:
##### From Aaron (session 1)
  - need to communicate more - not just talk out loud
- don't hack and slash - don't just 'try things'
- should know my methods pretty cold
- are we allowed to look up methods?  (e.g., each_with_index, each_index? )

##### From Rosa
  - great to create examples to work through algorithm - details helped Rosa to see what I was doing and to see that it could work
  - good to use binding.pry (use all tools available) - good debugging;  good recovery

##### From Aaron
  - when thinking through a difficult problem (e.g., typoglycemia), tended to mutter when it got difficult and then 'come back' and explain things.  Explaining things was good, might be better to just think quietly (don't feel the need to talk all the time)
  - don't say what you're typing:  might also be better to just explain what you're typing / going to type
  - 


- sort by secondary values
  - could still define a hash to store the actual info and what it's for, but then convert to an array to be able to sort by secondary factors


```ruby
def test(array)
  array.sort_by! {|subarr| [subarr[0], subarr[1]]}
end
 
p test([[1,2], [3,1], [1,3], [1,1]])
```


### test problem
```ruby
=begin
Background
There is a message that is circulating via public media that claims a reader can easily read a message where the inner letters of each words is scrambled, as long as the first and last letters remain the same and the word contains all the letters.

Another example shows that it is quite difficult to read the text where all the letters are reversed rather than scrambled.

In this kata we will make a generator that generates text in a similar pattern, but instead of scrambled or reversed, ours will be sorted alphabetically

Requirement
return a string where:

1) the first and last characters remain in original place for each word
2) characters between the first and last characters must be sorted alphabetically
3) punctuation should remain at the same place as it started, for example: shan't -> sahn't

Assumptions

1) words are seperated by single spaces
2) only spaces separate words, special characters do not, for example: tik-tak -> tai-ktk
3) special characters do not take the position of the non special characters, for example: -dcba -> -dbca
4) for this kata puctuation is limited to 4 characters: hyphen(-), apostrophe('), comma(,) and period(.)
5) ignore capitalisation - only get lower-case letters in the string

algorithm
  - method:  'transform_word' 
      - convert string to array of characters
      - output will be first char: index 0 + "middle characters sorted" +  last char:  index -1
          - for middle characters:
          - take a subarray of 'middle characters' : index 1 to index -2
          - 
  
  - split strings with multiple words into array of words
  - initialize a new collection array for transformed words > empty array
  - iterate array of words,  for each word:
      - call transform_word 
      - add transformed word to collection array
  - join transformed words in new string


notes:
  - need to identify positions of punctuation - needs to remain the same
  - need to manage lead / trailing punctuation - get 'next'(before or after, depending on leading or trailing) letter
  - 
=end

def transform_word(word)
  return '' if word == nil
  return word if word.size <= 3
  chars = word.chars

  middle_chars = chars[1..-2].sort

  middle = middle_chars.join("")
  word[0] + middle + word[-1]
end

def scramble_words(string)
  words = string.split(" ")
  transform_word(words[0])

end

# p scramble_words('professionals') #== 'paefilnoorsss'
# p scramble_words('i') == 'i'
# p scramble_words('') == ''
# p scramble_words('me') == 'me'
# p scramble_words('you') == 'you'
p scramble_words('card-carrying') == 'caac-dinrrryg'
# p scramble_words("shan't") == "sahn't"
# p scramble_words('-dcba') == '-dbca'
# p scramble_words('dcba.') == 'dbca.'
# p scramble_words("you've gotta dance like there's nobody watching, love like you'll never be hurt, sing like there's nobody listening, and live like it's heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like it's haeevn on earth."
```

### session 2 w/ Rosa
Feedback for Rosa:
- good work with implicit requirements
- could tell you were working on not saying what you were typing - good work!
- `str.chars.tally` returns a hash with a tally of counts of each letter
- good job identifying the bug
- think more deeply about what to iterate over (e.g., hash vs string)
  - may be able to think about hash as 'dictionary'
  - key vs value (keeping track of different types of values)
- need to get comfortable with indexed access to the hash
- good job thinking systematically through debugging


### live coding w/ Amy / Matic
```ruby
def solve(n,k)
  arr = n.to_s.chars
  # combined_array = arr.combination(n.to_s.size - k).to_a
  # combined_array = arr.permutation(n.to_s.size - k).to_a
  
  combined_array.map(&:join).min
end
```

### live coding with Amy
  - not sure why reverse digits array - because 'digits' returns digits in backwards order
  - good to take time to understand problem - check cases, etc.
  - good communication - clear, easy to follow
  ** - get comfortable with remainders - i.e., no remainder means it divides evenly
  - to return index in map - some options - just save value and re-export it

  - separate how from what - be 'declarative', e.g., split substrings
  - syntax - separate syntax from logic, as much as possible.... 
  - helper methods
  - to determine if something is divisible - always use the remainder 
  - good job finding the error - with substring size
  - good effort at not giving up!

```ruby
def pangram?(string)
  alphabet = ('a'..'z').to_a.join
  string.chars.each { |c| alphabet.delete!(c.downcase) }
  alphabet.empty?
end
```

### notes on live coding with Rowan
- may have been helpful to look at test cases more carefully (started with an approach that wouldn't have worked for all cases) - good catch!
- a bit of saying what you type (I was given feedback not to do that)
- did a lot of code without testing 

- love the humour (e.g., jail, laws, etc.)
- debugging - might want to talk about what you're thinking about?
  - dig harder to find out exactly why - try to replicate error


### notes on live coding with Matic
- like the prepared template - slick and tidy
- saying what you type?  
- typed a lot!  
- when thinking about algo, dipped into syntax - best to separate?
- about 10 minutes on pedac
- good testing in stages initially (e.g., first test case)
- using 'reject' - watch language 'let's just see'
- debugging : seemed good, remember to mention what the error, 
    - could add code to better dig into errors (e.g., debugging the 'nil' case)
    - can create new test cases, as well

- don't need to highlight the whole line to comment out (can just have cursor on the line)

- translate the requirements - can be shorter / faster


### live coding with James D.
- `groups = Hash.new { |h, k| h[k] = [] }` initialize a new hash with default empty array

