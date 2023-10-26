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

- when a method is called on an object, JS binds `this` to the object whose method you used to call it
  - if that method can't be found in that object (`hasOwnProperty`), it will look up the prototype chain
    - but `this` *doesn't* change (`this` always refers to the original object)



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


## Memory allocation / Garbage Collection
- generally speaking, GC is de-allocating memory
  - in JS, allocation of memory is a separate process that is part of creation phase

- to remove a closure and 'de-reference' values to free them for GC
  - assign any variabls referencing that value to `null` - this will 'de-reference' the prior value and free it for GC

- in languages that do not have Garbage Collection (GC), in order to assign values to variables:
  - claim memory
  - test for successful allocation of memory
  - copy required values into memory
  - use required values (in memory)
  - release memory
  ```javascript
  // fictional representation
  let name = claim(5);   // Claim 5 bytes of memory for use by name
  if (memoryNotAllocated(name)) {
    throw new Error("Memory allocation error!");
  }

  copy(name, "Sarah");  // Copies "Sarah" into claimed memory referenced by name
  console.log(name);    // Do something with object referenced by name
  release(name);        // Release memory for use by others
  ```


- simple model of GC (assumes all values participate in GC):
  - as long as an object / variable remains 'accessible' JS can't / won't GC
    - note that multiple copies of primitives will be formed (as required) if assigned, re-assigned, etc.
      - typically only 1 version of objects is formed (objects can be assigned by reference)
    - copies that are not required are removed by GC

