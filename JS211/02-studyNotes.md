# JS211 study notes

## Assignments and comparisons

## Variable scope, especially how variables interact with function definitions and blocks

## Function scope

## Hoisting

## Primitive values, types and type conversions / coercions

## Object properties and mutation

## Understand the differences between loose and strict equality

## How passing an argument into a function may or may not permanently change the value that a variable contains or points to



## Working with Strings, Arrays, Objects. 

### In particular, you should be thoroughly familiar with the basic Array iteration methods (forEach, map, filter, find)
- Accessing array elements by index (bracket notation) will return `undefined` for empty elements
- built-in Array methods (e.g.`forEach`, `map`) ignore empty elements and non-elements (have keys that are NOT non-negative integers) in an array, but do not remove them

### How to use Object methods to access the keys and values in an Object as an Array
- `Object.keys(obj)` returns all keys of an array (incl. non-element keys), but NOT empty items (they return `undefined`, but actually have no value; if they WERE assigned to `undefined`, an index would be created)



## Understand that arrays are objects and be able to determine whether you have an Array
- use `Array.isArray(obj)` to check whether an object is an array
- `obj.length` will return the 'length' of an array (incl. empty items, but NOT including non-elements - i.e., keys that are not non-negative integers)

### for..in / for..of



## Variables as pointers
- 'references' are 'pointers' : terms can be used interchangably - JavaScript does not make a distinction
- i.e., "a variable *points to* or *references* an object in memory", "the pointers stored in variables are references"
- when new variables are created, JavaScript will allocate a spot in memory to hold its value
  - for **primitive** values, JavaScript will store the actual value in the memory address of the variable
  ```javascript
  let a = 5; // a has a distinct memory address, stores the value 5
  let b = a; // b has a distinct memory address, ALSO stores the value 5
  a = 8; // re-assigns a at the SAME memory address, now stores a new value, 8
  b; // still stores the value 5 at the same memory address as previous
  ```
  - for **objects**, JavaScript will allocate additional memory for the object and store a pointer to the object in the variable
  ```javascript
  let e = [1, 2]; // e has a distinct memory address, stores pointer to array at another address
  let f = e; // f has a distinct memory address, stores the same pointer to array as e
  e.push(3, 4); // mutating *operation* changes array referenced by both e and f
  e; // [1, 2, 3, 4] 
  f; // [1, 2, 3, 4] - e and f are *aliases* for the same array
  ```


## console.log vs return

## Truthiness: false and true vs falsy and truthy

## Function definition and function invocation

## Function declarations, function expressions, and arrow functions

## Implicit return value of function invocations

## First-class functions

## Partial function application

## Side effects

## Pure functions and side effects

## Naming conventions (legal vs idiomatic)

## Strict mode vs sloppy mode

## JavaScript syntactic sugar






# Questions
- [X] Why does `false && undefined === false` and `undefined && false === undefined`? (usually `1 && 2 === 2`)