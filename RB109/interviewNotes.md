=begin

INTERVIEW ASSESSMENT

- Zoom & Coderpad
- One hour. Two problems.
- Focus: Structured problem-solving approach, Ruby fluency, Communication ability.
- No documentation but personal notes okay.
- Don't be afraid to spend lots of time on PEDA before jumping into C.
- Make sure you understand the problem.
  - Feel free to ask questions.
  - Check test cases for implicit rules.
  - Write down what you find out to refer back to later.
- Develop your algorithm from a top-down approach.
- Test code frequently and verbally explain your expectations.
- Preparation: RB101-RB109 Small Problems, Pair up with other students.
    - aim to complete medium problems in 20 mins
    - codewars is good, just watch out for very condensed solutions from codewars (don't just chain methods together)
    - may be hard to find suitable codewars problems

- Questions?
  - avoid hack and slash;  confirming behaviour in irb is great

=end

`proper_range = ('a'..'z').to_a` - creates an ordered array of letters from 'a' to 'z'
- `proper_range.difference(arr)` - will compare `arr` (an array) to `proper_range` and show the difference

- notes on Rosa's mock interview:
- structured approach is great - having a template is great for comments
- notes were well organized
- could be more explicit about explicit rules (e.g., always get a valid array - may feel unnecessary, but can help to ensure you don't overlook explicit rules;  and explicit and implicit rules, e.g., no empty arrays, no empty characters, etc.
- breaking down test cases was great; good to identify working w/ arrays
- algorithm was exactly the same as your code - make sure it matches - that was great;  good detail
- algorithm - avoid adding code or coding elements into algorithm;  best not to get 'married' to an approach, work on implementation later
- communication, while typing, you were saying the same thing you were typing - to improve communication, try speaking naturally as you type
- ask to clarify cases (e.g., missing letter at the end of the sequence)
- TAs typically just ask you solve for displayed test cases

## Notes
- `counts[:lowercase] = characters.count { |char| char =~ /[a-z]/ }` counts the number of lowercase characters (in an array of characters)
- when using `reduce`, the colletion variable comes first
  - e.g., `1.upto(3).reduce(0) { |tot, n| tot += n**2 }`
- `text = File.read('sample_text.txt')`
- https://medium.com/@treskey/rb109-my-pedac-process-build-little-magic-boxes-with-me-4c63e08c5e79
