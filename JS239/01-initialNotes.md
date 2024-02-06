# JS230 DOM and Asynchronous Programming with JavaScript

## DOM (Document Object Model)
- an in-memory object representation of an HTML document
- provides a way to interact with a webpage using JavaScript
- the HTML you write (e.g., what you see when you 'View Source') is parsed by the browser and turned into the DOM
- the DOM will differ from the HTML you write if
  - the browser inserts omitted elements (e.g., like `<tbody>`) for you
  - JavaScript has manipulated the DOM elements (e.g., inserting content, etc.)
    - this change will be reflected within "DevTools" which shows what is on-screen (and will change dynamically based on JS)
- the functionality in webpages is based on interacting with a "DOM API" - it just happens to use JavaScript
  - JavaScript can be used independently of the DOM (e.g. Node.js)

### structure
- the DOM is a hierarchical tree structure of nodes
  - elements represent HTML tags
  - text nodes represent text in document
  - whitespace text nodes (or "empty nodes") contain "formatting" text in the HTML document (e.g., tabs, spaces, newlines)
    - typically appear before and after tags in HTML - remember that they include the spaces that indent the HTML tag (i.e., as it is formatted when typed)
    - https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Whitespace

- DOM visualizer:  https://bioub.github.io/dom-visualizer/


## BOM (Browser Object Model)
- an object that allows access to components of the browser:
  - e.g., windows used to display web pages
  - e.g., browser's history
  - e.g., sensors, including location

## Nodes
- (DOM) **node** : a single point in the node tree, such as the document itself, HTML elements, text, and comments
  - all DOM objects are nodes
  - all DOM objects have a type that inherits from `Node` : they all have properties and methods they inherit from `Node`
  - the most common DOM object types used are typically *Element* and *Text*
  - if you know the node's type, you can determine what properties and methods are available 
    - e.g., `HTMLDivElement` has different properties/methods than `HTMLParagraphElement` or `HTMLInputElement`
    - types will inherit from "parent" types (e.g., `HTMLInputElement` inherits from `HTMLElement`)
    - `EventTarget` supports interactive event-handling behaviour
    - `Node` provides common behaviour for *all* nodes
    - `Text` (for text) and `Element` (for HTML tags) are the main subtypes of `Node`

- `document` node : represents the entire HTML document (the top-most DOM node)
  - `window.HTMLDocument` is an alias for `document`
  - `document.head` references the head directly
  - `document.body` references the body directly
- `.querySelector()` searches the entire DOM for an element that matches a selector


### determining node type
- `.toString()` can be used to determine an object's type:
  - e.g., `document.toString()` returns `'[object HTMLDocument]`
  - some types implement a custom `toString` which does not return the type (e.g., `HTMLAnchorElement` returns the target URL)
  - this is generally best in the browser
- `.constructor` can also be used : returns the constructor function (but format may vary between browsers)
  - some browsers will allow `.constructor.name`

- when coding, use `instanceof`
  - e.g., `p instanceof HTMLParagraphELement` or `p instanceof Element` (more general)


### Node properties
- `.nodeName` : a string that represents the node type (e.g., "P", "#text", "#comment", etc.)
  - historically, these were always uppercase
- `.tagName` : can be used on elements, returns the same thing as `.nodeName`
- `.nodeType` : returns a number that matches a node type (can also reference this using a name)
  - e.g., `Node.ELEMENT_NODE === 1` e.g., `p.nodeType === Node.ELEMENT_NODE` returns `true`
  - e.g., `Node.TEXT_NODE === 3`
  - e.g., `Node.COMMENT_NODE === 8`
  - e.g., `Node.DOCUMENT_NODE === 9`
- `.nodeValue`
  - elements will return `null`
  - text nodes will return their text content (including any whitespace)
  - will contain everything between the next opening or closing tag
  - will depend on how HTML text is actually written (formatted)
- `.textContent` : returns all text content within an *element* (including whitespace)
  - i.e., the concatenation of the `textContent` property value of every child node
- `.innerText` : returns text associated with an element
- `.data` : returns the textual content of a text node
    - this belongs to the `CharacterData` DOM interface which presents textual data as a `DOMString` (a String-like object)
- `.contains(anotherNode)` : returns `true` if `node` contains `anotherNode` (assuming invoked as `node.contains(anotherNode)`)


### Traversing nodes
- DOM nodes connect to each other via properties that point to other nodes
- parent node properties
  - `childNodes` : returns a live collection of all child nodes
  - `firstChild` : returns `childNodes[0]` or `null`
  - `lastChild` : returns `childNodes[childNodes.length - 1]` or `null`

- child node properties
  - `parentNode` : immediate parent of current node
  - `nextSibling` : `parentNode.childNodes[n + 1]` or `null`  (where `n` is the index of the current node)
  - `previousSibling` : `parentNode.childNodes[n - 1]` or `null`

- "walking the tree" : the process of visiting every node that has a relationship with a given node (i.e., child, grandchild, etc.)
```javascript
// walk() calls the function "callback" once for each node
function walk(node, callback) {
  callback(node);                                                   // do something with node
  for (let index = 0; index < node.childNodes.length; index += 1) { // for each child node
    walk(node.childNodes[index], callback);                         // recursively call walk()
  }
}

walk(document.body, node => {                                // log nodeName of every node
  console.log(node.nodeName);
});
```

### Notes
- cannot load JS scripts in the HEAD if I want to manipulate the body - need to load the JS scripts after the HTML elements have been created

- Using Chrome "Snippets"
  - can create and test code directly on webpages using "snippets"
  - go to: Dev Tools (F12) > Sources
  - CTRL-SHIFT-P to open command window
    - type "snippets"
    - select "create new snippet"
  - CTRL-Enter to execute snippet


## Elements
- can access the attributes of an Element using:
  - `.getAttribute(name)` : returns value as string
  - `.setAttribute(name, newValue)` : sets the value, returns `undefined`
      - use `Element.value` instead of `Element.setAttribute` if possible (`setAttribute` works inconsistently for some attributes, potentially where default values exist)
      - note:  *attributes* are different than *properties*
              - e.g., `onclick` is a property (accessed via standard `.onclick` notation), but `class` is an attribute
  - `.hasAttribute(name)` : check if element has attribute, returns `true` or `false`
  - `.toggleAttribute('hidden')` : can be used to toggle `'hidden'` on/off
  - `.id` : can be used to directly modify  these attributes of the Element
  - `.name` : (as above)
  - `.title` : (as above)
  - `.value` : (as above)
  - `.className` : modifies the `class` attribute of elements (can't use `class` since it's a reserved keyword in JS)
      - Note: this will return a string with all class names included, space delimited (same as when they are assigned)
      - `.classList` is better, can use:
        - `add(name)`
        - `remove(name)`
        - `toggle(name)` : add a class `name` to element if it doesn't exist, remove if it does
        - `contains(name)` : returns `true`/`false` if element has `name`
        - `length` : returns number of classes assigned to element
  - `.style` : can be used to alter CSS properties on the element
      - e.g., `h1.style.color = 'red'`
      - e.g., `h1.style.color = null` (to remove a property)
      - e.g., `h1.style.lineHeight = '3em'` (note camelCase for properties with dashes)

