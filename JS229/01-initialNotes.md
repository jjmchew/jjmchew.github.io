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
   