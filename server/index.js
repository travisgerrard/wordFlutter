const express = require('express');
const mongoose = require('mongoose');
var cors = require('cors');

const wordRouter = require('./routes/word');

const PORT = 3000;
const app = express();
const DB =
  'mongodb+srv://travisgerrard:djDS4uOM2JT74ViK@cluster0.cdwmezo.mongodb.net/test';

// Middlewere
app.use(cors());

app.use(express.json());
app.use(wordRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log('Connection Successful');
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, '0.0.0.0', () => {
  console.log(`connected at port ${PORT}`);
});
