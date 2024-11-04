#!/bin/bash

source ~/.termux-dev/env/env.sh
source ~/.termux-dev/env/config.sh

npm init --yes
mkdir src

nameProject=$(awk "NR == 2" package.json | cut -d '"' -f 4)

echo '{
  "name": "backend",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "type": "module",
  "scripts": {
    "dev": "node --env-file .env --watch src/index.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}' > package.json

sed -i "s!backend!${nameProject}!g" package.json

#npm install -D nodemon dotenv
npm install express mongoose cors morgan bcryptjs jsonwebtoken cookie-parser

echo 'import app from "./app.js";

app.listen(3000);

console.log("http://localhost:" + 3000);' > src/index.js

echo 'import express from "express";
import morgan from "morgan";

const app = express();

app.use(morgan("dev"));

export default app;' > src/app.js
echo 'PORT=3000' > .env
