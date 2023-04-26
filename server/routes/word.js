const express = require('express');
const bcryptjs = require('bcryptjs');
const Word = require('../models/word');
const jwt = require('jsonwebtoken');

const wordRouter = express.Router();

wordRouter.post('/api/addWord', async (req, res) => {
  try {
    const { word } = req.body;

    const existingWord = await Word.findOne({ word });

    if (existingWord) {
      return res.status(400).json({ msg: 'Word already exists' });
    }

    let newWord = new Word({
      word,
    });

    newWord = await newWord.save();

    res.json(newWord);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

wordRouter.get('/api/words', async (req, res) => {
  try {
    const words = await Word.find();
    console.log(words);
    res.json(words);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = wordRouter;
