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

## Using Environment variables
- should likely use a `.env` file to store all environment variables for local and prod (e.g., deployed URI / folder, etc.)
- in `testNode` project, I hard-coded the options into the various files and let the `NODE_ENV` support selecting the appropriate "mode"
  - this works, but since variables are hard-coded, is less ideal for deployment and quick changes / working with a group

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
