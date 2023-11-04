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
- also called "Factory Object Creation Pattern"

- disadvantages:
  - every object has a full copy of all the methods and properties, which can be redundant
  - there is no way to inspect an instance object and know whether it was created from a factory function (i.e., identify "type" or "class")




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

- in node:
  - 'main' execution context is `module.exports`
    - `this` in the main scope will be `module.exports`
    - `module.exports` is the default 'global' scope for `this`
  - 'global' execution context is `global`
    - undeclared variables end up in `global` no matter where this occurs


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

#### arrow functions and `this`
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
  - closures let a function access any variable that was in scope when the function was defined
  - closures use scope
  - only variables required will be part of the closure
  - closures are private data : it is impossible to access the value of variables in closures other than through the provided code

- closures also help to organize code into data and associated behaviour that relies on that data (similar to objects)

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
- GC only applies to non-primitive values;  **primitives are not subject to GC**
  - whether or not GC takes place with strings are bigInts is an implementation detail that may change among different implementations of JS
  - (non-primitive) values are eligible for GC when they are no longer needed (referenced) / accessible
    - variables can go "out-of-scope" and still be referenced through closures, arrays, objects, etc.
  - modern JS implementations use *mark-and-sweep* algorithm to determine what to GC (eliminates the referency cycle problem)
  - GC can occur at any time; typically at periodic intervals during a program's lifetime
  - in modern JS, the programmer has no control over GC

- the **"JS runtime"** handles GC

- stack: sequential memory;  generally primitives (fixed size) are stored here since required memory can be calculated during hoisting (creation phase)
- heap: "random access" memory - values here require a pointer (stored in the stack) to be accessed

- memory allocation in programming languages (may be "invisible" to the developer):
  - *claim* memory to be used by a variable
  - *test* (verify) memory allocation
  - *copy* desired value into claimed memory
  - *use* value (now stored in memory)
  - *release* memory (when unneeded)

- when assessing GC in JS - beware:
  - any values declared / assigned and used *within* a function are required until that function stops execution (not eligible for GC within that function)
  - remember:  **primitives are not eligible for GC**

### IIFEs
- **immediately invoked function expression** (IIFE) : a function that is defined and invoked simultaneously
  - involves a pair of parentheses around a function expression, then followed by another set of parentheses at the end to invoke that function
  - initial parentheses tell JS to evaluate what is inside as an expression (i.e., a function expression returns a function), thus, it can be invoked immediately
- 2 styles of syntax:
```javascript
(function (){ console.log("hello"); })();  // style 1
(function (){ console.log("hello"); }());  // style 2 : invoking `()` inside outer `()`
```
- pre-ES6: IIFEs were the best way to create a new scope (with variables) that was entirely separate from global scope
  - with `let` and `const`, can just create that new scope using a block (i.e., `{ // code here }`) (using `var` within a block would not contain the variable scope)

- IIFE can be used to define private data / methods
  - e.g., an object can be "converted" to an IIFE which returns an object accessing private data (which prevents direct access to the properties, which is possible in an object)



### Partial Function Application
- **partial function application** : returning a function that can call a 3rd function with some of its arguments already supplied
  - partial function application must *reduce* the number of arguments required to invoke that 3rd function by supplying those arguments in advance
- closures are used in partial function application to retain the arguments passed to the initial generating function (which returns another function)
- can also use `bind` (with `null` as execution context) for partial function execution (`bind` returns a new function with some of the arguments already supplied)



## Object Creation Patterns
- see also Object factories ("Factory Object Creation Pattern")
  - note: object factory functions also create "instances" of a fixed type, even if there's no way to determine the type
