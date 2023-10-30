# JS229 Study Notes

## Objects
- **function invocation** : when a function execution does *not* have an explicit receiver
  - i.e., function execution *without* the use of a property accessor;  e.g., `parseInt('18')`
  - IIFEs are considered function invocations
  - passing methods on objects as callback functions will also result in a function invocation (i.e., method has been removed from calling object) e.g., `setTimeout(myCat.logInfo, 1000)` is the same as `let func = myCat.logInfo; setTimeout(func, 1000)`
  - `this` refers to the global / window object
- **method invocation** : when a function is invoked on an object directly (as a 'method')
  - function execution *with* the use of a property accessor (of an object) e.g., `obj.myFunc()`
  - `this` refers to the receiver (calling object)

- **constructor invocation** : when a function execution is preceeded by `new` keyword
  - this is *not* a method or function invocation
  - `this` refers to the newly created object

- **indirect invocation** : when `call` or `apply` are used to invoke a function (execution context will be the first argument supplied)


- beware of re-assignment vs mutating objects : if objects are *re-assigned*, a new object is created.
  - Old references to a prior object will remain since a new object is created
  ```javascript
  let animal = { name: 'Tiger' };
  let zoo = { cage1: animal };
  animal = { name: 'Panda' };  // note the re-assignment
  zoo.cage2 = animal;

  console.log(zoo.cage1 === animal); // false - the old object 'Tiger' is still assigned to `cage1`
  console.log(zoo.cage2 === animal); // true
  ```

### Organizing code into appropriate objects
- **collaborator objects** (or "collaborators") : objects used to store state within another object
  - can be custom objects or built-in objects (like arrays, dates, simple objects, and/or primitives)
- object oriented programming
  - a programming pattern that uses objects as the basic building blocks of a program, instead of local variables or functions
  - **group related data and code together within objects**
  - structure objects according to their relationships to each other
  - group associated behaviours together with the data
  - don't expose complexity globally, keep it hidden within objects
  - useful when more than 1 instance of things are required
  - are increasingly useful as codebase size increases


### Object factories
- **object factory** : a function that returns an object, used specifically for creating objects (with a common structure)




## Function execution context (setting / determining `this`)
- **execution context** : an object accessible through the keyword `this` every time a JS function is invoked (executed)
  - `this` will vary depending on how the function is invoked (e.g., function invocation vs method invocation; implicit vs explicit execution context)
  - a context object is *bound* to a function **when you execute the function, not when you define it**
  - Note: execution context is *different* than scope
        - execution context depends on where / how a function is executed
        - (function / variable) scope depends on syntax and lexical context
  - execution context does not *propogate* to nested functions / scopes
  ```javascript
  let obj = {
    a: 'hello',
    b: 'world',
    foo() {
      function bar() {
        console.log(this.a + ' ' + this.b);
      }

      bar();
    },
  };

  obj.foo();        // => undefined undefined
  ```

- using `bind` is both explicit (and the time of binding) and implicit (since the returned function will be executed without 
explicit context being passed in)
  - `bind` will not alter the original function (it returns a new one)
  - note: once `bind` has been used, the execution context (of the returned function) can no longer be changed later 


### Implicit function execution context
- **implicit execution context** : an execution context that JS sets 'implicitly' (i.e., the developer does not define it explicitly)
  - for function execution, it is the global object (`window` in browser, or `global` in Node)
    - in strict mode it will be `undefined`
  - for method execution, it is the calling object


### Explicit function execution context
- **explicit execution context** : an execution context that you (the developer) explicitly sets; in JS using `call` (using **c**omma-separated arguments) or `apply` (using **a**rray arguments)


### Dealing w/ context loss
- common solutions:
  1. supply a 'context' argument (e.g., `thisArg` in `Array.prototype.forEach`)
  2. hard-binding (with `bind`) (use a function expression if chaining bind to a function declaration)
  3. preserve context with a local variable (e.g., `let self = this`)
  4. use an arrow function (automatically use the current value of `this` in the calling function)

