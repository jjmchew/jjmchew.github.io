# JS211 study notes

## Assignments and comparisons
- precedence of operators:
  - CEAO:
    - Comparison `<=, <, >, >=`
    - Equality `===, !==, ==, !=`
    - AND (logical) `&&`
    - OR (logical) `||`


## Variable scope, especially how variables interact with function definitions and blocks
- variables are:
  - declared with `let`, `var`
  - constants declared with `const`
  - function names
  - function parameters
  - class names
- property names of the **global object** are usually included when discussing 'variables'

- `let firstName = 'Mitchell'` : a variable was *declared* and *initialized* with a string value 'Mitchell'
- `let lastName` : a variable is declared and initialized to `undefined`

### Variable scope
- the location where you declare a variable determines it's scope (lexical scoping or 'static' scoping)
- variables declared in outer scopes are available in inner scopes
  - this is true for any level of nesting
- `let` and `const` have **block scope**
  - i.e., within `{}`, `if`, loops, generally consider functions as blocks (although technically not)
- `var` has **function scope**
  - when used *at the global level* (and within a REPL) will create a property on the global object
    - i.e., `var bar = 42;` can be accessed with `global.bar; // 42`
    - this does NOT happen if `var` is used inside a function, or if running separate JS files using node (i.e., `node file.js`) : an execution 'wrapper' hides the global object
- when executed, undeclared variables that are assigned a value become properties of the global object
  - e.g., `p = 'foo';`
  - these assignments are *not* 'hoisted'
  - these assignments will conflict with actual declared variable names (will raise a ReferenceError on these assignments if the same identifier is used in a declared variable with `let`;  `var` will hoist)

- typically there are *global* and *local* variables (or scope)
  - *global* variables are available throughout a program (not declared in a function or block)
  - *local* variables are confined to a function or a block


## Function scope
- in JS, every function or block creates a new variable scope
- defining a function / block creates a new nested inner scope
  - scope exists, even if code is never executed
- when JS tries to find a variable, it searches the scope hierarchy from the bottom (inside) to the top (outside) and uses the first variable it finds with a matching name
  - all variables in the same or surrounding scopes are visible inside functions and blocks
  - variables in lower (inside) scopes can *shadow* variables with the same name in a higher (outer) scope
  - if no variable can be found, a ReferenceError is raised

- named function expressions (e.g., `let hello = function howdy() { };`)
  - the variable `howdy` has scope local to the variable `hello` and is available only within the function's local scope


## Hoisting
- *hoisting* is the apparent movement of function, variable, and class declarations to the top of the scope in which they are defined
  - function declarations are hoisted before variable declarations

- JS engines have a *creation* phase (find all function, variable, class declarations) and an *execution* phase (program runs line by line)
  - this *seems* to move all declarations to the top of the code ("hoisting")

- when hoisted, `var` variables are assigned a value of `undefined`
- when hoisted, `let` / `const` variables are *unset* or in the *temporal dead zone* and return a ReferenceError (either "cannot access before initialization" or "not defined")

- hoisting behaviour of function declarations inside blocks (like `if`) is **inconsistent** prior to ES6 and if "strict mode" is used
  - best NOT to nest function declarations inside non-function blocks
  - best to use function expressions if you must



## Primitive values, types and type conversions / coercions
- Primitive values:
  - (B)BUNNS(S) : (BigInt), Boolean, Undefined, Number, Null, String, (Symbol)
- Note:  `typeof null` returns `object` : a bug that will never be fixed
  - ECMAScript standards define `null` as a primitive
  - are immutable (cannot be changed, can only be re-assigned)

- `NaN` is a number
  - it is the only value in JS that is not equal to itself (i.e., `NaN === NaN` returns false)
  - use `Number.isNaN(value)` or `Object.is(value, NaN)` to determine `NaN`
- `1 / 0 === Infinity`;  `-1 / 0 === -Infinity`
- `0 / 0` returns `NaN` (i.e., `Number.isNaN(0/0) === true`)


### Implicit Coercions

#### original notes
- `==`:
  - object / array & non-object / array : coerce to strings (objects as `[object Object]`)
  - boolean & other : coerce boolean to number (false is 0, true is 1)
  - string & number : coerce to numbers
  - `NaN` & other : return false (`NaN == NaN` AND `NaN === NaN` returns false)
  - `null == undefined` : always true
  - `null` or `undefined` & anything other than null and undefined : returns false

