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

