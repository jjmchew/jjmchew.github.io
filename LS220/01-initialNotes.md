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

#### O(1)
- the number of steps required by the algorithm is constant, regardless of input size
  - time complexity is constant : algorithm performance does *not* degrade as input size increases
  - does not necessarily mean it takes only 1 step, just that the number of steps does not vary with input size
- e.g., retrieving a value from a hash table (accessing a key-value pair always takes the same time - direct access, no need to iterate through the entire data structure)
- e.g., accessing an array item via index (location in memory is calculated based on index)

#### O(logN)
- the number of steps grows proportionally to the *logarithm of the input size*
  - this scales very well, even for larger input sizes
- e.g., binary search algorithm : at each step, divide the problem space in half by comparing the middle element
  - since we divide in half, the number of steps grows logarithmically with the size of the input
  - e.g., we have a sorted array of 1000 elements:  worst-case, need ~10 steps to locate the value.  If we double the number of elements to 2000, need only +1 steps (~11 steps)

- **logarithm** : a mathematical operation indicating the exponent to which a fixed value (the base) must be raised to obtain that number
  - "logarithm base 2" is `log2` : log2 of 8 is 3 (2 ^ 3 = 8) : also the number of times we can divide 8 by 2 (to get 1)

#### O(N)
- the number of steps grows linearly with the size of the input
  - as N increases, the time taken by the algorithm increases proportionally
- e.g., linear search (checking every element)

#### O(NlogN)
- the number of steps grows proportionally to product of N and logN (NlogN)
- e.g., collection of N elements, need to perform a task on each element;  time to perform this task increases at a rate that is proportional to NlogN
  - e.g., Merge sort or Quick sort:  both algorithms divide the collection into smaller collections, sort them individually, merge or combine back together
    - Merge sort:  merging takes O(N) for each iteration, total number of iterations is logN

#### O(N^2)
- the number of steps is proportional to the square of the input size
  - "quadratic time complexity"
- e.g., 2 nested loops iterating over an array of size N
  - e.g., to find all pairs of elements in the array OR compare each element with every other element
  - since each element needs to be compared with every other element, end up with N * N = N^2
- e.g., bubble sort or selection sort

#### O(2^N)
- the number of steps (exeuction time) grows exponentially with the size of the input
  - for each additional element in the input, the execution time of the algorithm doubles
  - this exponential growth occurs since the algorithm generates an increasing number of subproblems or recursive calls with each input element
- generally considered highly inefficient - alternative approaches are usually sought
- e.g., non-memoized recursion : the algorithm repeatedly performs redundant calculations
  - results in exponential increase in number of recursive calls and consequently, execution time

#### O(N!)
- the number of steps grows at a factorial rate with the size of the input
  - "factorial time complexity"
  - **factorial** : the produce of all positive integers from 1 to N
- e.g., pathfinding algorithms:  finding the shortest path between all N cities - each permutation of paths needs to be explored
  - the number of paths grows factorially

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


## Recursion


## Divide and conquer algorithms



# Questions
- [ ] why is an array deletion operation O(N) complexity? (i.e., from Anchor/runner example - lesson 3 assignment 3)

