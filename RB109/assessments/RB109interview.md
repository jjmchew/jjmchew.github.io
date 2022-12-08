# more notes
- always ensure you add test cases for all rules!
  - read test cases carefully - nil vs empty (array vs elements)
- beware of test cases that are introduced by my approach
- when I get into too much 'deep thinking', go back to the algorithm - clarify what I need to do and how
    - i.e., review inputs / outputs / cases, etc.
- `groups = Hash.new { |h, k| h[k] = [] }`
- `combined_array = arr.combination(n.to_s.size - k).to_a`
  `combined_array = arr.permutation(n.to_s.size - k).to_a`
- `str.chars.tally`

```ruby
def test(array)
  array.sort_by! {|subarr| [subarr[0], subarr[1]]}
end
 
p test([[1,2], [3,1], [1,3], [1,1]])
```


###  notes from interview
- good work on knowing when to 'quit' with current approach and find an easier one
- good thing I could describe my code decently
- good job finding a bug when reviewing the code out loud - that was good
- 