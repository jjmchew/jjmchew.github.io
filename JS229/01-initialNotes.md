# JS229 initial notes

## Methods
- method invocation:  where a function with a receiver is invoked
   - JS objects can contain methods : can be thought of as functions with a receiver (the object that the method is called on)
   - e.g., `greeter.morning()` (a function `morning` is declared on an object `greeter`)
- function invocation: calls *without* an explicit receiver are function calls
   - e.g., `morning()` (a function `morning` is invoked without an explicit receiver)
   - can also define a variable to point to a method and use function invocation (e.g., `let functionGreeter = greeter.morning; functionGreeter();`)
- `this` is available when methods or functions are invoked
   - in method invocation, `this` refers to the object itself
- a context is assigned when a function call uses `()`
   - functions defined in the main context have a context of the global window
   - functions defined as methods of a parent object have the parent object as context
   - can access the context using the `this` keyword


## Mutability
- be careful with object / array literal notation - this creates a **new** object
  - this does not mutate the original object
  - if a new object is created, then there will be a new pointer in memory to the new object


## Collaborator objects
- **collaborator objects** (or "collaborators") : Objects that are used to store state within another object
  - the represent connections between various actors in your program
  - collaborators don't have to be custom objects : could be built-in objects (like arrays, dates) or primitives (e.g., a name string)


## Objects
- are used to organize related data and code together
- are useful when a program needs more than 1 instance of something
- becomes mroe useful as the codebase size increases
- objects do not create a local scope - *context* is different from scope
  - objects create a new *context*, but not a new scope
  - scope is defined by functions or blocks (depending on var/let/function/etc.)


## Function Execution Context
- JS is both object-oriented and has first-class functions (functions can be added to objects and executed in the context of those objects, pass them from other functions, etc.)
  - to meet the requirements of both, it must let the developer control the execution context

### Implicit execution context
- (implicit) execution context (`this`) depends on *how you invoke* a function/method
  - "implicit *function* execution context" (also called "implicit binding for functions") is the global object
  ```javascript
  function foo() {
    return 'this here is: ' + this;
  }

  foo();                // "this here is: [object Window]"
                        // similar to running `window.foo()`
  ```
- variable scope depends on *where you write the code* (lexical scoping)
- the same function executed in different ways will have different execution context:
```javascript
let object = {
  foo() {
    return 'this here is: ' + this;
  },
};

object.foo();              // "this here is: [object Object]"

let bar = object.foo;
bar();                     // "this here is: [object Window]"
```
- in strict mode: implicit execution context will be `undefined`
```javascript
"use strict";

let object = {
  foo() {
    return 'this here is: ' + this;
  },
};

console.log(object.foo());              // "this here is: [object Object]"

let bar = object.foo;
console.log(bar());                     // "this here is: undefined"

console.log('this here is: ' + this); // "this here is: [object Window]" (browser)
                                      // this here is: [object Object] (node)
```
- implicit *method* execution context is set as the calling object
```javascript
let foo = {
  bar() {
    return this;
  },
};

foo.bar() === foo; // true

// changing the execution context
let baz = foo.bar;

baz() === foo;    // false  - execution context is no longer the object foo
baz() === window; // true - now an implicit function execution context
```

### Explicit execution context
- set execution context using `call` or `apply`
```javascript
a = 1;

let object = {
  a: 'hello',
  b: 'world',
};

function foo() {
  return this.a;
}

foo();                  // 1 (context is global object)
foo.call(object);       // "hello" (context is object)
```
- can also pass arguments to called functions
  - `someObject.someMethod.call(context, arg1, arg2, ...)`
  - `someObject.someMethod.apply(context, [arg1, arg2, ...])`
```javascript
let iPad = {
  name: 'iPad',
  price: 40000,
};
let kindle = {
  name: 'kindle',
  price: 30000,
};

function printLine(lineNumber, punctuation) {
  console.log(lineNumber + ': ' + this.name + ', ' + this.price / 100 + ' dollars' + punctuation);
}

printLine.call(iPad, 1, ';');        // => 1: iPad, 400 dollars;
printLine.call(kindle, 2, '.');      // => 2: kindle, 300 dollars.
// OR
printLine.apply(iPad, [1, '.'])  // 1: iPad, 400 dollars.
```
- can use `bind` to permanently set execution context for a function / method ("hard binding")
  - note: `bind` creates a *new* function with a set context; the original isn't altered (context of original will continue to change depending on execution)
  - once `bind` has been called, execution context cannot be changed (even explicitly using `call` / `apply`)
  - e.g., `john.greetings.bind(john)` : an object `john` has a method `greetings`, which is then permanently bound to the object `john` using `bind`

