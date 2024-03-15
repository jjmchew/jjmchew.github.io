# React notes

- compiling of jsx to js is handled by Babel
- all JSX tags need to be closed (e.g., `<br />`)
- all React components need 1 root element
    - could be `<>  </>`
    - could also put all elements in an array
- all react elements (const or other JS variables) need to be capitalized

- click handlers
  - generally these should be FUNCTIONS, *not* function *CALLS*
  - otherwise, the function would be called everytime the page re-renders, which is every click (which becomes an infinite cycle if that function call alters state)

- when importing files / components, ensure the file path is given relative to the importing file


## Components
- do not define components inside of other components
  - it will be treated as a new component on every render making it impossible for React to optimize
- remember:  components created from a collection (e.g., array) require a unique `key` property - tie this to a unique data identifier (i.e., UID in data)
- when creating elements via a collection and assigning event handlers:
  - note distinction betwen all elements have the same event handler VS creating a distinct handler for each element
  ```javascript
  { notes.map(note =>
    <Note
      key={note.id}
      toggleStatus={() => toggleHandler(note.id)}  // this creates a distinct handler for each element
    />
  )}
  ```

## State

- *if several components reflect the same changing data (i.e., same state), lift the shared state up to their closest common ancestor*

- setting state to a value passed in as a prop ONLY makes sense if further values passed as props are meant to be ignored (i.e,. to set an initial or default state)
  - state will only be initialized during the first render

- remember: don't mutate state
  - with arrays, use `array.concat('newValue')` will return a new array

- don't call the `useState` function from inside a loop, a conditional expression, or any place that is not a function defining a component (hooks must always be called in the same order)


## useEffect
- "effects let a component connect to and synchronize with external systems.  This includes dealing with network, browser DOM, animations, widgets written using a different UI library, and other non-React code."



## json-server
- a library package that takes a json file and "serves" it as an API through a localhost port
- `npm install json-server --save-dev`
- in `package.json` :  add to "scripts" `"server": 'json-server -p3001 --watch db.json"`
- make sure `db.json` file is in project root directory
- run with `npm run server`
- object in `db.json` will be served at `localhost:3001/persons`
