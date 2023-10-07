#separator:tab
#html:true
## Object.freeze()
<ul><li>This freezes the values of an object one-layer deep. Meaning it prevents the object from being modified. </li><li>If you want to freeze other layers, you can nest an Object.freeze() call.</li></ul>

## array.prototype.push()
An instance method that appends a new value to the end of the array and returns the new length of the array

## array.prototype.concat()
"<b><span style=""font-weight: 400;"">The non-destructive `concat` method concatenates two or more arrays and returns a brand new array that contains all the elements from the caller array followed by elements in the arrays passed to the method as&nbsp;</span></b><b><span style=""font-weight: 400;"">arguments</span></b><b><span style=""font-weight: 400;"">.</span></b>"

## array.prototype.pop()
Removes the last element from the array and returns the removed value&nbsp;

## array.prototype.splice()
Lets you remove and insert one or more elements from an array. It mutates the original array and returns an array with the deleted elements. Note that you don't have to insert new elements, but it is an option.
<div><br></div><div>a.splice(startIndex, deleteCount, item1, item2, itemN)<br></div>

## array.prototype.forEach()
- Iterates over an array<div>- Requires a callback function as an argument</div><div>&nbsp; * Callback can access the current element value, the index, and the original array forEach was called on if they are defined as parameters in the callback</div><div>- Always returns `undefined`</div><div>- Does not mutate the caller</div>

## array.prototype.map()
- Iterates over an array<div>- Requires a callback function as an argument</div><div>&nbsp; * callback has access to current element, index of current element, and the array that map() was called upon</div><div>
- Returns a new array with transformed values</div><div>- Does not mutate the caller</div>

## array.prototype.filter()
- Iterates over an array<div>
- Takes a callback function as an argument</div><div>&nbsp; * The callback function can access the current element being processed, the index of the current element, and the array filter() 
was called upon<br><div>
- Inserts an element into a new array if the callback function returns a truthy value</div><div>
- Returns a new array with the truthy values</div><div>
- Does not mutate the caller</div></div>

## Object.keys()
"- This is a static method that returns an array with all of the object's ""own"" keys and not the inherited properties.<div>
- For an array, this will return an array of all of the non-empty indexes including non-numeric and negative numeric indexes</div>"

## array.prototype.includes()
- Checks if any of the array values are equal to the argument supplied using strict equality `===`<br>
- Returns a boolean<br>
- The only exception to the strict equality is `NaN` becuase it will return true for that value when it normally returns false<br>
- Keep in mind that object references are being compared so if they don't point to same object, it's false

## array.prototype.slice()
- Extracts and returns a portion of the array.<br>
- It takes two optional arguments:<br>&nbsp; 
  1. A start index inclusive<br>&nbsp;
  2. An end index exclusive<br>
- It does not mutate the array<br>
- It returns a <b>shallow</b> copy of the array<br><br>array.slice(startIndex, endIndexExclusive)

## array.prototype.reverse()
- Reverses the order of the array<br>
- Mutates the array<br>
- Returns a reference to the original array, which is now reversed

## `for/in` loop
"- Iterates over all the keys in the object, including the properties of an object's prototype<br>
- In each iteration, it assigns the key to a variable which you can use to access the object's value:<br><br>for (let prop in person) {
<br>&nbsp; console.log(person[prop]);
<br>}                             // =&gt; Bob<br>"

## Object.values()
"- extracts the values from every ""own"" property in an object to an array"

## Object.entries()
- returns an array of nested arrays. Each array nested array has two elements - one of the object's keys and its corresponding value

## Object.assign()
- Merges two or more objects together into a single object<br>
- It mutates the first object by adding the other object's K-V pairs to it<br>
- It can accept more than two object arguments<br>
- If you want to create a new 
object without mutating the others, you can pass in an empty object {} as the first argument<br>
- If there are duplicate keys, it will take the value from the last object passed in as an argument<br>
- There is no parent child relationship unlike when using Object.create()

## `for/of` loop
- "Iterates over the values of any iterable collection like strings or arrays<br><br><h3><b>
let str = ""abc"";&nbsp;</b></h3><h3><b>
for (let char of str) {</b></h3><h3><b>&nbsp;console.log(char);&nbsp;</b></h3><h3><b>}</b></h3>"

