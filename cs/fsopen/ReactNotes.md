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

## Components
- do not define components inside of other component
  - it will be treated as a new component on every render making it impossible for React to optimize



## State

- *if several components reflect the same changing data (i.e., same state), lift the shared state up to their closest common ancestor*

- setting state to a value passed in as a prop ONLY makes sense if further values passed as props are meant to be ignored (i.e,. to set an initial or default state)
  - state will only be initialized during the first render

- remember: don't mutate state
  - with arrays, use `array.concat('newValue')` will return a new array

- don't call the `useState` function from inside a loop, a conditional expression, or any place that is not a function defining a component (hooks must always be called in the same order)