- "Constructor Pattern" : using constructor functions with `new`
- "Prototype Pattern"  : defining shared behaviours on prototypes (constructor's `prototype` property)
- pseudo-classical : using constructors and prototypes
- OLOO : using `Object.create` from "prototype objects"


### Constructor functions
- part of "Constructor Pattern" (also called "Prototype Pattern" in LS notes)
- constructor functions are intended to be called with the `new` operator
  - invoking constructor functions without `new` will create properties on the global object

- `new` - executes the following actions:
  - a new object is created (with `[[Prototype]]` set to `ConstructorFct.prototype`)
  - `this` is set to point to the new object
  - code in the function is executed
  - `this` is returned if the constructor doesn't explicitly return an object
    - if you *don't* want an object of the constructor type to be returned, need to **return an object**

- the *function prototype* (i.e., `.prototype` object) of the constructor function is the *object prototype* of instantiated objects (i.e., `[[Prototype]]` of the new object)

- the `.constructor` property of an instance object points to the constructor function
  - e.g., `newObj.constructor = ConstructionFct`
  - you can use `.constructor` to determine the type ("class") of an object **if** that property hasn't been re-assigned / is properly assigned
  - `instanceOf` will always work

#### Static properties and methods
- **static properties** : properties defined and accessed directly on the constructor (function) and *not* a specific instance
properties can be
- **static methods** : methods defined and accessed directly on the constructor (function) and *not* a specific instance

- define these directly onto the constructor
```javascript
function Dog(name, breed) {
  this.name = name;
  this.breed = breed;
  Dog.allDogs.push(this);
}
Dog.species = 'Canis lupus'; // static property
Dog.allDogs = []; // static property
Dog.showSpecies = function() { // static method
  console.log(Dog.species);
};

Dog.showSpecies(); // invokes static method
```

### Prototype objects
- **prototype object** : the object referenced by the (hidden) `[[Prototype]]` property of an object
      - a deprecated version of this is `__proto__` (non-hidden)
  - this object is part of the prototype chain that is checked when JS looks for a property (incl. methods) on an object
    - prototype chain lookup happens at the time of execution
        - i.e., you can define a method on the prototype after the object is instantiated, but it can still be later invoked since lookup happens on invocation (not at instantiation)
  - can be interacted with using `Object.getPrototypeOf` / `Object.setPrototypeOf()` / `.isPrototypeOf()`


- objects created via object literal notation have `Object.prototype` as their `[[Prototype]]`
  - the `[[Prototype]]` of `Object.prototype` is `null` (i.e., `Object.getPrototypeOf(Object.prototype) === null`)

- `obj1.isPrototypeOf(obj2)` will indicate if `obj1` is *anywhere in the prototype chain* of `obj2`

- using `Object.create` to set prototype at object creation is a good pattern and well supported
- using `setPrototypeOf` *prior* to object creation (i.e., for setting object prototype) is okay
  - using this dynamically may disrupt JS engines and cause de-optimized behaviour
- using `class` syntax may be best - can also define private methods (no obvious way to do this without `class` syntax)



### Behaviour delegation
- **behavior delegation** : the term given to the design pattern where an "upstream" (parent) object in the prototype chain handles behaviours (i.e., method requests) associated with the current object (enabled by prototypal inheritance in JS)

- use `Object.getOwnPropertyNames` (returns array of "own" properties)
- use `obj.hasOwnProperty('propName')` (returns `true` if `obj` has a property `propName`)
- generally `Object.prototype.toString()` should be overridden in custom objects to create a more descriptive string output (i.e, other than `[object Object]`)


### OLOO and Pseudo-Classical patterns

#### Pseudo-Classical
- combines constructor pattern and prototype pattern

- declare a constructor that initializes states (data) within each object
- define methods on the `prototype` (to reduce duplication)

- can check type using `instanceof`

- if creating a longer prototype chain, it may be better to set prototype using `Object.setPrototypeOf` vs `Object.create`:
  - from MDN: there are limited performance impacts from using `setPrototypeOf` if no instances have been created yet
    - if using `Object.create`, this will reset the `constructor`
        - need to re-set the constructor of the prototype to point to the constructor function


#### OLOO
- "Object Linking to Other Objects" (OLOO)

- create "prototype" objects with the desired behaviours and a constructor function
  - must make sure to `return this` in constructor, especially if chaining (otherwise, no object exists)
- use `Object.create` to create new objects
  - chain invocation of the constructor

- check type using `isPrototypeOf`


### `class` syntax
- similar to use of constructor functions (i.e., syntax is most similar to that of a function, *not* an object)
  - define properties in `constructor` function using `this.propName = ... `
  - no `,` between method declarations
  - all code in `class` declaration executes in strict mode
  - class declarations are *not* hoisted (the name of the class is hoisted similar to `let` and `const`, i.e., into the Temporal Dead Zone [TDZ])
  - the `prototype` object cannot be re-assigned
  - can't use `Object.setPrototype` to give the object a different prototype

- can use "class expression" or "class declaration" (similar to functions) - there is no difference between class expression or class declaration
- define static methods or properties by prepending keyword `static` on the declaration

- create instances using the `new` keyword

- use `extends` for subclasses
  - e.g., `let Student = class extends Person { ... };`


### My summary notes
- *functions* have `.prototype` property (an *object*)
    - this references an *object* : `FunctionName.prototype` which has a `.constructor` property (points to a function)

   instance object                       prototype object               constructor function
[instance : `[[Prototype]]`] > [object : `FunctionName.prototype`] < [         : `prototype`    ]
                               [         `constructor`           ] > [function : `FunctionName` ]
                               [         `[[Prototype]]`         ]   [           `[[Prototype]]`] > [`Function.prototype`]
                                             V
                                          `Object.prototype`

- constructors are *functions*
- constructors (*functions*) MAKE *objects*

### Misc notes (from videos)
- http://www.objectplayground.com/
- JS functions have `prototype` property;  this is distinct from `[[Prototype]]` (or `__proto__`)

- **CRITICAL** : when you create a *function* in JS (e.g., `myFunction`)
  - a "function object" is created with `prototype` property pointing to a ('prototype') *object*:
    - called `myFunction.prototype`
      - whose `[[Prototype]]` is `Object.prototype`
      - with `constructor` pointing to the original function (e.g., `myFunction`)
- every function you create is a bit like a "do-nothing class" (it can be a constructor if you want it to be)
  - hence the distinction to use capitals to indicate constructor functions
```javascript
function Answer() {}
Answer.prototype // is an *object*
Answer.prototype.constructor === Answer // the constructor of Answer.prototype is the original constructor function
Object.getPrototypeOf(Answer.prototype) === Object.prototype // a "plain" object with `Object` properties
  // note: `Object.getPrototypeOf(Object.prototype) === null`
  // note:  `Object.prototype` has a property 'constructor'
```

- `[[Prototype]]`:
  - of myObject : `Object.prototype`
  - of myFunction : `Function.prototype`
  - of `Object.prototype` : `null`
  - of `Function.prototype` : `Object.prototype`

- can create objects with no prototype by using `Object.create(null)`

#### prototypal inheritance
- declare a **prototype object** (w/ constructor and methods)
  - use `Object.create(PrototypeObject)`
  - invoke the constructor on the new object

- basic structure
  - using `Object.create(ParentObj)` returns a new object with the `[[Prototype]]` set to `ParentObj`
    - typically "prototype objects" (use for creating other objects) are capitalized
    - if desired, need to manually define `.constructor` property
  - when looking for methods, it will first search the current object
  - if it doesn't find it in current object, it will search in `[[Prototype]]` object
  - if it doesn't find it, it will continue searching up the prototype chain
- to call a method from somewhere up the chain (but reference values in the current object)
  - use `parentObj.methodName.call(this)` : executes a different method, using the current (object) context

- instantiating objects:
  1. create the object: extend the prototype (which has the methods) ("class")
  2. initialize the data ("instance")

- to create sub-classes
  - need to run `Object.create` on a child object (not the parent object)
  - if you want to instantiate directly from a child 'constructor' object, need to manually set prototype of child to be parent
  - or could create the subclass prototype object using `Object.create(ParentObj)` and then modify *that* object directly (can't re-assign it to a new object using object literal notation or prototype will be reset)


- properties that are private are often denoted with `_` prefix (e.g., `this._value` indicates a private property that is set through a "constructor" or "initialization" function, rather than directly)

#### classical inheritance (JS)
- declare a **constructor function** (that defines data)
- declare methods on `ConstructorFunction.prototype.myFunction = //... code here`
      - `.prototype` object is automatically created by JS, `constructor` property is automatically pointing to constructor function (i.e., same as for all functions)
  - use `new` keyword to instantiate
      - automatically invokes constructor on new object (since `constructor` property on `.prototype` object points to the constructor function)
      - automatically uses `.prototype` object as prototype (e.g., `ConstructorFunction.prototype`)

- define a constructor function (a prototype is automatically created)
  - if necessary, create a *new object* where `[[Prototype]]` points to the parent prototype object
  - need to manually set the `constructor` property (of this new object) to point back to the constructor function
- use `new` keyword with constructor function to create a new instance

- to create sub-classes:
  - create a new constructor function
      - invoke the parent constructor function (using `.call(this, ...)` as required)
  - set `NewConstructorFct.prototype = Object.create(OldConstructorFct.prototype)`
      - then set `NewConstructorFct.prototype.constructor = NewConstructorFct` 

#### `class` syntax
- declare a `class` with constructor and methods (can use `extends`)
    - no 'commas' between methods (e.g., similar to a function)
    - no need to define methods on the `.prototype`
  - use `new` keyword to instantiate (same as classical inheritance)

- if using `extends`:
  - don't need to manually create a linked prototype object to parent for sub-class
  - don't need to manually set `.constructor` to the sub-class constructor function


#### instanceof
- e.g., `lifeAnswer instanceof Answer`:
  - JS will compare if `[[Prototype]]` of `lifeAnswer` === `Answer.prototype`
    - note:  the different 'prototypes' being compared
    - JS will search up the prototype chain of `[[Prototype]]` which can result in a match


## Modules

### benefits
- splitting up code makes it easier to understand: more lines of code is more difficult to understand
- large single-file programs tend to lose cohesion (i.e., parts of code become tangled and dependent on other parts)
- working on a long program is difficult (may need to look at several different sections of a longer codebase concurrently - involves jumping around)
- if you are working with a team, it becomes difficult to work concurrently (e.g., may have to manually resolve conflicts)
- not everyone encapsulates effectively - it can be difficult to encapsulate parts of large programs
- modules are easy to share between programs (can clearly define what is public - exported; vs not)

### how to use and create CommonJS modules
- may need to first install the module using npm
- use `require` (e.g., `const readline = require('readline-sync');`)

### how CommonJS modules pass exported items to the importing module
- to create a module, explicitly add things to `module.exports`
  - e.g., `module.exports = function logIt(string) { console.log(string); };`
  - `module.exports` is an object: can use object destructuring to export / require

### notes on CommonJS modules
- CommonJS modules are loaded synchronously
- these modules are not supported by the browser (can be transpiled using Babel to work)
- CommonJS modules can work well for Node
- `__dirname` : contains the absolute pathname of the directory that contains the module
- `__filename` : contains the absolute pathname of the file that contains the module

### JS Modules
- use `import` statement
  - e.g., `import { bar } from './bar'` : imports an non-default export
  - e.g., `import { bar as newNameBar } from './bar`
  - e.g., `import * as FooModule from './foo'`
  - e.g., `import qux from './utils'` : imports an default export with name `qux`
  - e.g., `import { otherStuff, moreStuff } from './utils'` : also imports named exports from same file
- use `export` keyword to indicate what will be exported in the module (and thus what can be imported)
  - can use `export` multiple times in a module
  - called "named" exports
- can use `export default` once per file
- in Node, need to name JS modules with `.mjs` extension OR add `"type: "module"` to the `package.json` file





## Additional references
- talks about prototype vs class-based: https://alistapart.com/article/prototypal-object-oriented-programming-using-javascript/
- Video about JS prototypal vs classical inheritance:  http://www.objectplayground.com/



# Study Questions
- [ ] https://web.archive.org/web/20180209163541/https://dmitripavlutin.com/gentle-explanation-of-this-in-javascript/
      - 7.2 example (walkPeriod): can the execution context of `format` be changed, similar to LS example https://launchschool.com/lessons/c9200ad2/assignments/f68a9f7f where `this` changes for arrow function?
      - see 7.1 : "An arrow function is bound with the lexical context once and forever. `this` cannot be modified..."
      - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions#cannot_be_used_as_methods
        - arrow functions as 'auto-bound' methods - equivalent to `this.method = this.method.bind(this)`
      - also see js225/practice/04this.js > behaviour of arrow functions seems different depending on lexical context, but I can't seem to find any 'rules'
      