# Problems to be familiar with

## Capstone prep
- 242-**Valid Anagram**: https://leetcode.com/problems/valid-anagram/description/
    - may not have done this - review
    - May 7, 2024:  did this - easy;  solution wasn't particularly quick, however


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
    - consider as EASY

- 367-**Valid perfect square**: https://leetcode.com/problems/valid-perfect-square/description/
    - difficult conceptually (had to look at answers)
    - implementation seemed relatively straightforward


- 74-**Search matrix**: https://leetcode.com/problems/search-a-2d-matrix/description/
    - my initial implementation worked, but I had trouble with getting the start/end conditions correct on each binary search
    - the leetcode solution mimicking a binary tree was very clean / easy
    - worth a review to see if I can re-create


- 2529-**Maximum count**: https://leetcode.com/problems/maximum-count-of-positive-integer-and-negative-integer/description/
    - conceptually okay, but had challenges with search returning either a zero or a positive number
    - did this again as LS problem
      - consider as MED (needed to look at LS solution to clarify)


- 83-**Remove duplicates**: https://leetcode.com/problems/remove-duplicates-from-sorted-list/description/
    - makes sense, but had trouble with implementing
    - did this again as part of LS220 problems
      - LS solution is cleaner, but otherwise, no problems
    - consider as EASY

- 21-**Merge two sorted lists**: https://leetcode.com/problems/merge-two-sorted-lists/description/
    - had trouble with keep head / curr sensible
    - had to implement this first with arrays (lists) and then work on linked lists since I had trouble keeping track of pointers, etc.
    - consider as MED


- 141-**Linked list cycle**: https://leetcode.com/problems/linked-list-cycle/description/
    - had some trouble with implementing a means of observing a linked list (i.e., printing the list could be infinite)
      - final implementation seems straightforward
    - did this a part of LS problems
      - easy (but did not use fast/slow pointers)
    - do this again to review fast/slow pointers


## Mon May 6, 2024

- 54-**Spiral Matrix**: https://leetcode.com/problems/spiral-matrix/description/
    - slow on first pass - wasn't able to implement properly within 50 mins, had working approach
    - consider as MED
        - managed, but had some trouble with guard clauses, required patient debugging

- 56-**Merge Intervals**: https://leetcode.com/problems/merge-intervals/description/
    - implemented a solution assuming a sorted array, but had some implementation details that were incorrect
    - of the 3 problems in this set, probably the most comfortable
    - consider as MED
        - still some details with implementing and debugging

- 238-**Product of array except self**: https://leetcode.com/problems/product-of-array-except-self/description/
    - conceptually very difficult
      - implemented a working O(N^2) solution, but could not come up with the conceptual O(N)
      - mostly understand the given solution in O(N) and O(1), but could definitely use review
    - consider this as MED
        - managed on my own, but a bit slow, took a lot of thinking, especially around iterations / indexes
        - worked on optimized solution from SC - all understandable, but may not be able to re-creaete



## Tues May 7, 2024

- 1010-**Pairs of songs with total durations divisible by 60**: https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/description/
  - solved this as a group, had some good intuition, but had some challenges with implementing
    - worth reviewing to ensure I can implement this (e.g., think about combos, etc.)
    - should code this again with a simplified approach than the group version (very convoluted, dealt with extra cases)
  - consider as MED:  still had some trouble with this when trying to code it up (got the algo wrong initially and was getting multiple counts for each key)
      - don't do this in 2 passes, use the 'seen' hash to do it in ONE pass
      - just need to store / access hashes in slightly different way (% 60)


- 209-**Minimum size subarray sum**: https://leetcode.com/problems/minimum-size-subarray-sum/description/
  - after much grief, kind of lucked into a solution to this problem which passed leetcode
  - consider as MED
  - need to code O(NlogN) solution


