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

## use of Hooks
- don't call hooks inside loops, conditions, or nested functions
  - always use hooks at the top level of your React function
- don't call hooks from regular JS functions
  - call hooks from React function components
  - call hooks from custom hooks

### Custom hooks
- name must start with the prefix `use`

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

## useState

- *if several components reflect the same changing data (i.e., same state), lift the shared state up to their closest common ancestor*

- setting state to a value passed in as a prop ONLY makes sense if further values passed as props are meant to be ignored (i.e,. to set an initial or default state)
  - state will only be initialized during the first render

- remember: don't mutate state
  - with arrays, use `array.concat('newValue')` will return a new array

- don't call the `useState` function from inside a loop, a conditional expression, or any place that is not a function defining a component (hooks must always be called in the same order)


## useEffect
- "effects let a component connect to and synchronize with external systems.  This includes dealing with network, browser DOM, animations, widgets written using a different UI library, and other non-React code."


## useRef
- `useRef` allows access to a component's function from outside the component
- e.g., creating a `Togglable` component that creates a toggle functionality to display/hide child components along with the required buttons
  - state for visibility of child components should be local to the `Togglable` component, but we may want to change that state from outside the component

```javascript
import { useRef } from 'react';

const App = () => {
  // ...
  const noteFormRef = useRef(); // note useRef

  // note ref is passed to the component
  const noteForm = () => (
    <Togglable ref={noteFormRef}>
      <NoteForm />
    </Togglable>
  );

  // ...

  // to use the function exposed by useRef
  const addNote = (noteObject) => {
    noteFormRef.current.toggleVisibility(); // access noteFormRef
    noteService
      .create(noteObject)
      .then(returnedNote => {
        setNotes(notes.concat(returnedNote))
      });
  };
};
```
- use of `useRef` ensures that `noteFormRef` refers to the same component (`Togglable`) on each re-render

```javascript
// changes made to Togglable component
import { useState, forwardRef, useImperativeHandle } from 'react'


const Togglable = forwardRef((props, refs) => {
  const [visible, setVisible] = useState(false)

  const hideWhenVisible = { display: visible ? 'none' : '' }
  const showWhenVisible = { display: visible ? '' : 'none' }

  const toggleVisibility = () => {
    setVisible(!visible)
  }


  useImperativeHandle(refs, () => {
    return {
      toggleVisibility
    }
  })

  return (
    <div>
      <div style={hideWhenVisible}>
        <button onClick={toggleVisibility}>{props.buttonLabel}</button>
      </div>
      <div style={showWhenVisible}>
        {props.children}
        <button onClick={toggleVisibility}>cancel</button>
      </div>
    </div>
  )

})

export default Togglable
```
- need to add `forwardRef` and `useImperativeHandle`
  - `forwardRef` wraps the `Togglable` function
  - `useImperativeRef` make the function `toggleVisibility` available outside the `Togglable` component



## Router
- generally use react-router library:  https://reactrouter.com/en/main
- `npm install react-router-dom`

- `Router` (`BrowserRouter`) components wrap child components to be conditionally rendered (e.g., `Notes`, `Users`, `Home`)
  - `BrowserRouter` uses HTML5 history API to sync UI w/ URLs
- `Link` changes URL in address bar when clicked
- `Route` renders based upon the path (URL)

- `useMatch` : can be used to figure out if a parameterized route is provided (e.g., with an `id`)
  - if used, just define `Router` component 1 level higher (e.g., within `index.jsx` instead of `App.jsx`)

```javascript
import { useState } from 'react'
import {
  BrowserRouter as Router, // note change in name
  useNavigate,
  Navigate, // a component to redirect users
  Routes, Route, Link
} from 'react-router-dom'

const App = () => {
  const [user, setUser] = useState(null) 
  const padding = {
    padding: 5
  }

  const navigate = useNavigate()
  const onSubmit = (event) => { // not used below, but illustrates useNavigate
    event.preventDefault()
    props.onLogin('mluukkai')
    navigate('/')
  }

  return (
    <>
      <Router>
        <div>
          <Link style={padding} to="/">home</Link>
          <Link style={padding} to="/notes">notes</Link>
          <Link style={padding} to="/users">users</Link>
          {
            user
            ? <em>{user} logged in</em>
            : <Link style={padding} to="/login">login</Link>
          }
        </div>

        <Routes>
          <Route path="/notes/:id" element={<Note notes={notes} />} />
          <Route path="/notes" element={<Notes />} />
          <Route path="/users" element={user ? <Users /> : <Navigate replace to="/login" />} /> 
          <Route path="/login" element={<Login onLogin={login} />} />
          <Route path="/" element={<Home />} />
        </Routes>

      </Router>
      <footer>
        <div>
          <i>Note app, Department of Computer Science 2023</i>
        </div>
      </footer>
    </>
  )
}
```

