# TypeScript notes

- "official" TS playground:  https://www.typescriptlang.org/play

## Enum
```javascript
enum Weather {
  Sunny = 'sunny',
  Rainy = 'rainy',
  Cloudy = 'cloudy',
}

// type predicate to determine if a param is of type "Weather" (the enum)
const isWeather = (param: string): param is Weather => {
  return Object.values(Weather).map(v => v.toString()).includes(param);
};
```
- to narrow type `unknown` to an enum:
  - must establish:
    - non-`null`
    - a string
    - string matches enum strings (using above code)
  - e.g., `if (!txt || !isString(txt) || !isWeather(txt)) throw new Error('Incorrect info provided'); return txt;`



## install
- `npm install --save-dev ts-node typescript`
  - `ts-node` is used to remove the compilation step from running `.ts` files
  - can add `"ts-node": "ts-node"` to `package.json` to use an automatic `npm` script to run `.ts` files

- config file is `tsconfig.json`
  - can run `tsc --init` to create a `tsconfig.json` file

## @types
- generally types are defined with an `@types` package
- see: https://github.com/DefinitelyTyped/DefinitelyTyped

- `npm install --save-dev @types/node @types/react @types/express @types/lodash @types/jest @types/mongoose`

- note:  `@types/node` is a peer dependency of `ts-node` v7.0+

## modules
- read https://www.typescriptlang.org/docs/handbook/modules/introduction.html

## ESlint
- `npm install --save-dev eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser`

```json
// .eslintrc
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking"
  ],
  "plugins": ["@typescript-eslint"],
  "env": {
    "node": true,
    "es6": true
  },
  "rules": {
    "@typescript-eslint/no-explicit-any": 2,
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/restrict-template-expressions": "off",
    "@typescript-eslint/restrict-plus-operands": "off",
    "@typescript-eslint/no-unused-vars": [
      "error",
      { "argsIgnorePattern": "^_" }
    ],
    "@typescript-eslint/semi": ["error"],
    "no-case-declarations": "off"
  },
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json",
    "ecmaVersion": 11,
    "sourceType": "module"
  }
}
```
- add to `package.json`:
  - `"lint": "eslint --ext .ts ."`

- can create an `.eslintignore` file


## Express
- can use `ts-node-dev` to auto-reload servers
  - `npm install --save-dev ts-node-dev`


## New project steps:
- make a project directory, enter it
- `npm init`
- `npm install --save-dev typescript`
- `tsc --init` (then check config options)
  - NOTE:  `"outDir"` seems to EXCLUDE files from linting - if `outDir` is the same as `rootDir` no linting will occur and an error is raised

- `npm install express`
- `npm install --save-dev ts-node-dev`
  - add scripts to `package.json`
  - e.g., `"dev": "ts-node-dev index.ts"`
- `npm install --save-dev eslint @types/express @typescript-eslint/eslint-plugin @typescript-eslint/parser`
  - add scripts to `package.json`
    - e.g., `"lint": "eslint --ext .ts ."`
- create `.eslintrc` file:
```json
{
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking"
  ],
  "plugins": ["@typescript-eslint"],
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "rules": {
    "@typescript-eslint/semi": ["error"],
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/restrict-template-expressions": "off",
    "@typescript-eslint/restrict-plus-operands": "off",
    "@typescript-eslint/no-unsafe-member-access": "off",
    "@typescript-eslint/no-unused-vars": [
      "error",
      { "argsIgnorePattern": "^_" }
    ],
    "no-case-declarations": "off"
  },
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  }
}
```
