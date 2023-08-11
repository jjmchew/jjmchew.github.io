# Differences between Ruby and JS

## Style
- Ruby: use snake_case for variables, functions, etc.
- JS: no snake_case (except SCREAMING_SNAKE_CASE for constants, same as Ruby)

## Strings
- Ruby: interpolate with double quotes and #
- JS: interpolate with backticks and $

## Numbers
- Ruby: has integer, float, etc.
- JS: has only 'Number', 'Infinity', 'NaN' (also 'undefined')

## 'no value'
- Ruby: `nil`
- JS: `undefined`, `null` (only arises explicitly)

## errors
- JS: may fail silently (e.g., `Number('foo')` returns `NaN`, not an error)

## variables
- Ruby: just define them
- JS: use `let` or `const` (constants) - have block scope
  - using `var` variables have broader scoping
  - undeclared variables (e.g., `p = 'foo'`) have global scope : can be the source of debugging errors

## constants
- Ruby: can be changed, but shouldn't
- JS: have an immutable binding - cannot be changed

## scope
- Ruby: 
  - `if` doesn't create a new scope
  - uses lexical scoping
- JS: 
  - `if` creates blocks
  - not all things between `{}` are blocks, technically functions are not, but can be thought of as blocks
  - `let foo = { bar: 42 }` is NOT a block (object)
  - uses lexical scoping

## if
- Ruby: 
  - `if` can return a value
  - use `elsif`
- JS: `if` creates blocks
  - does not return a value (can't be used for assignment, must use a ternary operator)
  - use `else if`

## functions
- Ruby: implicit return of last line
  - always declared using 'def'
  - need to use procs / lambdas to return functions
- JS: no implicit return, returns 'undefined' unless `return` is explicitly indicated
  - 3 ways to define (function declaration, function expression, arrow function)
  - first-class functions: functions are objects (like any other value)

## comparisons
- Ruby: uses `==`, no coercion
- JS: equivalent uses `===` (better)
  - `==`, `>`, `<` will coerce values of operands
- both: use 'short-circuit' evaluation

## truthy / falsy
- Ruby: 
  - falsy: `false`, `nil`
- JS:
  - falsy: `false`, `0`, `-0`, `0n` (BigInt zero), `''`, `undefined`, `null`, `NaN`
  - truthy: `'false'` (the string 'false')
  - can use `!!` or `Boolean()` to convert to true/false

## incrementing
- Ruby: `+=`
- JS: `+=`, `++`

## operators
- Ruby:
  - `+` works for numbers, strings, arrays
- JS:
  - `+` works only for numbers or strings (i.e., will coerce arrays to strings then concatenate strings)
  - `true` is coerced to 1;  `false` is coerced to 0

## loops
- Ruby: `next`, `break`
- JS: `continue`, `break`

## objects
- Ruby: 
  - maintain order (based on order of key creation)
  - key values may be strings, integers, etc.
- JS:
  - generally, the order keys are added, BUT non-negative integer keys grouped first, then string-valued keys, symbol keys last
  - all key values are coerced into strings

## variables as pointers
- Ruby:
  - used `object_id` to show that different primitives have different object_id's
- JS:
  - used 'memory address' analogy to show that values are stored at a memory address assigned to each variable

## arrays
- Ruby:
  - `[]` is an method
- JS:
  - `[]` is an operator

## libraries
- Ruby: use 'Gemfile'
- JS: use 'package.json'
