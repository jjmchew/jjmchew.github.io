# Jest (JS testing framework)

## install
- `npm install --save-dev jest`
- test files in `file.test.js` identifies them as tests
- add to `package.json`:
  ```json
  {
    "scripts" : {
      "test": "jest"
    }
  }
  ```

- best not to use `import` : only experimental support for ECMAScript modules
  - if using `import`, need to add to `package.json`:
    `"type": "module"`
  - instead, use **COMMON JS modules**
    - `const func = require('./file.js');`
    - `module.exports = func;`

- basic test:
```javascript
beforeAll(() => {

});

afterAll(() => {});

beforeEach(() => {
  // code here
});

afterEach(() => {
  // code here
});

test('description', () => {
  expect(2 + 2).toBe(4);
});

describe('a set of tests', () => {
  it('description', () = {
    expect(1+1).toBe(2);
  });
});
```

- use "matchers" (https://jestjs.io/docs/using-matchers)
  - `expect().toBe()`
  - `expect().toEqual()` (can be used for objects)
    - `.toBeCloseTo()` : used for floating point math
  - `expect().not.toBe()`
  - `.toBeNull()`
  - `.toBeDefined()`
  - `.toBeUndefined()`
  - `.toBeTruthy()`
  - `.toBeFalsy()`
  - `.toBeGreaterThan()`
  - `.toMatch(/regex/)` : match strings with regex
  - `.toContain()` : for arrays / iterables
  - `.toThrow()` : for errors

- `test.only` makes only 1 test run


## JSDOM
- https://info340.github.io/jest.html

- `npm install --save-dev jest-environment-jsdom` (to include jsdom test environment for jest)
  - `--save-dev` adds the package to `devDependencies`
- could also install optional extended matchers for DOM assertions
  - `npm install --save-dev @testing-library/jest-dom`

- include dot block at top of file to configure jest to use jsdom

- "mount" HTML content into Jest's `document` object:
  - `document.documentElement.innerHTML = "<html></html>"`;
- can use node `fs`to read HTML

```javascript
/**
 * @jest-environment jsdom
*/

const { readFile } = require('node:fs/promises');
const { resolve } = require('node:path');

async function read(path) {
  try {
    const filePath = resolve(path);
    const contents = await readFile(filePath, { encoding: 'utf8' });
    return contents;
  } catch (err) {
    console.error(err.message);
  }
}

beforeEach(async ()=> {
  return read('./02page.html').then(data => document.documentElement.innerHTML = data);
});

test('interact with DOM', () => {
  let title = document.querySelector('h1');
  expect(title.textContent).toMatch(/A title/);
});
```

  - external scripts must use `require()`
    - all file locations are **relative to the location of the test file**

## W/ Puppeteer
- https://www.browserstack.com/guide/testing-library-jest-dom
- `npm i --save-dev puppeteer`

- NOTE:  although CHROME is needed, it should be downloaded as part of puppeteer - likely do not need to install my own version of it
  - may need chrome for testing:  https://developer.chrome.com/blog/chrome-for-testing
    - `npx @puppeteer/browser install chrome@stable`
    - note:  I needed to be on the latest version of Node (v20) and *NOT* the default v13 which is running when I start ubuntu in WSL

- web also recommends installing jest-puppeteer:  https://medium.com/touch4it/end-to-end-testing-with-puppeteer-and-jest-ec8198145321
  - `npm install --save-dev jest-puppeteer`
```javascript
const puppeteer = require('puppeteer');

let browser;
let page;

beforeAll(async () => {
  browser = await puppeteer.launch();
  page = await browser.newPage();
  await page.goto('http://localhost:8000/02page.html');
});

afterAll(async () => {
  await browser.close(); // must close browser at end of test
});

test('use puppeteer to test localhost and find a button', async () => {
  const input = await page.$('form input[type="text"]');
  input.value = 'hello';
  console.log(input.value);
  await page.screenshot({ path: 'button.png' }, 1000);
  expect(input).not.toBeNull();
});
```

## Using ES6 modules
- in `package.json`:
  ```javascript
  {
    "type": "module",
    "scripts": {
      "test": "node --experimental-vm-modules node_modules/jest/bin/jest.js"
    }
  }
  ```
- for puppeteer: `import puppeteer from 'puppeteer';`




