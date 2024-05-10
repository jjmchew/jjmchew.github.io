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
    - did this again as part of LS220 problems
      - LS solution is cleaner, but otherwise, no problems


- 21-**Merge two sorted lists**: https://leetcode.com/problems/merge-two-sorted-lists/description/
    - had trouble with keep head / curr sensible
    - had to implement this first with arrays (lists) and then work on linked lists since I had trouble keeping track of pointers, etc.
    - could review


- 141-**Linked list cycle**: https://leetcode.com/problems/linked-list-cycle/description/
    - had some trouble with implementing a means of observing a linked list (i.e., printing the list could be infinite)
      - final implementation seems straightforward
    - did this a part of LS problems
      - easy (but did not use fast/slow pointers)
    - do this again to review fast/slow pointers


## Mon May 6, 2024

- 54-**Spiral Matrix**: https://leetcode.com/problems/spiral-matrix/description/
    - slow on first pass - wasn't able to implement properly within 50 mins, had working approach
    - need to code


- 56-**Merge Intervals**: https://leetcode.com/problems/merge-intervals/description/
    - implemented a solution assuming a sorted array, but had some implementation details that were incorrect
    - of the 3 problems in this set, probably the most comfortable
    - need to code

- 238-**Product of array except self**: https://leetcode.com/problems/product-of-array-except-self/description/
    - conceptually very difficult
      - implemented a working O(N^2) solution, but could not come up with the conceptual O(N)
      - mostly understand the given solution in O(N) and O(1), but could definitely use review
    - need to code



## Tues May 7, 2024

- 1010-**Pairs of songs with total durations divisible by 60**: https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/description/
  - solved this as a group, had some good intuition, but had some challenges with implementing
    - worth reviewing to ensure I can implement this (e.g., think about combos, etc.)
    - should code this again with a simplified approach than the group version (very convoluted, dealt with extra cases)
  - need to code

- 209-**Minimum size subarry sum**: https://leetcode.com/problems/minimum-size-subarray-sum/description/
  - after much grief, kind of lucked into a solution to this problem which passed leetcode
  - need to code O(NlogN) solution


- 15-**3sum**: https://leetcode.com/problems/3sum/description/
  - had trouble developing a functional algorithm, my attempt was a bit convoluted
    -  sorted input array would have definitely helped (manage 2-sum)
    - was on the right track with fixing the first pointer
    - my implementation, even after looking at a solution, was still a bit off
        - needed to how / when to increment pointers j and k
  - 2nd attempt also never worked.  reached out to Srdjan for help


- 3-**Longest substring without repeating characaters**: https://leetcode.com/problems/longest-substring-without-repeating-characters/description/
  - got *very* close to solving this, but felt like I confused the order of operations a bit
    - after looking at the solution (based on time spent), realized my moving condition on anchor was off
      - needed to move anchor until there was no repeating char at runner
      - solution ultimately worked and looks clean, but I needed to look at the solution
  - worth reviewing to solidify


### warm up problems
- 392-**is subsequence**: https://leetcode.com/problems/is-subsequence/description/
  - had some trouble with edge cases, but otherwise, strong logic and easy to step through


### optional problem
- rooms:  https://gist.github.com/SrdjanCoric/d4088f0b1154fccabe49e232130b4528
          https://gist.github.com/SrdjanCoric/a1db45b57f9bff74535529758793c144 (updated link in python)
  - need to code




## Wed May 8, 2024

- 11-**Container with most water**: https://leetcode.com/problems/container-with-most-water/description/
  - worked on as a group;  went in the wrong direction entirely w/ Thomas
    - walkthrough in class seemed to make sense
  - tried this after class and had no trouble

- 162-**Find Peak Element**: https://leetcode.com/problems/find-peak-element/description/
  - got initial pass MOST of the way (didn't account for case where max is at edge)
  - code again from memory

- 153-**Find Minimum in Rotated Sorted Array**: https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/

### optional problem
- 33-**Search in rotated sorted array**: https://leetcode.com/problems/search-in-rotated-sorted-array/description/
  - feel like I understand the algo, but the details are fuzzy (i.e., how to check for left or right half and whether target is discovered)
    - sank at least an hour trying to implement and was not able to in ver 01
  - code again from memory


## Thu May 9, 2024

- 92-**Reverse Linked list II**: https://leetcode.com/problems/reverse-linked-list-ii/description/
  - walkthrough in lectures
  - need to code


- 19-**Remove Nth Node From End of List**: https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/
  - worked on this with Ben; solved most of it in 30 mins (needed to add a dummy node for case where head is removed)
  - worked on this with the group afterwards and improved the approach to use 2 pointers instead of re-establishing a stick of length 'n + 1' each iteration
  - coded this independently with some diagrams afterwards
    - consider this easy, shouldn't need to review


- 328-**Odd Even Linked List**: https://leetcode.com/problems/odd-even-linked-list/description/
  - worked this one out on my own, seemed straightforward and no major issues coding
    - don't forget to set last node to None (to prevent creating cycles)
    - consider this easy, shouldn't need to review

- 2-**Add Two Numbers**:  https://leetcode.com/problems/add-two-numbers/description/
  - 





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