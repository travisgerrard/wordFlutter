import 'package:flutter/material.dart';
import 'package:words_flutter/models/word.dart';

class WordProvider extends ChangeNotifier {
  Word _word = Word(id: '', word: '', percentCorrect: 0.0, isLearning: true);

  Word get word => _word;

  void setWord(String word) {
    _word = Word.fromJson(word);
    notifyListeners();
  }
}
