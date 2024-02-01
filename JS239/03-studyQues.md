# JS239 questions

## 1
- from lesson 2 assignment 21, problem 3 (https://launchschool.com/lessons/519eda67/assignments/5e87f026)
- how to explain the behaviour below?
  - i.e., the inclusion of the `await` keyword allows the catch block to catch the error

```javascript
function retryOperation(operationFunc) {
    let count = 0;
  
    let attempt = async function () {
      count += 1;

      // await operationFunc(); // catch block below WILL catch error
      operationFunc();  // catch block below will NEVER catch error
    };

    attempt().catch(err => console.log('Operation failed'));
  }

  // Example usage:
  retryOperation(
    () =>
      new Promise((resolve, reject) =>
        Math.random() > 0.8
          ? resolve("Success!")
          : reject(new Error("Fail!"))
      )
  );

```

**Notes**:
- it appears that if the `async` keyword is included, then `await` must also be included for the function to return the error properly (i.e., not in a promise)
- if the `async` keyword is not used, then the `await` keyword is not necessary for the `catch` method to work

## 1A
- related - modification of the code still does not allow the error to be caught:
```javascript
  function retryOperation(operationFunc) {
    let count = 0;
  
    let attempt = function () {
      console.log('starting attempt ', count);
      count += 1;

      return operationFunc()
      .then(console.log)
      .catch(err => {
        console.log(`Attempt ${count} failed`);
        if (count < 3) attempt(); // THIS LINE is key:  `return attempt()` makes the difference for the error to be caught
        else {
          console.log(err.message, ' Operation failed');
          throw err;
        }
      });
    };

    attempt().catch(err => console.log('Operation failed')); // this catch method is never executed
  }

  // Example usage:
  retryOperation(
    () =>
      new Promise((resolve, reject) =>
        Math.random() > 0.8
          ? resolve("Success!")
          : reject(new Error("Fail!"))
      )
  );
```

**Notes**:
- see line marked "THIS LINE is key"
  - as written, the error thrown will NOT be caught by the catch method
  - IF the line is modified to `return attempt()` then the final error *IS* caught
  - Hypothesis: each invocation of `attempt` is technically *nested* within itself, so the final invocation needs to return a promise, otherwise, the catch block does not apply