- relational operators (`< > <= >=`) (coerce the same way as `==`)
  - string & string : compared as strings (lexicographically)
  - string & number : coerce to number
  - Otherwise, JavaScript converts both operands to numbers before comparing them

- using `+`:
  - if a string is present, will always coerce to strings (and concatenate)
  - if an object (array) is present, will coerce to strings (and concatenate)
  - otherwise, will coerce to numbers

- other operators (`- * / %`) : will coerce to numbers

- there is no direct coercion of string to boolean
  - i.e., can do this:
    ```javascript
    let a = 'true';
    a === 'true'; // returns true
    ```

- JS temporarily coerces *primitive* types Number and String to a corresponding *object* type
  - (NOMADS: Number, Object, Math, Array, Date, String) are all automatically coerced to object types with methods available

#### summary notes on coercion
- for `==` and comparison operators:  (if number, then numbers)
  1. objects to string (`[object Object]`)
  2. arrays to string (`[]` as `''`, `[1, 2, 3]` as `'1,2,3'`)
  3. boolean to number (`false` as `0`, `true` as `1`)
  4. if numbers are present, coerce to number
  5. `NaN` & other : always `false`
  6. `null == undefined` : always true
  7. `null` or `undefined` & other : false

- for '+': (if string, then strings)
  1. if objects, all to string
  2. if arrays, all to string
  3. if string, boolean to string;  OTHERWISE boolean to number (no objects or strings)
  4. if strings are present, coerce to string

- for arithmetic operators ('- * / %'):
  - coerce to numbers


### Explicit Coercions
- to number:
  - `Number(str)` or `+(value)` (unary `+`, different than binary `+`)
  - `parseInt(str, 10)` or `parseFloat(str)`

  - Zero-NEWS: Zero (`0`) is coerced from (Null, Empty, Whitespace, Special characters)
    - special characters:  `\t`, `\n`, etc.
  - strings with alphabet coerce to `NaN`
  - `undefined` coerces to `NaN` (cannot be converted to a number)

  - use `Number.isNaN(value)` to check if `value` is `NaN`

- to string:
  - `String(num)` or `(num).toString()`
  - Note:
    - `String([null])` returns `''`
    - `String([undefined])` returns `''`
    - `String([false])` returns `'false'`

- `Boolean(value)` or `!!(value)` : converts `value` to `true` or `false` (EFUNNZZZ)


## Object properties and mutation
- re-assigning the properties of an object **mutates** the **object**
- "reassignment is the assignment of a variable to a new value or object" (changing the *binding* of a variable)
- "mutation is changing the value of the object or array referenced by a variable"
- `Object.freeze(obj)` prevents objects in `obj` 1 level down from changing
  - for nested objects, also need to define `freeze` (if desired)
- `obj.slice()` to create a (shallow) copy of `obj`

- a function that is part of an object is called a *method*
  - generally best not to define methods (functions in objects) using arrow functions
  - use *compact method syntax*
    ```javascript
    let myObj = {
      foo: function (who) {  // non-compact
      },

      bar(x, y) { // compact
      },
    }
    ```
- can access object properties using bracket (e.g., `obj['prop']`) or dot notation (e.g., `obj.prop`)
- `delete` can delete properties from objects
- `Object.getOwnPropertyDescriptors(myObj)` : will display `{value: someValue, writable: boolean, enumerable: boolean, configurable: boolean}` flags for each property
  - `Object.defineProperty(myObj, key, {property: newValue})` : changes the flags associated with a key

- shallow copy objects using:
  - `Array.prototype.slice()`
  - `[...arrayVar]` ("spread operator" - expands elements of array)
  - `Object.assign(obj1, obj2)` : copies properties from `obj2` to `obj1`

- deep copy nested arrays and plain objects (not complex or custom objects) using:
  ```javascript
  let copy = JSON.parse( JSON.stringify(obj) ) // makes a copy of obj
  ```



## Understand the differences between loose and strict equality
- `===` : strict equality operator (identity operator)
  - returns `true` when both operands have the same *type* and *value*
