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
  - Notes:  element nodes have no `nodeValue`;  they have `textContent` (all contained `nodeValue` concatenated together)
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

- using `data` attributes:
  - assign an attribute to elements which is prefixed by `data-`
    - e.g., `<div id="gold" data-block-="gold"></div>`
  - 'store' that element
    - e.g., `let gold = document.getElementById('gold')`
  - access the property `dataset`
    - e.g., `console.log(gold.dataset)`
    - e.g., `gold.dataset.block = 'silver'` (change the value of that attribute)
    - e.g., `delete gold.dataset.block` (remove data attribute)
    - e.g., `gold.dataset.sponser = 'newSponsor'` (add an attribute 'data-sponsor')


## Understanding event-driven programming for front-end development

### Events
- **event**:
  - an object that represents an occurence
  - the object contains info on what happened, where it happened, other details
  - the browser or the user trigger events : e.g., page loads, user interactions, etc.
  
- **event listener** (or *event handler*): the code the browser runs in response to an event (a callback)
  - note: multiple event listeners of the same type can be added to the same element
  - use `element.addEventListener` to register event listeners on an element

- common events:
  - **Reference**: https://developer.mozilla.org/en-US/docs/Web/Events
  - `DOMContentLoaded` : HTML received from server, parsed, JS evaluated, COM constructed from parsed HTML, 'DOMContentLoaded' fires on `document`
  - `load` : after 'DOMContentLoaded', page displayed, embedded assets are loaded, 'load' event fires on `window`
  - jquery `$.ready` is similar to `DOMContentLoaded`

- `event.type` : returns a string of the event type (e.g., `click`, `load`, `error`, etc.)
- `event.target` : the element interacted with
- `event.currentTarget` (same as `this`) : the element to which the event listener is attached

- keyboard event properties:  `.key`
- mouse event properties:  `.button`, `.clientX`, `.clientY`


### Capturing / Bubbling
- events go through **3** phases:  capturing, target, bubbling

- capturing and bubbling are different phases which an event goes through after it initially fires
  - events are dispatched to each element twice, but will only fire in 1 phase : capturing OR bubbling (the default)
  - Note:  objects which do not have a parent-child relationship with the target will not be affected (i.e., siblings will not fire an event)

- **capturing**:
  - the event gets dispatched to the global `window` object and then down *nested elements* to the target element
  - at each nested element, the event will check for any listeners that might be attached to various elements

- **target**:
  - the event reaches the `target` element (e.g., the element clicked)

- **bubbling**:
  - the event gets dispatched from the target element back up *parent elements* to the global `window` object


- `event.stopPropogation()`
  - prevents the event from propogating along its path and triggering any further associated events (in current and further phases)
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

- additional methods:
  - `Promise.all(promiseArray)` : will return an array with all resolved values (same order), or rejects immediately if any input promise rejects
  - `Promise.race(promiseArray)` : will return a single value for the first promise that resolves
  - `Promise.allSettled(promiseArray)` : returns an array with the status of each input promise (i.e., an object: `{ status: 'rejected', reason: 'returned string'} `) (status: 'fulfilled' or 'rejected')
  - `Promise.any(promiseArray)` : returns the first resolved value of any input promise;  if all promises are rejected it returns an `AggregateError` (which groups all individual errors)


### async/await
- `async` : tells a function to return a promise, resulting return can use `.then`, etc.
  - any return value (even if just a string) is wrapped in a promise
- `await` : is only used in async functions and *only* for promises
  - it tells JS to *wait* until the promise is fulfilled before executing subsequent code


### Notes
- Remember:  the output of an asynchronous function (e.g., uses `async`) is a *promise*
  - can't just `console.log(asynchFunc())` - the output will be a pending promise
  - always need to use `.then` or `await` to ensure the promise resolves prior to using output


## Communicating with the server through XHR and rendering the response to the page

- `XMLHttpRequest` is a browser API that provides network programming functionality to JS applications
  - it uses the HTTP protocol and it's included request/response cycle

- **Single Page Applications** : web applications where the DOM is entirely created from JavaScript running in a client's browser
  - these applications are often run entirely within a single HTML page with all data being passed as JSON (not HTML)
  - these applications rely exclusively on JavaScript and `XMLHttpRequest` to communicate with the server and build up the DOM

- **SSR** (Server-side rendering) : building a complete web page on the server and sending that page to the client (the web browser) which then display it

- **CSR** (Client-side rendering) : the server sends only a bare-bones HTML document and some JavaScript to the client;  the client then executes the JS code which requests the data it needs from the server to fill out the rest of the page dynamically


### Communicating with the server