```javascript
// within Notes component (to illustrate parameterized route)
import {
  // ...
  useParams
} from 'react-router-dom'

const Note = ({ notes }) => {

  const id = useParams().id // accesses URL parameter
  const note = notes.find(n => n.id === Number(id)) 
  return (
    <div>
      <h2>{note.content}</h2>
      <div>{note.user}</div>
      <div><strong>{note.important ? 'important' : ''}</strong></div>
    </div>
  )
}
```





## json-server
- a library package that takes a json file and "serves" it as an API through a localhost port
- `npm install json-server --save-dev`
- in `package.json` :  add to "scripts" `"server": 'json-server -p3001 --watch db.json"`
- make sure `db.json` file is in project root directory
- run with `npm run server`
- object in `db.json` will be served at `localhost:3001/persons`


## misc
- updating state for a collection:
  - e.g., `setPersons(persons.map(obj => obj.name === person.name ? newObj : obj));`, where `newObj` might be a response from an API, etc.
  - `map` returns a new collection, that collection will contain the updated object in place of the old object in the existing collection

- notification messages:
  - I tried having state within the component to manage a timeout, however the re-draw and update didn't seem to work
  - it was definitely more straightforward with state in the main app which also managed the timeout with a helper function

- see Part7-3 front end for custom hooks for API usage, input fields
- see Part9-4 front end for TS versions




## new projects
- using Vite:  `npm create vite@latest myProject --template react`;  `npm run dev`
- using Create-React-App:  `npx create-react-app myApp`;  `npm start`




## npm
- `npm update` : updates the dependencies of the project 
- `npm install` : installs the dependencies listed in the `package.json` file

- when creating scripts (e.g., `build:prod`), combine shell commands using `&&`
  - e.g., `"build:prod": "rm -rf dist && rm -rf ../back/dist && npm run build && cp -r dist ../back"`
    - will remove old dist files from `front` and `back`, build new `dist` files, copy them to `back` (to be served by `express.static` as part of front-end)
  - see `testNode` project

- `npm install -g npm-check-updates` : used to check how current dependencies in a react are
  - can run `ncu -u` to update a `package.json` file

- `npm audit` : compares list of dependencies against known security risks

- when running npm scripts, all arguments before `--` are for `npm`, arguments afterwards are for commands being run
  - e.g., `npm run tsc -- --init`, where `"tsc" : "tsc"` is a script in `package.json`
  - is equivalent to running `tsc --init` from the command line



## Prop-types
- a library that allows types required for React components to be defined:
  - `npm install prop-types`
  - `import PropTypes from 'prop-types'`
```javascript
Togglable.propTypes = {
  buttonLabel: PropTypes.string.isRequired,
  handleSubmit: PropTypes.func.isRequired,
};
```
- Note:  if using TypeScript, don't need to use propTypes - can define TS interfaces to define types for props


## Front-end Testing
- fsopen part 5c uses `vitest`, `jsdom`, `react-testing-library` (instead of Jest, used previously)'
  - note:  this is distinct from back-end testing using `node:test` (i.e., syntax will vary)

  - `jsdom` simulates a web browser
  - `npm install --save-dev vitest jsdom`
  - `npm install --save-dev @testing-library/react @testing-library/jest-dom`
  - `npm install --save-dev @testing-library/user-event` : used to simulate user input in user testing
  - `npm install --save-dev eslint-plugin-vitest-globals` : used if eslint is active and complains about globals `test`, `expect`
    - add to `.eslint.cjs`:
      - `env: {"vitest-globals/env": true}`
  - `npm install --save-dev @testing-library/user-event` : used to simulate user events in testing

- in `package.json` scripts:
  - `"test": "vitest run"`

- run w/ `npm test`
- get test coverage using `npm test -- --coverage`
  - will need top install library `@vitest/coverage-v8`


- can create a `testSetup.js` file
```javascript
import { afterEach } from 'vitest'
import { cleanup } from '@testing-library/react'
import '@testing-library/jest-dom/vitest'

afterEach(() => {
  cleanup()
})
```
  - need to update `vite.config.js` to include:
    - `globals: true` : indicates no need to import keywords such as `describe`, `test`, `expect`
    - `setupFiles: './testSetup.js'`