- `document.getElementById(id)` : access a (single) element by assigned id (should only have 1 element for each id)
- `document.getElementsByTagName(tagName)` : returns an `HTMLCollection` or `NodeList` (depending on browser) (array-like collection of nodes)
- `document.getElementsByClassName(className)` : returns an `HTMLCollection` or `NodeList` (depending on browser)
    - must use `Array.prototype.slice.call(collection)` to convert to a true array
    - Note: if an `HTMLCollection` is returned, it will be a *live collection* - it will update automatically based on changes in the DOM
        - this may lead to unexpected behaviour, especially if iterated over or the return value is used

- `document.querySelector(selectors)` : returns the *first* element matching the provided selectors, or `null`
- `document.querySelectorAll(selectors)` : returns a `NodeList` (not live) of matching elements
  - if an `id` tag begins with a number (e.g., `id="1"`) then the string to be used for `querySelector` is: `document.querySelector("id=['1']")`
  - see also:  https://stackoverflow.com/questions/20306204/using-queryselector-with-ids-that-are-numbers


- properties on `document` (or `document.body`, if using IE)
  - `.children` : returns a live collection of all child elements
  - `.firstElementChild` : returns first element child (`children[0]`) or `null`
  - `.lastElementChild` : returns last element child (`children[children.length - 1]`) or `null`
  - `.childElementCount` : returns `children.length`
  
  - `.nextElementSibling` : returns `.parentNode.children[n + 1]` or `null`
  - `.previousElementSibling` : returns `.parentNode.children[n - 1]` or `null`

  - use `.textContent` to access or assign the text node
    - Note: if used for assignment, this will remove all child nodes from the element and replace them with a text node
    - accessing and replacing text is easiest if it is contained within a `<span>` or `<div>` element
  - Note:  if this doesn't work, can try using `let nextNode = document.createTextNode('my text')` and then `myElement.appendChild(textNode)`

- check https://caniuse.com for compatibility with browsers, especially IE versions before v9

