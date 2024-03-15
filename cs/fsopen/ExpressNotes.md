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



## Misc

- **nodemon** : used to allow "auto-restart" of a dev server running on localhost ("hot reload")
  - e.g., `npm install --save-dev nodemon` (only required while doing dev)
  - add to `package.json`:  `"dev": "nodemon index.js"`