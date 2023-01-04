const repl = require("repl");

// Pre-assign variables
const context = repl.start("> ").context;
context.myVar = "Hello, World!";
context.anotherVar = 42;

console.log("REPL started with predefined variables");
