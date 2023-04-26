const mongoose = require('mongoose');

const wordSchema = new mongoose.Schema({
  word: {
    type: String,
    required: true,
  },
  percentCorrect: {
    type: Number,
    required: true,
    default: 0,
  },
  isLearning: {
    type: Boolean,
    required: true,
    default: true,
  },
});

const Word = mongoose.model('Word', wordSchema);
module.exports = Word;
