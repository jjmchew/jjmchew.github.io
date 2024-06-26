# DSA Notes from various sources

## from YouTube video (wk1 day1)
- https://www.youtube.com/watch?v=lbLZiHvPIKE&t=345s

- Big O reminders:
  - drop constants
  - don't drop non-constants
    - unless you can prove that something is much smaller relative to something else, better to include it as a distinct "Big O variable"
    - e.g., a series of functions may iterate over various variables (e.g., array size, years of life, # of years of projections) : all need to be included in Big O notation unless it can be proven that a particular variable is insignificant (e.g., like constants)
    - e.g., function `validate` if unknown results in an unknown Big O
  - avoid using "n" if it obscures meaning
  - add vs multiply : remember if terms are added (sequential) or multiplied (nested)
  - recursion call tree:
      - depth of tree of fibonacci is O(N), but SPACE complexity will depend on memoized vs non-memoized
  - always look at the code in detail and think about what the code is doing - don't answer blindly based upon patterns

- solving problems:
  - every piece of info is a clue
    - e.g., design an "anagram server"
      - solution may not make use of a server (e.g., permutations, check against a dictionary, etc.)
      - HOWEVER, solution COULD : e.g., pre-process dictionary words into tree structure to make returning anagrams VERY fast

  - use bigger sample cases to make your brain work
  - better to state the obvious and think out loud (e.g., if a solution seems obvious, your interviewer will not know that unless you say something)
  - don't start coding until you're sure that's what the interviewer wants to see (optimizations may be a big part of the problem, follow-up questions)

- approaches to develop algorithms:
  - look for "BUD":
    - Bottlenecks : think about what's the TRUE bottleneck (e.g., sorting vs space - assess Big O of both)
    - Unnecessary work : see if you can solve for variables, instead of brute force, etc.
    - Duplicated work : e.g., fibonacci, look for things that can be repeated / memoized, etc.
        - look for common sub-problems

  - space / time tradeoffs:
      - use hash tables
      - consider pre-computing
  
  - "do it yourself"
      - e.g., find all permutations of string `s` in longer string `b`
          - don't need to find all permutations of `s` to solve
          - sliding window w/ char count comparison is easier / faster
      - give yourself a bigger sample problem to work through
        - pay attention to how YOU solve it - this gives hints for how you can optimize an algorithm

  - solve things "incorrectly"
      - start with any solution, think about how it's wrong and then fix
      - e.g., return a random number from a binary tree
          - need to make sure that odds of returning each number are truly random (1 in total number of nodes)

- Don't start coding too early!
- Walk through the algorithm first

- before coding (when working through an algorithm on a whiteboard / etc.):
    - use modules / helper functions
        - don't write 1 giant function - break it up
    - think about error cases, etc.
    - use good variables
    - demonstrate good style - an indication of how you truly code

- when coding:
  - write the most important code first
  - start at the high-level and then drill down into more granular details

- when testing:
  - prioritize areas of risk - focus on high-risk lines of code when double-checking code
  - make sure you're truly testing your code - work through all things step-by-step
  - use small test cases when walking through test cases
      - this allows you to ensure you're testing each line of code properly
  - make sure you THINK before you fix your bug - make sure you're looking for the real bug
    - e.g., sliding window problems, off-by-one problems, etc.
      - make sure you fix the underlying problem and not just fix that single test case



## DSA Lessons learned from lectures and exercises
- think about what the OBJECTIVE is (i.e, ideal case):
    - this will help guide towards approaches
    - e.g., 11-Container with most water: box needs to be wide, so start wide (i.e, points to start/end pointers)

- *don't hack and slash*
- when encountering bugs:
    - consider if the bug is ALGORITHM related or just CODE related
    - if the algorithm is sound, fix the code
    - if the algorithm is missing something, fix the algorithm
        - understanding the algorithm deeply will help to assess the gap

- Remember, negative indexes in Python count from the END of the array

- create functions that do 1 thing (i.e., look for zeros, or look for negatives)
  - if they do many things (e.g., look for zeros or positives or negatives) managing the results will be very difficult

### Linked Lists
- generally, don't need a `prev` pointer unless I need to go backwards
  - e.g., reverse a list, etc.
- otherwise, can just use `curr.next`, `curr.next.next`, etc.
- use a `dummy` to point to `head` when the `head` might change or there is a risk of losing `head`

### Dynamic Programming
- in iterative approaches you don't LOOK-UP values from the cache - the values need to be POPULATED
  - it's iteratively building up the recursive values that will be used to calculate the final desired number

### Backtracking
- need to remember to append a COPY of the candidate (otherwise, this list gets mutated later)
- need to remember to *return results* (I often forget this and the output is - of course - incorrect)
- need to remember to *return* once a result is added to `results` : otherwise, iterations will continue to add values to candidates



