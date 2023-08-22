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
  - generally add `;`, *except* for `function`, `class`, `if`, `for`, `while` blocks [^11]

- [javascript (ecma) standards](https://www.ecma-international.org/publications-and-standards/standards/ecma-262/)

- [mdn javascript references](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  - this is recommended for most questions
  - *instance methods* are indicated by `prototype` in the format `Constructor.prototype.methodName()`; e.g., `String.prototype.charAt()`
  - *static methods* are indicated by no `prototype`; e.g., `String.fromCharCode()`
    - static methods are called on the "constructor name"; e.g., `String.fromCharCode(97)` vs `'Hello'.concat(' Bob!')`
  - trash can icon: indicates deprecated items (may not work in future versions of the language)
  - blue triangle with `!`: non-standard item (may not work on all platforms)
  - beaker icon: experimental item (should not be used in production code - may change behaviour or be removed)

- JS primitive data types: [^2] ([B]BUNNS[S])
  - String
  - Number (`NaN`, `Infinity`, `-Infinity` are all typeof Number)
  - Undefined
  - Null : note `typeof null` returns `'object'` (a legacy JS mistake, standard states its a primitive)
  - Boolean
  - (Symbol, BigInt : introduced in ES6)
    - for BigInt, add `n` after the number:  e.g., `23n ** 17n` will return a BigInt number (not floating point notation)

- **literal** : any notation that lets you represent a fixed value in source code [^2]
- **expression** : anything that JavaScript can evaluate to a value, even if that value is `undefined` or `null`; a value that can be captured and used in subsequent code [^2]
  - common expressions: evaluate to a number, a string, or a boolean [^14]
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
    - an anonymous[^18] function is saved to a variable - thus a function expression
    - cannot invoke the function before you declare it
    - *first-class functions* : functions are objects - can be treated like any other value (assign to variables, pass as arguments, return from a function call)
    - any function definition that doesn't have `function` at the beginning of the statement is a function expression
      - e.g., `(function greetPeople() { });` is a function expression - brackets come first
      - Note: a function defined with `function` will also create a variable with the same name, using a function expression does NOT create a variable with the same name as the function [^18]
    - can also used *named* function expressions: e.g., `let hello = function foo() { }`[^18]
      - Note: that the function name `foo` is ONLY accessible within the function scope (i.e., inside the variable 'hello')
  3. **arrow functions**: `let greetPeople = () => `
    - have implicit return "when and only when the function body contains a single expression that is not itself surrounded by curly braces" (i.e., evaluates to a single value)
    - can omit `()` from arguments if there is only a single argument [^18]
    - arrow functions inherit the *execution context* from the surrounding code [^18]

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
    - modifies OPERAND first, then evaluates the expression [^14]
  - `a++` is the *post-increment* operator - returns the **old** value
    - evaluates EXPRESSION first, then modifies the operand [^14]
  - e.g., [^14]
  ```js
  let a;
  let b;
  let c;

  a = 1;
  b = a++;  // equivalent to "b = a; a += 1;". so now b is 1 and a is 2
  c = ++a;  // equivalent to "a += 1; c = a;". so now c is 3 and a is 3
  ```

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
- generally there are 2 types of values: [^20]
  - "reference-type" value - objects (e.g., arrays, other non-primitives)
  - "primitives" - primitive values ("BBUNNSS")

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

- special string characters: [^12]
  - `\n` : new line
  - `\t` : tab
  - `\r` : carriage return
  - `\v` : vertical tab
  - `\b` : backspace
  - use `\` to escape quotes / double-quotes / newlines (in multi-line strings)
    - e.g., 
    ```js
    let longText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do \
    eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut \
    enim ad minim veniam, quis nostrud exercitation ullamco laboris \
    nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor \
    in reprehenderit in voluptate velit esse cillum dolore eu fugiat \
    nulla pariatur. Excepteur sint occaecat cupidatat non proident, \
    sunt in culpa qui officia deserunt mollit anim id est laborum.';
    ```
- strings: [^12]
  - `string.charAt(num)` : access the character at 'num' in 'string'
  - OR: `string[num]` : same as above
  - `something.toString()` OR `String(something)`

- JS reserved words:  https://262.ecma-international.org/5.1/#sec-7.6.1.1

- e.g., `let name = 'Jane';` : is a variable declaration combined with an *initializer* (distinct from assignment e.g., `name = 'James';`) [^13]
  - constants MUST be declared and initialized (since they cannot be changed)
- JS is dynamically-typed - a variable may refer to a value of any data type and can be re-assigned without error

- *unary operator* : an operator that takes only 1 operand

- implicit type coercion: [^15]
  - unary `+` : coerces with same rules as `Number()`
    - true => 1
    - false => 0
    - '' or ' ' => 0
    - \n => 0
    - null => 0
    - undefined => NaN
    - other strings => NaN
  - binary `+` (2 operands)
    - if a string or object is present, coerce everything to strings
    - if no strings are present, coerce everything to number and add
    - note: 1 + NaN = NaN
  - `-`, `*`, `%`, `/` (only defined for numbers)
    - coerce everything to numbers
  - `==`:
    - string == number : coerce string to number
    - boolean == other : coerce the boolean to number
    - null == undefined : always true
    - null == other : always false
    - undefined == other : always false
    - NaN == other : always false
  - `>`, `<`, `<=`, `>=` (only for strings or numbers)
    - coerce to numbers to compare
      - any comparison with NaN is false
    - unless both operands are strings - then compare as strings

- conditionals: [^16]
  - `1 && 2` will return `2` (truthy)
  - `1 || 2` will return `1` (truthy)
  - *expression* : e.g., `score > 70`
  - *conditional statement* : e.g., `if (score > 70)`

## scope [^17]
- *global scope* : the 'main' scope (sometimes function scope at the top level, 'file scope' or 'module scope' might be better terms[^19])
- *function scope* : an inner scope created when a function is defined
  - use `var` or `function` [^19]
- *block scope* : an inner scope created when a block is defined (e.g., for a while loop, etc.)
  - use `let`, `const`, `class` [^19]
- JS uses *lexical scoping* (vs *dynamic scoping*) to determine where it looks for variables
  - looks at the structure of the source code
    - Note: the code doesn't need to be executed for the scope to exist
  - searches the scope hierarchy from the bottom (innermost) scope to the top (outermost)
  - returns the first variable it finds with a matching name: variables in a lower scope can *shadow* or hide variables with the same name in outer scopes
  - if JS cannot find a matching variable, it *creates a new global variable* as a default action : can lead to bugs
- can think of differences between 'declared' scope and 'visible' scope (LS-terms)
  - e.g., you might use `let` to declare a variable with block-scope, which HAS global visible-scope
  - typically declared scope is block or function
  - typically visible scope is global or local (i.e., function or block)

## hoisting [^19]
- during the *creation phase* of js program execution (i.e., before actual code execution begins), variable, function, class declarations are reviewed and *appear* to be 'moved to the top' of their respective scopes (i.e., functions or blocks)
  - identifiers are noted and added to the appropriate scope: global or local (block or function)
  - creation phase will scan your code in order, and syntax errors will be noted as the arise (based on the order of your code)
- **don't** nest function declarations inside non-function blocks
  - if you must, function expressions are better
  - if using function expressions, variables will follow standard hoisting rules
    - note that the variable will be 'hoisted' and declared first and set as 'undefined'
    - the assignment of the function to that variable will occur in the sequence of code execution (i.e., no hoisting for function assignment will occur)
  - e.g., 
    ```javascript
    console.log(hello());

    var hello = function () {
      return 'hello world';
    };
    ```
    is equivalent to
    ```javascript
    var hello;

    console.log(hello());    // raises "TypeError: hello is not a function"

    hello = function () {
      return 'hello world';
    };
    ```
- if both variable and function declarations exist, functions will be hoisted above the variable declarations:
  - example 1:
  ```javascript
  // example 1
  bar();             // logs "world"
  var bar = 'hello';

  function bar() {
    console.log('world');
  }
  ```
  is hoisted to:
  ```javascript
  // example 1 hoisted
  function bar() {
    console.log('world');
  }

  bar(); // world
  bar = 'hello';
  ```

  - example 2:
  ```javascript
  // example 2
  var bar = 'hello';
  bar();             // raises "TypeError: bar is not a function"

  function bar() {
    console.log('world');
  }
  ```
  is hoisted to:
  ```javascript
  function bar() {
    console.log('world');
  }

  bar = 'hello';
  bar(); // error - can't invoke a string
  ```
- `var`
  - is *function-scoped*
    - a variable declared with `var` will be accessible everywhere within a function, even if the declaration is contained within a block which never gets executed (will have an 'undefined' value)
    - e.g., 
    ```javascript
    function foo() {
      if (false) {
        var a = 1;
      }
      console.log(a); // undefined
    }
    ```
  - cannot create constants
  - creates 'properties' accessible on the 'global' object (if used in the global scope)
    - note: this only works when code is run in the REPL, NOT through a .js file
      - code run through a .js file is first 'wrapped' in a function, hence there is no change to the global object
    ```javascript
    var bar = 42;
    console.log(global.bar); // 42

    let foo = 86;
    console.log(global.foo); // undefined
    ```
  - during hoisting, `var` variables are given a value of `undefined` and are thus accessible during execution prior to actual code execution
  - can define variables and functions with the same name
- `let` / `const`
  - is *block-scoped*
  - during hoisting, `let` or `const` variables are NOT given an initial value (left 'not defined' in the TDZ - *temporal dead zone*) and are thus NOT accessible in code prior to actual declaration
  - cannot define variable and function with the same name
  - multiple declarations and assignments to the same variable using `let` are allowed within loops but NOT within the main scope
    - e.g.,
    ```javascript
    let a = 'hello';
    let a = 'bye'; // SyntaxError
    ```
    BUT
    ```javascript
    let a = 'hello';
    for (let x = 0; x < 4; x++) {
      let a = 'pizza' + x; // is allowed - no error
    }
    ```

## best practice (let/const vs var) [^19]
- use `let` and `const` if possible - avoid details of `var`
  - declare variables as close to first use as possible
- if using `var` - place all definitions at top of scope (i.e., replicate hoisted code)
- declare functions before using them (avoid variations with hoisted behaviour)

## Closures [^21]
- "Closures use the scope in effect at a function's *definition* point to determine what variables that function can access. The variables in scope during a function's execution depend on that closure."
  - A function can access variables needed in (lexical) scope from when the function was *defined*, even if those variables aren't in-scope when the function is *invoked*
- Note: closure is different than **state** - if a variable's value changes, the function will see the updated value, not the old one
- Using local variables accessed via closure provides some 'data protection':
  ```javascript
  function makeCounter() {
    let counter = 0;

    return function() {
      counter += 1;
      return counter;
    }
  }

  let incrementCounter = makeCounter();
  console.log(incrementCounter()); // 1
  console.log(incrementCounter()); // 2
  ```
  - i.e., `counter` can only be accessed via the returned function (using 'incrementCounter') - each instance of `makeCounter` will declare and use a new instance of `counter`
- can also create closures that share the same local variable
  ```javascript
  function makeCounter() {
    let counter = 0;

    const fun1 = function() {
      counter += 1;
      return counter;
    }

    const fun2 = function() {
      counter += 2;
      return counter;
    }

    return [fun1, fun2];
  }

  let funs = makeCounter();
  let fun1 = funs[0];
  let fun2 = funs[1];
  console.log(fun1()); // 1
  console.log(fun2()); // 3
  ```
  - `fun1` and `fun2` both share 'counter' and affect it differently


## First-class value / First-class object [^21]
- describes values that can be:
  - assigned to a variable or an element of a data structure (such as an array or object)
  - passed as an argument to a function
  - returned as the return value of a function
- in JS - refers to primitives, arrays, objects, functions
  - if functions are first-class values this means:
    - functions can take other functions as arguments and return other functions - allows a more declarative and expressive programming style
    - don't have to execute a function in the same scope in which it was defined



## Partial function application [^21]
- when the number of arguments required to invoke a function is *reduced* by creating a new function
- useful when you need to call a function which takes multiple arguments, however when called, you'll only provide *some* of the arguments
  - you can create a function which returns a function which supplies *other* arguments and takes *some* arguments
  ```javascript
  // REQUIRED scenario : download needs an errorHandler that only takes 1 argument
  function download(locationOfFile, errorHandler) {
    // try to download the file
    if (gotError) {
      errorHandler(reasonCode);
    }
  }

  // existing errorHandler function takes 2 arguments
  function errorDetected(url, reason) {
    // handle the error
  }

  download("https://example.com/foo.txt", /* ??? */); // WHAT TO DO?
  ```
  - can use partial function application:
  ```javascript
  function makeErrorHandlerFor(locationOfFile) {
    return function(reason) {
      errorDetected(locationOfFile, reason);
    };
  }

  let url = "https://example.com/foo.txt";
  download(url, makeErrorHandlerFor(url));
  ```


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
[^11]: [Code Style](https://launchschool.com/lessons/7377ece4/assignments/88ed1c52)
[^12]: [More on Strings](https://launchschool.com/lessons/7377ece4/assignments/84419ace)
[^13]: [Variables ](https://launchschool.com/lessons/7377ece4/assignments/4a43f341)
[^14]: [Expressions and Statements](https://launchschool.com/lessons/7377ece4/assignments/d84fdace)
[^15]: [Implicit Primitive Type Coercions](https://launchschool.com/lessons/7377ece4/assignments/3d2e392a)
[^16]: [Conditionals ](https://launchschool.com/lessons/7377ece4/assignments/5f7c3a20)
[^17]: [Functional Scopes and Lexical Scoping](https://launchschool.com/lessons/7cd4abf4/assignments/0b1349b7)
[^18]: [Function Declarations and Function Expressions](https://launchschool.com/lessons/7cd4abf4/assignments/5cb67110)
[^19]: [Hoisting ](https://launchschool.com/lessons/7cd4abf4/assignments/510e62bb)
[^20]: [Variables, Functions, and Blocks: Revisted](https://launchschool.com/lessons/7cd4abf4/assignments/8ac6ad6d)
[^21]: [Closures ](https://launchschool.com/lessons/7cd4abf4/assignments/0ea7c745)