# Express notes

- `npm install express`

```javascript
const express = require('express');
const app = express();

app.use(express.json()); // MUST enable json parser to easily use JSON body content

let notes = [
  { id: 1, name: 'note1' }
];

app.get('/', (request, response) => {
  response.send('<h1>Hello World!</h1>')
});

app.get('/api/notes', (request, response) => {
  response.json(notes)
});

app.get('api/notes/:id', (req, res) => {
  const id = Number(req.params.id);  // note all params are strings by default
  const note = notes.find(note => note.id === id);

  if (note) res.json(note);
  else {
    res.statusMessage = 'Note not found';  // set custom error message (a node property on the response object, not express)
    res.status(404).end();  // need to manually manage errors if `note` is undefined
                               // .end() indicates no data will be sent
  }
});

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
});
```

## middleware
- `app.use(express.json())` : uses json-parser which is an express middleware
  - https://expressjs.com/en/api.html
  - this middleware takes raw data from the request object, parses into a JS object and assigns it to the `body` property of the `request` object

- can write custom middleware by creating a function with parameters `(request, response, next)`
  ```javascript
  const requestLogger = (request, response, next) => {
    console.log('Method:', request.method)
    console.log('Path:  ', request.path)
    console.log('Body:  ', request.body)
    console.log('---')
    next()  // passes control to next middleware
  }

  // invoke with
  app.use(requestLogger);
  ```
- middleware functions are executed depending on where they are defined
  - i.e., must be defined (with `use()`) prior to a route, if it should be executed on that route
  - can be defined after a route to manage unknown routes
  ```javascript
  const unknownEndpoint = (request, response) => {
    response.status(404).send({ error: 'unknown endpoint' })
  }

  app.use(unknownEndpoint)
  ```
- error handling middleware must be *the last* middleware loaded
  - all routes must be loaded prior to this middleware
  - custom error handling middleware must be a function which takes parameters `(error, request, response, next)`

- ideal middleware order (for aspects from fsopen course):
  - `express.static()`
  - `express.json()`
  - `requestLogger`
  - `unknownEndpoint`
  - `errorHandler`



## Cors
- to run a backend server and a front-end react dev server concurrently and use differnt port numbers, need to install cors middleware

- `npm install cors` : installs Node's cors middleware
- `const cors = require('cors')`
- `app.use(cors())`


## Misc

- **nodemon** : used to allow "auto-restart" of a dev server running on localhost ("hot reload")
  - e.g., `npm install --save-dev nodemon` (only required while doing dev)
  - add to `package.json`:  `"dev": "nodemon index.js"`

### Debugging Express
- can run files using `--inspect` and then use Chrome Developer Tools to debug (e.g., sources > breakpoints, console, etc.)
  - e.g., `node --inspect index.js`
  - then open Chrome > go to server URL/port > open dev tools > click on green node logo in top L of dev tools

### Async errors
- can use `express-async-errors`:
  - no need to use `try/catch` blocks in express routes - the package will automatically take care of all async errors
  - i.e., no need to define `(request, response, next)` and `catch (exception) { next(exception) }`

### Test / DB setup
- if saving more than 1 note into the db, use `Promise.all(dbActionsArray)` to ensure all db entries are saved prior to starting testing
  - can't use a `forEach` loop
  - can use a `for..of` loop




