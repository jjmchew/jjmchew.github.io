=begin

The vowel substrings in the word codewarriors are o,e,a,io. 
The longest of these has a length of 2. 
Given a lowercase string that has alphabetic characters only 
(both vowels and consonants) and no spaces, 
return the length of the longest vowel substring. 
Vowels are any of aeiou.

=end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




=begin
# Find the missing letter
# Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array.
#
# You will always get an valid array. And it will be always exactly one letter be missing. The length of the array will always be at least 2.
#
# The array will always contain letters in only one case.

# Example:
#
# ['a','b','c','d','f'] -> 'e'
# ['O','Q','R','S'] -> 'P'

# Use the English alphabet with 26 letters.

p find_missing_letter(["a","b","c","d","f"]) == "e"
p find_missing_letter(["O","Q","R","S"]) == "P"
p find_missing_letter(["b","d"]) == "c"
p find_missing_letter(["a","b","d"]) == "c"
p find_missing_letter(["b","d","e"]) == "c"

=end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# A substring is a contiguous (non-empty) sequence of characters within a string.
  
# A vowel substring is a substring that only consists of vowels ('a', 'e', 'i', 'o', and 'u') and has all five vowels present in it.
  
# Given a string word, return the number of vowel substrings in word.

=begin
input
  - string : mix of vowels and non-vowels
output
  - integer : number of vowel substrings in the word

assumptions / constraints:
  - vowel substring:  must have all 5 vowels, but more than 1 instance of a vowel is allowed
  - vowels can be in any order
  - vowels are all consecutive

data structure
  - array : collect all vowels for comparison
  - array : collect substrings of vowels


algorithm
  - find all substrings of vowels, collect them into an array
      - iterate through all characters
        1. - if a character is a vowel then add it to a new 'substring' of vowels
           - if it's not a vowel, don't count it
        - return to 1
        - add substring to an array of vowel_substrings

  - check a substring for completeness (all 5 vowels, any order)
      - iterate across each of 5 vowels
        - check that vowel is present in substring
        - if any 1 vowel isn't part of a substring - delete it


  - count the vowel substrings remaining - this is the number to return

notes:
  - find substrings of vowels, any length
  - permutations are allowed of the 5 vowels

=end

def substrings(str)
  subs = []

  (0...str.size).to_a.each do |starting|
    (starting...str.size).to_a.each do |ending|
      subs << str[starting..ending]
    end
  end
  subs
end

=begin
Feedback on my mock interview assessment

- overall approach is solid, good breakdown of problem
- input and output - additional detail was good
- going through test cases was good
- level of detail was good when talking about arrays / data structure
- algorithm was a good level of detail
- didn't follow 100% on logic - that can happen with difficult problems
- in code - if something isn't working and need to rethink logic, go back to algorithm - don't just move things around, unless it's minimal;  adjust the algorithm - maintain control of code or you might fall into hack and slash
- if you throw things at the solution, it can get complicated and become hack and slash
- when I talked over algorithm, it was good to proofread and review before jumping into coding
- great to check logic of algorithm and see if I understand logic
- suggest - test more frequently - it might seem like overkill, but it's worth doing so you don't have to go back, and don't get lost (e.g., can just output char, so you don't end up with syntactical or logical errors)
- test as you go - will save a lot of time in the long run
   - can identify logical vs syntactical errors
- when looking at the algorithm before, use test case and walk through a test case to see if the algorithm makes sense;  can be a good bridge to solving the problem
- communication was good, thought-process was well considered - good to weigh pros and cons
- try not to say what you're typing - something to practice while working with other students
- best indicator to take the interview?
  - solving problems until you can't solve them anymore / when you're sick of them

=end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

=begin
Given array of strings - only lowercase characters - return an array of all characters that show up in all strings within the given array (including duplicates)
- don't mutate the original array
=end

p common_chars(["bella", "label", "roller"]) == ["e", "l", "l"]
p common_chars(["cool", "lock", "cook"]) == ["c", "o"]
p common_chars(["hello", "goodbye", "booya", "random"]) == ["o"]
p common_chars(["aabbaaaa", "ccddddddd", "eeffee", "ggrrrrrr", "yyyzzz"]) == []

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


