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

## Elements
- can access the attributes of an Element using:
  - `.getAttribute(name)` : returns value as string
  - `.setAttribute(name, newValue)` : sets the value, returns `undefined`
      - use `Element.value` instead of `Element.setAttribute` if possible (`setAttribute` works inconsistently for some attributes, potentially where default values exist)
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


##
