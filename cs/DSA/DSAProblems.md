# Problems to be familiar with

## Capstone prep
- 242-**Valid Anagram**: https://leetcode.com/problems/valid-anagram/description/
    - may not have done this - review

- 13-**Roman to Integer**: https://leetcode.com/problems/roman-to-integer/description/
    - managed this one, had some trouble with modified numbers (like 4)
    - could do this in an easier to read / code way

- 28-**Needle in the Haystack**: https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/description/
    - initial attempt didn't work, likely from an implementation (and conceptual) oversight
    - working solution was based on looking at other solutions and is simple, functional enough

- 344-**Reverse String**: https://leetcode.com/problems/reverse-string/description/
    - initial implementation used 2 pointers (not necessary)
    - 2nd implementation (from looking at solutions) only used a single pointer (cleaner)

- 1346-**Check if N and a double exist**: https://leetcode.com/problems/check-if-n-and-its-double-exist/description/
    - initial implementation was not accepted
    - updated implementation seemed straightforward enough

- 26-**Remove duplicates**: https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/
    - initial attempt was long and hard to understand (used swap, but didn't need to)
    - revised solution from looking at solutions was much cleaner (didn't worry about non-unique elements)
    - could be reviewed

- 2006-**Count pairs with absolute difference K**: https://leetcode.com/problems/count-number-of-pairs-with-absolute-difference-k/description/
    - seems straightforward

- 367-**Valid perfect square**: https://leetcode.com/problems/valid-perfect-square/description/
    - difficult conceptually (had to look at answers)
    - implementation seemed relatively straightforward

- 74-**Search matrix**: https://leetcode.com/problems/search-a-2d-matrix/description/
    - my initial implementation worked, but I had trouble with getting the start/end conditions correct on each binary search
    - the leetcode solution mimicking a binary tree was very clean / easy
    - worth a review to see if I can re-create

- 2529-**Maximum count**: https://leetcode.com/problems/maximum-count-of-positive-integer-and-negative-integer/description/
    - conceptually okay, but had challenges with search returning either a zero or a positive number

- 83-**Remove duplicates**: https://leetcode.com/problems/remove-duplicates-from-sorted-list/description/
    - makes sense, but had trouble with implementing
    - review with the goal of getting more fluid / familiar with linked lists and manipulation

- 21-**Merge two sorted lists**: https://leetcode.com/problems/merge-two-sorted-lists/description/
    - had trouble with keep head / curr sensible
    - had to implement this first with arrays (lists) and then work on linked lists since I had trouble keeping track of pointers, etc.
    - could review

- 141-**Linked list cycle**: https://leetcode.com/problems/linked-list-cycle/description/
    - had some trouble with implementing a means of observing a linked list (i.e., printing the list could be infinite)
    - final implementation seems straightforward
    - could review with the goal of getting more familiar with linked lists


## Mon May 6, 2024

- **Spiral Matrix**: https://leetcode.com/problems/spiral-matrix/description/
    - slow on first pass - wasn't able to implement properly within 50 mins, had working approach

- **Merge Intervals**: https://leetcode.com/problems/merge-intervals/description/
    - implemented a solution assuming a sorted array, but had some implementation details that were incorrect
    - of the 3 problems in this set, probably the most comfortable

- **Product of array except self**: https://leetcode.com/problems/product-of-array-except-self/description/
    - conceptually very difficult
    - implemented a working O(N^2) solution, but could not come up with the conceptual O(N)
    - mostly understand the given solution in O(N) and O(1), but could definitely use review






# To review

## DSA
- [ ] LS220: 2 pointers, "count pairs" exercise: https://launchschool.com/exercises/1b055dda

## DSA
- [ ] Ch7 ex 2:  is O(N+M) accurate?  It doesn't run through both sets of array elements in sequence, it's O(N) where N is the greater number of elements?  It total steps, it's O(N+M), but Big O is slightly different?
- [ ] Ch11 ex 5: couldn't figure this out on my own;  couldn't quite figure out the "sub-problem"
- [ ] Ch 12 fibonacci example:  the book version of memoization is less efficient than my version
      - is this b/c there are 2 calls to `fib` in the function?
- [ ] Ch 14 ex 5:  couldn't do this on my own - was circling around the answer, but didn't put it together
- [ ] Ch 18, ex 5:  didn't do dijkstra - related question since Nick indicated on slack that we won't cover dijkstra's in capstone