- `!==` : strict inequality operator
- `==` : non-strict (loose) equality operator
  - returns `true` if one or both of the operands can be coerced and return the same value
- `!=` : non-strict (loose) inequality operator


## How passing an argument into a function may or may not permanently change the value that a variable contains or points to
- if argument is a primitive, it cannot be mutated; JS functions as pass-by-value
- if an argument is NOT a primitive, it can be mutated; JS functions as pass-by-reference
- need to know from docs or experience if an operation or function is mutating (destructive) or non-mutating


## Working with Strings, Arrays, Objects. 

### In particular, you should be thoroughly familiar with the basic Array iteration methods (forEach, map, filter, find)
- Accessing array elements by index (bracket notation) will return `undefined` for empty elements
- built-in Array methods (e.g.`forEach`, `map`) IGNORES empty elements and IGNORES non-elements (have keys that are NOT non-negative integers) in an array, but does not remove/change them

- `map` is non-mutating (it returns a new array)
- `===` used for arrays / objects : will only return true if both arrays / objects are the *same* object (not just different arrays with the same values)
- `Array.prototype.includes()` and `Array.prototype.indexOf()` both use `===` to compare array elements - hence, will not work for nested objects
- `Array.prototype.sort()` always sorts as strings, unless a sort function is otherwise defined
  - `sort` is destructive


### How to use Object methods to access the keys and values in an Object as an Array
- `Object.keys(obj)` returns all keys of an array (incl. non-element keys), but NOT empty items (they return `undefined`, but actually have no value; if they WERE assigned to `undefined`, an index would be created)
- best *not* to use `delete` to remove elements from an Array
  - best to use `Array.prototype.splice`

### Object.keys for objects:
- `Object.keys(obj)` will return ONLY 'own' properties / keys, NOT inherited ones

### for..in / for..of
- `for..in` iterates over ALL enumerable properties of an object, including properties inherited from another object
  - good for objects; bad for arrays
  - when used with an array, will return properties (index values) as strings, will iterate over ALL non-empty keys
  - a legacy implmentation of JS

- `for..of` iterates over the values of 'iterable' collections (arrays, strings)
  - will include EMPTY (undefined), but NOT non-element values
  - added in ES6

### Summary table
- `for..in` is essentially the same as `Object.keys` (for arrays)

+---------+--------------+-------------+---------+--------------+--------------+
|         |              | forEach/map | for..of |   for..in    | Object.keys  |
+---------+--------------+-------------+---------+--------------+--------------+
| Arrays  | elements     |      Y      |    Y    | Y string key | Y string key |
+---------+--------------+-------------+---------+--------------+--------------+
| Arrays  | non-elements |      N      |    N    | Y string key | Y string key |
+---------+--------------+-------------+---------+--------------+--------------+
| Arrays  | empty        |      N      |    Y    |      N       |      N       |
+---------+--------------+-------------+---------+--------------+--------------+
| Objects | own          |     n/a     |   n/a   |      Y       |      Y       |
+---------+--------------+-------------+---------+--------------+--------------+
| Objects | inherited    |     n/a     |   n/a   |      Y       |      N       |
+---------+--------------+-------------+---------+--------------+--------------+


### Strings
- special characters:
  - `\n` : new line
  - `\t` : tab
  - `\r` : carriage return
  - `\v` : vertical tab
  - `\b` : backspace
- `stringValue.charAt(num)` is the same as `stringValue[num]` (zero-indexed)



## Understand that arrays are objects and be able to determine whether you have an Array
- use `Array.isArray(obj)` to test if `obj` is an array
- `obj.length` will return the 'length' of an array (incl. empty items, but NOT including non-elements - i.e., keys that are not non-negative integers)


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

- can declare objects (e.g., arrays) with `const` - the pointer to the array cannot change, but the elements within the array can change


## console.log vs return
- `console.log` writes (or displays or outputs) something to the console; it is an expression which *does* something and also **returns** a value (`undefined`)
- a return value is a value that an expression evaluates to


## Truthiness: false and true vs falsy and truthy
- expressions that evaluate to `true` are 'truthy'
- expressions that evalue to `false` are 'falsy'
- falsy values in JS:
  - EFUNNZ(ZZ): `''` (empty), `false`, `undefined`, `NaN`, `null`, `0` (`-0`, `0n`)

