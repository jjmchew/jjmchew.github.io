# JS239 study notes

## Using Web APIs to work with the DOM

### DOM
- **DOM** (Document Object Model):
  - an in-memory representation of an HTML document
  - provides a way to interact with a webpage using JavaScript
  - provides functionality to develop modern interactive user experiences on the web

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

- **live collection** :
  - an "array-like" collection of DOM nodes or HTML elements which update automatically to reflect changes in the DOM
  - `document.getElementsByClassName` and `document.getElementsByTagName` both return live collections


### Common web APIs
- methods or properties exposed by DOM objects that allow us to interact with those objects
  - `document.querySelector()`
  - `document.createElement()`
  - `Element.setAttribute()`
  - `Element.innerHTML`
  - `EventTarget.addEventListener()`
  - `HTMLElement.style`
  - `Node.appendChild()`

## Understanding event-driven programming for front-end development


## Asynchronous JavaScript


## Communicating with the server through XHR and rendering the response to the page

### Communicating with the server

### Rendering the response to the page



## jQuery

### Using web APIs

### Event-driven programming

### Asynchronous JS

### Communicating with the server