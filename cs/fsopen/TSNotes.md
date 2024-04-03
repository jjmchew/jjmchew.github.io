# TypeScript notes

- "official" TS playground:  https://www.typescriptlang.org/play


## install
- `npm install --save-dev ts-node typescript`
  - `ts-node` is used to remove the compilation step from running `.ts` files
  - can add `"ts-node": "ts-node"` to `package.json` to use an automatic `npm` script to run `.ts` files

- config file is `tsconfig.json`


## @types
- generally types are defined with an `@types` package
- see: https://github.com/DefinitelyTyped/DefinitelyTyped

- `npm install --save-dev @types/node @types/react @types/express @types/lodash @types/jest @types/mongoose`

- note:  `@types/node` is a peer dependency of `ts-node` v7.0+

## modules
- read https://www.typescriptlang.org/docs/handbook/modules/introduction.html


## Express
- can use `ts-node-dev` to auto-reload servers
  - `npm install --save-dev ts-node-dev`