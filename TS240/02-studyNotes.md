# TS249 study notes

- **type safety** : ensuring that variables are assigned a specific data type when they are declared to prevent unanticipated behaviour from occurring
  - helps prevent bugs in code that could lead to errors or security vulnerabilities
  - JS is a dynamically-typed language - types are more flexible (e.g., variables of the wrong type can be passed to methods / functions, etc.), which can lead to bugs and mask typos which only reveal themselves at runtime

## The differences between build time and runtime
- build-time (or "compile-time") occurs when TypeScript code is converted to JavaScript
  - type errors (syntax errors, typos) are identified by the compiler and can be corrected before the code is actually executed
  - code is "compiled" by running a TS command line tool: `tsc`
    - warnings or errors in the TS code will be output and a `.js` file will be produced

- runtime occurs when the JavaScript code is actually being executed
  - examples can be null pointer exceptions, out-of-bound array accesses, type mismatches, accessing non-existant properties on objects, type mismatches, etc.


## Primitive and complex types

### Primitive types
- most common:  `string`, `number`, `boolean`
  - `undefined`, `null`
  - `bigint`, `symbol`

### Simple types
- literal types
  - e.g., `let color: 'red' | 'blue' | 'green';`  (string literal)
  - e.g., `let five: 5 = 5;`  (number literal)
  - e.g., `let hasName: true = true;` (boolean literal)

- `object` type : has no information about any properties of the object (will lead to errors when accessing properties)


### Complex types (non-primitive types, have properties)
- are created by combining "simple" types (anything)

- arrays: `Array<>` or ` []`
- tuples: a fixed length array
    - e.g., `[string, number, boolean]`
- `any`
- `void` : cannot be used with or assigned to any other data type
  - prevents the accidental use of a return value
  - e.g., `const elements: number[] = [1, 2, 3].forEach(el => console.log(el * 2));`

- type unions : use `|` operator
  - are used to create more flexible and reusable code
  - e.g., `type Status = 'success' | 'warning' | 'error';`
  ```typescript
  type Dog = { breed: string; age: number };
  type Cat = { breed: string; age: number; whiskerLength: number };

  type Pet = Dog | Cat;
  ```
  - e.g., an API response may be of the form `string | string[]`
  - e.g., event handlers may be type: `type MyEventHandler = (event: MouseEvent | SubmitEvent | HoverEvent) => void;`

- function signature:
  - defines the type of parameters and return value of a function
  - used for **function overloads** to provide specific function signatures correlating input function parameters to output function return values
  - e.g., `function getLengthOfArray(value: string[]): number;` ("overload function signature")
  - e.g., `function getLengthOfArray(value: string): string;`   ("overload function signature")
  - e.g., `function getLengthOfArray(value: string[] | string): number | string` ("implementation signature")


## Typing an object's properties
- involves defining the "shape" of objects
- **shape** (of an object) : the structure of an object's properties and their types

```typescript
// with type alias
type Person = {
  readonly name: string;
  age: number;
};
const john: Person = {name: 'john', age: 78};

// with literal object
const jane: { name: string, age: number } = {name: 'jane', age: 35};
```
- `readonly` prevents changes to that property after initial assignment
- `readonlyArray` prevents mutation of an array and use of methods `push`, `pop`, `shift`

- can use `keyof SomeType` to reference only valid defined keys of `SomeType` (e.g., string literals)


## Special types: any, unknown, and never

### any
- a special type of TS that represents any possible value
  - `any` is assignable to every type (except `never`), and all types are assignable to `any`
  - use of `any` effectively "turns off" type-checking for a given value or assignment
- is implicitly assigned by TS to parameters without type annotations
- generally not desired, since it does not help with type-safety
  - increases likelihood of bugs (i.e., will not prevent errors that TS is designed to catch)
  - if used, should be used to with type guards to narrow types
  - typically used when working with 3rd party libraries where type definitions are not available (or incomplete)
    - when migrating from JS to TS gradually (prevents the need to add type annotations to entire codebase)