- typically communicate through an *API*
- **API** (Application Programming Interface) : a way for computer systems to interact with each other
  - APIs provide functionality for use by another program
  - most commonly used to share or transfer data, enable automation, customize software behaviour or integrate it with other systems
  - there are public and private APIs


- web APIs (or HTTP APIs) are built with web technologies and operate over HTTP
  - requests have methods, paths, protocol version (e.g., HTTP/1.1), headers, (sometimes) a body
    - example headers:
      - "Accept" : defines desired media type of response (e.g., `*/*` is any type, `application/json`, etc.)
  - responses have 3 main parts:  status code, headers, body
    - `Content-Type: application/json` header describes the format of the response body (also called media type or MIME type)
    - `Access-Control-Allow-Origin: *` : allow all sites access via CORS
    - `Allow: GET, HEAD` : define allowed methods (e.g., GET, HEAD)
    - `Content-Length` : specifies length of body in bytes
    - `ETag: "6df23dc03f9b54cc"` : identifies a specific version of a resource
    - `Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT` : specifies last time the requested resource was modified
    - `WWW-Authenticate: Basic` : specifies basic HTTP authentication is required to access the resource
    - `X-RateLimit-Limit: 60` : headers with `X-` are non-standard, often application-specific headers

  - typical convention used is "REST" (REpresentational State Transfer)
    - define all interactions as being with a "resource"
    - define *WHAT* resource is acted on and *HOW* we change/interact with that resource
    - CRUD defines the 4 actions that can be taken on resources:
      - Create (POST http method: can act on an element resource or collection)
      - Read (GET)
      - Update (PUT)
      - Delete (DELETE)

    - PUT is typically used to update the value of a resource using a complete representation of that resource (i.e., send all required values back to the server)
      - missing values are thus assumed to be empty (e.g., null or nil)
      - some PUT implementations are more similar to PATCH (which only updates the values given and ignores the unspecified values) - this convention is less widely adopted
      - PUT is **idempotent** (making a series of identical requests is the same as making a single request)
        - (POST is *not* : multiple requests will add multiple entries to the collection)
      - the URL used for PUT should be the same as the URL that will be used in future to GET the data


  - elements:  a representation of a single type of API resource
  - collections: a grouping of elements of the same type; commonly the collection is a "parent" and an element is a "child"
- API provider : the system providing the API for other parties (generally the "server")
- API consumer: the system *using* the API to accomplish some work (generally the "client")

- URLs are comprised of:
  - scheme : e.g., http
  - hostname : e.g., google.com
  - path : e.g. /api/v1 (may contain a "placeholder" e.g., /:id to represent variables)
  - query string (optional) : e.g., query=term&size=50

  - single resource (also called a singleton resource): a path (or URL) that identifies a single resource


- typically data sent to the server (an API) is *serialized*
  - i.e., converted to a format that is more easily or efficiently stored or transferred
  - e.g., XML (extensible markup language) or JSON (JavaScript Object Notation)

#### AJAX
- **A**synchronous **J**avaScript **A**nd **X**ML : 
  - a technique used to exchange data between a browser and a server without causing a page reload
  - an HTTP request from a web browser that does not require a full HTTP page reload
  - benefits:
    - reloading an entire webpage is a limiting factor (a lot of data is transmitted, takes a lot of time)
    - all HTTP methods are available (i.e., not just GET / POST)
    - detailed control of headers is possible (e.g., data can be requested in different formats, HTML, JSON, XML, etc. which may not be possible with a purely HTML-based form)
  - Notes:
    - JS code initiates AJAX requests, typically from event listeners
    - once a response is received by the browser, JS handles the response (and can decide what to do with the response)

### XMLHttpRequest
- `XMLHttpRequest` objects are part of the browser API (not JS language)
- `request.send` is asynchronous
- popular response formats are HTML, JSON, XML
  - JSON is the most popular

```javascript
let request = new XMLHttpRequest(); // create new XMLHttpRequest object
request.open('GET', '/path');  // optional 3rd argument: false indicates send using a synchronous request (likely deprecated in modern browsers);  true is redundant (default - asynchronous request)
request.setRequestHeader('Content-Type', value); // e.g., value could be 'application/json; charset=utf-8'
request.send(); // `.send(data)` optional
request.timeout = 30; // time in ms until timeout
request.readyState;
request.responseType = 'json' // could also be `text`, `arraybuffer`, `blob`, `document`
request.abort();

request.addEventListener('load', event => {
  // let xhr = event.target; // if the original request object is defined within a function and not accessible from an outer scope, it can be accessed in this way
  request.responseText;
  request.response; // will change to reflect `responseType`
  // Note:  `responseText` is only available if `responseType` is '' or 'text'
  request.status;
  request.statusText;
  request.getResponseHeader('Content-Type');
});

request.addEventListener('error', e => {  // note additional handler added to manage errors
  console.log('An error occurred');
});
```
- `XMLHttpRequest` events:
  - `loadstart` : request sent to server
  - `readystatechange` : some change occurs (e.g., `OPENED`, `HEADERS_RECEIVED`, `LOADING`, `DONE`, etc.)
  
  - `load` : complete response loaded
  - `abort` : request was interrupted before it could complete
  - `error` : an error occurred
  - `timeout` : a response was not received before end of timeout period

  - `loadend` : last event to fire:  response loading done and all other events hae fired

