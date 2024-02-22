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

- example:  **linear search vs binary search**
  - linear search:  search each element 1-by-1 until the desired element is found
  - binary search: if the collection is sorted, check at the halfway point first, if number is > than the halfway element, discard the lower half; then check the halfway point of the remaining half
    - generally faster than linear search for sorted collections

  - for a collection of 8 elements, linear search needs up to 8 steps; binary search needs up to 3
  - for a collection of 1000 elements, linear search may need 1000 elements; binary might need 10

### solving problems:
- when solving problems - it can be helpful to solve first, then try to push down the time complexity curve by altering the algorithm (iterative approach)

- hash tables can often be used to reduce time complexity (with a corresponding increase in space complexity)
  - e.g., see 2-sum problem example : could do 2 nested loops, or use a hash table to store viewed numbers and corresponding array index
- pointer-based strategies can convert quadratic solutions O(N^2) to linear O(N) solutions while keeping O(1) space complexity
  - they improve time complexity without the need for additional data structures

## Big O notation
- can refer to both time complexity or space complexity

### Time complexity
- focuses on *time complexity* of an algorithm: the growth rate of the algorithm performance time as the input size increases
- big "O" stands for "order" : the most significant or biggest factor that influences an algorithm's time complexity
  - it disregards smaller, less significant terms and constant factors that may vary but do not significantly impact the growth rate as the input size becomes larger
  - identifies *worst-case scenario* of an algorithm's time complexity (maximum time to complete)
    - e.g., search for a desired element which is the last element in the list or not present at all
  - sometimes the average-case and best-case scenarios may also be considered, but worst-case is typically the most critical consideration (algorithm won't perform worse than this)
- linear search has a time complexity of O(N) ("oh of N") where N is the size of the input

#### O(1) : constant
- the number of steps required by the algorithm is constant, regardless of input size
  - time complexity is constant : algorithm performance does *not* degrade as input size increases
  - does not necessarily mean it takes only 1 step, just that the number of steps does not vary with input size
- e.g., retrieving a value from a hash table (accessing a key-value pair always takes the same time - direct access, no need to iterate through the entire data structure)
- e.g., accessing an array item via index (location in memory is calculated based on index)

#### O(logN) : increasing in proportion to log of input size
- the number of steps grows proportionally to the *logarithm of the input size*
  - this scales very well, even for larger input sizes
- e.g., binary search algorithm : at each step, divide the problem space in half by comparing the middle element
  - since we divide in half, the number of steps grows logarithmically with the size of the input
  - e.g., we have a sorted array of 1000 elements:  worst-case, need ~10 steps to locate the value.  If we double the number of elements to 2000, need only +1 steps (~11 steps)

- proportional to log2 is roughly the same as log, hence O(log2 N) is O(logN)

- **logarithm** : a mathematical operation indicating the exponent to which a fixed value (the base) must be raised to obtain that number
  - "logarithm base 2" is `log2` : log2 of 8 is 3 (2 ^ 3 = 8) : also the number of times we can divide 8 by 2 (to get 1)

#### O(N) : increasing linearly with input size
- the number of steps grows linearly with the size of the input
  - as N increases, the time taken by the algorithm increases proportionally
- e.g., linear search (checking every element)

#### O(NlogN) : typically perform a LogN operation on each of N elements (e.g., quicksort)
- the number of steps grows proportionally to product of N and logN (NlogN)
- e.g., collection of N elements, need to perform a task on each element;  time to perform this task increases at a rate that is proportional to NlogN
  - e.g., Merge sort or Quick sort:  both algorithms divide the collection into smaller collections, sort them individually, merge or combine back together
    - Merge sort:  merging takes O(N) for each iteration, total number of iterations is logN

#### O(N^2) : quadratic
- the number of steps is proportional to the square of the input size
  - "quadratic time complexity"
- e.g., 2 nested loops iterating over an array of size N
  - e.g., to find all pairs of elements in the array OR compare each element with every other element
  - since each element needs to be compared with every other element, end up with N * N = N^2
- e.g., bubble sort or selection sort

#### O(2^N) : exponential
- the number of steps (exeuction time) grows exponentially with the size of the input
  - for each additional element in the input, the execution time of the algorithm doubles
  - this exponential growth occurs since the algorithm generates an increasing number of subproblems or recursive calls with each input element
- generally considered highly inefficient - alternative approaches are usually sought
  - not suitable for large-scale problems
- e.g., non-memoized recursion : the algorithm repeatedly performs redundant calculations
  - results in exponential increase in number of recursive calls and consequently, execution time
  - e.g., non-memoized fibonacci function

#### O(N!) : factorial
- the number of steps grows at a factorial rate with the size of the input
  - "factorial time complexity"
  - **factorial** : the produce of all positive integers from 1 to N
- e.g., pathfinding algorithms:  finding the shortest path between all N cities - each permutation of paths needs to be explored
  - the number of paths grows factorially
- factorial time complexity grows more quickly than exponential complexity
  - less suitable for large-scale problems than exponential complexity


### Big-O Complexity chart
- can google this
- Horrible:  O(n!), O(2^n), O(n^2)
- Bad: O(n log n)
- Fair: O(n)
- Good: O(log n), O(1)

### space complexity
- indicates the maximum amount of memory that the algorithm requires to solve a problem
- can also be expressed using Big O notation
- e.g., O(N) space complexity:
  - means the maximum memory usage of the algorithm grows linearly with the input size
  - does *not* mean that memory usage will grow for every input - it sets an upper limit on memory consumption

### Simplifying time complexity
- ways to simplify complexity:
  - remove constants:  e.g., O(N) instead of O(2N)  (constant '2' has a negligible impact on overall growth pattern)
      - e.g., O(N) + O(N) = O(2N)
      ```javascript
      function example(arr) {
        for (let i = 0; i < arr.length; i ++) {
          // O(N) operations
        }
        
        for (let j = 0; j < arr.length; j ++) {
          // O(N) operations
        }
      } // overall, equivalent to O(N) time complexity
      ```
  - remove non-dominant factors: e.g., O(N^2) instead of O(N^2) + O(N)  (as N grows, O(N) becomes increasingly negligible)
    ```javascript
    function exampleFunction(arr) {
      for (let i = 0; i < arr.length; i++) {
        for (let j = 0; j < arr.length; j++) {
          // O(N^2) operations
        }
      }

      for (let k = 0; k < arr.length; k++) {
        // O(N) operations
      }
    } // overall, O(N^2) + O(N) complexity : can be simplified to O(N^2)
    ```
- notation:
  - can use any character instead of "N" to represent a collection
    - e.g., "U" for users and "T" for tasks
- Note:  **cannot** simplify O(U) + O(T) to O(N) : users and tasks represent different collections!
  ```javascript
  function processCollections(users, tasks) {
    for (let i = 0; i < users.length; i++) {
      // O(U) operations
    }
    for (let j = 0; j < tasks.length; j++) {
      // O(T) operations
    }
  } // overall O(U) + O(T)
  ```

- example problem:
```javascript
function test(n) {
  let result = [];
  for (let i = 0; i < n; i++) {
    result.push(new Array(n).fill(0));
  }
  return result;
}
```
  - time complexity O(N^2) : n arrays of size 'n' are created
    - typically the creation of an array (`new Array(n)` would be an O(1) operation, memory allocated, but not filled)
      - however, `.fill(0)` is linear O(N) since each element in array is set
  - space complexity O(N^2) : variable `result` contains `n` arrays of size `n`


## Sorting algorithms
- sorting is a fundamental operation in computer science to make data more manageable and accessible
  - sorting enables faster search, data analysis, optimizes performance of other algorithms that rely on ordered data
  - also good for UI (e.g., filtering / sorting products, posts)
  - applications:
    - databases rely on sorting for indexing, retrieving, searching, complex queries
    - search engines rely on sorting to provide results
    - computational biology uses sorting to find patterns, detect similarities in gene expression analysis, sequence alignment, DNA sequencing
    - operating systems (OS) use sorting for task scheduling, memory mgmt, file systems
    - network routing algorithms or protocols may sort network nodes by distance or other network metrics

- to choose sorting method, consider:
  - size of dataset
  - degree of order of the dataset
  - cost association with comparisons and swaps

- overview of various sorting algorithms:
  - bubble sort: compare and swap adjacent elements (builds right to left)
    - performs well on nearly sorted arrays
  - selection sort: look for smallest element and build sorted array from left to right
    - generally performs fewer swaps than bubble sort, can be a good choice when cost of swapping is high
  - insertion sort: pull out each element and shift them to the right if they are larger than the 'pulled' element
    - for partially / nearly sorted arrays, can be better than merge or quick sort
    - typically performs less comparisons than bubble sort - good if comparisons are costly in time/resources

 

### Bubble sort
- algorithm
  - check each adjacent pair of elements in the array
    - if the second one is smaller, swap with the first (for ascending order)
    - at the end of the first iteration, largest element should be at the end
  - for subsequent iterations, no need to check an additional element at the end (should already be in the right place)
- time complexity: O(N^2) (quadratic)
  - best case time complexity (for nearly sorted data) is O(N) (a single pass)
- considerations:
  - if comparing elements is computationally expensive (e.g., complex calculations, database queries, network requests, accessing external resources) the comparison time will increase substantially
  - swapping elements *may* also be expensive (e.g. physically moving large amounts of data in memory) - only a concern where swapping does not take place by reference
  - bubble sort can be good if data set is nearly sorted - easy to implement
```javascript
function bubbleSort(arr) {
  const len = arr.length;

  for (let i = 0; i < len - 1; i++) {
     // Flag to track if any swaps were made
    let swapped = false;

    // Last i elements are already in place
    for (let j = 0; j < len - 1 - i; j++) {

      // Check if the element in the current iteration
      // is greater than the one in the next iteration
      if (arr[j] > arr[j + 1]) {

        // Swapping elements
        [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];
        swapped = true
      }
    }

    if (!swapped) {
      // If no swaps were made in this iteration, the array is already sorted
      break;
    }
  }

  return arr;
}

const array = [5, 3, 8, 7, 2];
console.log(bubbleSort(array)); // Output: [2, 3, 5, 7, 8]
```

### Selection sort
- algorithm
  - each iteration is used to find the (next) smallest element in the remaining array
  - the "current" element is initially the first
      - the current number is compared to each of the remaining numbers to find the smallest element
      - this value is kept track of along with the index position
      - once all remaining numbers are checked, the smallest is swapped with the current (as required)
  - the current element is then incremented
- time complexity: O(N^2) (quadratic)
- considerations:
  - this is better than bubble sort when swapping is harder, since selection sort will conduct significantly fewer swaps than bubble sort (a maximum of N swaps for an array of size N)
  - like bubble sort, not considered efficient for large datasets
```javascript
function selectionSort(arr) {
  const len = arr.length;

  for (let i = 0; i < len - 1; i++) {
    let minIndex = i;

    for (let j = i + 1; j < len; j++) {
      if (arr[j] < arr[minIndex]) {
        minIndex = j;
      }
    }

    if (minIndex !== i) {
      [arr[i], arr[minIndex]] = [arr[minIndex], arr[i]];
    }
  }

  return arr;
}

const array = [3, 8, 2, 1];
console.log(selectionSort(array)); // Output: [1, 2, 3, 8]
```

### Insertion sort
- algorithm
  - start with 2nd element (at index 1)
  - pull that element out to create a "gap"
  - compare that element to numbers on the Left of the gap
    - if the number on L is greater, then move it into the gap
    - then check the next number to the Left of the (new) gap
    - when that number is less (or you reach the start of the list), insert the element
  - then iterate elements (e.g., then index 2, etc.)
- time complexity:
  - worst-case (array is in reverse order) O(N^2)
  - best-case (arrays that are already or nearly sorted) O(N) since during each iteration only a few comparisons may be needed before determining the correct position
- considerations:
  - insertion sort is often better than bubble and selection in practice
  - with ideal data sets, insertion sort can even outperform complex algorithms like merge sort or quick sort
  - insertion sort will perform few comparisons than bubble or selection, so if comparisons are slow, then insertion sort is preferred
  - also performs well on small arrays
```javascript
function insertionSort(arr) {
  const len = arr.length;

  for (let i = 1; i < len; i++) {
    let current = arr[i];
    let j = i - 1;

    while (j >= 0 && arr[j] > current) {
      arr[j + 1] = arr[j];
      j--;
    }

    arr[j + 1] = current;
  }

  return arr;
}

const array = [4, 2, 1, 3];
console.log(insertionSort(array)); // Output: [1, 2, 3, 4]
```

## Pointer-based optimization strategies
- start-end pointers: define a segment within the list, process elements within that segment
  - good for subarray problems (e.g., longest increasing subarray, finding palindromes)
  - generally best for sorted or partially-sorted arrays

- anchor/runner pointers: employ pointers with different speeds
  - also known as slow/fast pointers
  - often used to find midpoint of an array, determining if duplicates exist
  - also good for removing duplicates or paritioning elements based on specific conditions
  - reader/writer variation is great for linked lists (swapping is hard with linked lists)

- K-window slide: process elements within a sliding window of size "K"
  - maintain a fixed window and slide it through the list, updating boundaries as you iterate
  - often used for finding max/min sum of fixed-window size, calculating sliding window averages, solving substring problems
  - also good for finding max or min sums, averages, other operations on consecutive subarrays

- overall, these approaches reduce time complexity from quadratic to linear while maintaining constant space complexity
  - generally, solutions can be solved in place
  - generally work well with array-based problems


### Start/End pointers
- need to answer key questions:
  - where does `start` pointer begin?
  - where does `end` pointer begin?
  - under what conditions does `start` pointer move?
  - under what conditions does `end` pointer move?
  - under what condition do iterations stop?

- use questions above to develop clear algorithm
- may be able to achieve O(N) complexity

- example problem:
  - given a *sorted array* of numbers, find 2 numbers that sum to a given target

  - Naive solution:
      - check every possible combination of 2 numbers from array and see if the sum is the target
      - this solution is O(N^2) - not efficient;  typically implemented with 2 nested for loops to check all pairs of numbers

  - Better solution:
      - `start` pointer at index 0, `end` pointer at index length-1
      - if sum of numbers at both pointers is *greater* than target, move `end` pointer to LEFT
      - if sum of numbers at both pointers is *less* than target, move `start` pointer to RIGHT
      - stop moving pointers if they are adjacent to each other, return `null` if sum is not target

  - the better solution leverages the sorted nature of the array to ensure that moving the pointers correlates to the desired change in calculated sum of 2 numbers

### Anchor/Runner pointers
- need to answer key questions:
  - where does `anchor` pointer start?
  - where does `runner` pointer start?
  - under what conditions does `anchor` move?
  - under what conditions does `runner` move?
  - what does `anchor` do besides moving?
  - what does `runner` do besides moving?

- this may allow an array to be mutated in place, prevents the need for nested loops

- example problem:
  - given an array of positive integers and zeros, move all zeros to the end of the array while preserving the relative order of non-zero elements
  - if no zeros are present, no changes are needed

  - Naive solution:
    - iterate through array to check each element: if it's a zero, splice it from array, push to the end
    - this solution is O(N^2) because a deletion operation is O(N) and that operation is repeated for each element of the array

  - Better solution:
    - `anchor` and `runner` both start at 0
    - check number at `runner` index - if it is 0, increment `runnner`
                                     - if it is non-0, swap numbers with `anchor`, increment both pointers
    - stop moving pointers when `runner` reaches the end

    - Note:  both pointers must start at 0;  otherwise, non-zero elements could be swapped resulting in a change to their order
      - i.e., runner cannot start at last element (which could be non-zero)
      - i.e., runner cannot start at second element (index 1), which could also be non-zero

  - Variant solution (reader/writer):
    - `anchor` is considered the `writer` : it indicates the position where next non-zero element should be written
    - `runner` is considered the `reader` : it looks for non-zero elements to be written
    - both `writer` and `reader` start at 0
    - move `writer` when the element at `runner` is non-zero
        - write the non-zero element at `runner` in `writer`'s position, then increment `writer`
    - move `runner` on each iteration
    - stop iterating when `runner` reaches the end, then fill all positions from `writer` onwards with zeros

  - both solutions are O(N) time complexity and O(1) space complexity (array is modified in place with no additional space)
  - for arrays, either variation can be used with no differences (just preference)
  - the reader/writer variation is better for linked lists (since swapping is difficult)

### K-window slide
- use 2 pointers a fixed distance apart, move them in a synchronized fashion

- key questions to answer:
  - where do the `left` and `right` pointers start? (i.e., what is the size of the window)
  - what does the `left` pointer do besides moving?
  - what does the `right` pointer do besides moving?

- example problem:
  - given an array of integers, and an integer k, what is the maximum sum of consecutive k elements in the array?
  - if the array contains less than k elements, return `null`
  - if the integer k is less than 1, return `null`

  - Naive solution:
    - initialize `max` to the lowest possible integer
    - iterate through the array generating subarrays of length `k` and compute their sum
    - if the sum is greater than `max`, reassign `max`
    - the time complexity is O(N*K) where N is number of elements in the array, K is the size of the window since for each iteration, the array must be sliced to get the subarray of k consecutive elements

  - Better solution:
    - `left` pointer is set to 0, `right` pointer is set to 0 + k - 1
    - calculate `currentSum` of the numbers between `left` and `right` (inclusive); assign that sum to `maxSum`
    - when `left` pointer is incremented, subtract value of the number at previous position from `currentSum`
    - when `right` pointer is incremented, add value of the number at new position to `currentSum`
    - re-assign `maxSum` as appropriate:  take max of (`maxSum` and `currentSum`)

  - better solution is time complexity O(N), where N is length of the input array;  there are no nested loops or additional data structures


## Binary Search
- used to efficiently search for a target value in an ordered array
- it divides the search space in half at each step, thus it has a time complexity of O(logN) (better than O(N) )
  - it is especially better for arrays with a large number of elements
  - e.g., for 10 elements, binary search requires 4 comparisons : log2(10) ~ 3.32
  - e.g., for 1000 elements, binary search requires 10 comparisons : log2(1000) ~ 9.97   :  a 99% improvement

- when implementing binary search, **off-by-one errors** are common
  - i.e., iterate until `left < right` or `left + 1 < right` or `left <= right`
  - when reassigning `left` : assign to `mid` or `mid + 1`
  - when reassigning `right` : assign to `mid` or `mid - 1`

- using a binary search template is recommended:

```javascript
let left = 0
let right = array.length - 1
while (left <= right) {
  mid = Math.floor((left + right) / 2)
  if (array[mid] == target) { // note use of double equal here
    // Optional early return
  } else if (***comparison***) { // note this line needs to be updated (generall array[mid] < target)
    left = mid + 1
  } else {
    right = mid - 1
  }
}

// Most often, if the target is not found, additional handling
// or returning a specific value is needed. In most cases it will
// be the value that `left` variable holds.
```

## Linked Lists
- arrays vs linked lists:
  - **arrays**:
    - arrays are like a row of boxes: each box can hold data
    - memory allocated for arrays must be *contiguous*
    - note JS arrays are not implemented to be stored in contiguous blocks of memory, but they look and act sufficiently like real arrays to treat them that way
    - are **static data structures** - memory must be allocated in advance
      - making an array larger involves finding contiguous memory, copying existing items to the new location
      - this can be time-consuming and memory-intensive

  - **linked lists**:
    - can be thought of as a series of individual nodes
    - each node contains data and references the next node
    - these nodes can be scattered throughout the computer's memory
    - are **dynamic data structures** - they can grow or shrink in size as required
      - no need to find contiguous memory blocks
      - node pointers are easy to re-arrange, no need to copy data
    - linked lists are superior to arrays for inserting or deleting with large datasets:
      - for each deletion or insertion, the remaining elements in an array must be moved(for 2000 elements with 400 insertions, there could be 800,000 additional steps)
      - in a linked list, the list must be traversed, but insertion is just 1 step (operation); no elements need to be moved


- structure of linked lists:
  - **head** : first node of linked list
      - the primary access point to the linked list
      - a head is required to determine the starting point of the list (otherwise impossible)
  - **node** :
      - contains data
      - contains a reference (or pointer) to the next node
  - final node:
      - contains a pointer to `null` rather than another node

- **singly linked list** :
    - you can only move forward through this list
- **doubly linked list** :
    - nodes are linked forwards and backwards
- **circular linked list** :
    - the first node is connected to the last node
    - these may be singly or doubly linked

- there are several ways to implement a linked list - this course uses *node-as-a-class*
  - other approaches may create a `LinkedList` class to encapsulate `Node` objects

- **node-as-a-class** :
  - each node is an instance of a `Node` class
  - 2 main components:  `data` and `reference` to next node
  - in this approach, there is no way to encapsulate the entire linked list
  - work with the `head` node and traverse from there
  ```javascript
  class Node {
    constructor(data, next) {
      this.val = data === undefined ? 0 : data;
      this.next = next === undefined ? null : next;
    }
  }
  ```

+-----------+------------------------------------+-----------------------------------------------------------+
| Operation | Arrays                             | Linked Lists                                              |
+-----------+------------------------------------+-----------------------------------------------------------+
| Reading   | O(1) - can read directly           | O(N) - worst case, traverse every node                    |
| Searching | O(N) - need to check every element | O(N) - need to check every element                        |
| Inserting | at front: O(N), at back: O(1)      | at front: O(1), at back: O(N)                             |
| Deleting  | at front: O(N), at back: O(1)      | at front: O(1), at back: O(N) (must traverse to find end) |
+-----------+------------------------------------+-----------------------------------------------------------+

- sample problem:  deleting a node with a target value from a linked list
  - need to traverse from head; use a `prev` and `curr` counter to track the previous node and the current node
  - if the target value of `curr` node matches, then set `prev.next` to `curr.next` : skipping the existing node
  - then iterate pointers
  - need to watch : if the first node has `target` value (i.e., there is no `prev` value - initially `null` at the start), then need to reset `head`

  - alternative code solution:
    - can create a new variable `dummy` (a node) before `head`
    - i.e., `dummy.next` intitially points to `head`
    - using this `dummy` node, there is no need to address edge cases to reassign `head` specifically (i.e., if `prev` is `null` at the start of the linked list)


- visual analogy for pointer variables and how they relate to linked list nodes:
  - imagine the linked list is a series of connected balloons, each with a string to hold; each balloon is a node
    - the last balloon is connected to a tag with a string `null`
  - imagine cats are variables (i.e., 3 cats: `head`, `prev`, `curr`)
  - the `head` cat never lets go of the first string / balloon
    - when `prev = null`, the `prev` cat has no string (balloon), when `curr = head`, the `curr` cat is also hanging on to the same string as `head`
  - when iterating `curr`, that cat grabs the next string in the row of balloons / nodes
    - by last balloon, the next string will be the `null` tag
    - after that, there will be an error (no more strings to grab)

- Notes:
  - when working with linked lists always need to maintain a link to the next node
    - e.g., reversing a linked list:
      - can't just change `curr.next` to point to `prev`: if `curr.next` is "held" by a variable (cat) then the rest of the list will be lost
      - solution:  create a new variable (cat) `next` that "holds" `curr.next`


## Recursion
- a computer science concept where functions call themselves:  can be an elegant and efficient solution to complex problems

- **base case** : the condition where the recursive function stops calling itself (to prevent infinite loops)
  - e.g., `if (number < 0) return`
  - also called a termination condition
- **recursive case** : the part of the recursive function where it calls itself
  - this takes a larger problem and breaks it down into a smaller, similar subproblem
  - e.g., `populationCount(number - 1)`
- **reduction step** : a part of the recursive case, where the input is modified to move closer to the base case
  - this ensures each recursive call works on a smaller version of the original problem
  - e.g., `number - 1`

### Call stack
- the call stack is a stack of function calls
  - keeps track of:
    - order in which functions are called
    - execution contexts of each call
  - operates on LIFO (last-in-first-out) principle (most recently added function call is the first to be resolved and removed from the call stack)
  - once a function completes execution, it is removed from the stack (popped off) allowing the previous function (below) to resume its execution
  - can be thought of as a stack of plates (functions): the one on top is the most useful
  - as (recursive) functions are added, the stack grows until it reaches the base case / condition
    - then a value can be returned and the stack begins to unwind and shrink again until all functions are resolved and a final answer is available

- **stack overflow** :
  - a condition where the call stack exceeds its capacity
  - the call stack is too large for the system to handle, resulting in a runtime error
    - i.e., too many function calls are added to the stack
    - typically occurs with infinite recursion or excessively deep recursion
    - not including a proper base case is a common cause

### Time complexity
- measures the amount of time an algorithm takes to run, based on input size
- to measure:
  - count the number of recursive calls (based on input size)
  - assess the work done at each level (analyze time of each recursive call, and any additional time outside of each recursive call)
  - combine the # of calls with work done at each call to determine work done at each level
  - total the time for the algorithm
  - drawing a recursion tree can be helpful to see the number of calculations at each level

### Space complexity
- measures the amount of memory required by an algorithm to perform its computations
- for a recursive function, consider the maximum depth of the call stack and any additional data structures
  - e.g., creating a new array at each level will allocate additional O(n) space at each level
    - this results in overall space complexity of O(n^2) : for large inputs, will be a significant amount of memory
    - better to pass the array through the function call and adjust pointers

### Examples

-e.g., factorial function
```javascript
function factorial(n) {
  if (n === 1) return 1;
  return n * factorial(n - 1);
}
```
- e.g., factorial function:
  - `n` calls :  time complexity is O(n) (linear growth rate with n)
  - depth of call stack will be `n` calls : space complexity is O(n) (linear space usage)

```javascript
function fibonacci(n) {
  if (n === 1 || n == 2) return 1;
  return fibonacci(n - 2) + fibonacci(n - 1);
}
```

- e.g., fibonnaci sequence:
  - at each level, 2 recursive calls are made and addition performed : work done at each level is proportional the number of calls
  - since the number of recursive calls doubles at each level time complexity is ~ O(2^N), where N is input size
    - i.e., after initial function call, next level has 2 function calls
      - then next level has 4 function calls (each prior call has 2)
      - then next level has 8 function calls
      - etc.
  - space complexity:
    - draw the recursion tree for a sample call (e.g., `fibonacci(4)`) involving left and right sides
    - note that the left side of the tree (e.g., `fibonacci(3)`) will be larger than the right side (e.g., `fibonacci(2)`)
    - note that the call stack will never exceed `n` depth since the last number on each side will be resolved by base case
    - thus, no matter how large the input, the call stack will not exceed `n` depth
    - space complexity of O(n), where n is input size

### Function signature
- common in interview questions:  it defines the function name, the expected inputs, sometimes the expected output (type)
- e.g., 
```javascript
function fibonacci(num) {
  // implementation
}
```
  - e.g., for statically typed languages might see: `function fibonacci(num: number): number`
- don't change function signature unless agreed with interviewer
- can use a *helper function* if you want to pass in additional parameters
  - e.g., fibonacci solution with a cache for optimization
  ```javascript
  function fibonacci(num) {
    return fibonacciHelper(num, {});
  }

  function fibonacciHelper(num, cache) {
    // define base case and recursive case
  }
  ```
  - the cache stores previously calculated fibonacci values preventing redundant calculations
  - this kind of optimization is called *Dynamic programming*


### Solving problems
- define base case first
- define recursive definition of problem
  - need to use *declarative language* (explain what should happen, rather than *how* it should happen)
- **template for declarative statement** 
  - A [data structure] is a [problem definition] if [some condition is true], and the rest of the [data structure] is [problem definition]
    - [data structure]: the data structure of the problem
    - [problem description]: the name of the problem
    - [some condition is true]: can be the most difficult part, will vary for each problem

- e.g., valid palindrome problem:
  - A string is a valid palindrome if [the first and last characters of the string are the same], and the rest of the string is a valid palindrome

  - solution using `slice` to test inner substrings:
    - reasonable to assume that `slice` has time complexity O(n) and may also allocate new memory for substrings
    - time and space complexity becomes O(N^2) : worst case we create a new substring that is almost the same length as original string
  - solution using pointers (instead of `slice`):
    - time and space complexity of O(N) : no new string being created
    - in coded solution, note use of helper function to pass in `start` / `end` pointer as arguments



## Divide and conquer algorithms
- divide and conquer is a problem-solving technique that involves breaking down a complex problem into smaller sub-problems that are easier to solve individually, then combining those solutions to obtain the final answer
- three main steps:
  - divide :  divide the problem into sub-problems that have a similar structure, allowing algorithm to be applied recursively
  - conquer : solve the sub-problems recursively and work towards the base case
  - combine : aggregate individual solutions to derive the desired result


### Quicksort
- a popular sorting algorithm used by many programming languages
- when dealing with average scenarios, has exceptional speed and efficiency
  - when dealing with worst-case scenario (inversely sorted array), performs similarily to insertion sort and selection sort

- quicksort can be implemented using the first element in the (sub-)array, but this is not that efficient
  - once the array has been partitioned once, treat all elements to the left of subarry as another array
  - treat all elements to the right of the partition (pivot) element as another subarray
  - then partition / sort each of the sub-arrays
  - base case is when there are no elements or 1 element to be partitioned

  - worst-case performance occurs when the array is nearly / already sorted
    - if the first element is picked as pivot, partitioning will be inefficient (left and right partition are in-equal), resulting in time complexity of O(n^2)
    - assume only 1 element in the partition (worst-case scenario), then N-1 elements are greater than the pivot
      - each recursive call processes only 1 element, resulting in N recursive calls
      - the total number of comparisons will be 1 + 2 + 3 + ... N, which is proportional to N^2
  - `left` and `right` pointers will generally not include the pivot element with first-element pivots being selected
    - thus, an additonal step is needed to ensure the correct placement / swapping of the pivot element

- picking the middle element of the array for pivot is most effective: reduces risk of worst-case scenario
  - partitions are even, letting each recursive call process more unsorted elements
  - with middle-element partitions, `left` and `right` will include the pivot position, the pivot is in its correct sorted position (eliminates need for extra swaps)

- note: the `combine` step of quicksort happens implicitly during partitioning
  - by placing the pivot element at its correct position it combines the sorted subarrays
  - this does not significantly alter overall time complexity

#### Time Complexity
- time complexity in quicksort is primarily affected by partitioning step and recursion step
  - partitioning step: on average, this is O(N), where N is the number of elements in the array
    - exact implementation may vary, but generally remains linear O(N)
    - algorithm scans through the array once and partitions elements
  - recursion step: on average, this step is log (N) times since each recursive call roughly divides the array into 2 parts
  - combining partitioning and recursion:  multiply the complexities together to get O(NlogN) which represents the average case scenario when the input is randomly arranged in no order

  - worst-case scenario time complexity degrades to O(N^2)




#### Partitioning
- a fundamental step in quicksort
  - selecting a pivot point which is used to arrange elements (either to the left or the right)
  - pivot is selected somewhat randomly
  - arranging elements on either side must be done consistently (e.g., elements equal to the pivot must always go on the same side)
  - the choice of the pivot can affect the algorithm's performance
  - desired outcome of partitioning is for all elements that are smaller than pivot to be on its *left* side and all elements that are greater than (and equal, in assumed case) to be on the *right* side, in the order in which they appear in the original array
    - e.g., `[ 7, 3, 9, 8, 5, 1]` : if `7` is the partition, then result should be: `[ 3, 5, 1, 7, 9, 8 ]`

- steps in partitioning:
  - choose a pivot element
  - assign `left` pointer to left-most element in remaining array
  - increment `left` pointer until it reaches an element that is greater than or equal to the pivot element OR becomes greater than the `right` index
  
  - assign `right` pointer to right-most element in remaining array
  - decrement the `right` pointer until it reaches an element that is less than the pivot OR until it becomes smaller than the `left` index

  - if the above can be achieved, swap the value at pivot index with the value at the `right` index
  - OR: swap the values at the `left` and `right` indexes and then continue moving the indexes inwards as above



# Questions
- [ ] why is an array deletion operation O(N) complexity? (i.e., from Anchor/runner example - lesson 3 assignment 3)
- [ ] divide and conquer lesson 2 :  partitioning
      - **need to confirm desired order and outcome of partitioned elements in example**
        - i.e., should [7, 3, 9, 8, 5, 1] result in [3, 5, 1, 7, 9, 8] OR [5, 3, 1, 7, 8, 9]