- more advanced model:
  - most languages divide memory into 'stack' and 'heap'
    - generally items on stack are fixed size (size can be predetermined)
    - items on heap will have different sizes (that can't be predetermined)
  
  - *primitive values don't get involved in GC when they are stored on the stack*
    - memory is assigned on the stack during creation phase of execution, after execution, memory is released
      - this process is *similar to* GC, but is considered distinct
      - when a block / function begins executing, JS calculates and assigns memory required on stack based upon variables declared and fixed item sizes
      - some primitive values are not stored on stack (since they aren't fixed size), e.g., string, bigint;  however, they act like they are on the stack, and we can consider them to be on the stack
  
  - JS stores most primitive values and references (pointers to actual values) to objects on the stack
    - everything else on the heap
  
  - on the heap, must decide when a value can be GC
    - could use a value's reference count, i.e., when it reaches 0 it can be garbage collected (*not* when a variable goes out of scope, i.e., closures, arrays, objects may make a value relevant, even if out-of-scope)
      - reference count is when a value is relied on by other variables, etc.
    - GC generally occurs at regular intervals during a program's lifetime, generally no control over this
    - modern JS engines use "mark and sweep" algorithm (when an object is unreachable) to do GC, this eliminates the "reference cycle" problem (2 objects both reference each other and thus are never GC)
      - this can introduce memory fragmenting which makes it difficult to allocate large chunks of memory

  - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management



## IIFEs
- **IIFE** (Immediately Invoked Function Expressions):  a function that is defined and invoked simultaneously
  - a function expression (wrapped with brackets) is followed by another set of `()` to immediately invoke it
  - invoking `()` can be inside or outside wrapping brackets:
    ```javascript
    (function(a) {
      return a + 1;
    })(2); // 3
    // OR
    (function(a) {
      return a + 1;
    }(2)); // 3
    ```
  - surrounding brackets are not required if the function definition / expression doesn't occur at the start of the line
  ```javascript
  let foo = function() {
    return function() {
      return 10;
    }();
  }();

  console.log(foo);       // => 10
  ```
  - IIFEs are helpful for creating a defined scope and private variables that cannot interfere with global scope
    - example: studentIds can be protected and a function exists to produce them consistently
    ```javascript
    let generateStudentId = (function() {
      let studentId = 0;

      return function() {
        studentId += 1;
        return studentId;
      };
    })();
    ```

## Closures
- closures are created when a function is DEFINED, and allow the function to retain access to the variables it needs from its outer scope

## Factory functions
- disadvantages to using object factory functions:
  - each object owns the same methods, which can be redundant (a separate copy of the method is typically created for each instance)
  - no way to know which function created which object after the object has been created

- factory functions create *instances* of objects with a common type, even if there is no way to test the type in code



## Constructor pattern
- create a (constructor) function (capitalized to indicate it should be called with `new` operator)
  - call `new` on the constructor function
  - calling a constructor function without `new` creates properties on the global object

- the `new` operator:
  - creates a new object
  - sets `this` to point to the new object
  - executes the code in the constructor function
  - returns `this` if the constructor doesn't explicitly return an object
    - to NOT return an object of the constructor type, need to return a DIFFERENT object (e.g., object literal)


## Prototypes
- all JS objects have a hidden property `[[Prototype]]`
  - retrieve and set this property using `Object.getPrototypeOf` and `Object.setPrototypeOf` methods
    - NOTE:  using `setPrototypeOf` is a slow operation - better to use `Object.create` which automatically sets prototypes, rather than manually setting prototypes using `Object.setPrototypeOf(newObj, parentObj)`
  - use `.isPrototypeOf` to check if a given object is a prototype (e.g., `oldObj.isPrototypeOf(newObj)`)
    - this will search the entire prototype chain
    - `Object.prototype` object is at the end of the prototype chain for all JS objects
      - objects created using object literal notation have `Object.prototype` as the `[[Prototype]]`
  - using `Object.create` sets `[[Prototype]]` of the created object to the passed in Object
    - `let newObj = Object.create(oldObj)` : `oldObj` is the *prototype object* of `newObj`
                                           : `newObj` was created using `oldObj` as its prototype

- `__proto__` ('dunder proto') : a deprecated, non-hidden version of `[[Prototype]]` property
  - only use this to support very old browsers, old versions of Node, or as quick shortcuts when debugging

- **Prototypal inheritance** : the sharing of methods (or data) between objects via the prototype chain.
  - objects are created directly from other objects and methods / data are shared
  - also called *behaviour delegation* : objects on the bottom of the chain delegate requests to upstream objects to be handled
  - behaviours defined locally will override shared behaviours
  - sharing behaviours on the constructor's `prototype` property is also called the **prototype pattern** of object creation
  ```javascript
  let Dog = function() {};

  Dog.prototype.say = function() {
    console.log(this.name + ' says Woof!');
  }

  Dog.prototype.run = function() {
    console.log(this.name + ' runs away.');
  }

  let fido = new Dog();
  fido.name = 'Fido';
  fido.say();             // => Fido says Woof!
  fido.run();             // => Fido runs away.

  let spot = new Dog();
  spot.name = 'Spot';
  spot.say();             // => Spot says Woof!
  spot.run();             // => Spot runs away.
  ```


- object properties can exist anywhere along the prototype chain
  - to check an object itself for properties, use `hasOwnProperty` (e.g., `myObj.hasOwnProperty(someProperty)`)
  - can also use `Object.getOwnPropertyNames(myObj)` : returns an array of 'own' property names
  - using `Object.getPrototypeOf` on `[Object: null prototype]` returns `null` - the top of the prototype chain (no more prototypes)
  - can create [Object: null prototype] using `Object.create(null)`
    - this is NOT the same object as the actual `[Object: null prototype]` on individual objects


- `Object.prototype.toString()`
- `Object.prototype.isPrototypeOf(obj)`
- `Object.prototype.hasOwnProperty(prop)`

- `Object.getOwnPropertyNames()`



- use `instanceof` (note lowercase 'o') : e.g., `this instanceof User` will return `true` if `this` is set to an instance of `User` (e.g., using `new` keyword to invoke constructor function) vs `false` if `this` is set to a window/global object if constructor is invoked without `new`

- any method defined in any prototype along the prototype chain is considered to be an *instance method* of the object



## Function prototype
- constructor (function) : a function intended to be invoked with `new`

- **function prototype** : the name given to the *value* (an object) of the `prototype` property for most functions (used as constructors). 
  - the `prototype` property is typically used when a function is invoked as a constructor with `new`, but rarely useful otherwise
  - if the constructor is `Foo`, the constructor's prototype object will be stored in `Foo.prototype`
  - the function prototype (constructor's prototype object) is used by the constructor as the object prototype for the objects it creates

- **object prototype** : the *name of the reference* (an object) given to new objects created with the `new` keyword. 
  - the object from which a new object inherits is the object prototype;  a new object will inherit from the object prototype (an object)
  - by default, constructor functions set the object prototype for new objects to the constructor's prototype object (the constructor function's prototype)

- notes:
  - most non-function objects do not have a `prototype` property
  - the `constructor` property on a function's `prototype` object points back to the function itself by default
    - the `constructor` property can be used to create a new instance of the same type of object produced by the original constructor function
  - arrow functions are a special case of function - also do not have a `prototype` property
    - you cannot call an arrow function with the `new` keyword

  - every object (including functions) have a `[[Prototype]]` property - this references an OBJECT to look up properties not owned by the original object
  - only functions have a `prototype` property - used to share properties among objects returned by the function when invoked as a constructor
    - for `function Foo() {}`, `Object.getPrototypeOf(Foo) === Function.prototype; // true` and `Foo.prototype.constructor === Foo; // true`

- once an object is instantiated, the methods on that instance can be **overridden** by defining a custom method of the same name on that object directly

- ways to set a prototype of a new object:
  - use `Object.setPrototypeOf(newObj, parentObj)` (can be slow)
  - set the `prototype` property of a constructor function and create that object (better)
  - use `let newObj = Object.create(parentObj)` (less good for building inheritance chains since this reassigns `property` and removes `constructor` which can be more error-prone.  Also, there are limited performance gains if constructors have not yet created any instances)

- all objects inherit from `Object.prototype` - methods added to `Object.prototype` will be accessible by *any* object


- https://medium.com/@patel.aneeesh/a-shallow-dive-into-the-constructor-property-in-javascript-b0a89747058b
  - when objects are created using object literal syntax, their `[[Prototype]]` references `Object.prototype`
    - the constructor for object literals is the same as the constructor for `Object.prototype`
      i.e., `Object.prototype.constructor === myObj.constructor` (where `myObj` is a basic object declared using object literal syntax)
  - the constructor for `Object` is Function
    i.e., `Object.constructor === Function.constructor`
  - objects do not have (their own) `.prototype` or `.constructor` property;  functions have a `.prototype` and `.constructor` property

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain
- https://karistobias.medium.com/part-2-the-javascript-pseudo-classical-pattern-explained-with-pictures-70dfda6c6351
- https://medium.com/launch-school/javascript-design-patterns-building-a-mental-model-68c2d4356538



## Static
- **static properties** : are properties defined and accessed directly on the constructor
  - i.e., these would be common to ALL instances of the constructor (would not vary for specific instances)
  - e.g., could keep a list of all instances as a static property (e.g., an array)

- **static methods** : are methods defined and invoked directly on the constructor
  - e.g., `Object.assign` is a static method


## Best practice for creating objects in JS

### Pseudo-classical pattern
- create a constructor function to define instance *properties*
  - e.g., `let Point = function(x = 0, y = 0) { this.x = x; this.y = y; }`
- define instances *methods* on the prototype
  - e.g., `Point.prototype.onAxis = function () { // etc. };`

### OLOO
- **Object Linking to Other Object**
- define an object (capitalized) with an `init` method (a convention) to set initial instance properties, include all methods
  - e.g. 
  ```javascript
  let Point = {
    x: 0,  // default value
    y: 0,  // default value
    onXAxis() {

    },
    init(x, y) {
      this.x = x;
      this.y = y;
    }
  };
  ```
- use `Object.create()`
  - e.g., `let pointA = Object.create(Point).init(30, 40);` (where 30, 40 are initial x, y values)


### Class keyword
- define a "class" with constructor method, include methods within the class definition
  - there are no commas between properties / methods
  - classes are also first-class 'citizens' : can be passed into a function, returned from a function, assigned to a variable
  - all code in class executes in strict mode
  - class declarations are *not* hoisted like function declarations
  - class 'variables' (name of the class) *is* hoisted, but is similar to `let` and `const` and declarations remain in the Temporal Dead Zone until formally intialized
  - the `prototype` *cannot* be re-assigned (either directly or using `Object.setPrototypeOf`)
- 'invoke' the class using `new` (same as Pseudo-classical pattern)
  - a class *must* be invoked with `new`
- logging a class in Node returns `[class Rectangle]`, but logging a constructor function returns `[Function: Rectangle]`
- 2 versions of syntax:
```javascript
// Class declaration
class Rectangle {
  constructor(length, width) {
    this.length = length;
    this.width = width;
  }

  getArea() {
    return this.length * this.width;
  }
}

let rec = new Rectangle(10, 5);
console.log(typeof Rectangle);         // function
console.log(rec instanceof Rectangle); // true
console.log(rec.constructor);          // [class Rectangle]
console.log(rec.getArea());            // 50
// OR
// Class expression
let Rectangle = class {  // note "anonymous" class (similar to function expressions)
  constructor(length, width) {
    this.length = length;
    this.width = width;
  }

  static getDescription() {
    return 'a rectangle is a shape with 4 sides';
  }

  getArea() {
    return this.length * this.width;
  }
};

```

- can use `extends` to add a class to the prototype chain
```javascript
class Square extends Rectangle {
  constructor(size) {
    super(size, size);
  }

  toString() {
    return `[Square] ${this.width * this.length}`;
  }
}
```

### Coding patterns
- **NOT** monkey patching (i.e., adding methods directly only existing object types, like `Array`)
  - instead:  create a new class that inherits from `Array` and add to that - will have access to `Array` methods from inheritance change
  ```javascript
  Object.getPrototypeOf([]) === Array.prototype;    // true - shown to illustrate the prototype of `Array` objects

  function NewArray() {} // creation of constructor function
  NewArray.prototype = Object.create(Object.getPrototypeOf([])); // set prototype of new object to existing Array object prototype

  // add new method to new object type
  NewArray.prototype.first = function() {
    return this[0];
  };

  let newArr = new NewArray();  // note:  will be an 'array-like' object with access to Array instance methods
  // newArr cannot be an actual Array object, otherwise it will not be able to access methods on `newArr`
  let oldArr = new Array();

  // using the new object type
  oldArr.push(5);
  newArr.push(5);
  oldArr.push(2);
  newArr.push(2);
  console.log(newArr.first());           // => 5
  console.log(oldArr.first);             // => undefined
  ```


- `Object.defineProperties(myObj, { myProp: { value: myValue, writable: false, } } )` : create properties that cannot be changed (i.e., `writable : false`)

- `Object.freeze(myObj)` : will prevent 'ownProperties' from being changed
  - note: nested objects will not be frozen unless explicitly defined, however, references to those objects cannot be changed
  - once frozen, objects cannot be unfrozen



## Modules
- there are 2 module systems:
  - **CommonJS modules** (also known as "Node modules")
    - initially available with Node, but are synchronous - unsuitable for use in a browser
  - **JS modules** (also known as "ES modules" or "ECMAScript modules")
    - must use a transpiler (e.g., Babel) to emulate these modules with older versions of Node

### Benefits
- modules allow you to split a large program in multiple files
  - each module focuses on a specific problem
  - different developers can work on different files without fear of conflicts
  - different modules are less likely to get "tangled" through multiple enhancements and bug fixes
  - modules are easier to work with private data and help maintain encapsulation (must explicitly export items available outside the module)
  - easy to re-use modules in other areas / programs



### How to use and create (CommonJS modules)
- need to 'require' (similar to 'import') code in a program
  `const someVar = require('myModuleName.cjs')`
  - can import multiple items using object destructuring (if multiple objects are exported)
    e.g., `const { myFunction1, myFunction2 } = require('./myModuleName.cjs');`
- the code to import needs a specific export:
  `module.exports = myModuleName;`
  - exported names become available
  - export multiple items within an object
- modules *not* installed by NPM typically require a full path to the file (e.g., `./myModuleName`)
  - modules installed by NPM generally do not need `./`

- `module` : an object that represents the current 'module' (program file)
- `exports` : an object containing exported objects
- `require` : a function that loads a module
- `__dirname` : absolute pathname of directory that contains the module
- `__filename` : absolute pathname of file that contains the module

- private variables (those not exported) are still available within the module and will still store 'state', etc.

### How CommonJS modules pass exported items to the importing module

### JS Modules
- uses the keywords `export` and `import`
- Webpack helps to consolidate modules into a single file

- put `export` before any declarations (e.g., function, variable, etc.)
  - anything without an `export` is local / private to the module
  - also need to put a `package.json` file in directory:
  ```
  {
    "type": "module"
  }
  ```
  OR
  - can name all extensions with `mjs` (e.g., `myModule.mjs`)
- can also use `export default myFunctionName;` 
  - there can only be 1 default export per module

- `import { myFunction, myVariable } from './myModule.mjs`;
- can also rename:  `import { foo as renamedFoo } from './myModule.mjs'`
- or use *namespace import*:  `import * as FooModule from './myModule.mjs'`
- for default exports, don't need curly braces:  `import newNameForModule from './bar.mjs'`




# Things to review
- [X] : Mutability of objects, Problem 4 and 5:  https://launchschool.com/lessons/4671d66f/assignments/9695cfa4
- [X] : could do further exploration (deep equality): https://launchschool.com/exercises/1937fc28
- [X] : review context, problem 5:  https://launchschool.com/lessons/c9200ad2/assignments/84fbe7cb
- [ ] : defining this, problem 2, 4(try all methods):  https://launchschool.com/lessons/c9200ad2/assignments/7bef6908
- [ ] : could review GC, problem 1: https://launchschool.com/lessons/0b371359/assignments/c19c9fbf
- [ ] : review GC, problem 1:  https://launchschool.com/lessons/0b371359/assignments/d5156138
- [ ] : https://launchschool.com/exercises/f7659085
- [ ] : https://launchschool.com/exercises/19cc5636
- [ ] : https://launchschool.com/exercises/2726c8c6
- [ ] : null prototypes, problem 1:  https://launchschool.com/lessons/24a4613a/assignments/b158be5a
- [ ] : global scope vs variables; node vs browser : problem 1:  https://launchschool.com/lessons/24a4613a/assignments/2d53f659
- [ ] : prototype objects : problem 5:  https://launchschool.com/lessons/24a4613a/assignments/2d53f659
- [ ] : constructors and inheritance : see my solution to Problem 7:  https://launchschool.com/lessons/24a4613a/assignments/2d53f659
        - Why would the constructor for an inherited object be the SAME as the constructor for the object?
        - likely because the constructor property is INHERITED for object literal objects anyway - either way, we're looking up the prototype chain to get that constructor
- [ ] : constructors, problem 1, 5: https://launchschool.com/lessons/24a4613a/assignments/cbb1afa7
- [ ] : pseudo-classical:  https://launchschool.com/exercises/c32e20ee
- [ ] : ** private data in instances:  https://launchschool.com/exercises/6abaca87  (check user-submitted solutions!)
        - use `WeakMap`?
- [ ] : review 'private methods for constructor functions' : need to confirm when methods are private or not private
        - e.g., LS solution vs my solution for https://launchschool.com/exercises/d6d3971a
        - e.g., can use class syntax with `#` to indicate private methods