- `||` returns the first *truthy* operand **OR** last operand
- `&&` returns the first *falsy* operand **OR** last operand if both are truthy


## Function definition and function invocation
- function definitions have *parameters*
- function invocation involves *arguments*
  - when the function is running, we can also refer to the local variables (with the same name as the parameter) as arguments
- function invocation requires `()` after function name
- invocation also described as a function *call*
- an *argument* is a **value** that you pass from outside a function's scope into the function so it can be accessed
- a *parameter* is a declaration for a local variable inside a function to access the arguments
  - parameters have scope within a function

- calling a function with fewer than the defined arguments does not raise an error
  - arguments that weren't provided will have a value of `undefined`
- extra arguments provided are ignored

- functions can be nested (no limit to how deeply)

### `arguments`
- `arguments` is an array-like local variable available inside all functions
  - it contains the arguments passed to a function
  - type 'object'
  - can use bracket notation to access elements
  - cannot call array methods on it (e.g., like `pop`)
  - can create an array using `let args = Array.prototype.slice.call(arguments);`
  - drawbacks: the arguments used are not explicitly declared as parameters within the function definition


## Function declarations, function expressions, and arrow functions
- nested functions are created and destroyed every time the outer function runs; are 'private'
- 3 ways to declare a function:
  - function declaration:  `function functionName(zeroOrMoreParameters...) {}`
  - function expression: `let functionName = function longFunctionName(definedParameters) { };` OR `(function functionName(parameters) {});` OR `return function functionName() {};`
  - arrow functions:  `let functionName = (parameters) => {};`


## Implicit return value of function invocations
- in JS all implicit returns are 'undefined'
- use `return` statement to *explicitly* return a value from a function
  - `return` statement causes the function to stop running and return control to the caller
- **predicates** are functions that always return a boolean value (`true` or `false`)
- assigning a function to a variable creates a pointer to it (like other objects) 


## First-class functions
- in JS, functions are **objects** (can be treated like any other value)
- functions can be:
  - assigned to variables
  - passed as arguments
  - returned from function calls

## Partial function application
- partial function application is when you create a function that can call a second function with fewer arguments than the second function expects; the created function supplies the remaining arguments
  - partial function application only occurs **if the number of arguments required is reduced**
  - sometimes also called "partial function" or "partially applied function", but these terms may refer to something different


## Side effects
- a function *call* that does any of the following has side effects (WRRECM):
  - Reads / Writes to any data entity (file, network, console, keyboard, db, clock, mouse, random number generator, speakers, etc.) - anything outside the JS program
  - Re-assigns a non-local variables
  - Exception raised
  - Calls another function that has (non-local) side effects
  - Mutates the value of any object referenced by a non-local variable

- generally, consider whether a function will have side effects when used as intended
  - e.g., no required arguments omitted
  - e.g., function is passed the expected arguments
  - e.g., all expected preparations are established (e.g., opening connections, etc.)

- unexpected side effects are bugs
- generally, functions should return a useful value OR have side effects, NOT BOTH
  - exceptions might include user input or db - will have side effect, but also need to return a value


## Pure functions and side effects
- pure functions
  - have no side effects
  - given the same arguments, always returns the same value during the function's lifetime (nothing else in the program influences the return value)

- function lifetime: begins when function is created, ends when function is destroyed

## Naming conventions (legal vs idiomatic)
- use camelCase for variable and function names
- constructor functions use PascalCase
- SCREAMING_SNAKE_CASE for constants (w/ values)
  - use standard rules for constants that store functions
- alphabetic and numeric characters only
- ALL CAPS only for acronyms or constants

- valid, but non-idiomatic:
  - anything starting with `$`
  - snake_case
  - ALL CAPS for non-constants or non-acronyms
  - beginning or ending with `_`
  - constructors starting with lowercase letters
  - "magic numbers"

- invalid:
  - beginning with a number
  - hyphens
  - use of `.` within the identifier

- variable names are *identifiers*

## Strict mode vs sloppy mode
- strict mode:
  - eliminates some *silent errors* and throws errors
  - prevents running some code which is not optimized
  - prohibits using names and syntax which may conflict with future versions of JavaScript

- why strict mode?
  - B: prevent or mitigate bugs
  - F: code can run faster
  - A: avoids conflicts with future language changes
  - D: make debugging faster