## Using Environment variables
- part of fsopen Part 3c (https://fullstackopen.com/en/part3/saving_data_to_mongo_db)

- should likely use a `.env` file to store all environment variables for local and prod (e.g., deployed URI / folder, etc.)
- in `testNode` project, I hard-coded the options into the various files and let the `NODE_ENV` support selecting the appropriate "mode"
  - this works, but since variables are hard-coded, is less ideal for deployment and quick changes / working with a group

- in `package.json`:
  - run scripts by passing in required env variables:
    - e.g., `"server:prod": "NODE_ENV=production node index.js"`
    - e.g., `"server:dev": "NODE_ENV=development nodemon index.js"`

  - use package `cross-env` to get environment variables to work in Windows environment


### Back end
- for `testNode` project, used:
  - `process.env.NODE_ENV = process.env.NODE_ENV || 'development'`
  - `const ROOT = process.env.NODE_ENV === 'development' ? '' : '/testa'`

### Front end
- for `testNode` project, used:
  - for `api.js`:  set `BASE_URL` with `process.env.NODE_ENV`
  ```javascript
  const BASE_URL = process.env.NODE_ENV === 'production'
                   ? 'https://jjmchew.a2hosted.com/testa/api/persons'
                   : 'http://localhost:3001/api/persons';
  ```
  - check Vite (if using Vite) resources on environment variables:
    - https://vitejs.dev/guide/env-and-mode.html

  - building (with Vite):
    - for 'production':  run `vite build --base=/testa/`
    - for 'development' (i.e., localhost): run `NODE_ENV=development vite build --mode development` 
    - can still add longer scripts: e.g., `"rm -rf dist && rm -rf ../back/dist && npm run build && cp -r dist ../back"` (adjust `npm run build` to reference the appropriate script and build for prod vs dev)


## Testing
- test expects all tests to be named with "extension" `.test.js`
  - e.g., `reverse.test.js`

```javascript
const { test } = require('node:test');
const assert = require('node:assert');

describe('average', () => {
  test('some desc', () => {
    const result = funcToTest();
    assert.strictEqual(result, 'expectedResult');
  });

  test('another test', () => {
    const result = funcToTest();
    assert.strictEqual(result, 'anotherExpectedResult');
  });
})
```

### Testing APIs
- fsopen part4b:  https://fullstackopen.com/en/part4/testing_the_backend

- `npm install --save-dev supertest`  (use another package)
```javascript
const { test, after, beforeEach } = require('node:test');
const mongoose = require('mongoose');

const supertest = require('supertest');
const app = require('../app.js');
const api = supertest(app);

beforeEach(async () => {
  // do db setup here
  // example (using Mongoose, full requires not included above)
  await Note.deleteMany({})
  let newNote = new Note(initialNotes[0]);
  await newNote.save();
});

test('notes are returned as json', async () => {
  await api
    .get('/api/notes')
    .expect(200)
    .expect('Content-Type', /application\/json/); // note use of regex to find a string *that contains* 'application/json', NOT one that equals 'application/json'
});

test('there are 2 notes',  async () => {
  const response = await api.get('/api/notes');
  assert.strictEqual(response.body.length, 2);
});

test('first note is about HTTP methods', async () => {
  const response = await api.get('/api/notes');
  const contents = response.body.map(e => e.content);
  assert.strictEqual(contents.includes('HTML is easy'), true);

  // OR
  assert(contents.includes('HTML is easy'));
});

after(async () => {
  await mongoose.connection.close();
});
```
- can also use `assert.deepStrictEqual` (for nested objects)

- use `test.only` to run only 1 test and run testing with `npm test -- --test-only`
- use `npm test -- --test-name-pattern='name of test or describe block here'`
- may need to create helper methods for testing (e.g., `initialNotes`, `nonExistingId`, `notesInDb`)
- note tests are executed at the same time by default
  - can use flag `--test-concurrency=1` to define tests to be executed sequentially


## Authentication

### Passwords
- use node.bcrypt.js to store password hashes:  https://github.com/kelektiv/node.bcrypt.js/#a-note-on-rounds
  - `npm install bcrypt`
  - see fsopen 4c
  - `await bcrypt.compare(password, user.passwordHash)`

- note that password restrictions should not be tested with MongoDB validations - passwords received are not what is stored (password hashes)


### Sessions
- use jswebtoken library to generate JSON web tokens:  https://github.com/auth0/node-jsonwebtoken
  - `npm install jsonwebtoken`
  - see fsopen 4d

- `const token = jwt.sign(userForToken, process.env.SECRET, {expiresIn: 60*60})`
  - where `const userForToken = { username: user.username, id: user._id }`
- then `response.send({ token, username: user.username, name: user.name})`
- use `decodedToken = jwt.verify(getTokenFrom(request), process.env.SECRET)`
  - where `getTokenFrom(request)` is a helper function that access the Authorization header and removes the prefix "Bearer " from the header value (which will be the token)


### Authentication scheme
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#authentication_schemes
- "Bearer" scheme:
  - use Authorization header to send "Bearer [token here]"

- should extend express middleware to accommodate token errors (e.g., invalid token and token expired)
- setting an expiry time for tokens is best practice

- **server-side sessions**:
  - saving tokens to a backend database to allow each API request to be checked to see if access rights associated with that token are still valid
  - if not, those righs can be revoked at any time
  - common to use Redis for this
    - Redis is a key-value database with limited functionality (compared to MongoDB or relational DBs), but is extremely fast for some use cases
  - common for tokens to just be a random string (i.e., do not include any info about the user - that info is saved in server-side db)
  - also common to use cookies to transfer token b/w client and server and not use the Authorization header

- always need to consider how to minimzie Cross Site Scripting (XSS) attacks
  - i.e,. the injection of JS code which an app might inadvertently execute
  - React generally sanitizes all rendered text, so is generally less of a concern w/ React

- an alternative option for saving tokens is the use of **httpOnly cookies** (https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#restrict_access_to_cookies)
  - this may or may not be safer than localStorage



## local storage
- a key-value database in the browser
- `window.localStorage.setItem('key', 'value')`
- `window.localStorage.getItem('key')`
- `window.localStorage.removeItem('key')`
- `window.localStorage.clear()` : empties localStorage

- info must be saved in JSON format (values are saved as DOMstrings)
- can be used to save login information (i.e., id's, etc.)

## Misc
- express security best practices:  https://expressjs.com/en/advanced/best-practice-security.html

- recommended library for backend express servers:  https://helmetjs.github.io/

