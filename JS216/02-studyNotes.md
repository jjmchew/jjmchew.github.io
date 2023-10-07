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
      case 'H': return 1;l
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

- if you don't give `reduce` an initial value, it will take the first value for accumulator (can effectively act to skip that value, depending on what you do with accumulator, etc.)
- remember object keys in JS are coerced to strings!
- remember `map`,`reduce`, etc. are non-destructive!!
- watch COMPARISONS (e.g., < >, <= >=, etc.) - confirm if I'm using STRINGS or NUMBERS!

- review how to check for NaN
- review iterating methods

- note on sparse arrays:
  - truly empty elements have NO KEYS (i.e., `Object.keys(arr)` will not show a corresponding key for the empty elements)
  - elements assigned to `undefined` will have keys

- checking for `-0`:
  - can determine if a value is `-0` using `Object.is(value, -0)`
  - could also check with `1 / value === -Infinity` (will return true if value is `-0`)

- `[...Array(3).keys()]` will return an array of 3 elements `[0, 1, 2]`

Key questions:
- if arguments are involved:
  - wrong number of arguments?
    - too many
    - not enough
  - wrong type of argument?
  - undefined?
  - null?

- if numbers are involved:
  - NaN?
  - Infinity / -Infinity
  - 0 / -0
  - negatives?
  - non-integers
  - likely size of numbers (exceed number?) need BigInt?
  - floating point inaccuracies? (e.g., multiply by 100, calculate, then divide by 100 for money)
  - decimals?

- if arrays / objects are involved:
  - empty arrays?
  - sparse arrays?
  - nested arrays?
  - nested objects?
  - deep vs shallow copy?
  - mutate (argument) arrays?
  - non-element properties?
  - how many elements (any length?)

- if equality or comparison is involved (including sorting)
  - how to test arrays?
  - how to test objects?
  - think about coerced values
  - how to deal with repeated values?

- if strings are involved
  - empty string?
  - case?
  - length
  - mutate?
  - non-alphabetic characters?
  - special characters? (e.g., newlines, tab, etc.)
  - other charsets?
  - likely length of string?

- if booleans are involved
  - ask about coercion - e.g., falsey values!

- boundary conditions (i.e., where things change)?

## Using the browser:
<!DOCTYPE html>
<html>
  <script src="18railFence.js"></script>
</html>
