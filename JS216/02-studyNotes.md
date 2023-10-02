# things to remember
- can *never* return early from a `forEach` loop - return statement is ignored
- `splice` - need to define a 'length' argument to remove only 1 element
- watch iterating indexes, values
- watch implicit returns from functions vs explicit returns
- for recursive functions, need to keep it *clean* - always return something from various branches
  - need to break problem down into doing the same steps over and over to be able to do things recursively
- case statements using `return` in a function do not need `break` statements
  ```javascript
  function valence(element) {
    switch (element) {
      case 'H': return 1;
      case 'C': return 4;
      case 'N': return 5;
      case 'O': return 6;
      // omitting the rest
    }
  }
  ```
- random numbers:
  - `Math.random() * (max - min) + min` from min (inclusive) to max (exclusive)
  - `Math.random() * (max - min + 1) + min` min to max (both inclusive)