=begin
676. Integer reduction
6 kyu
(https://www.codewars.com/kata/59fd6d2332b8b9955200005f/ruby) 

In this Kata, you will be given two integers n and k and your task is to remove k-digits from n and return the lowest number possible, without changing the order of the digits in n. Return the result as a string.
Let's take an example of solve(123056,4). We need to remove 4 digits from 123056 and return the lowest possible number. The best digits to remove are (1,2,3,6) so that the remaining digits are '05'. Therefore, solve(123056,4) = '05'.
Note also that the order of the numbers in n does not change: solve(1284569,2) = '12456', because we have removed 8 and 9.
More examples in the test cases.
=end

# p solve(123056,1) == '12056'
# p solve(123056,2) #== '1056'
# p solve(123056,3) == '056'
# p solve(123056,4) == '05'
# p solve(1284569,1) == '124569'
# p solve(1284569,2) == '12456'
# p solve(1284569,3) == '1245'
# p solve(1284569,4) == '124'


=begin 
create a method that takes a positive integer number and returns the next bigger number formed by the same digits:
e.g., 12 => 21
513 => 531
2017 => 2071
If no bigger number can be composed using those digits, return -1
e.g., 9 => -1
111 => -1
531 => -1

p next_bigger_num(9) == -1
p next_bigger_num(12) == 21
p next_bigger_num(513) == 531
p next_bigger_num(2017) == 2071
p next_bigger_num(111) == -1
p next_bigger_num(531) == -1
p next_bigger_num(123456789) == 123456798

=end 

=begin
The maximum sum subarray problem involves finding the maximum sum of a contiguous subsequence in an array of integers:

maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4] should be 6: [4, -1, 2, 1]

Easy case is when the whole array is made up of onl positive numbers and the maximum sum is the sum of the whole array.  If the array is made up of only negative numbers, return 0 instead

Empty array is considerd to have zero greatest sum.  Note that the empty array is also a valid subarray
=end
p max_sequence([]) == 0
p max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
p max_sequence([11]) == 11
p max_sequence([-32]) == 0
p max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12


=begin
Write a method to find the longest common prefix string amongst an array of strings

If there is no common prefix, return an empty string "".

Example 1:
given:  ["flower", "flow", "flight"]
output: "fl"

example 2:
given: ["dog", "racecar", "car"]
output:  ""

Note:  all inputs are lowercase lettesr a-z

p common_prefix(["flower", "flow", "flight"]) == "fl"
p common_prefix(["dog", "racecar", "car"]) == ""
p common_prefix(["interspecies", "interstellar", "interstate"]) == "inters"
p common_prefix(["throne", "dungeon"]) == ""
p common_prefix(["throne", "throne"]) == "throne"

=end



=begin
Given 2 strings, find out if there is a substring that appears in both strings.
Return true if you find a substring that appears in both strings.
Return false if you do not.
We only care about substrings that are longer than 1 letter long.
=end

p substring_test('Something', 'Fun') == false
p substring_test('Something', 'Home') == true
p substring_test('Something', '') == false
p substring_test('', 'Something') == false
p substring_test('BANANA', 'banana') == true
p substring_test('test', 'lllt') == false
p substring_test('','') == false
p substring_test('1234567', '541265') == true
p substring_test('supercalifragilisticexpialidocious', 'SoundOfItIsAtrocious') == true


=begin

9:26 am - 

Given 2 strings, find out if there is a substring that appears in both strings.
Return true if you find a substring that appears in both strings.
Return false if you do not.
We only care about substrings that are longer than 1 letter long.

input
  - 2 strings
output
  - boolean (true or false)
rules
  - if there is a substring that appears in both given strings, return true
  - if NOT, return false
  - empty strings are empty - i.e., they don't count as a string
  - case-insensitive

algorithm
  - find the shortest string of the 2 given
  - use the shortest string as the 'reference'
  - initialize a 'collection' string

  - iterate across each letter of the reference (word)
      - see if the other word contains that letter
        - if SO:  then add that letter to the collection string
                  check the next letter
                  - if the next letter of both strings is the same, then add it to the collection string
                  - if NOT:  reset the collection string
        - if NOT: do nothing
                  
      - scan the word for another instance of the reference letter 
        AND start iteration again
  
  - check the length of the collection string to see if it is longer than 1 letter

=end

p substring_test('Something', 'Fun') == false
p substring_test('Something', 'Home') == true
p substring_test('Sochiomething', 'Homeo') == true
p substring_test('Something', '') == false
p substring_test('', 'Something') == false
p substring_test('BANANA', 'banana') == true
p substring_test('test', 'lllt') == false
p substring_test('','') == false
p substring_test('1234567', '541265') == true
p substring_test('supercalifragilisticexpialidocious', 'SoundOfItIsAtrocious') == true
