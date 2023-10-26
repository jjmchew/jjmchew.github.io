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

- arrow functions preserve the `this` of their execution 'context'
  - they will use the `this` of their lexical context:
    - if defined in the global scope, the execution context of global scope cannot change
    - if defined in another function, the execution context of that function can change (and thus `this` will also change for the arrow function)


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
obj2.foo();                   // This is obj2 - note context for arrow function depends on execution / invocation
```



## Scope and Closures

### Higher-order functions

### Creating and using private data

### Garbage collection

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
      