- `use strict;`
  - can only be enabled at the start of the file or a function
  - is lexically scoped, will have function scope
  - cannot be disabled once enabled
  - is automatically enabled within the body of a `class` and in JS modules

- features:
  - disables uninitialized variables (will catch if `this` is forgotten)
  - using function call syntax sets `this` to undefined
  - disallows numbers w/ leading `0` (i.e., octal literals)
  - disables 2 function parameters sharing the same name
  - disables using reserved keywords (e.g., `let` and `static`) as variable names
  - cannot use `delete` on a variable name
  - forbids binding of `eval` and `arguments`in any way
  - disables access to some properties of the `arguments` object
  - disables `with` statement


## JavaScript syntactic sugar
- concise property initializers
  - when returning an object from a function, variables can be returned as properties with the same name
  ```javascript
  function xyzzy(foo, bar, qux) {
    return {
      foo,
      bar,
      qux,
    };
  }
  // is equivalent to
  function xyzzy(foo, bar, qux) {
    return {
      foo: foo,
      bar: bar,
      qux: qux,
    };
  }
  ```
- concise methods
  - can eliminate `function` when defining methods in objects
  ```javascript
  let obj = {
    foo: function(bar) {
    };
    // is equivalent to
    foo(bar) {
    };
  };
  ```
- object destructuring
  - can perform multiple assignments in a single expression
  ```javascript
  let obj = {a: 1, b: 2, c:3};
  //
  let a = obj.a;
  let b = obj.b;
  let c = obj.c;
  // is equivalent to
  let { c, a, b } = obj; // note: spaces in {} are helpful, not required (distinguish from literals)
                         // note: order doesn't matter, a still assigned to obj.a, etc.
  let { a: newName, c } = obj; // assigns obj.a to newName

  // for function parameters
  function xyzzy({ a, b, c }) {
    console.log(a); // 1
    console.log(b); // 2
    console.log(c); // 3
  }

  // for re-assignment
  ({ a, b, c } = obj); // use parentheses
  ```

- array destructuring (same as objects)
  ```javascript
  let arr = [1, 2, 3];
  
  let [ a, b, c ] = arr; // a = 1, b = 2, c = 3
  let [ d, , f] = arr; //d = 1, f = 3

  // swap values in variables
  let a = 1;
  let b = 2;
  [ a, b ] = [b, a]; // note R side is an array literal
  ```

- spread syntax
  - equivalent to using `Function.prototype.apply`
  - when used with objects, only returns enumerable 'own' properties (sames as `Object.keys` - will not duplicate the prototype object)
  ```javascript
  function add3(num1, num2, num3) {
    return num1 + num2 + num3;
  }

  let foo = [3, 7, 11];
  add3(foo[0], foo[1], foo[2]);
  // is equivlent to
  add3.apply(null, foo);
  // is equivalent to
  add3(...foo);

  // w/ objects
  let bar = {a: 1, b: 2};
  let copy = { ...bar };  // creates a copy of bar (new object)
  ```

- rest syntax
  - used to collect multiple items into an array or object
  ```javascript
  let obj = {a: 1, b: 2, c: 3, d: 4};
  let { a, d, ...other } = obj;  // a = 1, d = 4, other = {b: 2, c: 3};

  let arr = [1, 2, 3, 4];
  let [ first, ...otherArr ] = arr; // first = 1, otherArr = [2, 3, 4]
  ```

### spread vs rest
- *rest parameter* : *collects* arguments together into an array (e.g., `function sum(...args)`)
- *spread parameter* : *distributes* array elements into separate arguments (e.g., `let copy = [...arrayVar];`)


# Questions
- [X] Why does `false && undefined === false` and `undefined && false === undefined`? (usually `1 && 2 === 2`)
    - A: based on definition of `&&` and `||` for non-boolean data types:
        - `&&` will return the first operand than can be converted to `false`, or 2nd operand if both are truthy
        - `||` will return the first operand that can be converted to `true`, or 2nd operand if both falsy
- [ ] Do all quizzes again
- [X] review:
  ```javascript
  function hello() {
    a = 'hello';
    console.log(a);

    if (false) {
      var a = 'hello again';
    }
  }

  hello();
  console.log(a);
  // hello
  // ReferenceError
  ```
