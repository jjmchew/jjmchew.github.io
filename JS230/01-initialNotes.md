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


## Events
- once displayed, most UIs *wait* for something to happen, then execute the appropriate code as a response
  - an **event** is an object that represents some occurrence
  - an **event listener** (also known as **event handler**) is code that browser runs in response to an event

- common events:
  - keyboard:  `keydown`, `keyup`
  - mouse:  `mouseenter`, `mouseleave`, `mousedown`, `mouseup`, `click`, `mousemove`
  - touch: `touchstart`, `touchend`, `touchmove`
  - window: `scroll`, `resize`
  - form: `submit`

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

### Event capturing and bubbling
- nested elements can also "trigger" events
  - e.g., adding eventListener to outermost event allows `event.target.id` to identify inner nested elements that are clicked
    - `event.currentTarget.id` will always be the element with the eventListener (i.e., the outer element)
    - Note:  `this` (if using a function expression) will be the same as `event.currentTarget`
- event "capturing":
  - the event always starts at `window`, goes to `document`, continues to get passed inwards to `target`
  - as it passes various elements, they are "checked" to see if there is a relevant eventListener
  - once it reaches `target`, "capturing" is finished
- event "bubbling":
  - from `target` it moves back outwards, and any relevant eventListeners are "fired" (i.e., callback functions are executed)
- `addEventListener(event, callbackFn, useCapture)`
  - can set `useCapture` to `true` to fire events on capture, rather than bubble (which is default)
  - e.g., `addEventListener('click', event => console.log(event.key), true)`

- `event.stopPropogation()` : prevents further bubbling or capturing (depends on whether events are triggered on capture or bubbling)
- `event.preventDefault()` : prevents a "default action" (e.g., loading a page when clicking on an "a" href)
  - the default behaviour is attached to the `event` object, *not* the event listener (e.g., all nested events can have their default behaviour prevented)
  - all capturing / bubbling happens *before* default actions are performed;  thus a single "preventDefault" in the propogation path (any listener that the event "travels" to) prevents all default behaviour
    - Note:  if `stopPropogation` is used, then the event may not "reach" a `preventDefault` defined for a nested event
      - this will depend on whether an eventListener is defined on capture / bubble, nesting, etc.

### Event delegation
- the use of *event propogation* to attach a single event handler to a parent element, rather than attach individual eventListeners to individual objects
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


### Event loop
- the **event loop** - monitors the call stack and task queue (or callback queue, or message queue):  If the stack is empty, it takes the next item (e.g., a callback function) from the *task queue* and pushes it onto the stack (and runs it)
- code such as `setTimeout` or XHR requests are part of a *web API* (part of the browser, not the JS runtime) which allows things to run concurrently
  - web API code will run asynchronously and then go to the *task queue* where the *event loop* will move it to the stack once ready
- the *JS runtime* is the JS engine (e.g., Chrome V8) which is "pure JS";  the browser also includes access to *web APIs* and includes functionality of the *task queue* and *event loop* which collectively support *asynchronous* activities
- node.js is similar, but instead of web APIs, it has "C++ APIS"
- in ES6 (for promises) (https://blog.bitsrc.io/understanding-asynchronous-javascript-the-event-loop-74cd408419ff):
  - a "job queue" (also called micro-task queue) is added, which has higher priority than the message queue
  - promises use the job queue, which will be resolved before tasks waiting in the task/message queue


## Misc
- to change button appearance (disabled vs not disabled):
  - CSS selector:  `input[type="submit"] { css here... }` and `input[type="submit"]:disabled { css here }`
  - then set disabled attribute:  e.g., `document.querySelector('input[type="submit"]').disabled = true;`