- properties of elements:
  - e.g., `onclick` (although it shouldn't be used)

- properties of `e` (event):
  - `.preventDefault` : a function
  - `.currentTarget` : returns the element (i.e., that was clicked and thus triggered `e`, the event)

## Manipulating Nodes

### Creating Nodes
- `document.createElement(tagName)` : creates an element (e.g., `let newElement = document.createElement('p')`)
- `document.createTextNode(str)` : creates a text node (e.g., `let textNode = document.createTextNode('this is a new text node')`)
- `node.cloneNode(boolean)` : copies an existing `node`
    - if boolean is `true`, creates a "deepClone" (i.e., copies the node and *all* descendants), if `false` copies only the `node`
    - copies are independent

### Adding Nodes
- `parent.appendChild(node)` : append `node` to end of `parent.childNodes`
    - cannot use `document.appendChild`, use `document.body.appendChild`
    - can also use `parent.append(node)`
- `parent.insertBefore(node, targetNode)` : insert `node` into `parent.childNodes` before `targetNode`
    - if `targetNode` is `null` then `node` will be inserted at the end
- `parent.replaceChild(node, targetNode)` : remove `targetNode` from `parent.childNodes` and insert `node` in its place

### Inserting Nodes
- Note: the same node cannot appear twice within the DOM; inserting it somewhere new will move it

- `element.insertAdjacentElement(position, newElement)` : inserts `newElement` at `position` relative to `element`
- `element.insertAdjacentText(position, text)` : inserts text node that contains `text` at `position` relative to `element`
  - `position` must be:
      - 'beforebegin' : before the element
      - 'afterbegin' : before the first child of the element
      - 'beforeend' : after the last child of the element
      - 'afterend' : after the element

### Removing Nodes
- unless a reference to the node is saved in a variable, the node will no longer be accessible after removing

- `node.remove()` : remove `node` from DOM
- `parent.removeChild(node)` : remove `node` from `parent.childNodes`


## Asynchronous execution
- can use `setTimeout` to create a delay on when code is executed - asynchronous execution (i.e., code won't be executed sequentially in the order in which it is encountered, it may be executed later)
  - note: code execution takes place in event cycles;  if `setTimeout` with no delay is used, code will not get executed until the next cycle
  - `setTimeout` may also behave unpredictably for small time differences (i.e., execution sequence may vary)
  ```javascript
  setTimeout(()=>{ 
    f();            // executed after g since it is executed at the next event cycle
  });

  g();              // still executed first
  ```
- can use `setInterval` to run something repeatedly with a set delay
  - `let counterId = setInterval(callback, delay);` : note `setInterval` returns an identifier; `callback` is called with `delay` number of ms delay
  - use `clearInterval(counterId);` to cancel the interval
    - Note:  you can cancel the interval from *within* the interval callback:
    ```javascript
    function startCounter(callback) {
      let count = 1;

      let int = setInterval(() => {
        let finish = callback(count);
        if (finish) clearInterval(int); // the interval is cleared from within the callback
        count += 1;
      }, 1000);
    }

    startCounter( count => {
      console.log(count);
      return count === 5;
    });
    ```


## Events
- once displayed, most UIs *wait* for something to happen, then execute the appropriate code as a response
  - an **event** is an object that represents some occurrence and contains a variety of information about what happened and where it happened
  - an **event listener** (also known as **event handler**) is code (a callback) that browser runs in response to an event

- common events:
  - keyboard:  `keydown`, `keyup`
  - mouse:  `mouseenter`, `mouseleave`, `mousedown`, `mouseup`, `click`, `mousemove`, `clientX`, `clientY`
  - touch: `touchstart`, `touchend`, `touchmove`
  - window: `scroll`, `resize`
  - form: `submit`
  - input: `focus`, `focusout` (note:  `blur` doesn't bubble, so is not good for delegated events)

- https://developer.mozilla.org/en-US/docs/Web/Events

- steps to setup event handler:
  - identify the event to handle (e.g., `click`)
  - identify the element that will receive the event (e.g., a button)
  - define a function to call when this event occurs (it will be passed an `event` object, which may or may not be used)
  - register the function as an event listener (i.e., `addEventListener`)


### Page lifecycle events
- a webpage will display in multiple steps - simplified mental model:
  - HTML code received from server
  - HTML parsed and JS evaluated
  - DOM constructed from parsed HTML
  - `DOMContentLoaded` event fires on `document` (sometimes called "DOM Ready Event", typically uesd for JS code that must access the DOM)
  - Page dislayed on screen
  - Embedded assets are loaded
  - `load` event fires on `window`  (this may fire much later after everything on page loads incl. images, videos, etc.)
- using `DOMContentLoaded`:
  ```javascript
  document.addEventListener('DOMContentLoaded', event => { 
    // do something with the DOM
  });
  ```

### Event object
- an object passed to the event handler that contains extra contextual information about the event:
  - `type` : the name of the event
  - `currentTarget` : the current object the event object is on (always refers to the element that has the event listener on it)
  - `target` : the object on which the event occurred (e.g., actual element clicked by user (may be nested under `currentTarget`))

- mouse events:
  - `button` : indicates which button was pressed (read-only property)
  - `clientX` : horizontal position of mouse when event occurred (relative to visible area of page - pixels from upper L corner of browser viewport)
  - `clientY` : vertical position of mouse when event occurred (relative to visible area of page - pixels from upper L corner of browser viewport)

- keyboard events:
  - `key` : string value of pressed key (**older browsers do not support this property**)
  - `shiftKey` : boolean, true if user pressed shift
  - `altKey` : boolean, true if user pressed alt (option) key
  - `ctrlKey` : boolean, true if user pressed control
  - `metaKey` : boolean, true if user pressed meta (command) key
  - `keydown` : good for checking if a key has been pressed (limiting input / response to valid keys)
                - occurs before the `input` event fires so the last key pressed is not included in input value
                - works for "modifier keys" (e.g., alt, ctrl, shift)
  - `keyup` : better for managing input values on text entered
              - note:  `altKey`, `ctrlKey` only work for `keyup` if another key is pressed concurrently


### Event capturing and bubbling
- nested elements can also "trigger" events
  - e.g., adding eventListener to outermost event allows `event.target.id` to identify inner nested elements that are clicked
    - `event.currentTarget.id` will always be the element with the eventListener (i.e., the outer element)
    - Note:  `this` (if using a function expression) will be the same as `event.currentTarget`
      - `this` has the value `event.currentTarget` (which will be the same as `event.target` if the event listener is attached to the same element)
      - `event.target` will be the clicked element (if the listener is attached to a parent)
  - `.closest(selector)` : will find the closest ancestor element which matches `selector` (incl. itself) or `null` (if no match)
    - e.g., can use `event.target.closest('a')` to find the closest 'a' if there are nested elements within 'a'

- events propogate in 3 phases:
  - event "capturing":
    - the event always starts at `window`, goes to `document`, continues to get passed inwards to `target`
    - as it passes various elements, they are "checked" to see if there is a relevant eventListener
  - event "target"
    - once it reaches `target`, "capturing" is finished
  - event "bubbling":
    - from `target` it moves back outwards, and any relevant eventListeners are "fired" (i.e., callback functions are executed)
- `.addEventListener(event, callbackFn, useCapture)`
  - can set `useCapture` to `true` to fire events on capture, rather than bubble (which is default)
  - e.g., `addEventListener('click', event => console.log(event.key), true)`

- `.removeEventListener(event, callbackFn)` : must use the same arguments as passed to `.addEventListener`; must use a named function (not an anonymous one)

- `event.stopPropogation()` : prevents further bubbling or capturing (depends on whether events are triggered on capture or bubbling)
- `event.preventDefault()` : prevents a "default action" (e.g., loading a page when clicking on an "a" href)
  - the default behaviour is attached to the `event` object, *not* the event listener (e.g., all nested events can have their default behaviour prevented)
  - all capturing / bubbling happens *before* default actions are performed;  thus a single "preventDefault" in the propogation path (any listener that the event "travels" to) prevents all default behaviour
    - Note:  if `stopPropogation` is used, then the event may not "reach" a `preventDefault` defined for a nested event
      - this will depend on whether an eventListener is defined on capture / bubble, nesting, etc.

### Event delegation
- **event propogation** : attaching a single event handler to a parent element, rather than attach individual eventListeners to individual objects
  - e.g., all 8 buttons are part of a `div` or the listener is attached to `document`
  - pros:
    - with multiple cells (e.g., a spreadsheet), don't need to add new listeners to each cell (would be very slow)
    - if attaching to `document`, don't need to wait for DOM to load - can be faster
  - cons:
    - code will be more complicated if there are different types of events, different types of tags involved (need to address each case to 
    differentiate the common eventListener)
    - e.g., `if (event.target.tagName === 'BUTTON') ...` and `if (event.target.tagName === 'A') ...`

- generally, start with individual eventListeners / handlers for new/small projects
  - as code gets more complex, use delegation to reduce the number of event handlers required

- e.g., `form.dispatchEvent(new Event('submit', { cancelable: true }));` :
  - this dispatches the 'submit' event another element `form`, which is 'cancelable'


### Event loop
- the **event loop** - monitors the call stack and task queue (or callback queue, or message queue):  If the stack is empty, it takes the next item (e.g., a callback function) from the *task queue* and pushes it onto the stack (and runs it)
- code such as `setTimeout` or XHR requests are part of a *web API* (part of the browser, not the JS runtime) which allows things to run concurrently
  - web API code will run asynchronously and then go to the *task queue* where the *event loop* will move it to the stack once ready
- the *JS runtime* is the JS engine (e.g., Chrome V8) which is "pure JS";  the browser also includes access to *web APIs* and includes functionality of the *task queue* and *event loop* which collectively support *asynchronous* activities
- node.js is similar, but instead of web APIs, it has "C++ APIS"
- in ES6 (for promises) (https://blog.bitsrc.io/understanding-asynchronous-javascript-the-event-loop-74cd408419ff):
  - a "job queue" (also called micro-task queue) is added, which has higher priority than the message queue
  - promises use the job queue, which will be resolved before tasks waiting in the task/message queue


## Asynchronous coding patterns

### Callbacks
- **callback** : a function (e.g., `cb`) that is passed into another function (e.g., `foo`) that will be invoked for `foo` to complete an action.  The callback function `cb` will be executed later to prevent blocking the main execution of the program
- **callback hell** : when callbacks are nested together into a 'pyramid' (also called the "pyramid of doom")
  - to eliminate callback hell, use modular functions (break them into smaller pieces), use *named functions* to track and reference them
  - aim to flatten code so that callbacks aren't all nested


### Promises
- **promise** : an object that represents an asynchronous operation that will complete at some point and produce a value
- rather than pass a callback into a function, you receive a promise object that you can attach callbacks to, without nesting them
- promises have 3 states:
  - pending: operation not yet complete
  - fulfilled: operation completed (resulting value produced)
  - rejected: operation failed (promise has an error)
- promises are created using `new Promise( (resolve, reject) => { ... })`
- can chain
  - `.then(successCallback, failCallback)` for successful resolving (returns a promise which can be chained)
  - `.catch(callback)` for unsuccessful resolving (reject)
    - `callback` *must* be a function, otherwise, the catch method will not work
    - it is good practice to always include a `catch` method at the end of promise chains to handle errors
    - can return values from `catch` methods to ensure subsequent chained promises have a "fallback value"
  - `.finally(callback)` for actions that are alway executed after resolving (e.g., clean-up actions)
- promises can be chained with multiple `.then` methods

- `Promise.all(promiseArray)` : takes an array of promises, returns an array of all resolved values (in same order), or rejects if any promise rejects
- `Promise.race(promiseArray)` : will resolve as soon as a single promise in `promiseArray` resolves, or rejects if all promises provided reject
- `Promise.allSettled(promiseArray)` : takes an array of promises, returns an array of objects that describe the result (i.e., `{ status: 'fullfilled', value: returnValue }` OR `{status: 'rejected', reason: returnValue}`)
- `Promise.any(promiseArray)` : takes an array of promises, will return a single promise: if any of given promises resolves, it returns that value; if no promises resolve, it returns `AggregateError` (groups individual errors)


### Async/await
- adding the `async` keyword to functions indicates that the function should return a promise
  ```javascript
  async function fetchData() {
    return "data from server"
  }

  fetchData().then(data => console.log(data)); // outputs "data from server"
  ```
- `await` is used *inside* an `async` function to indicate the code should wait for a promise to fulfill
  - best practice is to only use `await` inside `async` functions
  - an exception is more advanced use of `await` with modules (not covered in LS)
- `try`/`catch` blocks can be used inside `async` functions to catch errors in the `await` statement or function called
```javascript
async function fetchMultipleData() {
  try {
    let [firstData, secondData] = await Promise.all([
      fetchFirst(),
      fetchSecond(),
    ]); // Promise.all used to trigger multiple promises in parallel;  await used to pause until all promises resolve
    console.log(firstData, secondData);
  } catch (error) {
    console.error("An error occurred while fetching data:", error);
  }
}
```

### Notes
- may be best to avoid using `await` in a loop since each iteration will require the async operation to complete;  `Promise.all()` may be better
  - don't use unnecessarily - can reduce performance (from waiting)
- be careful with `myPromise.then(func1()).catch(func2())`:
  - if there is an error with `func1()`, then the `.catch` block and `func2` will also be executed
  - if there is a chance that errors may arise with `func1`, then it is safer to use `.then(func1, func2)` - `func1` will execute if `myPromise` is successful or `func2` will execute if `myPromise` is unsuccessful
- When working with promises / async/await:
  - **don't confuse a promise (async code) for synchronous code (i.e., a non-promise):  must always deal with `.then`, etc. with async code
- `try / catch / finally` blocks are inherently synchronous - the `try` block can't inherently catch errors in asynchronous functions
  - to catch asynchronous errors, must use the `.catch` method
- `.then / .catch / .finally` : these *methods* are synchronous - must be used with promises
  - can also use `async/await` to create an async `try` block to `await` an async operation


## APIs (LS API book)
- **API** :  (Application Programming Interface) A way for systems to interact with each other;  AIS provide functionality for use by another program
  - programming languages have a built-in API that is used to write programs
  - mobile devices provide APIs to access location or other sensor data (e.g., GPS, device orientation)
  - OS have APIs to open files, access memory, draw text, etc.
  - **web APIs** (or HTTP APIs) : APIs built with web technologies that work in a similar way to the web

- **API provider** : the system that provides the API for other parties to use (generally the "server" for the LS book)
- **API consumer** : the system that *uses* the API to accomplish some work (generally the "client" for the LS book)

- common uses for APIs:
  - sharing / transferring data between systems
  - allow users of a service to make use of it in new and useful ways
  - integrate a developer's own code with a service's functionality
    - enable application developers to build their app on top of other specialized systems; allows focus on actual objectes and not worry about complexities of every part of the system
  - as an "escape hatch" - allowing users to customize software's behaviour or integrate it with other systems, if required

- benefits of using web APIs:
  - API operations can be shorter and more succinct to document (e.g., CRUD is mapped to a specific path / resource)
  - APIs have less limitations (don't rely on web forms which may be limited by HTML spec and specific web browsers)
  - development of APIs moves more quickly than HTML since compatibility is ensured by using HTTP (methods)
  - mapping of CRUD actions to HTTP methods is fairly standard


- **public API** : an API intended for consumption *outside* of the organization that provides it
  - to use a public API, you generally must accept the terms and conditions of use (e.g., resposibility for data privacy, rate / request limits, etc.)
- **private API** : an API intended only for internal use by an organization

- **parsing** : the process of converting data from one format into another
  - typically there is a format designed for data transfer or data persistence which must be converted into another format that is easier to work with for a computer
  - e.g., parse HTML text into page DOM
  - common HTTP content type for transfer of data in HTTP response body is `application/json`

- **data serialization format** : describes a common way for programs to convert data into a form that is more easily or efficiently stored or transferred
  - e.g., SVG (vector graphics)
  - e.g., XML (**extensible markup language**) : similar, but stricter than HTML
  - e.g., JSON (**JavaScript Object Notation**) : perhaps the most popular data serialization format used by web APIs today
    - similar to JS syntax for objects, but note that all keys (in key-value pairs) are surrounded by double-quotes `"`


- **MIME type** : (also called **content types** or **media types**) identifies how the content within an HTTP response is encoded (i.e., the format of a response's body)
  - https://en.wikipedia.org/wiki/Media_type#List_of_common_media_types
  - e.g., `Content-Type: text/html; charset=UTF-8` or `text/html; charset=ISO-8859-1`
  - e.g., `text/css`, `text/plain`, `application/javascript`, `text/css`
  - e.g., `image/jpeg`
  - e.g., SG

### REST / CRUD
- **REST** (representational state transfer) : how a representation of a resource is being transferred (not the resource itself) via a stateless protocol
  - think of a resource as a webpage
  - "REST" is a way to define everything you might want to do with 2 values: **what** (what resource) and **how** (how do we change/interact with that resource)
  - REST is a set of conventions, not rules;  practically, there may be deviations as a result of development/support costs, business needs, etc.


- **CRUD** : describes the 4 actions that can be taken on resources:
  - Create (use `POST` HTTP method)
  - Read (use `GET` HTTP method)
  - Update (use `PUT` HTTP method - APIs only)
  - Delete (use `DELETE` HTTP method - APIs only)

  - with APIs, params can get passed as JSON (i.e., not as URL params)

- general CRUD pattern:

| objective   | how       |             | what     |               |
|-------------|-----------|-------------|----------|---------------|
|             | operation | HTTP method | resource | Path          |
| get info    | Read      | GET         | info     | /info/:id     |
| add info    | Create    | POST        | info <br> collection     | /info         |
| change info | Update    | PUT         | info     | /info/:id     |
| remove info | Delete    | DELETE      | info     | /info/:id     |

  - generally, need to translate "verb-oriented" functionality into "noun (or resource)-oriented actions for CRUD
    - e.g., "deposit $100 into this account" changes to "create a new transaction with an amount of $100 for this account" for CRUD
    - with CRUD, the simplicity of each step may require multiple steps for things that appear easy (eg., submitting an order for 2 items may require multiple CRUD requests)

- **singular resource** (or **singleton resource**) : where the resource and path identify only a single resource (i.e., are "singular")

- **resource** : a representation of some grouping of data; data can be anything that a user may need to interact with (e.g., posts, tags, comments, accounts, transactions, etc.)
  - when fetching a resource from an API, the JSON body in the response will be a representation of a single resource on the server, which may include multiple properties (e.g., a single product may have an *id*, *name*, *price*, etc.)
  - every resource must have a unique URL to identify and access it
    - URL is comprised of *hostname* and *path*
  - a resource can be a *collection* which identifies multiple resources as a group (e.g., returned body may be represented as an array)
  - best way to tell if a path/resource will return a collection vs a single element is to look at documentation, or infer from the returned body (e.g., single element returned vs multiple elements returned)
  - when requeesting resources, may be helpful to define an *accept header* (e.g., `Accept:application/json`) to tell provider what media types can be used to respond to the request
  - note:  HTTP requests may have side effects (e.g., a GET request may increment a counter);  be aware of potential side effects

- APIs may enforce **rate limiting** : allotting each API consumer a fixed number of requests within a specified amount of time

- common API response codes:
  - *2xx* : typically a successful request / response
    - e.g., *200 OK* for a GET request or succesful PUT request
    - e.g., *201 Created* for a successful POST request
    - e.g., *204 No Content* when a DELETE request is successful (no content to return)
  - *4xx* : typically "client" errors (user has done something incompatible)
    - e.g., *422 Unprocessable Entity* (required params not provided)
    - e.g., *404 Not Found* (path/resource doesn't exist, also often used for unauthorized access to prevent knowledge that a privileged resource exists at that path)
    - e.g., *401 Unauthorized* or *403 Forbidden* (sometimes used when incorrect authorization credentials are provided)
    - typically requests submitted beyond rate limits return a *403 Forbidden* status code
    - e.g., *415 Unsupported Media Type* (body submitted in the wrong format, e.g., HTML form vs JSON)
  - *5xx* : typically "server" errors (not the result of anything a user does)
    - could result from a bug or oversight in server implementation
    - hardware / infrastructure problems
    - sometimes retrying a request later may solve server errors
    - resubmitting requests which return errors may worsen problems with a remote system

- common API request headers:
  - see https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields
  - `Access-Control_Allow-Origin: *` : allows all sites access using CORS
  - e.g., `Allow: GET, HEAD` : typically used with a *405 Method Not Allowed* status to indicate what methods ARE allowed
  - `Content-Length: ` : indicates length of response body in bytes
  - `Content-Type: application/json; charset=utf-8` : indicates media type / format of body
  - e.g., `ETag: "6df23dc03f9b54cc"` : used to specify a specific version of a resource
    - changes to the resource result in a new ETag
    - this value can be sent with future requests to the same URL using the `If-None-Match` header
      - if there are no changes, server typically returns *304 Not Modified*
      - if there are changes, the response should include the entire resource along with new ETag
    - helps to avoid fetching / processing unmodified data
  - e.g., `Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT` : indicates last time resource was modified
    - typically this value can be sent with future requests to the same URL using the `If-Modified-Since` header
  - e.g., `WWW-Authenticate: Basic` : indicates basic HTTP authentication is required
  - `X-` prefix (e.g., `X-RateLimit-Limit: 60`) : typically indicates non-standard headers
    - e.g., GitHub uses these to indicate status of rate limiting with each request

## AJAX
- **AJAX**:  Asynchronous Javascript And Xml
  - provides the ability to fetch data (typically HTML or XML) and update parts of a web page (rather than re-rendering the entire webpage)
  - an "AJAX request" (or "via AJAX") refers to an HTTP request from a web browser that *does not perform a full page load*
  - benefits of AJAX over HTML forms:
    - allows the use of all HTTP methods (HTML forms only allow `GET` and `POST`)
    - allows detailed control of headers and data-format (e.g., HTML, JSON, XML)
  - AJAX requests are initiated from JavaScript code, typically an event listener
    - JS code will handle the response, the developer *can* (but doesn't need to) update the page (typically specific sections of the page), as desired

- **single page application** : a web application in which the DOM is created entirely from JavaScript running in the client browser, often run entirely within a single HTML page
  - instead of fetching HTML from a server, the application will fetch data from the server (often encoded in JSON)

- **SSR** (server-side rendering) : a complete web page is built by the server and sent to the client (web browser) for display

- **CSR** (client-side rendering) : a server sends only the bare-bones HTML document and some JavaScript to the client. The client will run the JS code to request the data it needs to fill out the rest of the page dynamically


### XMLHttpRequest object
```javascript
let request = new XMLHttpRequest();
request.open('GET', '/path');  // by default will use the existing domain
request.open('POST', '/path');
request.send(data); // occurs asynchronously (by default), never use this synchronously
                    // data is optional (e.g., if using `POST` method)
                    // if sending data, must set headers
  request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); // as example
            // request.open('GET', '/path', false) indicates a synchronous request
            // - setting sychronous requests may be deprecated
            // Note: must set request method using `request.open` before setting request headers
request.setRequestHeader(header, value);  // set HTTP `header` to `value`
request.abort();  // cancel an active request
request.getResponseHeader('Content-Type');

// properties of XMLHttpRequest object
request.responseText; // raw text of response body
request.response;     // parsed (interpreted) response based on value in `.responseText` (not always meaningful)
request.status;       // number code
request.statusText;
request.timeout;      // max time a request can take to complete (in ms), default is `0`
request.readyState;   // no default value

request.responseType = 'json';  // could also be 'text', 'arraybuffer', 'blob', 'document'
                                // - assigning this affects the interpreted value in `request.response`
                                // see comments below in Data Serialization > Receiving JSON data

// since request.send is asynchronous, can use event listener on 'load'
request.addEventListener('load', event = {
  var request = event.target;  // the XMLHttpRequest object
  console.log(request.responseText);
});
```

- events
  - `readystatechange` : occurs after request is instantiated and after request is sent
    - 'OPENED', 'HEADERS_RECEIVED', 'LOADING', 'DONE'

  - `loadstart` : request sent to server
  - `progress` : typically occurs while loading a response

  - 1 of the following events may occur
    - `load` : a complete response loaded
    - `abort` : request was interrupted before it could complete
    - `error` : an error occurred
    - `timeout` : a response wasn't received before timeout period ended

  - `loadend` : response loading done and all other events have fired - last event to fire

- it's always best to check the request response to ensure the desired response was received (i.e., the browser will consider any request that receives a complete response as "successful", even if that response is non-200 or an error)


### Data serialization formats

- Query string (without encodeURIComponent)
  - e.g., `title=Do Androids Dream of Electric Sheep?&year=1968`
- URL encoding (with encodeURIComponent)
  - e.g., `title=Do%20Androids%20Dream%20of%20Electric%20Sheep%3F&year=1968`
  - to use with `POST` request:
    - include header `Content-Type: aplication/x-www-form-urlencoded; charset=utf-8`
    - put encoded string in request body

- Multipart forms
  - used for forms with file uploads or that use `FormData` objects to collect data
  - name-value pairs are put in separate sections of request body separated by a **boundary delimiter**
  - typically do not define `charset` for multipart forms (best to define `charset` for other types)
  - example (complete request):
      POST /path HTTP/1.1
      Host: example.test
      Content-Length: 267
      Content-Type: multipart/form-data; boundary=----WebKitFormBoundarywDbHM6i57QWyAWro
      Accept: */*

      ------WebKitFormBoundarywDbHM6i57QWyAWro
      Content-Disposition: form-data; name="title"

      Do Androids Dream of Electric Sheep?
      ------WebKitFormBoundarywDbHM6i57QWyAWro
      Content-Disposition: form-data; name="year"

      1968
      ------WebKitFormBoundarywDbHM6i57QWyAWro--
  - note final boundary is trailed by `--` which indicates end of multipart content

- JSON (JavaScript Object Notation)
  - can exchange arrays, objects, strings, numbers, boolean values
  - does not (natively) support complex data types like dates and times, would need to define a format using strings, numbers, objects that both client and server understand
  - e.g., `Content-Type: application/json; charset=utf-8` and `{"title":"Do Androids Dream of Electric Sheep?","year":"1968"}`

### Working with different formats

#### Submit (url-encoded) data for post request
```javascript
let request = new XMLHttpRequest();
request.open('POST', 'https://lsjs230-book-catalog.herokuapp.com/books');

request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
let data = 'title=Effective%20JavaScript&author=David%20Herman';

request.addEventListener('load', () => {
  if (request.status === 201) {
    console.log(`This book was added to the catalog: ${request.responseText}`);
  }
});

request.send(data);
```
- corresponding request looks like this:
    POST /books HTTP/1.1
    Host: lsjs230-book-catalog.herokuapp.com
    Content-Length: 50
    Content-type: application/x-www-form-urlencoded
    Accept: */*

    title=Effective%20JavaScript&author=David%20Herman

#### Submit (url-encoded) data from a form
```html
<form id="form" method="POST" action="books">
  <p><label>Title: <input type="text" name="title"></label></p>
  <p><label>Author: <input type="text" name="author"></label></p>
  <p><button type="submit">Submit</button></p>
</form>
```

```javascript
let form = document.getElementById('form');

// Bind to the form's submit event to handle the submit button
// being clicked, enter being pressed within an input, etc.
form.addEventListener('submit', event => {
  // prevent the browser from submitting the form
  event.preventDefault();

  // access the inputs using form.elements and serialize into a string
  let keysAndValues = [];

  for (let index = 0; index < form.elements.length; index += 1) {
    let element = form.elements[index];
    let key;
    let value;

    if (element.type !== 'submit') {
      key = encodeURIComponent(element.name);
      value = encodeURIComponent(element.value);
      keysAndValues.push(`${key}=${value}`);
    }
  }

  let data = keysAndValues.join('&');

  // submit the data
  let request = new XMLHttpRequest();
  request.open(form.method, `https://ls-230-web-store-demo.herokuapp.com/${form.getAttribute('action')}`);
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  request.addEventListener('load', () => {
    if (request.status === 201) {
      console.log(`This book was added to the catalog: ${request.responseText}`);
    }
  });

  request.send(data);
});
```
- request sent is identical to previous example, but data string was created from user-entered form data

#### Submit form data using FormData
- use same form as above
```javascript
let form = document.getElementById('form');

form.addEventListener('submit', event => {
  // prevent the browser from submitting the form
  event.preventDefault();

  // NOTE:  FormData only uses input fields with a `name` attribute
  let data = new FormData(form);

  let request = new XMLHttpRequest();
  request.open(form.method, `https://ls-230-web-store-demo.herokuapp.com/${form.getAttribute('action')}`);

  request.addEventListener('load', () => {
    if (request.status === 201) {
      console.log(`This book was added to the catalog: ${request.responseText}`);
    }
  });

  request.send(data);
});
```
- request will be in a multipart serialization format
    POST /books HTTP/1.1
    Host: lsjs230-book-catalog.herokuapp.com
    Content-Length: 234
    Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryf0PCniJK0bw0lb4e
    Accept: */*

    ------WebKitFormBoundaryf0PCniJK0bw0lb4e
    Content-Disposition: form-data; name="title"

    Effective JavaScript
    ------WebKitFormBoundaryf0PCniJK0bw0lb4e
    Content-Disposition: form-data; name="author"

    David Herman
    ------WebKitFormBoundaryf0PCniJK0bw0lb4e--

##### Another option with FormData
```javascript
document.querySelector('form').addEventListener('submit', e => {
  e.preventDefault();
  let form = e.target;

  let data = new FormData(form);

  fetch(form.getAttribute('action'), {
    method: form.getAttribute('method'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    },
    body: new URLSearchParams([...data]),  // creates string in format key=value&key2=value2 in encoded format, etc.
  })
    .then(response => response.json());
});
```

- to iterate through FormData entries:
```javascript
let data = new FormData(form);
for (const pair of data.entries()) {
  console.log(pair[0], pair[1]);
}
```

#### Receiving JSON data
simple example:
```javascript
let request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');

request.addEventListener('load', event => {
  let data = JSON.parse(request.response); // depending on response, this may raise an error
  // do something with data
});

request.send();
```
- if `request.responseType` is not defined, developer will need to manually define what to do with various data types
  - trying to parse non-JSON data with `JSON.parse` will raise an error, would need to manage with a `try...catch` block
  - **Updated solution** : could add `request.responseType = 'json';`:

  ```javascript
  let request = new XMLHttpRequest();
  request.open('GET', 'https://api.github.com/repos/rails/rails');
  request.responseType = 'json';

  request.addEventListener('load', event => {
    // request.response will be the result of parsing the JSON response body
    // or null if the body couldn't be parsed or another error
    // occurred.

    let data = request.response;
  });

  request.send();
  ```

#### Submit form data in JSON
```javascript
let request = new XMLHttpRequest();
request.open('POST', 'https://lsjs230-book-catalog.herokuapp.com/books');
request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

let data = { title: 'Eloquent JavaScript', author: 'Marijn Haverbeke' };
let json = JSON.stringify(data);

request.send(json);
```
- serialized JSON will look like: `{"title":"Eloquent JavaScript","author":"Marijn Haverbeke"}`
- get in the habit of setting request headers for `Content-Type` to `application/json; charset=utf-8`

#### Working with form data
- use `querySelector` to get the form node (e.g.,`let form = document.querySelector('form')`)
- can then use `id` or `name` to access form data (e.g., `form['idValue']` or `form['nameValue']`)
  - the `idValue` or `nameValue` must be unambiguous (or else it will return nothing)


### CORS
- **Origin** : comprised of *scheme*, *hostname*, *port*
- **Cross-origin request** : occurs when a page tries to access a resource from a different origin
  - the *same origin policy* prevents `XMLHttpRequest` from making cross-domain requests
- **CORS** (Cross-Origin Resource Sharing) : a mechanism to allow cross-origin access to resources

- by default, an `XHR` object cannot send a cross-origin request
  - CORS is a W3C specification that defines how a browser and server must communicate when accessing cross-origin resources;  this will determine whether the request should succeed or fail
  - every `XHR` request must contain an `Origin` header with the origin of the requesting page
    - typically, this is added automatically by the browser
    - the receiving server will check `Origin` - if allowed, it will send back a response with the header `Access-Control-Allow-Origin` with value `*` (available to everyone) or the same origin

- Note:  may need to check "Disable cache" in developer tools, otherwise, CORS headers can be cached and thus result in unexpected behaviour





### Tools
- HTTPie : linux command line tool
  - to check version / installation: `http --version`
  - `http --print HBhb` : show submitted headers, request, etc. and response headers, body, etc.
  - `http Authorization:"token AUTH_TOKEN` : was required to submit a request header "Authorization" with value "token AUTH_TOKEN" to authenticate on heroku app
  - `http [url] name="Purple Pen 2.0"` : submits json body key-value pairs in request
  - `http --form` : submits POST request with header/content-type as HTML form data (e.g., `name=purple+Pen+2.0&sku=purp101`)


- Postman (now a windows app)
- deployed the LS test server at https://github.com/gotealeaf/web_store to heroku
  - my deployed URL is:  https://jctealeaf-f7d075977a46.herokuapp.com/
  - turns out there is a working LS version still online at: https://ls-230-web-store-demo.herokuapp.com


### Using Fetch
- typically must resolve things in stages:  each stage returns a promise:

```javascript
fetch(url, {method: 'GET'})           // see options available (e.g., headers, etc.)
  .then(response => response.json())  // can also call different methods on Response obj :  e.g., response.body() for readable stream
  .then(json => console.log(json));   // define what to do with the resulting data here
```

### HTML data attributes
- these are used to store extra-information on elements (e.g., to link a button to article, store additional metadata on an element)
- HTML attributes that always start with `data-` and at least 1 character after the `-`
- https://developer.mozilla.org/en-US/docs/Learn/HTML/Howto/Use_data_attributes
  - data attributes can be accessed (get and set) in HTML by using `.dataset` object available on the DOM element or `.getAttribute()`
  - data attributes can be accessed in CSS by using e.g., `attr(data-parent)` ('data-parent' is the name of the attribute)
- datasets:  https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/dataset



## Using JS libraries
- place script tags for the library BEFORE script tags where the library is used
- when using a CDN to load libraries (i.e., via script tag), be sure to include `integrity` and `crossorigin` attributes
  - this is for *subresource integrity*:  https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity
  e.g.,:
  ```html
  <!doctype html>
  <html lang="en">
    <head>
        <title>My Awesome Project</title>
        <script
          src="https://code.jquery.com/jquery-3.6.0.min.js"
          integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
          crossorigin="anonymous"
        ></script>
    </head>
    <body>

    <!-- rest of html -->
  ```

### jquery
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.2/jquery.min.js"></script>
- check if an object is a jquery object using `obj.jquery` : will return a string with jquery version or `undefined`
  - convention is to name all jquery objects with `$` prefix
  - **Careful** : keep track of whether your object / collection is a jquery object or a DOM object
    - jquery objects represent DOM objects, but are NOT DOM objects and DOM methods cannot be called on them
    - similarly, jquery methods CANNOT be called on DOM objects

- `$(document).ready(callback)` : DOM loaded and ready, referenced image on img tags are not ready
  - shortcut:  `$(callback)`
- `$(window).load(callback)` : DOM loaded and ready, referenced image on img tags loaded and ready

- `$('p')` : get all 'p' elements in a jquery object (e.g., `$ps = $('p')`)
- e.g., `$obj.css('font-size', '18px')` : **sets** css `font-size` for all elements in `$obj` (a jquery object)
- e.g., `$obj.css('font-size')` : **gets** the value of the `font-size` property for elements in `$obj`
  - can also pass in an object:
  ```javascript
  $obj.css({
    'font-size': '18px', // note use of quotes b/c of the '-' in `font-size`;  can also use 'fontSize'
    color: '#b00b00',
  });
  ```
- `.width()` / `.height()` : can be setter and getter for 'width' and 'height' property with *numeric* values

- traversing nodes:
  - e.g., `$obj.parent('.highlight')` : finds the parent(s) of `$obj` with class `'highlight'` 
    - argument for `parent` is optional
    - `parent` doesn't start matching with the current element (`.closest` does - may return the same elements as contained in the calling object)
  - `.closest('selector')` : will get the closest elements matching 'selector'
  - `.parents('selector')` : will get all parent elements matching 'selector'
  - `.find('selector')` : will get all child elements matching 'selector'
  - `.children('selector')` : will get immediate children matching 'selector' ('selector' is optional)
  - `.nextAll()`
  - `.prevAll()`
  - `.next()`
  - `.prev()`
  - `.siblings()`
- `.show()` / `.hide()`
- `.eq(#)` : returns the jquery object at index position `#` within a collection
- `[ # ]` : use of array notation on a jquery collection returns a *DOM* object at index `#` (not a jquery object)
- `.slideToggle()` : animate opening and closing (for "accordion elements")

- e.g., `$obj.on('click', callback)` : add a 'click' event listener to `$obj`
- e.g., `$obj.off('click')` : remove the 'click' event listener on `$obj`
- e.g., `$obj.trigger('click')` : used to trigger a 'click' event on `$obj`

- in jQuery:
- can use `.attr('data-name')` method to access 'data-name'
  - best for getting and setting HTML data attribute
- can use `.data('name')` method : accesses 'data-name'
  - setting using `.data` does NOT modify HTML, but sets  key-value data on an internal store for data on that DOM element
  - can be used to set and retrieve custom data *after* a page has rendered, but does NOT update HTML




### handlebars
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.5/handlebars.js"></script>
- https://handlebarsjs.com/guide/
- used for HTML templating : i.e., keep the HTML out of JS code
  - other libraries with similar features include Mustache and Underscore
- whitespace control: https://handlebarsjs.com/guide/expressions.html#whitespace-control
  - use of `~` character in `{{ }}` removes whitespace (can be used before or after expressions)
  - nesting of element tags vs handlebars expressions affects rendering
- Note: data (JS) must be passed into templates as an object with a key corresponding to what is identified in the template
  - e.g., `{{#each posts}}` implies that the data object passed in has a key `'posts'` which is an array

- STEPS:
  - HTML:  include handlebars script src in head;  create script template w/ id (`type=text/x-handlebars`)
            - template and handlebars need to match naming within a data object to be passed in (keys must match)
  - JS: get the element's HTML (`.innerHTML` in vanilla JS/DOM or `.html()` in jquery)
        - create the "handlebars function" using the template HTML : `templateFct = Handlebars.compile(templateHTML)`
        - create a desired element (optional)
        - generate resulting HTML from template/data object and turn it into an element:  e.g., `domElement.innerHTML = templateFct(dataObj)`
          - can modify existing elements, or create new elements and then append them to existing elements

- partials:
  - `Handlebars.registerPartial('myPartial', template)`
    - where 'myPartial' is the name of the partial (e.g., invoked with `{{> myPartial }}`)
    - where 'template' is the text string of the template (e.g., `innerHTML`)

- LS code to automatically register templates:
  ```javascript
  const templates = {};  
  // grabs all script tags with type 'text/x-handlebars' (i.e., full templates)
  document.querySelectorAll("script[type='text/x-handlebars']").forEach(tmpl => {
    // assigns (compiled) template to `templates` obj with defined 'id' (tag attribute)
    templates[tmpl["id"]] = Handlebars.compile(tmpl["innerHTML"]);
  });

  // grabs all partial templates based on `data-type` attribute
  document.querySelectorAll("[data-type=partial]").forEach(tmpl => {
    Handlebars.registerPartial(tmpl["id"], tmpl["innerHTML"]);
  });
  ```

- for partials, arrays, etc :  be aware of "context" and when I pass in another object (e.g., `this`)
  - my solution for /probs/04forms/05quiz shows this : passing `this` into `{{> radioTemplate}}` worked better
    -  previously I had the {{#each options}} within the main template instead of the partial - this prevented me from passing anything into each question

- Note:  the new element (using handlebars template) must be created in a `newElement` "container" using `newElement.innerHTML = template(data)`
  - to not include the `newElement` container, use `newElement.firstElementChild`



## Misc
- to change button appearance (disabled vs not disabled):
  - CSS selector:  `input[type="submit"] { css here... }` and `input[type="submit"]:disabled { css here }`
  - then set disabled attribute:  e.g., `document.querySelector('input[type="submit"]').disabled = true;`

- from Douglas Crockford lecture on theory of DOM (https://youtu.be/Y2Y0U-2qJMs)
  - early browser worked in this way:
    - (url) > **Fetch** > (cache) > **Parse** > (tree) > **Flow** > (display list) > **Paint** > (pixels)
      - "Flow" is a layout engine that calculates the size and position of each element
      - when an image is required, early browsers would go back to "fetch" (to get the image and determine how big it was supposed to be), while displaying nothing - this would happen for each image, which felt slow since nothing would be displayed until all images were retrieved
      - newer browsers put a placeholder in for the image and kept painting while the image fetch was taking place, and would then re-paint as images were received. This is actually slower, but is better for the user since some content appears quickly
  - modern scripted browser worked in a cycle:
    - **Flow** > **Paint** > **Event** > **Script** > (back to Flow)
      - "Event" could be any kind of event, fetch, UI event (e.g., click), timer, etc.
      - "Script" is a function call (i.e., event handler)
  - Douglas Crockford "walk the DOM" (recursive):
  ```javascript
  function walkTheDOM(node, func) {
    func(node);
    node = node.firstChild;
    while (node) {
      walkTheDOM(node, func);
      node = node.nextSibling;
    }
  }
  ```
  - in IE can use `node.currentStyle.stylename` to get the CSS styles assigned to a particular element (current state)
  - in non-IE (W3C), must use `document.defaultView().getComputedStyle(node, "").getPropertyValue(stylename)`
  - best practice (for IE6) to remove eventHandlers from a node before you delete the node (event handlers prevent garbage collection)
  - `alert`, `confirm`, `prompt` (all browser functions) - blocks the browser-thread (prevents asynchronous traffic from occurring in the background while the alert is on-screen);  recommended to avoid these

- there is a `defer` attribute of the `script` element:
  - https://developer.mozilla.org/en-US/docs/Web/HTML/Element/script
  - indicates to the browser that the script is meant to be executed after the document is parsed, but before firing `DOMContentLoaded`
  - cannot be used with inline scripts (i.e., need the `src` attribute)

- **fetch** vs **XMLHttpRequest**
  - https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
  - `XMLHttpRequest` is callback-based API (asynchronous)
  - `fetch` is promise-based (asynchronous)
  - `fetch` will return a `Response` object, which has a number of useful built-in methods (e.g., `response.ok?` which is true for any 2xx status code)

- HTML forms have a `submit` event

- **dispatch table** : an object which contains a series of key-value pairs where the key helps SELECT the appropriate value (function) to execute based upon the key
  e.g.,
  ```javascript
  const Calculate = {
    '+': (num1, num2) => num1 + num2,
    '-': (num1, num2) => num1 - num2,
    '*': (num1, num2) => num1 * num2,
    '/': (num1, num2) => num1 / num2,
  };

  let calculate = Calculate['*'];  // first "select" the right function
  let answer = calculate(1, 4);    // use the function
  ```

- to create colour palettes (UX design):  use adobe color (https://color.adobe.com/create/color-wheel)

- CSS transitions - to make things appear / disappear:
  - use `visibility: hidden` and `visibility: visible` along with `opacity: 0` and `opacity: 1`
  - `modal` will have CSS `transition: visibility 1s, opacity 1s`;  start with `hide` (as desired)
  - add CSS classes `show` (`visibility: visible; opacity 1`) or `hide` (`visibility: hidden; opacity: 0`) on click
  - Note:  cannot transition visibility if the entire element is removed from the DOM; don't remove elements for transitions
      - better to just show/hide and dynamically change element content when clicked

- https://developer.mozilla.org/en-US/docs/Learn/Forms/Form_validation
  - HTML forms have a `novalidate` attribute to prevent built in validations
    - turns off browser's automatic validation
    - still allows JS and constraint validation API (e.g., `pattern`) with custom validation messages to run
    - `:valid` css selector still works
  - input validation can be done using the `pattern="regex here"` of inputs
  - can also use `data-allowed-pattern` attribute (e.g., `data-allowed-pattern="\d"` allows only digits)

- import a "module" js within HTML:
  - include in header:  `<script type="module" src="./filename.js"></script>`
  - within `filename.js` can include:  `import someFunc from './otherFolder/anotherFile.js'`
  - within `anotherFile.js` need to include: `export default function someFunc() {}`



## To review
- [X] Q3 https://launchschool.com/lessons/519eda67/assignments/5e87f026
      - my initial implementations to retry did not work with the catch block properly
      - really need to understand the nuance of synchronous vs asynch and how to make the loop (retries) happen as-if "synchronous" - i.e., need to try the attempt, exit if successful or try again if failed a fixed number of times
      - **Notes**:  my new solution worked;  both new solution and LS solution involve a "recursive" solution - need to keep trying the given function and need to that with 'nested' catch invocations while keeping count of the number of attempts

- [X] Q5 https://launchschool.com/lessons/519eda67/assignments/5e87f026
      - try to replicate the coding pattern used in LS solution for `loadData` - different than my initial, but makes sense as a "package" (single function and simple function invocation)
      - **Notes** :
        - definitely better to catch the error in the `loadData` function
        - the question DEFINES the response to an error - catching it and then returning a new promise (i.e., `return Promise.resolve('Using cached data)`) - need to pay attention to the question

- [X] Q4 https://launchschool.com/lessons/519eda67/assignments/2f41b3a1
      - suspect LS solution may only works since the fallback is delayed by 1 sec; otherwise how can we be sure that the primary is being used?
      - re-work solution to guarantee the primary is tried first, then the fallback secondarily
      - **Notes**:
        - remember:  an async function always returns a **promise** - can't just use output directly (e.g., with a `console.log`)
          - need to use `.then` to wait for promise to resolve

- [X] Q5 https://launchschool.com/lessons/519eda67/assignments/2f41b3a1
      - could confirm feedback sent:  i.e., need explicit return in solution for `fetch(url)` and don't want to "pre-process" errors as indicated in the LS solution
      - **Notes**:
        - output is specified specifically - the `catch` method in `loadMultipleResources` is there to alter the error message

- [X] Q4 https://launchschool.com/lessons/519eda67/assignments/90b41710
      - confirm that my solution actually fetches each resource sequentially and not in parallel
      - **Notes**:
        - `Promise.all` and `Promise.allSettled` offer *concurrent* async task execution, which is not strictly sequential
        - i.e., my original solution (using `Promise.allSettled`) would NOT be sequential
        - using explicit `await` steps (e.g., like LS solution and my subsequent solution) are expicitly sequential

- [X] https://launchschool.com/exercises/7555977a
      - had a lot of trouble with this - especially making each function in an array of functions execute each second
      - **Notes**:
        - clearly `setInterval` would have been easier
        - making use of `async/await` made counting seconds by giving the interval easier
        - separating "counting time" from "executing callbacks" made things very easy

- [X] get very comfortable walking the DOM and doing something to each node
      - **Notes**:
        - memorized the approach for "walking the DOM";  may not need to use it that frequently, DOM API querySelector may be easier

- [X] https://launchschool.com/exercises/ba09ed14
      - had some trouble with identifying valid elements to delegate to
      - would help to practice this again
      - **Notes**:
        - had trouble with the callback - forgot to pass in 'e' and didn't recognize the error.  Pay more attention to the errors - make sure I track them down and don't jump to conclusions
        - remember, I can use `===` on nodes - the same node will return true for the `===` operator
        - it helps to review all of the use cases to understand the problem before coding.  working through use cases 1 at a time is okay, but can be slow if I need to revise my approach each time


- [X] https://launchschool.com/exercises/c2055175
      - there are "built-in" ways of accomplishing this that may be more straightforward than my solution
      - my solution felt a bit "spaghetti"
      - **Notes**:
        - updated solution was much cleaner, although I didn't parse the data fully to count staff schedules
        - definitely felt more confident with promises / asynchronous code and organizing it


- [ ] https://launchschool.com/exercises/2a95a258
      - my solution was okay - but perhaps a bit spaghetti
      - try making the solution easier to understand and more straightforward
      - could also try with async/await syntax (like user submitted solutions)

- [ ] https://launchschool.com/exercises/1aefc02b
      - do this problem, but with a "toggle" (can use 'hidden' attribute, `toggleAttribute`)

- [ ] could try practice problems with various OO methods (e.g., pseudo-classical, prototypal, class, etc.)
      - also try with `fetch` vs `XMLHttpRequest` : will need to get familiar with different syntax

- [ ] https://launchschool.com/exercises/05c8e206
      - further exploration: my UI was very simple and did NOT refresh once changes were made
      - could re-do this to refresh data once changes are made to a booking, etc.
      - could also add student names to the displayed bookings (for teachers) - need to pull student list and incorporate info

- [ ] https://launchschool.com/lessons/bf83d729/assignments/0a5dd23b
      - my solution worked for show/hide, but transitions did not work
      - LS solution enables transitions, and is much cleaner

- [ ] https://launchschool.com/exercises/b9409ae0
      - my solution was good
      - it would have been better if I had encapsulated it into a package and made it "tighter"