- NOTE:  all received respones are considered successful, even if response has a non-200 status code or represents an application error
  - i.e., the "semantic meaning" of the response is NOT considered - the developer needs to *inspect* the response and  accommodate this based on the application

- query string / URL encoding:
  - use `encodeURIComponent` for URL encoding for query strings (e.g., use `%20` or `+` for spaces)
    - encoded data in HTTP request body must have `Content-Type: application/x-www-for-urlencoded; charset=utf-8` header
    - including `charset` is optional, but considered best practice

- multipart form data:
  - multipart forms use a *delimiter* defined within the header
    - e.g., `Content-Type: multipart/form-data; boundary=----WebKitFormBoundarywDbHM6i57QWyAWro`

- JSON:
  - header:  `Content-Type: application/json; charset=utf-8`
  - `let data = JSON.stringify(dataObj)`



#### Serializing data for submission
- URL-encoding for POST:
  - set header: `request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");`
  - encode keys / values with `encodeURIComponent`
  - combine then into a string with format `key=value&key2=value2` etc.

- using `FormData`:
  - `let data = new FormData(form)` : where `form` is the DOM form element (e.g., `let form = document.querySelector('form')`)
  - `form.method`, `form.getAttribute('action')`
  - using `request.send(form)` will send formData as a multipart form