- by default, config looks for test files in the same directory as the component to be tested
  - filename should be `[component name].test.jsx`


```javascript
// example test file
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event`
import Note from './Note'

test('renders content', () => {
  const note = {
    content: 'Component testing is done with react-testing-library',
    important: true
  }

  render(<Note note={note} />) // render method used to render to 'screen'

  // OR
  const { container } = render(<Note note={note} />);
  // use const div = container.querySelector('.note') to return a specific element

  const element = screen.getByText('Component testing is done with react-testing-library')  // use 'screen' method to access rendered component
  expect(element).toBeDefined() // expect is a Vitest command
});

test('clicking the button calls event handler once', async () => {
  const note = {
    content: 'Component testing is done with react-testing-library',
    important: true
  }

  const mockHandler = vi.fn()

  render(<Note note={note} toggleImportance={mockHandler} />)

  const user = userEvent.setup() // note start of session
  const button = screen.getByText('make not important') // find button
  await user.click(button) // click button
  expect(mockHandler.mock.calls).toHaveLength(1)
});
```
- methods on `scren` used to access specific elements:
  - `.getByText(str)` : looks for element containing `str`
      - can include option `{ exact: false }`
      - e.g., `const element = screen.getByText('Does not work', {exact: false})`

  - `.queryByText(str)` : simliar to `getByText`, but will not return in error if not found
      - good for ensure something is *not* rendered to screen
      - i.e., select using `.queryByText()` and then `expect(element).toBeNull()`

  - `.findByText(str)` : similar to `getByText` but it returns a *promise*

  - `.getByTestId(id)` : looks for element by `id`
  - `.getByRole(str)` : where `str` is a role like 'textbox'
  - `.getAllByRole(str)` : returns *all* elements (in an array) with role `str`
  - `.getByPlaceholderText(str)` : gets elements based on placeholder text in `str`
  - `.querySelector(str)` : similar to DOM method

  - `.debug(element)` : outputs to terminal the HTML of `element`


- methods on `expect` for testing:
  - `expect(element).toBeDefined()`
  - `expect(div).toHaveTextContent(str)`
  - `expect(div).toHaveStyle(str)`, where str is a style (e.g., 'display: none')

- methods on `user`:
  - `user.click(element)`
  - `user.type(element, strInput)`


## End-to-end Testing
- fsopen 5d:  https://fullstackopen.com/en/part5/end_to_end_testing_playwright

- E2E tests can be time-consuming, flaky (i.e., inconsistent)

- uses 'Playwright', an alternative is 'Cypress'
  - playwright: https://playwright.dev/
    - tests are executed in the node process, which is connected to the browser via programming interfaces
    - pro: browser support (chrome, firefox, webkit browsers e.g., safari)
  - cypress: https://www.cypress.io/
    - tests are run entirely within the browser

- tests can be located in an entirely different npm project
- can create endpoints that are only loaded if app is run in test mode
  ```javascript
  if (process.env.NODE_ENV === 'test') {
    const testingRouter = require('./controllers/testing');
    app.use('/api/testing', testingRouter);
  }

  app.use(middleware.unknownEndpoint);
  // etc.
  ```


## React TS
- `npm create vite@latest appName -- --template react-ts`

```javascript
import ReactDOM from 'react-dom/client'

interface WelcomeProps {
  name: string;
}

const Welcome = (props: WelcomeProps): JSX.Element => {
  return <h1>Hello, {props.name}</h1>;
};

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Welcome name="Sarah" />
)
```
- note: defining return type of react component (`JSX.Element`) is optional - can be inferred by TS compiler
  - could also define type as: `const Welcome: React.FC<PropTypes> = ({ prop1, prop2 }) => {};`

- https://react-typescript-cheatsheet.netlify.app/

- onSubmit event:  use type `React.SyntheticEvent`

- for `label` elements use `htmlFor` instead of `for`
  - e.g.,  `<label htmlFor={props.val}>{props.val}</label>`


## Misc
- `setInterval` does funny things:  https://overreacted.io/making-setinterval-declarative-with-react-hooks/

- using React Router with a nginx:
  - https://gist.github.com/huangzhuolin/24f73163e3670b1cd327f2b357fd456a
  - https://www.barrydobson.com/post/react-router-nginx/
  - https://stackoverflow.com/questions/46820682/how-do-i-reload-a-page-with-react-router
  - https://ui.dev/react-router-cannot-get-url-refresh