# LS220 Intro to Data Structures and Algorithms

## Why learn about data structures?
- improved code efficiency : different structures may be more efficient for specific problems
- algorithm design : algorithms are linked to data structures;  need to know their strengths and weaknesses
- problem-solving : some problems may require specific data structures

## set vs array (choosing data structure)
- scenario: keeping a guest list for an event
  - need to check if a guest is on the list, see if they have RSVP'd
- array: would need to iterate through the list to check each guest
  - there is a linear relationship between size of guest list and number of iterations to search through the list
- set: can add using `add` method, check using `has` method
  - no matter how many guests there are, the operations take the same amount of time to execute
  - the set provides "constant-time operations" for adding and checking elements

## choosing algorithms
- **algorithm**:  a set of instructions that outline a specific sequence of steps to solve a problem or perform a task
  - a systematic approach to accomplishing a desired outcome
- example:  linear search vs binary search
  - linear search:  search each element 1-by-1 until the desired element is found
  - binary search: if the collection is sorted, check at the halfway point first, if number is > than the halfway element, discard the lower half; then check the halfway point of the remaining half
    - generally faster than linear search for sorted collections
  - for a collection of 8 elements, linear search needs up to 8 steps; binary search needs up to 3
  - for a collection of 1000 elements, linear search may need 1000 elements; binary might need 10

## Big O notation
- focuses on *time complexity* of an algorithm: the growth rate of the algorithm performance time as the input size increases
- big "O" stands for "order" : the most significant or biggest factor that influences an algorithm's time complexity
  - it disregards smaller, less significant terms and constant factors that may vary but do not significantly impact the growth rate as the input size becomes larger
  - identifies *worst-case scenario* of an algorithm's time complexity (maximum time to complete)
- linear search has a time complexity of O(N) ("oh of N") where N is the size of the input


