# Study Questions

---

1. 

As provided, what will the code below output to the screen?  Why?
What kind of function is `add`? (i.e., pure vs side effects?)
Add code in the space indicated to change only the output of the 2nd set of console.logs AND
change the type of function (e.g., pure > side effect OR side effect > pure).

```javascript
function add(...args) {
  let first = args.shift();
  args.forEach(array => first.push(...array));
  return first;
}

function makeAdder(array2) {
  return function(array1) {
    return add(array1, array2);
  };
}

let addFive = makeAdder([5, 6, 7]);
let addTen = makeAdder([10, 11]);

console.log('addFive: ', addFive([1, 2, 3]));
console.log('addTen:  ', addTen([1, 2, 3]));

// Add code only here to change only the values output to screen below

console.log('addFive again: ', addFive([1, 2, 3]));
console.log('addTen again: ', addTen([1, 2, 3]));
```

---

2. 

What will the code below output to the screen?  Why?

```javascript
function test1(one, two) {
  if (one && two) return `${one && two} passed.`;
  else return `${one && two} failed.`;
}

function test2(one, two) {
  if (one || two) return `${one || two} passed.`;
  else return `${one || two} failed.`;
}

console.log('1: ', test1(false));
console.log('2: ', test2(false));
console.log('3: ', test1(0, 'apple'));
console.log('4: ', test2(0, 'apple'));
```

---

3. 
What will the code below output to the screen?  Why?

```javascript
let thing1 = {
    a: 1,
    b: 2,
    add() {
      return thing1.a + thing1.b
    },
  };

let thing2 = [
  1,
  2,
  function add(a, b) {
    return a + b
  },  
];

console.log(thing1.add());
console.log('thing1 length 1: ', Object.keys(thing1).length);
thing1.c = 'hello';
console.log('thing1 length 2: ', Object.keys(thing1).length);


console.log(thing2.add());
console.log('thing2 length 1: ', thing2.length);
thing2.c = 'hello';
console.log('thing2 length 2: ', thing2.length);
```

---

4. 
What will the code below output to the screen?  Why?

```javascript
function myProgram() {
  console.log(adj);
  myFunc('night');
}

let myFunc = function hilariouslyLongName(arg) {
  var adj = 'silent';
  console.log(`That's a ${adj} ${arg}`);
};

myProgram();
```

How could 1 line of the code be changed make it work?

---

5. 
What will the code below output to the screen?  Why?

```javascript
let customObj = {
  length: 3,
};

[].push.call(customObj, '3 points');

console.log(customObj);
```

---


- [ ] Which is spread vs rest operator?
- [ ] create shallow copies
```javascript
let arr = [1, 2, 3, 4, [9, 8, 7]];
// create a copy of this array. name it `arrCopy`

let copy1 = arr.slice();
let copy2 = [...arr];
let copy3 = arr.map(ele => ele);
let copy4 = Array.from(arr); // review this

copy3[2] = 'a';
console.log(copy3, arr);
```
- double-check Object.assign vs Object.create
- [ ] review for..in vs for..of : enumerable vs non-enumerable
  - for..in lists all keys in arrays (including non-indexes) (enumerable is true)
  - for..of in arrays - will not list non-valid indexes
  - We can add properties to the object arr that are not elements of the array. All we have to do is use a key that is not a non-negative integer; it doesn't even have to be a number: https://launchschool.com/lessons/79b41804/assignments/153a803b

---

// Write a function that takes an array of strings and returns a new array containing only 
// the elements from the argument that begin with capitalized letters and contain at least 3
// characters. You must use a built in itterative method within your function. 

let test = ['String', 'Sr', 'Fast', 'fast', 'slow', 'Steady'];

// Write a function `findSecond` that takes two arguments (an array and a predicate callback 
// function) that uses two (and only two) built in Array itteration methods to find the second
// occurance of the predicate.
// A predicate callback is a function that returns true or false.

// Write a function in the theme of `findSecond` above named `findNth` that finds the nth occurance of a true return value of the predicate condition. 
  // solve with recursion
  // solve with PFA (partial function application)

// Can you use == or === to compare arrays in JavaScript? Why or why not?

// Write a function that returns true if two arrays contain the same values and false if
// they do not.
// Write a similar function to compare two objects.
//====================================


---

1. 
What will the code output and why?

```javascript
function checkValue() {
  myVar1 = 3;
}

checkValue();

let myVar1 = 27;
console.log(myVar1);
```

---

2. 
Define `myFunc` using `filter` so that the code below outputs `true` twice

```javascript
let arr = [12, 45, 'a', 3, 'dc'];
console.log(myFunc(arr)[0] === 'dc');
console.log(myFunc(arr)[1] === 'a');
```

---

3. 
Is `myFunct` a pure function?

```javascript
let myFunct = (arg) => arg.length = 10;

let arr = [1, 2];
myFunct(arr);
```

---

4. 
What is output to screen and why?

```javascript
let arr = [1, 2, 3];
arr.length = 5;

for (let value in arr) {
  console.log(value);
}
```

---

5. 
What is the output and why?
```javascript
let obj = {
  a: '1',
  b: '2',
  c: [1, 'a', 'd'],
};

obj['c'][2] = ['fe', 'fi', 'fo'];
obj.length = 5;

console.log(obj);
```