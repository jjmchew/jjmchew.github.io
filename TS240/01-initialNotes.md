# TS240 Intro to TypeScript
- Reference:  https://www.typescriptlang.org/docs/handbook/2/basic-types.html

## Background

- **dynamically typed languages** :
  - variables are not assigned a specific data type when declared
  - variable type is determined at runtime based on the type of value assigned
  - can be more flexible and easier to write
  - may be prone to type-related errors that are not caught until runtime

- **statically typed language** :
  - each variable must be assigned a specific data type when it is declared
  - functions must specific the type of value they return
  - provide *type safety*
  - helps catch errors at compile-time instead of runtime
  - can make code easier to read and maintain

- TypeScript (TS) : compile-time errors are caught during the process of converting TS code to JS code
  - adds type safety (security, reliability) to flexibility and ease of use of JavaScript
- JavaScript (JS) : an interpreted language (does not go through a compilation process like TS), runtime errors cannot be caught until code is actually executed

## Intro to TS
- developed by a team of Microsoft engineers (led by someone responsible for creating C#) in response to criticism that JS was not a good choice for large / serious applications since dynamic typing made runtime errors common and difficult to detect
- benefits:
  - better quality code: catch errors before runtime, bugs are less likely, code more likely maintainable
  - code scalability: by making data types explicit, its easier to maintain and refactor large codebases
  - better collaboration: easier to read and understand other people's code

- drawbacks:
  - can be slower to add type annotations, especially for complex types
  - additional compile step : can add complexity and time
  - reduced flexibility : static types can sometimes make code less flexible
  - 3rd party libraries : not all libraries have type definitions, or type definitions may have errors

- TS vs JS:
  - small, simple, independent projects may be faster/easier in JS
  - rapid prototyping may be better in JS
  - depending on libraries used, JS may be better than TS
  - quick scripts / small tasks : JS likely better
  - otherwise, TS is a sensible default for most JS projects

- TS is compiled at *build time* to JS (by developer, specific version of JS can be decided)
  - the JS is then "compiled" (interpreted) and run by a web browser (or node)

  - TS can catch errors before JS code is deployed; can transpile TS code to any platform that supports JS
  - JS will only catch errors at runtime

- TS Language Service
  - "language service" is a background service that provides additional TS features while editing code (e.g., within VSCode)
  - code completion: can suggest completion code completions based upon current context
  - signature help: can display tooltips with parameters and return types of functions
  - error checking: real-time detection of potential errors
  - renaming variables or functions: can suggest or perform renaming

- TS is a superset of JS
  - any valid JS will be valid TS, but TS is not necessarily JS
  - after TS compile, all TS annotations will be removed to create JS code


## Using TS (for a project)
- `npm init -y`  :  create a new project
- `npm install typescript --save-dev`  :  installs typescript for dev for project in current folder
- create `tsconfig.json`:
  ```json
  {
    "compilerOptions": {
      "target": "ES2015",       // ES6
      "module": "commonjs",
      "strict": true,           // enables broader type-checking
      "outDir": "./dist",       // compiled files go to folder 'dist'
      "esModuleInterop": true,
      "skipLibCheck": true,
      "forceConsistentCasingInFileNames": true,
      "noUncheckedIndexedAccess": true  // indexed access to arrays returns type union with `undefined` which must be explicitly checked
    },
    "include": ["./src/**/*"],  // run TSC against all files in src directory
    "$schema": "https://json.schemastore.org/tsconfig",
    "display": "Recommended"
  }
  ```
- create folder `src` for TS code (common convention)
- `npx tsc` : runs TS compiler (from local `node_modules` package)

## Common Types
- don't use capitalized types (these are special built-in types)

- `string`
- `number` : can be any numeric format (e.g., integer, float, hex, binary, octal, etc.)
- `boolean`
- `null` : intentional absence of a value
- `undefined` : an uninitialized variable
- e.g., `number[]` (array) OR `Array<number>` (equivalent)
- `any` (indicates no type-checking)
- `unknown`
- `object` : used for non-primitives
    - typically not that useful (provides no info on properties available in an object)
    - a custom-defined index signature is better for objects with properties (properties can be logged)
      - to do anything with properties, need to narrow type first
    ```typescript
    interface CustomObject {
      [key: string]: unknown;
    }
    ```
- `void` : a type that represents the absence of a value; typically used as return type for functions that don't return a value
- e.g., `let nyName: string = 'Alice';`
- e.g., `function getNum(): number {}`  (indicates `getNum` returns a number)
- e.g., `Promise<number>` (indicates a Promise that returns a number)
- e.g., `obj: { first: string; last?: string }` : indicates an object type with property `first` and optional property `last`
    - optional properties (e.g., `last`) will be stated type or `undefined`
- e.g., `id: number | string` : union type, `id` can be a `number` or `string`
- e.g., `type BooleanFunction = () => boolean[]` : defines a type alias for a function that returns an array of booleans

- e.g., defines a "type alias" (type "definition")
  ```typeScript
  type Point = {
    x: number;
    y: number;
  };
  ```
  - "type" vs "interface" : an interface is extendable; type cannot be changed after being created

- type assertion, defines the specific type a variable will be
  - e.g., `const myCanvas = document.getElementById("main_canvas") as HTMLCanvasElement`
  - e.g., `const myCanvas = <HTMLCanvasElement>document.getElementById("main_canvas")`  (equivalent syntax)

  - type assertions should be used with caution

- e.g., `x!.toFixed()` : indicates that `x` will NOT be `null` or `undefined`
- e.g., `x?.toLowerCae()` : indicates that `x` MAY be a string (e.g., with union types)

- arrays:
  - e.g., `let numbers: Array<number> = [1, 2, 3, 4, 5]`
  - `let myNum: number = numbers[5]` : will not return an error unless `"noUncheckedIndexedAccess" : true` is in `tsconfig.json`
  - since arrays in JS are not bounded, TS has no way of knowing how many elements are in an array and if a value exists at a given index

- tuples:
  - a collection of values stored in a specific order, with a fixed length
  - TS provides support for tuples (JS does not)
  - TS will raise an error for access to out-of-bounds indexes with tuples
  - since TS tuples are implemented as JS arrays, `push()` and `pop()` will still work (i.e., not raise errors), but this can lead to unexpected bugs

- TS contains type definitions for built-in JS functions (e.g., `.map`, `.toString()`)

- literal types: when specific values are defined that a variable can have
  - e.g., `let color: 'red' | 'blue' | 'green' = 'red';`
  - e.g., `let five: 5 = 5;` : variable `five` can only have value `5`;  `five++` will raise a compilation error
  - e.g., `let hasName: true = true` : `hasName` can only have value `true` (boolean literal)

- e.g., `type Operation = 'add' | 'subtract' | 'multiply' | 'divide';` : type definition

- **readonly** types
  - e.g.,
  ```typescript
  interface Config {
    readonly apiUrl: string;  // once value is defined, this property cannot later be changed, will raise compile error if attempted
    debugMode: boolean;
  }
  ```
  - Notes:
    - if the `readonly` property is an object, that object can be *mutated*, even though it can't be re-assigned
    - to make it immutable:
      - make properties of object `readonly` properties 
      - OR assign the properties using `Object.freeze({ prop1: "value", prop2: "value2" })` (now properties cannot be changed)

- `ReadonlyArray`:
  - a specific type of array that can't be mutated (no reassigning elements, or use of `push`, `pop`, `shift`)
  - e.g., `let hobbies: ReadonlyArray<string> = ['reading', 'running']`
    - `hobbies[1] = 'movies'` will raise a compile-error;  `hobbies.push('eating')` will raise a compile-error
  - cannot assign a `ReadonlyArray` to an `Array` (but a regular array can be assigned to a `ReadonlyArray`)



## Type vs Syntax errors

- **type inference**:
  - a TS feature where the compiler automatically deduces the types of variables, function parameters, function return values when they are not explicitly specified
  - TS cannot infer type of parameters - it will assign `any` to un-typed parameters
  - TS is *not* good at inferring complex data types, DOM types, or 3rd party libraries - explicit typing is usually required in these cases
  - implicit typing is usually sufficient with primitive values and function return types


- explicit typing:
  - provides "documentation" for variables, functions, objects helping make code easier to read/understand
  - good when working with a number of developers;  compiler can help catch downstream errors


- **type error**:
  - when code violates the type rules of the language
  - i.e., TS is statically typed, which means variables have a defined type at compile time
    - assigning a variable of the wrong type will result in a compilation error
  - e.g., analogy of using the wrong measurements and ingredients in a recipe

- **syntax error**:
  - when the language itself is incorrect
  - e.g., analogy of grammatical errors in a recipe



## Type Aliases
- for functions, can create a type alias and then assign it to a function definition
  - can only be used with arrow functions or function expressions

```typescript
type GreetFunction = (name?: string) => string;

const greet: GreetFunction = (name) => {
  return name ? `Hello, ${name}!` : `Hello, World!`;
};

greet(); // Hello World!
greet("Catherine"); // Hello, Catherine!
greet(8); // Argument of type 'number' is not assignable to parameter of type 'string'.
```

## Object types
- the **shape** of an object:
  - refers to the structure of properties and their types (i.e., names and types of properties)

- can use **literal object type** (i.e., an object type defined "inline")
  - e.g., `function processObject(obj: {name: string; value: number}) {}`

- can also use a type alias (type definition):
  - e.g., 
  ```typescript
  type Person = {
    name: string,
    age: number,
  };
  const person: Person = {name: 'John', age: 40};
  ```


## Structural typing
- structural typing is where the compiler compares two types by looking the properties and types of properties (not the names of the types)
  - i.e., `type Student = {name: string, age: number}` is the same as `type Engineer = {name: string, age: number}`
  - a type `Student` can be assigned to `Engineer` as long as `Student` has at least the same members and properties as `Engineer`
  - Note:  if an object with additional properties is assigned to another type with *less* properties, those extra properties will not be accessible in the new type (according to TS compiler)
  - Note:  when using literal object type annotations, extra properties *cannot* be added - TS will raise a compile-time error


## Working with Classes
```typescript
class Point {
  x: number; // can define type of instance properties
  y: number;

  constructor(x: number = 0, y: number = 0) {  // constructor should never have a return type (will be an instance of class)
    this.x = x;                                // parameters can / should be typed
    this.y = y;
  }

  onXAxis(): boolean {  // return type of method is defined
    return this.y === 0;
  }

  onYAxis(): boolean {
    return this.x === 0;
  }

  distanceToOrigin(): number {
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }
}
```
- can use `implements` keyword (from TS) and an interface to describe properties and methods
  - e.g.,
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

  const fido = new Dog('Fido');
  console.log(fido.makeNoise()); // outputs 'Fido says Woof!'
  ```
- note that `extends` is "overloaded" :  it is used in JS (for classes) *and* also in TS (for extending interfaces)

- `private` keyword (TS) was added before `#` in JS (ES2020)
  - either can be used, but *not together*
  - `private` will add overhead and is only a compile-time restriction, may make code harder to test
    - each instance of the class will create it's own copy of the private field
  - `#` is a true private method/property


- using the keyword `public` automatically creates properties with the same names / types
```typescript
class Person {
  constructor(public name:L string, public age: number) {}
}

// is equivalent to
class Person {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}
```


## Union types
- **narrow type** : a type that is more specific and represents a smaller set of possible values
- **wide type** : a type that is more general and represents a larger set of possible values

- in general: you cannot assign a wider type to a narrow type
- when using union types, generally need to check the specific type of the variable before acting on it (unless actions can be performed on both types)
  - e.g., `if (typeof unionVar === 'string') // etc.`  note:  typeof only works with JS types (not type aliases in TS)

- can use `in` operator (from JS) for type guards
  - e.g., `if ('whiskerLength' in someVar) //etc` : will check for `whiskerLength` property in `someVar` (assuming it's an object)


## Function overloads
- additional valid "function signatures" can be provided prior to an "implementation signature"
  - each function signature must be a valid subset of the implementation signature
  - **warning** : TS will not validate that each function signature has been implemented appropriately
    - it only checks that overload signatures match implementation signature AND that implementation return match implementation signature definitions
```typescript
function getLengthOfArray(value: string[]): number;  // overload function signature
function getLengthOfArray(value: string): string;    // overload function signature
function getLengthOfArray(value: string | string[]): number | string {   // implementation signature
  if (Array.isArray(value)) {
    return value.toString(); // no error - TS doesn't check that return is a number since function returns `number | string`
  } else {
    return "Not an array!";
  }
}

const numberResult: number = getLengthOfArray(["a", "b", "c"]);
console.log(numberResult); // "a,b,c" (should be a number, but no error is raised)
```


## Generics
- **generic type** can be thought of as a kind of variable that works for types, instead of variables
```typescript
function first<T>(arr: T[]): T {
  return arr[0];
}

let numArray = [1, 2, 3, 4, 5];
let strArray = ["a", "b", "c", "d", "e"];

let firstNum = first<number>(numArray); // Type of firstNum is number
let firstStr = first<string>(strArray); // Type of firstStr is string

// can also use type inference:
let firstNum = first(numArray); // Type of firstNum is inferred as number
```


- **generic objects**
```typescript
type User<T1, T2> = {
  name: string;
  age: T1; // type of `age` can be defined when object is created
  id: T2;  
}

const user1: User<number, string> = { name: 'John', age: 32, id: 'a23-232' };
const user2: User<string, number> = { name: 'Jane', age: 'thirty' , id: 222938 };
```


- **generic arrays**
  - e.g., `const numbers: Array<number> = [1, 2, 3];`
  - e.g., `const numbers: number[] = [1, 2, 3];`



## Narrowing
- the process of refining a value from a larger set of possible types to a smaller set of types (or single type)

- TS uses "control flow analysis" to understand if types are being narrowed through conditional `if/else` or `switch` statements
  - can use `in` : e.g., `if ('radius' in shape) // etc.`
  - can use `typeof` : e.g., `if (typeof value === 'string') // etc.` :  note only primitive JS types will be returned
  - can use "truthiness" : e.g., `if (circle) // etc.` (would remove `undefined` from possible type options)
  - can use `instanceof` : e.g., `if (shape instanceof Circle) // etc`

  - can use type predicate (special function)
  - can use short circuiting : e.g., `'opacity' in shape && console.log('this shape has opacity ', shape.opacity)`
  - can use discriminated unions : i.e., a common property between types used to identify the type


- **predicate**:  a function that takes 1 items as input and returns true or false based on whether that function satisfies some condition

- **type predicate**
  - a function which returns true or false to indicate whether a object belongs to a specific type
  - return type of this function must include `param is [some type]`
  - can be used as a custom "type guard"
  - note: TS cannot validate that the logic within the function is correct

  ```typescript
  function isFish(pet: Fish | Bird): pet is Fish {
    return (pet as Fish).swim !== undefined;
  }

  // another example
  function isCircle(shape: Shape): shape is Circle {
    return 'radius' in shape;
  }
  ```

- **discriminated union** : union types where each type within the union has a common *discriminant property* which helps to identify the specific type an object may belong to
  - e.g., `type Circle = { kind: 'circle'; radius: number}` and `type Square = { kind: 'square'; sideLength: number}`
    - property `kind` is the discriminant property and can be used for narrowing
  - typically a `switch` statement is used on that property to define specific actions for each type
  - these are helpful for:
    - distinguishing variants of a similar structure
    - modelling workflows or processes (i.e., each state can have a distinct 'status')
    - error handling : as above, define distinct status states for 'success' or 'failure'

  - using `in` is better when there is no discriminant property available
  - all you care about is a specific property within a wide range of types
      - e.g., `email` property could be part of `Student`, `Store`, `Employee` types

## Exhaustiveness Check
- a feature of many typed languages that helps guarantee all possible cases have been handled 
  - e.g., in discriminated unions, ensure that all possible shape types have been addressed using `switch` statements
- in TS:  use the `never` type
  - any type assigned to `never` will raise a compile error
```typescript
// Shape definitions above

type Shape = Circle | Square | Triangle;

function describeShape(shape: Shape) {
  let area: number;

  switch (shape.kind) {
    case "circle":
      area = Math.PI * shape.radius ** 2;
      break;
    case "square":
      area = shape.sideLength ** 2;
      break;
    default:
      const _exhaustiveCheck: never = shape;
      // Type 'Triangle' is not assignable to type 'never'.
      throw new Error(`Invalid shape: ${JSON.stringify(_exhaustiveCheck)}`); // additional safeguard to identify error at runtime
  }

  console.log("The area is " + area);
}
```


## Any
- use of type `any` essentially turns off type-checking for anything related to that variable / function / etc.
- this can cascade throughout a code base (i.e., type `any` variables can be assigned to any other type, passed to functions, etc.)
- this is likely to prevent compile errors, but will result in runtime errors
- using `any` may be good for:
  - working with 3rd party libraries, especially when no type definitions are available
    - use type guards to narrow `any` types to expected types
  - an initial step when migrating a JS codebase to TS


## Type unsoundness
- **type unsoundness** : occurs when the type system (e.g., TS) fails to prevent type errors, resulting in runtime errors
- may be caused by:
  - use of `any` (and assignment of variables with type `any` to specific types - this won't be checked because of `any`)
  - use of `as` (type assertions)
    - e.g., 
    ```typescript
    let x: any = "Launchschool";
    const y: number = x as number;  // this assertion will allow a string to be assigned to a number type variable
    ```
  - indexed access of arrays
    - TS allows assignment of index array element to type string since arrays can be unbounded in JS (no way of knowing whether element exists)
    ```typescript
    const names: string[] = ["John", "Jane"];
    const name: string = names[2];
    name; // undefined
    ```


## Unknown
- type `unknown` is a safer alternative to `any` (introduced in TS v3.0)
- `unknown` types:
  - cannot be assigned to any other type
  - properties on this type cannot be accessed
  - must be narrowed to more specific types with type guards to re-assign or use these types
  - accessing properties or using the `unknown` objects is likely to require rigourous type guards / type predicates

- general best practice if type assertions are used:
  - use `unknown` type to initially indicate that objects come from external sources and may be uncertain
  - initially declaring type as `unknown` allows TS to enforce type checks and validations which would not be present if the variable was initially asserted to be a specific type;  this helps to prevent runtime errors
  - best to do initial basic validations on unknown type, then make assertions

- type validations can be managed using external libraries:  e.g., io-ts, runtypes, zod

## Declaration Merging
- only works for **interfaces**
- if an interface is defined more than once, TS will merge all definitions into a single definition containing all the properties/methods
  - if any of the properties/methods conflict, an error will be raised
  - also works for imported interfaces (e.g., `import {Mammal} from './animals'` where `interface Mammal { name: string; legs: number; }`)
- an error "Duplicate identifier" will be raised if this is attempted with type aliases


## Extending interfaces
- e.g., `interface Elephant extends Mammal {}` where `Mammal` is a previously-defined interface
  - `Elephant` will take all properties/methods of `Mammal` and additional properties/methods can be defined
- e.g., `interface Elephant extends Mammal, Tusked {}` where `Mammal` is a previously-defined interface, `Tusked` is a previously defined type alias OR interface
- cannot use `extends` to create a type alias (i.e., `type Walrus extends Tusked {}` will NOT work)
- an error will be raised if any methods/properties conflict (i.e., are not assignable from child to parent)
  - need to make parent wider, or child narrower to accommodate

- `extends` is also used for **generic constraints** (i.e., ensuring that any type passed in possesses a specific property)
```typescript
function describeItem<T extends { age: number }>(item: T) { // all types 'T' must (at minimum) have property `age` as `number`
  if (item.age < 10) {
    console.log(
      `This item is ${item.age} years old. It's still got that fresh style!`
    );
  } else if (item.age < 100) {
    console.log(
      `This item is ${item.age} years old, giving it that touch of character!`
    );
  } else {
    console.log(
      `Wow! This item is ${item.age} years old. This is a true antique, with a history that speaks volumes!`
    );
  }
}
```



## Type intersections
- analogous to extending interfaces
- uses the `&` operator
- e.g., `type Elephant = Mammal & TrunkedAnimal`, where `Mammal` is a type alias, and `TrunkedAnimal` is another type alias
- e.g., 
  ```typescript
  type ProductWithReview = Product & {  // Product is a previously defined type alias
    reviews: Review[];                  // Review is another previously defined type alias
  }
  ```
- if there are conflicting properties, TS will take the intersection of those 2 properties
  - if there are no overlapping properties, type `never` will be assigned
  - Note:  NO error will be raised when types are defined / intersected - will only raise an error once a type is assigned to `never` (e.g., when defining an object of the intersecting type)

- using `extends` may be preferable since it will raise errors


## Interfaces vs Type Aliases
- intefaces define *objects*;  type aliases define *all* types
  - type aliases can also be used for primitives, tuples, unions, etc.

- interfaces are considered "open" - can be extended, later defined again and automatically merged
- type aliases are considered "closed" - once defined, cannot be re-declared or changed

- both intefaces and type aliases can be used to create new interfaces/types
  - interfaces use `extends` : more expressive of hierarchies, better error messages, allows better code reusuability and modularity
  - type aliases use `&` : better for more complex types


## Index Signatures
- used to define a pattern for objects keys-values
```typescript
interface UserProfile {
  name: string,
  age: number,
  email: string,
}

