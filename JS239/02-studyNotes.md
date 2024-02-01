# JS239 study notes

## Using Web APIs to work with the DOM

### DOM
- **DOM** (Document Object Model):
  - an in-memory representation of an HTML document
  - provides a way to interact with a webpage using JavaScript
  - provides functionality to develop modern interactive user experiences on the web
  - **is a hierarchy of nodes** where each node can contain any number of child nodes

- the DOM will vary from actual HTML written when:
  - JS is used to manipulate the DOM
  - browsers automatically insert element (e.g., `<head>` `<body>`, `<tbody>`, etc.)

- the DOM is comprised of nodes
  - element notes (HTML tags, specific sub-types inherit from `HTMLElement`)
  - text nodes (including whitespace nodes or "empty" nodes)
  - comment nodes

- **Node** : a single point in the node tree (e.g., document, element, text, comment, etc.)
  - complete list of nodeType:  https://developer.mozilla.org/en-US/docs/Web/API/Node/nodeType
  - Notes:  element nodes have no `nodeValue`;  then have `textContent` (all contained `nodeValue` concatenated together)
  - `EventTarget` is a type of node
 
 - Determining node type:
  - use `.toString()` OR `.constructor` (or `.constructor.name`) on a node to get the type
  - use `instance of` (e.g., `document.querySelector('p') instance of HTMLParagraphElement` returns `true`)
    - or `p instance of Element`
  - use `.tagName` (result is in uppercase) or `.nodeName`
  - `.nodeType`

- **live collection** :
  - an "array-like" collection of DOM nodes or HTML elements which update automatically to reflect changes in the DOM
  - `document.getElementsByClassName` and `document.getElementsByTagName` both return live collections


### Common web APIs
- methods or properties exposed by DOM objects that allow us to interact with those objects
  - `document.querySelector()`
  - `document.createElement(tagName)`
  - `document.createTextNode(text)`
  - `Element.setAttribute()`
  - `Element.innerHTML`
  - `Element.innerText`
  - `Node.firstChild`, `Node.lastChild`, `Node.childNodes`, `Node.nextSibling`, `Node.previousSibling`, `Node.parentNode`
  - `Element.firstElementChild`, `.lastElementChild`, `.children`, `.nextElementSibling`, `.previousElementSibling`
  - `EventTarget.addEventListener()`
  - `HTMLElement.style`
  - `HTMLElement.classList`
  - `Node.appendChild()`
  - `Node.remove()`
  - `Node.cloneNode(deepClone)`
  - `parent.insertBefore(node, targetNode)` (insert `node` before `targetNode`)
  - `parent.replaceChild(node, targetNode)` (remove `targetNode`, insert `node` in its place)

- specific node properties which can be used to 'get' and 'set':
  - `id`
  - `name`
  - `title`
  - `value`


## Understanding event-driven programming for front-end development

### Events
- **event**:
  - an object that represents an occurence
  - the object contains info on what happened, where, other details
  - the browser triggers events : e.g., page loads, user interactions, etc.
  
- **event listener** (or *event handler*): the code the browser runs in response to an event
  - note: multiple event listeners of the same type can be added to the same element

- common events:
  - **Reference**: https://developer.mozilla.org/en-US/docs/Web/Events
  - `DOMContentLoaded` : HTML received from server, parsed, JS evaluated, COM constructed from parsed HTML, 'DOMContentLoaded' fires on `document`
  - `load` : after 'DOMContentLoaded', page displayed, embedded assets are loaded, 'load' event fires on `window`
  - jquery `$.ready` is similar to `DOMContentLoaded`

- `event.target` : the element interacted with
- `event.currentTarget` (same as `this`) : the element to which the event listener is attached


### Capturing / Bubbling
- capturing and bubbling are 2 different phases which an event goes through after it initially fires
  - events are dispatched to each element twice, but will only fire in 1 phase : capturing OR bubbling (the default)
  - Note:  objects which do not have a parent-child relationship with the target will not be affected (i.e., siblings will not fire an event)

- **capturing**:
  - the event gets dispatched to the global `window` object and then down *nested elements* to the target element
  - at each nested element, the event will check for any listeners that might be attached to various elements

- **bubbling**:
  - the event gets dispatched from the target element back up *parent elements* to the global `window` object

- `event.stopPropogation()`
  - prevents the event from propogating along its path and triggering any further associated events
  - can prevent a `preventDefault` from being reached further along the propogation path

- `event.preventDefault()`
  - the default behaviour prevented is associated with the **event** object, *not* the target element
    - e.g., a `click` event listener on both a nested `a` and a parent `div` : a `preventDefault` on the parent `div` will prevent default behaviour on the `a`
  - the browser waits for capturing and bubbling phases before performing the default action (or not if `preventDefault` is anywhere in the propogation path)


### Event delegation
- assigning an event listener to common parent of multiple elements to manage interactions on multiple elements with a single event listener
  - depending on the number and type of elements, it may add complexity to the event listener


### Event loop
- DOM events are not a part of the JS runtime - they are part of Web APIs provided by the DOM, ajax (e.g., XMLHttpRequest), etc.
  - events / activities from these APIs go to a callback queue
  - the event loop monitors the JS runtime and pulls activities from the callback queue to be executed



## Asynchronous JavaScript
- asynchronous code : code that doesn't run continuously and sequentially (i.e., not *sequential code*)
  - to determine if code is asynchronous, you must understand what (and how) functions are called and the behaviour of those functions

- `async/await` - `await` can only be used to wait for something which returns a *promise*
  - a callback-based delay must be wrapped in a promise first
  - `await` can only be used to create 'synchronous' execution within an `async` function
    - e.g., `let res = await new Promise()`  :  the resolved value of the `Promise` is assigned to `res`


### callbacks
- **callback** (function) : a function passed into another function as an argument which is later invoked to complete an action

- `setTimeout`
  - note:  code executed by `setTimeout` is called from a different execution context than the function where `setTimeout` is called
    - using a "wrapper" function (e.g., arrow function) is generally best (passes in the same execution context as where `setTimeout` was called)
  - if using multiple `setTimeout`s : each invocation occurs synchronously, must set a successively longer delay to *mimic* waiting for the next count to occur

- `setInterval`
  - `let id = setInterval(callback, msDelay)` :  use `clearInterval(id)` to cancel the interval
  - `clearInterval()` can be called from "within" the callback function passed to `setInterval` (just need to assign the id to an in-scope variable)


### promises
- promises have 3 states:
  - pending : operation not yet complete
  - fulfilled : successful completion
  - rejected : failed completion / error

- to conduct activities synchronously, must chain `.then` methods, passing data which resolves from the previous promise to the next in the chain
  - each `.then` method returns a promise to allow chaining
  - functions that aren't explicitly promises are assumed to resolve and will be executed synchronously as long as they are within chained `then` methods

- use `.catch` for error handling
  - it will catch any errors arising from prior `.then` methods


## Communicating with the server through XHR and rendering the response to the page

### Communicating with the server

### Rendering the response to the page



## jQuery

### Using web APIs

### Event-driven programming
- jquery `$.ready` is similar to `DOMContentLoaded`

### Asynchronous JS

### Communicating with the server