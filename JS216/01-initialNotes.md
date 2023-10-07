# JS215 initial notes

## Declarative vs Imperative
- Imperative style:
  - focus on mechanics of solution - each step
  - this can be abstracted through various levels by creating functions with descriptive names to make it easier to understand code
  - built in functions (e.g.,`forEach`, `filter`) are great for ensuring robust code, simplifying understanding when reading code
- Declarative style:
  - focuses most on outcomes - what you want to achieve, rather than HOW to achieve it
  - should be a good description of the problem
  - should be 'closer to how humans think', 'less like a computer' (defining very minute, tiny steps)

- benefits of declarative style:
  - readability: aim for functions / steps to fit mental models of the problem
    - shorter code is often easier to read / comprehend
  - using built-in functions is typically more robust

## Objects
- JS has less built-in ways to iterate over objects (e.g., `map`, `forEach`, `filter`, etc.)
- can use `Object.entries` (creates an array of [key, value] for each key-value pair) and `Object.fromEntries` to iterate through / transform Object, then convert back to an Object
- could also use `Object.keys`, `Object.values`

## RegEx
- can use `String.prototype.search`, `String.prototype.match`, `String.prototype.replace` (can use `/g` in the regexp to replace all without using `replaceAll`)
- can use `RegExp.prototype.exec`, `RegExp.prototype.test`, etc. (see MDN docs)
- https://www.amazon.com/Mastering-Regular-Expressions-Friedl/dp/0596528124


## String methods
- see MDN docs for full list
- `indexOf`
- `lastIndexOf`
- `replace`
- `split`
- `substring` is similar to `slice` but deals with -ve indexes differently:
  - `slice` treats negative indexes as relative to the end of the string
  - `substring` will treat negative indexes as `0`, if 2nd argument is less than the first, it will reverse them
      - i.e., `substring(2, -1)` is equivalent to `substring(0, 2)`
- `toUpperCase`, `toLowerCase`


## PEDAC
- consider:
  - problem
    - input
    - output
    - rules (implicit and explicit)
  - examples / test cases
  - data structure
  - algorithm
  - code

- edge cases to consider:
  - empty input:  null, empty strings, arrays, etc.
  - boundary conditions (where things change)
  - repeat / duplicate values
  - data-type specific considerations (e.g., case sensitive?)
- consider input validation?
  - how to deal with bad input?

## Helpful methods
`Array(length).fill(0);`
`Array.from({length: 2}, (_) => [])`
- `[...Array(3).keys()]` will return an array of 3 elements `[0, 1, 2]`
- for (quick) deep copies of basic objects:
```javascript
let arr = [{ b: 'foo' }, ['bar']];
let serializedArr = JSON.stringify(arr);
let deepCopiedArr = JSON.parse(serializedArr);
```