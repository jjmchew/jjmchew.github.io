
# Notes from "A Common Sense Guide to Data Structures and ALgorithms in Python"

- ordered array lookup takes O(log N) time (i.e,. using binary search)

- **abstract data type** : a kind of data structure that is a set of theoretical rules that revolve around some other built-in data structure
    - e.g., "sets", "stacks"


## Hashes
- a valid hash function must only meet 1 criterion:
  - a hash function applied to a key must return the same value every single time

- in hashes, if a *collision* occurs, colliding keys / values may be stored as sub-arrays within an array associated with the hashed key value (ch 8)
  - the efficiency of (lookups for) hashes is dependant upon the hash function used:
    - it must avoid collisions while not consuming lots of memory
    - **rule of thumb for hash tables**:  for every 7 data elements in a hash table, it should have 10 cells
    - **load factor** (of hash tables):  the ratio of data to cells
        - e.g., for 7 data elements / 10 cells load factor is 7 / 10 = 0.7

- hash tables should be used for "paired data":  e.g., status codes and corresponding text description
  - converting arrays into hash tables also changes O(N) lookup to O(1) lookup
  - e.g., array `[61, 30, 91, 11, 54, 38, 72]` could be hash `{61: True, 30: True, 91: True, 11: True, 54: True, 38: True, 72: True}`
    - `hash_table.get(72)` would return True, `hash_table.get(103)` would return None
    - using hash tables in this way is a bit like using hash tables as an "index"

## Stacks
- designed for temporary data

- arrays with the following restrictions:
    - data can only be inserted at the end (top) of a stack
    - data can only be deleted from the end (top) of a stack
    - only the last (top) element of a stack can be read

- *top* of stack:  last item in the array
- *bottom* of stack:  first item in array

- new items are **pushed** onto the stack (i.e., new last element added)
- old items are **popped** off the stack (i.e., last element removed)

- stacks are **LIFO** : last-in-first-out

- a stack is an *abstract data type*

## Queues
- designed for temporary data

- arrays with the following restrictions:
  - data can only be inserted at the end (back) of the queue
  - data can only be deleted from the front of the queue (opposite to stacks)
  - only the first (front) element of a queue can be read (opposite to stacks)

- old items are **dequeued** from the queue

- queues are **FIFO** : first-in-first-out (like a line)
- queues are also *abstract data types*


## Recursion
- recursion is best way to replace looping when you don't know how many layers / levels you will need to "dig"
  - e.g., searching a directory tree

