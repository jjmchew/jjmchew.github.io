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
- `.innerText` : returns text associated with an element
- `.data` : returns the textual content of a text node
    - this belongs to the `CharacterData` DOM interface which presents textual data as a `DOMString` (a String-like object)

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

- properties on `document` or `document.body` (IE)
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
- `parent.insertBefore(node, targetNode)` : insert `node` into `parent.childNodes` before `targetNode`
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