### unknown
- a safer alternative to `any` introduced in TS 3.0 which requires type-checking be implemented before an `unknown` value is re-assigned or actioned
  - `unknown` is not assignable to any other type; all types are assignable to `unknown`
  - a property on `unknown` cannot be accessed unless the type is appropriately narrowed

- if type assertions are used with unknown variable types, it's best to still initially assign type `unknown` as a signal to other developers, and enable stricter type checking


### never
- a type used by TS that represents a state that shouldn't exist
- `never` is assignable to every type, but *no type* is assignable to `never`
- can be used as an **exhaustive check** : ensuring that all possible types have been considered within a function
  - e.g., `const _exhaustiveCheck: never = myVarToCheck;`  (assign the variable you are checking to a `never` variable, this this line gets executed, there will be a compile error)


- as a return type, indicates "you can never return from a function" (i.e., you are throwing an error)
  ```typescript
  function assertNever(value: never): never {
    throw new Error(`Unhandled value: ${value}`);
  }
  ```



## Typing function parameters and return values
```typescript
function add(a: number, b?: number, c:number = 3) : number {
  // function implementation
}
```
- use of a type alias: `type AddFunction = (a: number, b?: number, c:number) => number;`
  ```typescript
  function add: AddFunction = (a, b, c) => {
    // function implementation
  }
  ```
- optional parameters must be assigned `undefined` if there are other parameters identified after them

- return type `void` is common for functions that don't return a value

- e.g., can use different syntax to type functions:
```typescript
function identity<T>(arg: T): T {
  return arg;
}

let identityCopy1: <I>(inp: I) => I = identity; // generic function declaration
let identifyCopy2: { <T>(arg: T): T } = identity; // object literal type signature

interface GenericIdentityFn {
  <T>(arg: T): T,
}
let identityCopy3: GenericIdentityFn = identity; // use of interface

// note variation on syntax creates a *non-generic* function signature that is part of a generic type
interface GenericIdentityFn2<T> {
  (arg: T): T,
}
let identity2: GenericIdentityFn2<number> = identity;
```



### Function overloads
- **function overloads** : the use of multiple function signatures for the same function, each with different parameter and return types
  - helps to correlate specific input parameter types with corresponding output parameter types
  - **should be used with caution** : can create incorrect data types within code (see example below)

  - there must be at least 2 overload signatures for a function definition
  - overload function signatures must be compatible with implementation signatures:
      - each overload parameter must have a corresponding implementation parameter
      - each overload parameter type must be assignable to implementation parameter type
      - each overload return type must be assignable to implementation return type
  - Note:  TS will not validate that implementation for each signature is correct
      - i.e,. you can return any valid return type for any valid parameter type in the implementation signature
      ```typescript
      function getLengthOfArray(value: string[]): number; // function signature 1
      function getLengthOfArray(value: string): string;   // function signature 2
      function getLengthOfArray(value: string | string[]): number | string {
        if (Array.isArray(value)) {
          return value.toString(); // incorrectly implemented for function signature 1, but matches implementation signature
        } else {
          return "Not an array!";
        }
      }

      const numberResult: number = getLengthOfArray(["a", "b", "c"]); // no error
      console.log(numberResult); // "a,b,c"
      ```




## Structural typing and assignment
- **structural typing** : types are considered equivalent if they have the same shape (i.e., same properties and the same types)