- [X] could review: https://launchschool.com/lessons/7cd4abf4/assignments/1d43f233
- [X] could review: https://launchschool.com/lessons/7cd4abf4/assignments/01c3e47c
      - [ ] review Ques #5
- [ ] could review: https://launchschool.com/lessons/e15c92bb/assignments/5aed9f6f (additional coercions w/ arrays)
- [X] play around problems on function / block scope and variable def'ns, e.g.
      ```javascript
      function hello() {
        function hi() {
          console.log(a);
        }

        function howdy() {
          a = 'pizza';
          console.log(a);
        }

        hi(); // move this around
        let a = 'a';
        howdy(); // move this around
        console.log(a);
      }
      hello();
      ```
- [ ] coercion exercises
      - [ ] from practice 1, review:  4, 5, 6, 9, 24, 35, 44
- [ ] review statements and expressions
- [ ] review term 'lexical scoping' (lesson 2)
- [ ] clarify operators vs methods

- [ ] Quiz 1: #5, 10    ;    
- [ ] Quiz 2: #2, 5     ;    
- [ ] Quiz 4: #2        ;    
- [ ] Quiz 5: #5        ;    

## Coercion exercises
  ```javascript
  [] == '0'; // 1
  [] == 0; // 2
  [] == false; //3
  [] == ![]; // 4
  [null] == ''; // 5
  [undefined] == false; // 6
  [false] == false; // 7
  1 + true // 8
  '4' + 3 // 9
  false == 0 // 10
  +('123') // 11
  +(true) // 12
  +(false) // 13
  +('') // 14
  +(' ') // 15
  +('\n') // 16
  +(null) // 17
  +(undefined) // 18
  +('a') // 19
  +('1a') // 20
  '123' + 123 // 21
  123 + '123' // 22
  null + 'a' // 23
  '' + true // 24
  1 + true // 25
  1 + false // 26
  true + false // 27
  null + false // 28
  null + null // 29
  1 + undefined // 30
  [1] + 2 // 31
  [1] + '2' // 32
  [1, 2] + 3 // 33
  [] + 5 // 34
  [] + true // 35
  42 + {} // 36
  (function foo() {}) + 42 // 37
  1 - true // 38
  '123' * 3 // 39
  '8' - '1' // 40
  -'42' // 41
  null - 42 // 42
  false / true // 43
  true / false // 44
  '5' % 2 // 45
  1 === 1 // 46
  1 === '1' // 47
  0 === false // 48
  '' === undefined // 49
  '' === 0 // 50
  true === 1 // 51
  'true' === true // 52
  '42' == 42 // 53
  42 == '42' // 54
  42 == 'a' // 55
  0 == '' // 56
  0 == '\n' // 57
  42 == true // 58
  0 == false // 59
  '0' == false // 60
  '' == false // 61
  true == '1' // 62
  true == 'true' // 63
  null == undefined // 64
  undefined == null // 65
  null == null // 66
  undefined == undefined // 67
  undefined == false // 68
  null == false // 69
  undefined == '' // 70
  undefined === null // 71
  NaN == 0 // 72
  NaN == NaN // 73
  NaN === NaN // 74
  NaN != NaN // 75
  11 > '9' // 76
  '11' > 9 // 77
  123 > 'a' // 78
  123 <= 'a' // 79
  true > null // 80
  true > false // 81
  null <= false // 82
  undefined >= 1 // 83
  ```

  - answers
  ```javascript
  // 1  false -- becomes '' == '0'
  // 2  true -- becomes '' == 0, then 0 == 0
  // 3  true -- becomes '' == false, then 0 == 0
  // 4  true -- same as above
  // 5  true -- becomes '' == ''
  // 6  true -- becomes '' == false, then false == false
  // 7  false -- becomes 'false' == 0, then NaN == 0
  // 8  true is coerced to the number 1, so the result is 2
  // 9  3 is coerced to the string '3', so the result is '43'
  // 10  false is coerced to the number 0, so the result is true
  // 11:  123
  // 12:  1
  // 13:  0
  // 14:  0
  // 15:  0
  // 16:  0
  // 17:  0
  // 18:  NaN
  // 19:  NaN
  // 20:  NaN
  // 21:  "123123" -- if a string is present, coerce for string concatenation
  // 22:  "123123"
  // 23:  "nulla" -- null is coerced to string
  // 24:  "true"
  // 25:  2
  // 26:  1
  // 27:  1
  // 28:  0
  // 29:  0
  // 30:  NaN
  // 31:  "12"
  // 32:  "12"
  // 33:  "1,23"
  // 34:  "5"
  // 35:  "true"
  // 36:  "42[object Object]"
  // 37:  "function foo() {}42"
  // 38:  0
  // 39:  369 -- the string is coerced to a number
  // 40:  7
  // 41:  -42
  // 42:  -42
  // 43:  0
  // 44:  Infinity
  // 45:  1
  // 46:  true
  // 47:  false
  // 48:  false
  // 49:  false
  // 50:  false
  // 51:  false
  // 52:  false
  // true  53
  // true  54
  // false -- becomes 42 == NaN  55
  // true -- becomes 0 == 0   56
  // true -- becomes 0 == 0  57
  // false -- becomes 42 == 1  58
  // true -- becomes 0 == 0  59
  // true -- becomes '0' == 0, then 0 == 0 (two conversions)  60
  // true -- becomes '' == 0, then 0 == 0  61
  // true  62
  // false -- becomes 1 == 'true', then 1 == NaN 63
  // true  64
  // true  65
  // true  66
  // true  67
  // false  68
  // false  69
  // false  70
  // false -- strict comparison  71
  // false  72
  // false  73
  // false -- even with the strict operator  74
  // true -- NaN is the only JavaScript value not equal to itself  75
  // true -- '9' is coerced to 9  76
  // true -- '11' is coerced to 11  77
  // false -- 'a' is coerced to NaN; any comparison with NaN is false  78
  // also false  79
  // true -- becomes 1 > 0  80
  // true -- also becomes 1 > 0  81
  // true -- becomes 0 <= 0  82
  // false -- becomes NaN >= 1  83
  ```

