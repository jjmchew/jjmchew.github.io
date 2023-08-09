# LS JavaScript book notes

- *programming languages* express the steps that a machine needs to perform to convert some input into an output [^1]
- JavaScript is an *interpreted language* - an interpreter converts the code written by a programmer into a form a computer can understand; then runs that interpreted code directly, or passes it on to a companion program [^1]
  - compiled languages use a compiler to produce output that a computer can run directly (perhaps after additional processing called 'linking')
  - modern JS uses a *just in time (JIT) compiler* for performance reasons
  - applications access an operating system's resources through an *Application Programming Interface* (API); the operating system is the intermediary
  - 1 level of abstraction above the API is the *runtime environment* - a more accessible API
    - the term *runtime environment* typically includes both OS and compiler/interpreter APIs
  - developer tools include tools for debugging / profiling code
  - most common JS runtime environments:  browser, node.js

- running JS code in different environments gives slightly different outputs [^1]q4
  - node REPL runs each line of code and gives return value of each line
  - using node and passing in a .js file as argument outputs only what goes to screen (e.g., console.log)
  - using chrome runs all code (pasted in as block), provides any defined outputs (e.g., console.log) and also return value of last line

- [airbnb javascript style guide](https://github.com/airbnb/javascript)
  - no variables / functions / constants / etc can start with a number
  - variables and functions generally have same style guidelines:
    - camelCase, start with a (lowercase) letter, no snake_case
    - functions can be PascalCase (start with uppercase letter) (for constructor functions)
  - "Magic Number" - a constant (may not be a number) that is important to our program but not as a configuration value:  use SCREAMING_SNAKE_CASE [^1]
  - in JS, snake_case is not really used

- [javascript (ecma) standards](https://www.ecma-international.org/publications-and-standards/standards/ecma-262/)

- [mdn javascript references](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  - this is recommended for most questions
  - *instance methods* are indicated by `prototype` in the format `Constructor.prototype.methodName()`; e.g., `String.prototype.charAt()`
  - *static methods* are indicated by no `prototype`; e.g., `String.fromCharCode()`
    - static methods are called on the "constructor name"; e.g., `String.fromCharCode(97)` vs `'Hello'.concat(' Bob!')`
  - trash can icon: indicates deprecated items (may not work in future versions of the language)
  - blue triangle with `!`: non-standard item (may not work on all platforms)
  - beaker icon: experimental item (should not be used in production code - may change behaviour or be removed)

- JS primitive data types: [^2]
  - String
  - Number (`NaN`, `Infinity`, `-Infinity` are all typeof Number)
  - Undefined
  - Null : note `typeof null` returns `'object'` (a legacy JS mistake, standard states its a primitive)
  - Boolean
  - (Symbol, BigInt : introduced in ES6)

- **literal** : any notation that lets you represent a fixed value in source code [^2]
- **expression** : anything that JavaScript can evaluate to a value, even if that value is `undefined` or `null`; a value that can be captured and used in subsequent code [^2]
- **statement** : a line of coding commanding a task (or action for the computer to perform); will not return a value that can be captured and reused later in code; is not an expression - typically a declaration, control flow, iteration, or something else;  may contain expressions, but it is not an expression itself [^2]
  - [MDN statements and declarations](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements)
  - statements don't return values [^3] (declarations are statements e.g., `let firstName = 'Mitchell'`, the assignment may return 'Mitchell', but the declaration does not return anything)
- **variable** : a named area of a program's memory space where the program can store data [^3]
- **identifiers** : a broader term for variables names that also includes constants, property names, function names, function parameters, class names [^3]
  - "variable name" does not include property names of objects, generally does includes property names of the *global object*
- **predicates** : functions that always a return a boolean value (true or false) [^5]
- **callback**: a function that you pass to another function as an argument; the callback function will be invoked at the time specified by the other function [^8]

- JS operators: [^2]
  - `+`, `-`, `*`, `/`, `%` (remainder, NOT modulo)

- remainder vs modulo [^2]
+----+----+---------------+------------+
| a  | b  | a remainder b | a modulo b |
+----+----+---------------+------------+
| 17 | 5  | 2             | 2          |
| 17 | -5 | 2             | -3         |
|-17 | 5  | -2            | 3          |
|-17 | -5 | -2            | -2         |
+----+----+---------------+------------+
  - best to just always work with positive integers (will avoid any issues w/ differences)
  - the sign of remainder is the same as sign of a
  - the sign of modulo is same as sign of b

- `NaN` : `NaN === NaN` will return `false` - the only value in JS that is not equal to itself [^2]
  - use `Number.isNaN(value)` or `Object.is(value, NaN)`, where `value` is a variable you want to determine if it might be `NaN` (expression will return `true` if it is, `false` if not)

- implicit type coersion : when using `+`, if either operand is a string then the non-string operand will be coerced into a string first, then concatenated [^2]

- JS compatibility table:  http://kangax.github.io/compat-table/es2016plus/
  - to determine whether or not a specific JS feature may be supported by various browsers / runtimes

- `=`: can be an *assignment operator* or a *syntactic token* [^3]
  - `let name = 'Mitchell'` : `=` is a syntactic operator
  - `name = 'Mitchell'` : `=` is the assignment operator


- using libraries w/ JS [^4]
  - `npm init -y` : create a package.json file
  - `npm install [library] --save` : install [library] and add to package.json, creates a package-lock.json, and adds a 'node_modules' folder to current directory with packages
  -  e.g., `let rlSync = require('readline-sync');`
    - `let name = rlSync.question("What's your name?\n");`

- 3 ways to declare a function: [^5]
  1. **function declaration**: `function functionName(args) { }`
    - can invoke the function before you declare it
    - declaring a function 1) defines the function and 2) creates a variable which is used to reference that function [^5]q6 (video)
  2. **function expression**: `let greetPeople = function () { }`
    - a function is saved to a variable - thus a function expression
    - cannot invoke the function before you declare it
    - *first-class functions* : functions are objects - can be treated like any other value (assign to variables, pass as arguments, return from a function call)
    - any function definition that doesn't have `function` at the beginning of the statement is a function expression
      - e.g., `(function greetPeople() { });` is a function expression - brackets come first
  3. **arrow functions**: `let greetPeople = () => `
    - have implicit return "when and only when the function body contains a single expression that is not itself surrounded by curly braces" (i.e., evaluates to a single value)

- comparison operators: [^6]
  - `===` : *strict equality operator* (or *identity operator*) returns true when operands have the same type *and* value [^6]
  - `!==` : *strict inequality operator* - the inverse of the `===`
  - `==` : *non-strict equality operator* (or *loose equality operator*) - will try to coerce 1 or both operands and then compare (e.g., `5 == '5'` returns true)
  - `<`, `>` will use coerce operands

- booleans: [^6]
  - `let isOk = !!(foo || bar);` is equivalent to `let isOk = (foo || bar) ? true : false;`
    - converts values into booleans (i.e., truthy into true and falsey into false)
  - `??` : *nullish coalescing operator* - evaluates to the Right operand if the Left operand is `null` or `undefined`
    - e.g., `null ?? 'over here!'` returns `'over here!'`

- `++` incrementing: [^7]
  - `++a` is the *pre-increment* operator - returns the **new** value
  - `a++` is the *post-increment* operator - returns the **old** value

- JS arrays - beware of: [^8]
  - changing the 'length' of the array will truncate the elements beyond the new defined length
  - arrays are objects: `typeof [1, 2, 3]` returns 'object'
  - use `Array.isArray(ary)` to determine if 'ary' is an array
  - Arrays can have 'properties' which appear to be key-value pairs which look like elements
    - these properties do not count as part of the 'length'
    - you can use `Object.keys(ary)` to return these keys (in addition to standard numeric keys, returned as strings)
  - arrays can hold an '<empty item>' which is not a true item (will count towards length, but does not count as a key or a true value)
    - note: 'undefined' is a value
  - `===` : in JS - 2 arrays are equal ONLY IF they are the same array (i.e,. occupy the same spot in memory)
  - `Array.includes` uses `===` to check values - i.e., checking if an element is a specific array is difficult
  - can use `.slice()` to create a copy of an array

- in JS: things that aren't objects or primitives: [^9]
  - data and functions are objects or primitives
  - anything that isn't data or a function is NOT a primitive or an object:
    - variables, identifiers
    - statements (e.g., 'if', 'return', 'try', etc.)
    - keywords (e.g., 'new', 'function', 'let', 'const', etc.)
    - comments
    - etc.

- JS objects: [^9]
  - `let newObj = Object.create(protoObj)` : creates a new object (`newObj`) using `protoObj` as the prototype
    - properties from `protoObj` will return false to `newObj.hasOwnProperty(key)`
    - `for..in` loops will iterate over all keys, but own keys first
      - never use 'for..in' to iterate over arrays (the keys returned will be strings, not index integers) [^10]
      - can use 'for..of' instead - works with strings and arrays (only ES6+) [^10]
    - `Object.keys(newObj)` will only iterate over own keys

- RegEx in JS [^10]
  - `/[regex]/.test(str)` : test 'str' with [regex] pattern - returns true / false
  - `str.match(/[regex]/)` : look for [regex] pattern in str - returns array of matches
    - don't use `/g` (global match) with `test` if you only need to test for a single occurrence - otherwise, you will get different responses each time you run `//g.test(str)` based on the number of occurences of a match within 'str';  use 'match' instead

- JS error types: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error


## References
[^1]: [Preparations ](https://launchschool.com/books/javascript/read/preparations)
[^2]: [The Basics](https://launchschool.com/books/javascript/read/basics)
[^3]: [Variables ](https://launchschool.com/books/javascript/read/variables)
[^4]: [Input / Output](https://launchschool.com/books/javascript/read/input_output)
[^5]: [Functions ](https://launchschool.com/books/javascript/read/functions)
[^6]: [Flow Control ](https://launchschool.com/books/javascript/read/flow_control)
[^7]: [Loops & Iterating](https://launchschool.com/books/javascript/read/loops_iterating)
[^8]: [Arrays ](https://launchschool.com/books/javascript/read/arrays)
[^9]: [Objects ](https://launchschool.com/books/javascript/read/objects)
[^10]: [More Stuff](https://launchschool.com/books/javascript/read/more_stuff)