- 15-**3sum**: https://leetcode.com/problems/3sum/description/
  - had trouble developing a functional algorithm, my attempt was a bit convoluted
    -  sorted input array would have definitely helped (manage 2-sum)
    - was on the right track with fixing the first pointer
    - my implementation, even after looking at a solution, was still a bit off
        - needed to how / when to increment pointers j and k
  - 2nd attempt also never worked.  reached out to Srdjan for help and later solved
    - consider as MED


- 3-**Longest substring without repeating characters**: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
  - got *very* close to solving this, but felt like I confused the order of operations a bit
    - after looking at the solution (based on time spent), realized my moving condition on anchor was off
      - needed to move anchor until there was no repeating char at runner
      - solution ultimately worked and looks clean, but I needed to look at the solution
  - worth reviewing to solidify
    - consider as MED


### warm up problems
- 392-**is subsequence**: https://leetcode.com/problems/is-subsequence/description/
  - had some trouble with edge cases, but otherwise, strong logic and easy to step through
    - consider as EASY


### optional problem
- rooms II:  https://gist.github.com/SrdjanCoric/d4088f0b1154fccabe49e232130b4528
          https://gist.github.com/SrdjanCoric/a1db45b57f9bff74535529758793c144 (updated link in python)
  - tried this and it generally worked, consider as MED



## Wed May 8, 2024

- 11-**Container with most water**: https://leetcode.com/problems/container-with-most-water/description/
  - worked on as a group;  went in the wrong direction entirely w/ Thomas
    - walkthrough in class seemed to make sense
  - consider this EASY: tried this after class and had no trouble