interface Accounts {
  readonly [username: string]: UserProfile, // defines pattern for key-value properties defined in 'Accounts' object
  admin: UserProfile,              // "named properties" can also be added, but key-value must be consistent with index signature
                                   //  - otherwise, error will be raised
                                   //  - can also define readonly properties
}

const userAccounts: Accounts = {
  admin: {
    name: 'admin',
    age: 25,
    email: 'admin@admin.com',
  },
  user1: {
    name: 'real name',
    age: 23,
    email: 'j@j.com',
  },
  crazyhandle: {
    name: 'jim bo',
    age: 21,
    email: 'jim@bo.com',
  }
};
```
- example index signature for JSON data:
```typescript
interface MyJSONData {
  [key: string]:
    | string
    | number
    | boolean
    | null
    | MyJSONData                                              // note nesting of this type
    | Array<string | number | boolean | null | MyJSONData>;
}

const jsonData: MyJSONData = JSON.parse(
  '{ "name": "John", "age": 30, "address": { "street": "123 Main St", "city": "Anytown", "state": "CA" }, "hobbies": ["reading", "music"] }'
);

/*
Note that the shape of jsonData matches the index signature: 

jsonData = {
  name: "John",
  age: 30,
  address: { street: "123 Main St", city: "Anytown", state: "CA" },
  hobbies: ["reading", "music"],
};

*/
```

- Note:  JS automatically converts all object keys to strings
        - even if index signature indicates `number`, index will be converted to a string

- working with arrays:
  - remember arrays are type `object` (i.e., `typeof myArray === 'object'`)
  - use `Array.isArray(someVar)` to determine if it is an array
  - where a parameter requires an object, an array will also be valid
  - the index signature for arrays will be:
  ```typescript
  interface CustomArray<T> {
    length: number,
    [index: number]: T,
  }
  ```


## keyof operator
- used to dynamically create a new type based on the properties of an existing interface
- e.g.
  ```typescript
  type Animal = {
    name: string;
    species: string;
    age: number;
    isEndangered: boolean;
  };

  const tiger: Animal = {
    name: "Felix",
    species: "Panthera tigris",
    age: 7,
    isEndangered: true,
  };

  function getAnimalProp(animal: Animal, key: keyof Animal): unknown {
    return animal[key];
  }

  getAnimalProp(tiger, "species"); // Returns 'Panthera tigris'

  // alternative (wrong) approach
  function getAnimalProp(animal: Animal, key: string): unknown {
    return animal[key]; // Element implicitly has an 'any' type because expression of type 'string' can't be used to index type 'Animal'.
    // No index signature with a parameter of type 'string' was found on type 'Animal'
  }
  ```
  - using an index signature is too generic (doesn't limit keys to specific values)
  - using `key: 'name' | 'species' | 'age' | 'isEndangered'` isn't scalable and is error-prone
  - using `keyof` automatically uses key properties of `Animal` to limit potential key strings to literal types




## Misc
- **"magic strings"** - the use of a string to affect the behaviour (execution) of a function which is not otherwise defined
  - generally NOT recommended, can be unreliable
  - use of type definition for admissible strings improves this code and prevents errors
  - e.g., 
  ```typescript
  function calculate(operation: string, a: number, b: number) {
    switch (operation) {
      case "add":
        return a + b;
      case "subtract":
        return a - b;
      case "multiply":
        return a * b;
      case "divide":
        return a / b;
      default:
        throw new Error("Invalid operation");
    }
  }
  ```

# to review
- [ ] lesson 4 assignment 8 : https://launchschool.com/lessons/edc1804c/assignments/5af3f807
      - confirm understanding of type narrowing and when it is / isn't possible
- [ ] lesson 4 assignment 18 : https://launchschool.com/lessons/edc1804c/assignments/09797d35
      - unknown vs any : validating type - how much is sufficient, compile errors vs runtime errors

- [ ] lesson 5 assignment 10 problem 2:  https://launchschool.com/lessons/18156389/assignments/39894170
      - use of `Map` raises a TS compile error - "Cannot find name 'Map'"  (using node v21.6.2, typescript v5.3.3)

- [ ] lesson 5 assignment 12 problem 1:  https://launchschool.com/lessons/18156389/assignments/7aa69c34
      - I confirm that the input object was actually an array - does it matter?

- [ ] problems "narrowing", problem 2:  https://launchschool.com/exercises/a2c7b933
      - could review implementing type predicates


