require('dotenv').config();

// Express App Setup
const express = require('express');
const bodyParser = require('body-parser');
const routes = require('./routes/routes');
const app = express();
const { connectDB } = require('./config/db');

// Connect Database
if (process.env.NODE_ENV !== 'test') {
  connectDB();
}

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

routes(app);

app.use((err, req, res, next) => {
  res.status(422).send({ error: err.message });
});

module.exports = app;