## string.prototype.charCodeAt()
- Returns UTF code of index number of calling string passed in as an argument
- If index not provided, default is index 0

## string.prototype.includes()
Performs case sensitive search for string and returns a boolean. The position value is optional, but is the index for where to start searching in the string.<br><br><pre><code>includes(searchString, position)</code></
pre>

## string.prototype.split()
"- returns an array of strings split at each point where the separator argument occurs<br>- """" (empty string) passed in as argument returns an array of individual characters<br>- "" "" (blank space) passed in as 
argument returns an array of ""words"""

## array.prototype.join()
"- returns a new string by concatenating all of the elements in an array separated by the value passed in as an argument<br>- """" (empty string) passed in as an argument returns all the elements joined together with no 
separator<br>- "" "" (blank space)&nbsp;passed in as an argument returns all the elements joined together with a space as a separator"

## String.prototype.charAt()
Returns character based on index provided as argument.<br><br>Behaves much like accessing a character through bracket index notation, except when returning value for indices that don't exist, it returns blank string  ('') instead of `undefined`

## String.prototype.trim()
Removes leading and trailing whitespace or whitespace-like characters such as `\n` or `\t`<br><br>Other variations are trimStart() and trimEnd()

## array.prototype.some()
<ul><li>Takes a callback function that returns a truthy value as an argument</li><li>Returns a boolean `true` if one of the callback function evalues to true for any element in the collection</li></ul>

## array.prototype.every()
<ul><li>Takes a callback function that returns a truthy value</li><li>Returns boolean `true` if every iteration of the callback function returns a truthy value</li></ul>

## array.prototype.find()
<ul><li>Takes a callback function as an argument</li><li>Returns the first element for which the callback returns a truthy value</li><li>If no value returns a truthy value, returns `undefined`</li></ul>

## array.prototype.findIndex()
<ul><li>Takes a callback function as an argument</li><li>Returns the index of the first element for which the callback returns a truthy value</li><li>If no value returns a truthy value, returns `-1`</li></ul>

## UTF Order
<div>Lower to higher number (first to last)</div><div><ol><li>Numbers and most punctuation</li><li>Uppercase letters</li><li>Lowercase letters</li><li>Extended ASCII that contains accented characters and others comes 
after main ASCII table</li><li>All other UTF-16 characters</li></ol></div><div><br></div>

## Shallow Copy
Only the top level of the array is copied and when there are nested objects, those references are also copied (so those references point to the same place in memory)<br><br>Two common ways to make a shallow copy of array are:<br><ul><li>slice()</li><li>spread syntax [...arr]</li></ul><div>Object.assign() also creates a shallow copy</div>

## Deep Copy
<ul><li>JS does not have an explicit method or function for deep copying objects</li><li>The workaround is to use JSON.stringify() which serializes (converts to string) any object, including arrays, that only has primitives, arrays, and plain objects as elements</li><li>The&nbsp;JSON.parse()&nbsp;method performs that conversion from a string back to an object<br></li></ul>

## JSON.stringify()
<ul><li>Takes an array or plain object and returns the contents as a string</li><li>Contents can only be other array, plain objects or primitives</li></ul>

## JSON.parse()
<ul><li>Takes a stringified object as an argument and returns an object reference</li></ul>

## Higher Order Functions
Functions that take other functions as arguments and/or return other functions

## string.prototype.concat()
concatenates arguments with calling string and returns a new string

## array.prototype.fill()
<ul><li>Changes all elements in an array to a static value, from a start index to an end index (exclusive)</li><li>Returns the mutated array</li></ul><div><br></div><div><pre><code>fill(value, start, end)</code></pre></
div>

## array.prototype.indexOf()
<ul><li>Returns first index at which a given element can be found in the array</li><li>Returns -1 if it is not present</li><li>Has optional argument for index at which to start searching</li></ul><div><pre><code>indexOf
(searchElement, fromIndex)</code></pre></div>

## array.prototype.shift()
<ul><li>Removes first element (index 0) of the array and shifts other elements over</li><li>Returns that removed element</li></ul>

## array.prototype.unshift()
<ul><li>Adds the specified elements to the beginning of an array</li><li>Returns the new length of the array</li></ul><div><pre><code>unshift(element0, element1, /* … ,*/ elementN)</code></pre></div>

