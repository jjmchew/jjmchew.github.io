# JS211 study notes

## Assignments and comparisons
- precedence of operators:
  - CEAO:  Comparison (<=, <, >, >=), Equality (===, !==, ==, !=), (logical) AND (&&), (logical) OR (||)


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
  - variables in lower (inside) scopes can *shadow* variables with the same name in an higher (outer) scope
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

### Implicit Coercions

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

- JS temporarily *primitive* types (NOMADS: Number, Object, Math, Array, Date, String) to a corresponding *object* type


### Explicit Coercions
- to number:
  - `Number(str)` or `+(value)` (unary `+`, different than binary `+`)
  - `parseInt(str, 10)` or `parseFloat(str)`

  - Zero-NEWS: Zero (`0`) is coerced from (Null, Empty, Whitespace, Special characters)
  - alphabetic strings coerce to `NaN`
  - `undefined` coerces to `NaN` (cannot be converted to a number)

  - use `Number.isNaN(value)` to check if `value` is `NaN`

- to string:
  - `String(num)` or `(num).toString()`

- `Boolean(value)` or `!!(value)` : converts `value` to `true` or `false` (EFUNNZZZ)


## Object properties and mutation
- re-assigning the properties of an object **mutates** the **object**
- "reassignment is the assignment of a variable to a new value or object" (changing the *binding* of a variable)
- "mutation is changing the value of the object or array referenced by a variable"
- `Object.freeze(obj)` prevents `obj` from objects 1 level down from changing
  - for nested objects, also need to define `freeze`
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
- `for..in` is essentially the same as `Object.keys`

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
- `console.log` writes (or displays or outputs) something to the console; it is an expression which *does * something and also **returns** a value (`undefined`)
- a return value is a value that an expression evaluates to


## Truthiness: false and true vs falsy and truthy
- expressions that evaluate to `true` are 'truthy'
- expressions that evalue to `false` are 'falsy'
- falsy values in JS:
  - EFUNNZ(ZZ): `''`, `false`, `undefined`, `NaN`, `null`, `0` (`-0`, `0n`)

- `||` returns the first *truthy* operand
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

## Pure functions and side effects

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

## JavaScript syntactic sugar






# Questions
- [X] Why does `false && undefined === false` and `undefined && false === undefined`? (usually `1 && 2 === 2`)
    - A: based on definition of `&&` and `||` for non-boolean data types:
        - `&&` will return the first operand than can be converted to `false`, or 2nd operand if both are truthy
        - `||` will return the first operand that can be converted to `true`
- [ ] Do all quizzes again
- [ ] review:
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
  ```
- [ ] could review: https://launchschool.com/lessons/7cd4abf4/assignments/1d43f233
- [ ] could review: https://launchschool.com/lessons/7cd4abf4/assignments/01c3e47c
- [ ] could review: https://launchschool.com/lessons/e15c92bb/assignments/5aed9f6f (additional coercions w/ arrays)