### Context loss
- occurs when a method is 'removed' from it's containing object and invoked (i.e., invoked independently of it's containing object)
```javascript
function repeatThreeTimes(func) {
  func();       // can't do func.call(john), out of scope
  func();
  func();
}

function foo() {
  let john = {
    firstName: 'John',
    lastName: 'Doe',
    greetings() {
      console.log('hello, ' + this.firstName + ' ' + this.lastName);
    },
  };

  repeatThreeTimes(john.greetings); //
}

foo();

// => hello, undefined undefined
// => hello, undefined undefined
// => hello, undefined undefined
```
- potential solutions:
  - pass in context as another argument (e.g., optional `thisArg` argument of `forEach`)
  - hard binding (use `bind` to define fixed execution context)
- executing functions within functions may result in context loss (i.e., context does not *propogate* to internal functions)
```javascript
let obj = {
  a: 'hello',
  b: 'world',
  foo() {
    function bar() {
      console.log(this.a + ' ' + this.b);
    }

    bar(); // when invoked, context of 'obj' does not propogate from obj.foo() invocation, will use global `this` instead
  },
};

obj.foo();        // => undefined undefined
```
- potential solutions
  - save `this` within a variable so that it can be accessed by the function
  ```javascript
  foo() {
    let self = this;

    function bar() {
      console.log(self.a + ' ' + self.b);
    }

    bar();
  }
  ```
  - explicitly define context using `call` / `apply`
    - updated invocation:  `bar.call(this);`
  - use `bind` to set context permanently
    - to chain directly, use a function expression (cannot use a function declaration) to chain directly
    ```javascript
    let bar = function() {
      console.log(this.a + ' ' + this.b);
    }.bind(this);
    ```
  - use an arrow function : the value of `this` in an arrow function will be the current execution value of `this` in the calling function
    - `let bar = () => console.log(this.a + ' ' + this.b);` : `this` in the arrow function will point to `obj` which is the execution context for `foo` in the original example
    - note: arrow functions do NOT get their context lexically
    ```javascript
    let obj1 = {
      a: 'This is obj1',

      foo() {
        let bar = () => console.log(this.a);
        bar();
      },
    };

    let obj2 = {
      a: 'This is obj2',
    };

    obj1.foo();                   // This is obj1

    obj2.foo = obj1.foo;
    obj2.foo();                   // This is obj2 - note that context changes for arrow function, not based on lexical scope
    ```




## Global object
- JS creates a global object when it starts running
  - global object is the implicit evaluation context
    - thus `foo = 1`; on it's own creates a property `foo` on the global object (similar to `window.foo = 1`)
    - difference between `var` and new global properties:
      - undeclared global properties can be deleted, but those declared with `var` *cannot* be deleted
        - e.g., `delete window.foo`
  - in the browser: it's the `window` object
    - contains properties such as `window.Infinity` and `window.isNaN` (recommend using `Number.isNaN` instead - won't coerce strings into NaN and return 'true' unexpectedly)
    - can add properties to this object anytime (e.g., `window.foo = 1`)
  - in node: it's `global`
    - however, in node, all variables and functions have function scope:
      - node adds a 'module' scope (available from within the file, but not anywhere else), so variables declared with `var` are not added to `global` object, but are in the 'module' scope
      - `var`, `let` and undeclared variables are *not* added to `this`
        - these variables don't belong to any object
    - top-level program in Node will be an empty object `{}`
- strict mode changes the implicit context to `undefined` (i.e., will not use `window` or `global`)



## Higher-order functions
- **Higher-order functions** : can accept a function as an argument, return a function when invoked, or both
- similar, but distinct from *first-class functions*
  - a language has "first-class functions" : i.e., treats functions as values; specifically refers to functions in programming languages
  - higher-order functions : functions that *work* on other functions; can be applied to mathematical functions, as well as programming functions
  - concepts are related:  likely would not have a programming language that supports higher-order functions without first-class functions



# Things to review
- [ ] : Mutability of objects, Problem 4 and 5:  https://launchschool.com/lessons/4671d66f/assignments/9695cfa4
- [ ] : could do further exploration (deep equality): https://launchschool.com/exercises/1937fc28
- [ ] : review context, problem 5:  https://launchschool.com/lessons/c9200ad2/assignments/84fbe7cb
- [ ] : defining this, problem 2, 4(try all methods):  https://launchschool.com/lessons/c9200ad2/assignments/7bef6908