- using JSON:
  - `request.responseType = 'json'`  (if this isn't defined, may need to use `try/catch` blocks to test if response is parse-able)
  - `let data = JSON.parse(request.response)`


### Rendering the response to the page
- if using `XMLHttpRequest`:
  - once the response is received, DOM content can be updated using JS
  - e.g., if HTML is received, can use `element.innerHTML = request.response`
  - 

### Common HTTP/API responses / errors
- client (user) errors (4XX):
  - 422 Unprocessable Entity : sometimes missing parameters, validation errors on data provided
  - 404 Not Found:
    - resource may not exist
    - URL could be incorrect
    - authentication may be required (but server does not indicate this for security reasons)
  - 401 or 403 Forbidden : authentication errors, valid credentials required
    - 403 may also indicate rate limiting is in effect (i.e., only a fixed number of requests within a specified time are allowed)
  - 415 Unsupported Media Type : data was provided in the wrong format
  - 405 Method Not Allowed : typically used if requested methods are not specified in `Allow` header

- server errors (5XX)
  - typically caused by:
    - bugs or oversights in the server implementation
    - hardware or other infrastructure problems with remote system
    - any other error not foreseen by the remote server implementation
  - can sometimes be fixed by trying the API again later

- 201 Created : new data entry created by server
- 204 No Content : request successfully processed, but no data is sent back (e.g., a good response for a DELETE request)

- 304 Not Modified : often used in conjunction with `ETag` headers


### CORS
- **CORS** (Cross Origin Resource Sharing) : a W3C specification that defines how the browser and server must communicate when accessing cross-origin resources
  - request must include `Origin` header
  - response must include `Access-Control-Allow-Origin` header
    - this header can include the specific `Origin` supplied in the request
    - could also include `*`
  - if both request and response headers match, then the browser will allow the script access to the response

- a *cross-origin request* occurs when a page tries to access a resource from a different origin
  - i.e., scheme, hostname and port of requesting page are different from that of resource URL

- by default `XHR` objects *cannot* send cross-origin requests for security reasons
  - browsers implement a security feature called the **same-origin policy** which prevents `XHR` objects from making cross-origin requests


### debounce
- used to **throttle** XHR requests (i.e., send only the requests that are required)
  - e.g., autocomplete - don't need to search on every keypress, just keypresses after a fixed interval to allow users to type
```javascript
// debounce.js
export default (func, delay) => {
  let timeout;
  return (...args) => {
    if (timeout) { clearTimeout(timeout) }
    timeout = setTimeout(() => func.apply(null, args), delay);
  };
};

// project JS file
import debounce from './debounce.js';

const App = {
  // etc

  this.valueChanged = debounce(this.valueChanged.bind(this), 300); 

  //etc
}
```

## jQuery
- a library that provides an API to work with DOM, manipulate elements, handle events, make AJAX requests
  - a function that wraps DOM elements and convience methods into an *object*
  - convention is to use `$` to prefix jquery objects
  - all jquery objects have a `.content` property - this can be used to check if a variable / object is a jquery object

- equivalent operations in jquery / vanilla JS/dom:
    - https://tobiasahlin.com/blog/move-from-jquery-to-vanilla-javascript/


### Using libraries
- libraries like jquery were traditionally used to ensure that the same front end code worked across all browsers
- reading documentation:
  1. first read high-level overview : understand use case(s), assess fit, basic mental model / syntax
  2. check tutorials / how-tos : should provide a way to get quickly up to speed and achieve specific goals
  3. use API references, as required:
    - learn the structure (e.g., how things are grouped)
    - learn the syntax / style of documentation
    - leverage existing mental models for fundamental concepts

- libraries can be be hosted:
  - locally (i.e., downloaded to same server as HTML / application files)
  - using a CDN (i.e., available online through a Content Distribution Network)
    - remember to include `integrity` and `crossorigin` attributes
    - these attributes are part of a browser security feature called **subresource integrity**
      - https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity
    - e.g.,
    ```html
    <script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
    ```


### Using web APIs
- get elements:  `let $content = $('#content')` : will store element with id 'content', returned as a collection object (array-like)
  - can use `$content.length` to see how many items are in the collection
- CSS:  `$content.css('attribute', 'value')`  :  setter
        `$content.css('attribute')`  : getter
- many methods can be chained
- may also be able to input multiple key-value pairs by passing in an object, rather than a string
  - e.g., for CSS:  `$content.css({ 'font-size': '18px', color: '#b00b00'})`

- traversing DOM:
  - `$element.parent(selector)` : can pass in an optional selector to target a specific parent (will not check itself)
  - `.parents()` : will get all parents
  - `.closest(selector)` : closest parent (including itself, if matching)
  - `.find(selector)` : checks for child elements (incl. nested) that meet a selector criteria
  - `.children()` : gets all immediate children
  - `.next()` : next sibling element
  - `.last()` : last sibling element  (can also use `.eq(-1)`)
  - `.nextAll()`
  - `.prevAll()`
  - `.hide()` : hide element
  - `.show()` : show element
  - `.eq(idx)` : will get the element with index number `idx` from a collection (e.g., of multiple children)
  - `.odd()` : will get the odd-number elements
  - `.not()`

- `$element.val()` : changes value of an element (e.g., for an input)
- `.text()` : gets text value
- `.remove()` : removes the element from DOM


- pseudo-selectors:
  - https://api.jquery.com/category/selectors/
  - e.g., `$('li li').filter(":contains('ac ante')")` : can use `filter` and also pseudo-selector `:contains()` (a string)
  - `:not()`
  - e.g., `$('a[href^="#"]');` : pseudo-selector `^` for "beginning with"
  - e.g., `$('[class*=block]');` : pseudo-selector `*` for "contains"

- misc:
  - `.stop()` : stops current animations on element
  - `.fade()` : animate visibility of element (needs `visibility: visible` CSS)
  - `.fadeIn()` : animate appearance

### Event-driven programming
- jquery `$.ready` is similar to `DOMContentLoaded` (DOM loaded and ready, referenced img tags are not ready)
  - can also use `$( function() {} )`
- `$(window).load( function() {} )` : DOM loaded and ready, referenced img tags are loaded and ready
- `$('a').on('click', e => {})` : adds 'click' listener to 'a' element (or all 'a' elements')
  - `.off()` removes an event listener
- `$('a').trigger('click')` : e.g., will trigger the 'click' event listener registered on the 'a' element(s)
- `.slideToggle()` : built-in method for accordion content (i.e., clicking a button reveals more content)
- `$element.append(string)` : where `string` is HTML text; HTML elements in `string` will get appended to `$element`
- `$element.html()` : will get HTML within `$element` (e.g., good for handlebars templates)

- `$element.attr('data-block')` : will return the value of the `data-block` attribute of `$element`
  - can also be used as a setter:  `.attr('data-block', 'newvalue')` - will change the HTML markup
- `$element.data('block')` : equivalent to above (will return value of `data-block` attribute)
  - can also be used as a setter:  `.data('block', 'newvalue')` - will *not* change the HTML markup, data is stored in a separate internal jquery data store associated with that element


### Asynchronous JS
- `$.ajax(configObj)` where `configObj` contains:
 ```javascript
let configObj = {
  url: '/path',
  type: 'GET',
  dataType: 'json',
};

$.ajax(configObj)
.done(function(json))
.fail(function())
.always();
 ```


### Communicating with the server