- 162-**Find Peak Element**: https://leetcode.com/problems/find-peak-element/description/
  - got initial pass MOST of the way (didn't account for case where max is at edge)
  - code again from memory



- 153-**Find Minimum in Rotated Sorted Array**: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/
  - consider this as MED-EASY:
    - basically had the algo and the implementation, but could be faster if I didn't test so many test cases and try to come up with a "clever" way to solve it



### optional problem
- 33-**Search in rotated sorted array**: https://leetcode.com/problems/search-in-rotated-sorted-array/description/
  - feel like I understand the algo, but the details are fuzzy (i.e., how to check for left or right half and whether target is discovered)
    - sank at least an hour trying to implement and was not able to in ver 01
  - consider as HARD


## Thu May 9, 2024

- 92-**Reverse Linked list II**: https://leetcode.com/problems/reverse-linked-list-ii/description/
  - consider as HARD
    - even after seeing in lectures, when trying on my own, could not remember the details
    - had to look again at walkthrough (need a "temp" pointer), implementing was difficult and I still ran into problems (had to look at coded solution)



- 82-**Remove Duplicates from Sorted List II**: https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/description/
  - worked on this w/ Grace:  did a great job solving the wrong problem (i.e,. create a list of unique values, we didn't remove ALL of the duplicated values)
    - understood algo from walkthrough
  - MED tried to code this on my own and it went smoothly


- 19-**Remove Nth Node From End of List**: https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/
  - worked on this with Ben; solved most of it in 30 mins (needed to add a dummy node for case where head is removed)
  - worked on this with the group afterwards and improved the approach to use 2 pointers instead of re-establishing a stick of length 'n + 1' each iteration
  - coded this independently with some diagrams afterwards
    - consider this EASY, shouldn't need to review


- 328-**Odd Even Linked List**: https://leetcode.com/problems/odd-even-linked-list/description/
  - worked this one out on my own, seemed straightforward and no major issues coding
    - don't forget to set last node to None (to prevent creating cycles)
    - after seeing walkthrough, could have done this more easily / cleanly (by swapping even/odd)
    - consider this as MED

- 2-**Add Two Numbers**:  https://leetcode.com/problems/add-two-numbers/description/
  - this went relatively smoothly taking about an hour total over 2 sessions
    - could review creation of linked lists (e.g., forwards vs backwards), but ultimately easy
  - consider this as EASY




## Fri May 10, 2024

- 70-**Climbing Stairs**: https://leetcode.com/problems/climbing-stairs/description/
  - recursive solution (w/ cache) would be EASY
    - iterative solution is MED (had to look to clarify)


- 62-**Unique Paths**: https://leetcode.com/problems/unique-paths/description/
  - recursive solution was easy
    - iterative solution was MED (had to look to clarify again)



- 63-**Unique Paths II**: https://leetcode.com/problems/unique-paths-ii/description/
  - had some trouble with getting the recursive solution right
    - manage details:  guard clause, base case
    - consider this as MED



- 64-**Minimum Path Sum**: https://leetcode.com/problems/minimum-path-sum/description/
  - consider this as MED
    - managed fairly quick, but was hacking and slashing a bit with guard clauses, limits, initial cache values



- 120-**Triangle**: https://leetcode.com/problems/triangle/description/
  - consider this as MED
    - based on my approach, was able to make it work, but required looking at solution to figure out an improved implementation approach
    - definitely needs practice to improve this



## Sat May 11, 2024:  Mock Interview
- 680-**Valid Palindrome II**: https://leetcode.com/problems/valid-palindrome-ii/description/
  - consider this MED:  had some trouble implementing, my original solution was more complicated
    - however, understanding it now, assume it should be no problem the next time


- 49-**Group Anagrams**: https://leetcode.com/problems/group-anagrams/description/
  - given to me for my interview
  - consider this as EASY: figured out the majority of it in 40 mins (had a few minor hints, e.g., steered away from hash as dict)
      - had a bit of issue with falsy values in Python (check existence of key directly)




## Mon May 13, 2024

- 198-**House Robber** - walkthrough
  - https://leetcode.com/problems/house-robber/description/
  - managed this independently
  - my solution is roughly in line with the given iterative walkthrough
  - consider this EASY


- 55-**Jump Game**: https://leetcode.com/problems/jump-game/description/
  - consider this HARD:
      - tried this on my own, my thinking was not sound
      - solution developed w/ Ben was workable, but I never coded it or saw it through to completion
  - Tried again after seeing the solution described by Srdjan
    - consider as MED (not convinced I could do it again)

- 322-**Coin Change**: https://leetcode.com/problems/coin-change/description/
  - set 20 mins to try this - had some good ideas, but didn't solve it
  - consider this HARD

- 1143-**Longest Common Subsequence**: https://leetcode.com/problems/longest-common-subsequence/description/
  - need to code



## Tues May 14, 2024

- 20-**Valid Parentheses**: https://leetcode.com/problems/valid-parentheses/description/
  - need to code

- 71-**Simplify Path** https://leetcode.com/problems/simplify-path/
  - need to code

- 98-**Validate Binary Search Tree**: https://leetcode.com/problems/validate-binary-search-tree/description/
  - need to code

- 100-**Same Tree**:  https://leetcode.com/problems/same-tree/
  - need to code

- 104-**Maximum Depth of Binary Tree**: https://leetcode.com/problems/maximum-depth-of-binary-tree/
  - need to code

- 266-**Invert Binary Tree**: https://leetcode.com/problems/invert-binary-tree/description/
  - consider as EASY:  worked first try, seemed straightforward

- 110-**Balanced Binary Tree**:  https://leetcode.com/problems/balanced-binary-tree/description/
  - consider as HARD: need to review

- 101-**Symmetric Tree**: https://leetcode.com/problems/symmetric-tree/
  - consider as HARD: need to review

- 227-**Basic Calculator II**: https://leetcode.com/problems/basic-calculator-ii/description/
  - consider as HARD:  tried to solve with group, created a good foundation, but never really got it to work, even after 1.5 hrs
      - principles are understood, but need to work on simplifying and implementing cleanly


**Note**
- this list of problems in incomplete
- check Google Drive JC-DSAProblemTracker for most update to list and assessment of problem difficulty













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