### Lexical scope
- "lexical" refers to structure of surrounding code without regard for execution state
- arrow functions do *not* get their context lexically (execution state still matters)
  - arrow functions do not have their own `this`;  `this` lookup happens in the same way as regular variable search via the outer lexical environment (https://javascript.info/arrow-functions)

- from personal experiments on `this` and arrow functions:
  - arrow functions share the same `this` as any outer functions in which they are defined (i.e., nested)
    - they share the `this` of outer functions, and only functions - not plain objects
  - if they are part of the global context, `this` can only be the global execution context
  - you cannot explicitly change the `this` of arrow functions (e.g., using `call`, `apply`, or `bind`)
  - if an arrow function is returned by an outer function, execution context will still depend on the execution context of that outer function.  Depending on how the arrow function is invoked, the execution context of the outer function may or may not change

```javascript
// LS example of `this` changing for arrow functions
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
obj2.foo();                   // This is obj2 - note context for arrow function depends on execution / invocation

// personal examples - showing how arrow is invoked will affect execution context
let obj4 = {
  a: 'obj4',
  func() {
    let arrow = () => console.log(this, this.a);
    return arrow;
  },
}
obj4.func()(); // obj4  :  execution context of `func` is `obj4`

let obj5 = {
  a: 'obj5',
  func: obj4.func(), // `arrow` is assigned directly to `obj5.func`
};
obj5.func(); // obj4  :  execution context of `obj4.func` didn't change

let obj6 = {
  a: 'obj6',
  func: obj4.func,
}
obj6.func()(); // obj6  :  execution context of `obj4.func` is now `obj6`
```



## Scope and Closures
- variable scope:  the part of the program that can access that variable by name;  how and where a language finds and retrieves values from previously declared variables
  - variables are looked up using lexical scoping
  - functions create a new inner scope;  code within an inner scope can access any variables in the same or surrounding scope
  - blocks also create a new inner scope

- (only) functions form closures (not objects)
  - e.g., function declaration, function expression, assigning functions to properties
- **closure** : when functions *close over* or *enclose* the lexical environment at their definition point, thus retaining access to (only) the variables (and most current values) required at the time of execution
  - closures use scope
  - only variables required will be part of the closure
  - closures are private data : it is impossible to access the value of variables in closures other than through the provided code


### Higher-order functions
- **higher-order functions** : are functions that
  1. can accept a function as an argument,
  2. return a function when invoked,
  3. or both

- first-class functions vs higher-order functions
  - first-class functions: when a language treats functions as values (i.e., functions can be assigned to variables, passed around, used in control structures, etc.)
    - this is a specific property of programming languages (not a specific language)
  - higher-order functions: functions that "work" on other functions
    - a general concept that also applies to mathematics


### Creating and using private data
- use closures to store private data; use returned functions to access / modify that private data
  - any variables in the closure will only be accessible via the defined methods
  - to access that data differently may require altering the original code (e.g., you can prevent "monkey patching" depending on how you define the original code)


### Garbage collection
- **garbage collection** (GC) : a process of "automatically" freeing up (deallocate, unclaim, or release) memory allocated to unused values
- GC only applies to non-primitive values;  primitives are not subject to GC
  - whether or not GC takes place with strings are bigInts is an implementation detail that may change among different implementations of JS
  - (non-primitive) values are eligible for GC when they are no longer needed (referenced) / accessible
    - variables can go "out-of-scope" and still be referenced through closures, arrays, objects, etc.
  - modern JS implementations use *mark-and-sweep* algorithm to determine what to GC (eliminates the referency cycle problem)
  - GC can occur at any time; typically at periodic intervals during a program's lifetime
  - in modern JS, the programming has no control over GC

- stack: sequential memory;  generally primitives (fixed size) are stored here since required memory can be calculated during hoisting (creation phase)
- heap: "random access" memory - values here require a pointer (stored in the stack) to be accessed

- memory allocation in programming languages (may be "invisible" to the developer):
  - *claim* memory to be used by a variable
  - *test* (verify) memory allocation
  - *copy* desired value into claimed memory
  - *use* value (now stored in memory)
  - *release* memory (when unneeded)

### IIFEs

### Partial Function Application




## Object Creation Patterns

### Constructor functions

### Prototype objects

### Behaviour delegation

### OLOO and Pseudo-Classical patterns

### `class` syntax




## Modules



# Study Questions
- [ ] https://web.archive.org/web/20180209163541/https://dmitripavlutin.com/gentle-explanation-of-this-in-javascript/
      - 7.2 example (walkPeriod): can the execution context of `format` be changed, similar to LS example https://launchschool.com/lessons/c9200ad2/assignments/f68a9f7f where `this` changes for arrow function?
      - see 7.1 : "An arrow function is bound with the lexical context once and forever. `this` cannot be modified..."
      - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions#cannot_be_used_as_methods
        - arrow functions as 'auto-bound' methods - equivalent to `this.method = this.method.bind(this)`
      - also see js225/practice/04this.js > behaviour of arrow functions seems different depending on lexical context, but I can't seem to find any 'rules'
      