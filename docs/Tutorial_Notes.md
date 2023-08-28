# Tutorial Notes

> Source: https://create-react-app.dev/docs/getting-started

---
- `webpack` and `Babel` are preconfigured and hidden from the user
    - `webpack` is a module bundler (optimizes code for production)
    - `Babel` is a transpiler (converts modern JS to older JS for compatibility)
---
- This project was bootstrapped using the following command:
    - `npx create-react-app skb-react-ts --template typescript`
---
- Important files:
    - `public/index.html` - page template
    - `src/index.js` - JavaScript entry point
---
- Core scripts:
    - `npm start`
        - runs the app in development mode on [http://localhost:3000](http://localhost:3000)
    - `npm run build`
        - builds the app for production to the `build` folder
    - `npm test` 
        - launches the test runner in the interactive watch mode
    - `npm run eject` 
        - copies all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them