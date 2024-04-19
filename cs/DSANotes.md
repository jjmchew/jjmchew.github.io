
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

- calculating the result of a problem by computing the solution to a *subproblem* is a *top-down* approach to recursion
  - a *bottom-up* approach requires the use of additional parameters passed in to keep track of the successive result of computation (similar to a traditional looping approach)
  - see Ch. 11, example of calculating factorials

- finding all of the anagrams of a given string:
  - if there are `N` characters in the string, there are N! (N factorial) possible anagrams
  - at minimum, this must take O(N!) time complexity (you must iterate through each anagram)
  - O(N!) is extremely slow : slower than O(2^N) and O(N^2)

- **dynamic programming** : the process of optimizing recursive problems that have overlapping subproblems
  - e.g., through memoization

## Quicksort / Quickselect
- Quicksort:  has O(N logN) time complexity in the average case; O(N^2) in the worst case (i.e., elements sorted inverse-ly)
  - worst case requires an increeased number of comparisons (pivot is not in the middle of the array)

- Quickselect: has time efficiency O(N)


### Comparison w/ Insertion Sort
+----------------+-----------+------------+------------+
| Sort           | Best case | Avg case   | Worst case |
+----------------+-----------+------------+------------+
| Insertion sort | O(N)      | O(N^2)     | O(N^2)     |
| Quicksort      | O(N logN) | O(N log N) | O(N^2)     |
+----------------+-----------+------------+------------+

## Linked Lists / Nodes
- basic operations for lists / arrays:
  - reading
  - searching  - insertion
  - deletion


- connected data that is dispersed throughout memory are known as nodes
  - each node also contains info on where the next node in the list is (in memory)
  - to store 4 pieces of data, 8 cells of memory are required

- **head**:  first node of a linked list
- **tail**: last node of a linked list

+-----------+-------------------+-------------------------+
| Operation | Array             | Linked list             |
+-----------+-------------------+-------------------------+
| Reading   | O(1)              | O(N)                    |
| Search    | O(N)              | O(N)                    |
| Insertion | O(N), O(1) at end | O(N), O(1) at beginning |
| Deletion  | O(N), O(1) at end | O(N), O(1) at beginning |
+-----------+-------------------+-------------------------+

- note:  for linked lists, actual insertion and deletion steps are just O(1)
- linked lists are good for moving through an existing list and adding/deleting data as we "comb"

- doubly linked lists are perfect for queues:
  - they insert data at the end in O(1)
  - they delete data from the front in O(1)


## Trees
- **tree** : a node-based structure when each node can have links to multiple nodes

- **root** (of a tree): is the uppermost node (at the "top")
  - the root has no parents (ancestors), only children (descendants)
- **level** (of a tree): a "row" within a tree (i.e., common descendant level)
- **balanced tree**: when each nodes' sub-trees have the same number of nodes in it

- **binary tree** : a tree in which each node has 0, 1, or 2 children
- **binary *search* tree** : a binary tree that also follows:
    - each node can have at most 1 *left* child and 1 *right* child
    - a node's *left* descendants can only contain values that are less than the node
    - a node's *right* descendants can only contain values that are greater than the node itself

- a balanced tree with N nodes will require logN levels to hold all of the nodes
- adding a new level will roughly double the size of the tree (add N + 1 nodes)
- searching a binary tree is O(log N)  (same as an ordered array)
  - however, insertion in a binary tree is more efficient: O(log N) + 1 steps which is O(log N)

- inserting RANDOM data into a binary search tree results in a well-balanced tree
- inserting sorted data into a binary search tree results in linear tree so searching would be O(N)

- rules for deleting nodes:
  - if a node being deleted has no children, just delete it
  - if the node being deleted has 1 child, delete the node and replace it with it's child
  - if the node being deleted has 2 children:
      - replace the deleted node with the *successor node*
          - the successor node is the node whose value is the least of all values greater than the deleted node
            (i.e., take the right branch and then follow all subsequent left branches to the bottom)
    
      - if the deleted node's right child has no left children then it IS the successor
      
      - if the successor node was previously a left child AND it has a right child:
        - the successor node will replace the deleted node
        - the (former) right child of the successor node will become the *left* child of the former parent of the successor node

- deletion from trees is typically O(log N)
  - it involves search plus a few extra steps to deal with children

- example:  book list
  - with millions of titles and constant changes to the list, a binary search tree may be better than an array

- **inorder traversal** (of a binary search tree) : visiting every node in the tree in ascending order so that the data can be printed in order
    - call traverse on the left child recursively until there is no more left child
    - do something (e.g., print the data)
    - call traverse recursively on the right child until there is no right child


## Graphs
- all trees are graphs (trees are a type of graph)
- not all graphs are trees
  - to be a tree, a graph:
      - cannot have *cycles* (nodes connected in a "circle")
      - all nodes must be *connected* (directly or indirectly, graphs can have unconnected nodes)

- graph terminology:
  - "node" is called a **vertex**
  - lines connected "verticies" are called **edges**
  - verticies that are connected by an edge are called **adjacent** (or are "neighbours")
  - if all verticies are connected, the graph is called **connected**
  - **search** : if we have access to 1 vertex and we search for another, we are trying to find a path to another vertex
    - in a connected graph, searching is used to find any other vertex from a given vertex
    - search is also used to traverse a graph
  - **path**: the specific sequence of edges to get from 1 vertex to another

- **directed graph** : a graph where arrows on the edges indicate the *direction* of a relationship

- hash tables can be used to represent (directed) graphs:
```python
followees = {
  'Alice': ['Bob', 'Cynthia'],
  'Bob': ['Cynthina'],
  'Cynthia' : ['Bob']
}
```
### Depth-first Search (DFS)
- need to keep track of visited verticies (in case there are cycles)
- easiest with a recursive implementation to keep calling itself on adjacent (unvisited) vertices
- DFS is best for diving deep and moving farther away from the starting vertex quickly

### Breadth-first Search (BFS)
- BFS does *not* use recursion
- BFS uses a queue (FIFO) 
- also need to keep track of visited vertices
- as differing from DFS, BFS will check all adjacent vertices of the current vertex before checking deeper (i.e., adjacent vertices of adjacent vertices)
- BFS is best for checking all direct connections of the starting vertex first

### Big O
- efficiency of graph search is dependant upon V (number of vertices) and E (number of edges):
  - O(V + E)
  - number of steps is actually V + 2E, but constants are dropped for big O