## Coercion practice 1
```javascript
[] == '0'; // 1  :  '' == '0'  :  false
[] == 0; // 2  :  '' == 0  :  0 == 0  :  true
[] == false; //3  :  '' == 0  :  0 == 0  :  true
[] == ![]; // 4  :  '' == !''  :  '' == true  :  '' == 1  :  0 == 1  :  false  *************  '' == false  :  true
[null] == ''; // 5  :  'null' == ''  :  false  **************  '' == ''  :  true
[undefined] == false; // 6  :  'undefined' == false  :  NaN == 0  :  false  ********** '' == false  :  0 == 0  : true
[false] == false; // 7  :  'false' == 0  :  NaN == 0  :  false
1 + true // 8  :  1 + 1  :  2
'4' + 3 // 9  :  4 + 3  :  7  ********  '4' + '3'  :  '43'
false == 0 // 10  :  0 == 0  :  true
+('123') // 11  :  123
+(true) // 12 :  1
+(false) // 13  :  0
+('') // 14  :  0
+(' ') // 15  :  0
+('\n') // 16  :  0
+(null) // 17  :  0
+(undefined) // 18  :  NaN
+('a') // 19  :  NaN
+('1a') // 20  :  NaN
'123' + 123 // 21  :  '123123'
123 + '123' // 22  :  '123123'
null + 'a' // 23  :  'nulla'
'' + true // 24  :  '' + 1  :  '1'  ***** '' + true  :  'true'
1 + true // 25  :  1 + 1  :  2
1 + false // 26  :  1 + 0  :  1
true + false // 27  :  1 + 0  :  1
null + false // 28 :  0 + 0  :  0
null + null // 29  :  0
1 + undefined // 30  :  1 + NaN  :  NaN
[1] + 2 // 31  :  '1' + 2  :  '12'
[1] + '2' // 32  :  '1' + '2'  :  '12'
[1, 2] + 3 // 33  :  '1, 2' + 3  :  '1,23'
[] + 5 // 34  :  '' + 5  :  '5'
[] + true // 35  :  '' + 1  :  '1'  *** '' + 'true'  :  'true'
42 + {} // 36  :  42 + '[object Object]'  :  '42[object Object]'
(function foo() {}) + 42 // 37  :  'function foo() {}' + 42  :  'function foo() {}42'
1 - true // 38  :  1 - 1  :  0
'123' * 3 // 39  :  123 * 3  :  369
'8' - '1' // 40  :  8 - 1  :  7
-'42' // 41  :  -42
null - 42 // 42  :  0 - 42  :  -42
false / true // 43  :  0 / 1  :  0
true / false // 44  :  1 / 0  :  NaN  *********  1 / 0  :  Infinity
'5' % 2 // 45  :  5 % 2  :  1
1 === 1 // 46  :  true
1 === '1' // 47  :  false
0 === false // 48  :  false
'' === undefined // 49  :  false
'' === 0 // 50  :  false
true === 1 // 51  :  false
'true' === true // 52  :  false
'42' == 42 // 53  :  42 == 42  :  true
42 == '42' // 54  :  42 == 42  :  true
42 == 'a' // 55  :  42 == NaN  :  false
0 == '' // 56  :  0 == 0  :  true
0 == '\n' // 57  :  0 == 0  :  true
42 == true // 58  :  42 == 1  :  false
0 == false // 59  :  0 == 0  :  true
'0' == false // 60  :  '0' == 0  :  true
'' == false // 61  :  '' == 0  :  0 == 0  :  true
true == '1' // 62  :  1 == '1'  :  true
true == 'true' // 63  :  1 == 'true'  :  1 == NaN  :  false
null == undefined // 64  :  true
undefined == null // 65  :  true
null == null // 66  :  true
undefined == undefined // 67  :  true
undefined == false // 68  :  false
null == false // 69  :  false
undefined == '' // 70  :  false
undefined === null // 71  :  false
NaN == 0 // 72  :  false
NaN == NaN // 73  :  false
NaN === NaN // 74  :  false
NaN != NaN // 75  :  true
11 > '9' // 76  :  11 > 9  :  true
'11' > 9 // 77  :  11 > 9  :  true
123 > 'a' // 78  :  123 > NaN  :  false
123 <= 'a' // 79  :  123 <= NaN  :  false
true > null // 80  :  1 > 0  : true
true > false // 81  :  1 > 0  :  true
null <= false // 82  :  0 <= 0  :  true
undefined >= 1 // 83  :  NaN >= 1  :  false
```