- **assignable** : type A is assignable to type B if type A possesses at least the same members (properties and property types) as type B
  - type A can have additional properties (i.e., type A is "narrower", type B is "wider");
  - assignability of a variable is always checked against the declared type (or earliest inferred type based on declaration) (https://www.typescriptlang.org/docs/handbook/2/narrowing.html)


- **narrow type**: a type that is more specific and represents a smaller set of possible values
- **wide type**: a type that is more general and represents a larger set of possible values

- Note:  "narrow" / "wide" refers to possible **type** values,  *not* object properties / members (since more properties should be assignable to types with less properties)





## Interfaces
- an alternative to defining type aliases (i.e., using `type = {}`)

```typescript
interface Address {
  street: string,
  city: string,
  state: string,
  zip: number,
}
```

### type alias vs interface
- types:
  - can be used for all types: primitives, objects, tuples, literals, etc.
  - must be used for unions, complex types
  - are considered "closed" (once declared, canot be re-declared elsewhere)
  - uses `&` for type intersections
    - these will *NOT* raise an error if incompatible types are intersected
    ```typescript
    type A = { id: string };
    type Aplus = A & { id: number }; // no error, but `id` will now be type `never` since no intersection exists
    ```

- interfaces
  - can only be used for objects (and are generally preferred for reasons below)
  - uses `extends`; better communicates hierarchy between base type and new type
    - interfaces can extend types
  - are considered "open" (i.e., are subject to "declaration merging")
  - **declaration merging** : when additional declaration(s) for the same named interface exist, all declarations are merged together into a single declaration that merges all of the originals
    - any incompatible declarations will raise an error



## Type assertions
- forcing / overriding the TS compiler's type checking to treat a value as a given type using `as`
  - commonly used when working with the DOM
  - TS type inference may not be effective;  we may know more about a type than is defined in TS

- *type inference* : when TS infers the data type of a variable based on its initial value and its static analysis of the code paths, including structure of the code and the context in which a value is used
  - e.g., `let name = 'Jane';`
  - more common when working with primitive types and function return types
  - Note:  TS does not infer types of parameters, they are instead assigned type `any`

- *explicit typing* : when the type of a variable has been defined through annotations
  - e.g., `let name: string = 'hello';`
  - more common when working with complex objects, function parameters, class properties
  


## Type widening and narrowing
- a narrow type is more specific and represents a smaller set of possible values
- a wide type is more general and represents a larger set of possible values
  - see also "Structural type and assignment" above

- **narrowing** : the process of refining a value from a larger set of possible types to a smaller set of possible types;
  - ultimately, may define the *specific* (exact) type of a variable of a wider type, so that it can be assigned or interacted with as a narrower type
  - e.g., a variable of type `string | boolean` is narrowed to a `string` type

### Narrowing Methods

- **type guard**:
  - use `typeof` : e.g., `if (typeof myUnion === 'string') ...` (standard JS, only returns primitives)
  - use `in` : e.g., `if ('breed' in pet) ...` where `'breed'` is a property which helps distinguish the type of variable `pet`
  - use truthiness (to eliminate `null` or `undefined`) : e.g., `if (circle) ...`, where `circle` is an optional parameter
  - use `instanceof` : e.g., `if (shape instanceof Circle) ...`, where `Circle` is a class and shape may be an instance
  - use `Array.isArray()` : e.g., `if (Array.isArray(myVar)) ...`, where `myVar` is a type that could be an array

- **type predicates** :
  - a function whose return value is `true` or `false` and explicitly identifies the return as being a particular type (i.e, the return statement includes `is` keyword)

  ```typescript
  function isCircle(shape: Shape): shape is Circle {
    return "radius" in shape;
  }
  ```

- **short-circuiting**
  - using the behaviour of the logical operators `&&` and `||` (where the second operand is only evaluated if the first operand does not determine a result)

  - e.g., `'opacity' in shape && console.log(shape.opacity)` : where 'opacity' is a property only present in some `shape` variables


- **control flow-based type analysis**
  - TS will evaluate `if/else` and `switch` statements to determine what types may or may not exist within each branch


- **discriminated unions**
  - a union type where each member type contains a *discriminant property* to differentiate between the various member types
    - best practice involves exhaustiveness checking to ensure all types in union are addressed

  - common uses of discriminated unions
    - representing variants of a data structure
    - modeling workflows or processes (e.g., states within the process)
    - error handling (e.g., define a specific type for a result, another for an error using a generic)
      ```typescript
      type Result<T, E> =
        | { status: "success"; value: T }
        | { status: "failure"; error: E };

      function divide(
        numerator: number,
        denominator: number
      ): Result<number, string> {
        if (denominator === 0) {
          return { status: "failure", error: "Division by zero" };
        }
        return { status: "success", value: numerator / denominator };
      }
      ```
  ```typescript
  type Circle = {
    kind: "circle"; // This is the discriminant property (of type string ,typically lowercase of type alias)
    radius: number;
  };


  type Square = {
    kind: "square"; // This is the discriminant property
    sideLength: number;
  };


  type Shape = Circle | Square; // the discriminated union
  ```



## Index signatures
- are used when you don't know the names of a type's properties, but you know the shape of the values
  - only `string`, `number`, `symbol` are allowed for template string patterns

```typescript
interface StringArray {
  [index: number]: string;  // note that 'index' is any string  (like a variable name) to identify "properties"
}
```

## Utility types
- `Pick<SourceType, 'propName'>`, where `SourceType` is an object type with a named keys and corresponding value types : will select only `propName` to be included in the new type
- `Omit<SourceType, 'propName'>`, as above : will select all properties except `propName` to be included in the new type

```typescript
// implementation of Pick in TS
type Pick<T, K extends keyof T> = { // use of mapped types (advanced concept)
  [P in K]: T[P];
};
```

- `ReturnType<typeof myFunction>`, where `myFunction` is a defined function with parameters and return types defined
  - returns a new type that matches the return type of `myFunction`
- `Parameters<myFunctionType>`, where `myFunctionType` is a function signature
  - or `Parameters<typeof myFunction>`
  - returns a new type that matches the parameter type(s) of `myFunction`
- `Partial<SourceType>`, where `SourceType` is an object type with a named properties
  - returns a new type where all properties are optional
- `Record<keyType, valueType>` : maps key types to value types


## Generics
- the use of a type "variable" (or "placeholder") to allow the creation of functions / components that can work with a variety of types, rather than a single type

### Generic Functions
- e.g., a function that returns a type based upon an input type
- e.g., `function identity<T>(arg: T): T {}`
    - can be invoked without specifying `T` (TS will use *type argument inference* to infer type);  may not be able to do this with more complex types
  - type variable `T` will be treated as any and all types : to use specific methods / properties, need to narrow type


### Generic Objects
- an object for which a particular property can be defined with a generic type
- arrays are a type of pre-defined generic object (i.e., `Array<number>`, `number[]` is syntactic sugar)

```typescript
type Car<T> = {
  model: T;
  year: T;
};

const car1: Car<string> = {
  model: "Mustang",
  year: "2021",
};

const car2: Car<number> = {
  model: 3,
  year: 2021,
};

const car3: Car<string> = {
  model: "Accord",
  year: 2021, // Type 'number' is not assignable to type 'string'.(2322)
  // The expected type comes from property 'year' which is declared here on type 'Car<string>'
};
```



## Updating or extending types
- types:
  - use `&` for type intersections

- interfaces:
  - use `extends` for "subclasses" (i.e., a class that inherits the methods and properties of the parent)



## Misc
- **type unsoundness** : when the type system fails to prevent type errors, resulting in runtime errors
  - this can lead to unexpected bugs and behaviours
  - this occrs since TS was designed to work with existing web technologies, including JS which may not have perfect "type soundness"

- `implements` : used to ensure that a class satisifies a particular interface

```typescript
interface Animal {
  name: string;
  makeNoise(): string;
}

class Dog implements Animal {
  name: string;

  constructor(name: string) {
    this.name = name;
  }

  makeNoise(): string {
    return `${this.name} says Woof!`;
  }
}

const fido = new Dog("Fido");
console.log(fido.makeNoise()); // Outputs: "Fido says Woof!"
```

- catch all errors as type `unknown` and validate if `e instanceof Error`
- using "Omit" with non-existent properties does NOT raise an error


### Notes from study sessions
- type deferment? real term? (from Will)
  - use of "backup error" to throw after typescript error

- if you combine types:  declaration merging (when using interfaces)
  - if you combine incorrectly? interfaces will raise an error
  - types are "closed"
  - interfaces are limited to "objects"
    - use types for primitives and functions (literals) - available to everything

- check errors in types and interfaces - they throw different errors
  - type intersections: doesn't throw errors for inconsistent type assignments
  - interface extends will give you a clear error when types are inconsistent in declaration merging