## Coercion practice 2
```javascript
[] == '0'; // 1
[] == 0; // 2
[] == false; //3
[] == ![]; // 4
[null] == ''; // 5
[undefined] == false; // 6
[false] == false; // 7
1 + true // 8
'4' + 3 // 9
false == 0 // 10
+('123') // 11
+(true) // 12
+(false) // 13
+('') // 14
+(' ') // 15
+('\n') // 16
+(null) // 17
+(undefined) // 18
+('a') // 19
+('1a') // 20
'123' + 123 // 21
123 + '123' // 22
null + 'a' // 23
'' + true // 24
1 + true // 25
1 + false // 26
true + false // 27
null + false // 28
null + null // 29
1 + undefined // 30
[1] + 2 // 31
[1] + '2' // 32
[1, 2] + 3 // 33
[] + 5 // 34
[] + true // 35
42 + {} // 36
(function foo() {}) + 42 // 37
1 - true // 38
'123' * 3 // 39
'8' - '1' // 40
-'42' // 41
null - 42 // 42
false / true // 43
true / false // 44
'5' % 2 // 45
1 === 1 // 46
1 === '1' // 47
0 === false // 48
'' === undefined // 49
'' === 0 // 50
true === 1 // 51
'true' === true // 52
'42' == 42 // 53
42 == '42' // 54
42 == 'a' // 55
0 == '' // 56
0 == '\n' // 57
42 == true // 58
0 == false // 59
'0' == false // 60
'' == false // 61
true == '1' // 62
true == 'true' // 63
null == undefined // 64
undefined == null // 65
null == null // 66
undefined == undefined // 67
undefined == false // 68
null == false // 69
undefined == '' // 70
undefined === null // 71
NaN == 0 // 72
NaN == NaN // 73
NaN === NaN // 74
NaN != NaN // 75
11 > '9' // 76
'11' > 9 // 77
123 > 'a' // 78
123 <= 'a' // 79
true > null // 80
true > false // 81
null <= false // 82
undefined >= 1 // 83
```

