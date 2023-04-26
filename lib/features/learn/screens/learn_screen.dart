import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:flutter/material.dart';

// import 'dart:math';

// import 'package:english_words/english_words.dart';

// String generateRandomWord() {
//   final Random random = Random();
//   return nouns[random.nextInt(nouns.length)].toLowerCase();
// }

class LearnWordView extends StatefulWidget {
  static const String routeName = '/learn-screen';

  final String word;

  LearnWordView({required this.word});

  @override
  _LearnWordViewState createState() => _LearnWordViewState();
}

class _LearnWordViewState extends State<LearnWordView> {
  final TextEditingController _textEditingController = TextEditingController();
  List<bool> _correctLetters = [];
  FlutterTts _flutterTts = FlutterTts();

  int countdown = 5;
  bool isGuessingEnabled = false;
  bool hasGuessed = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _flutterTts.stop();

    _timer.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
        if (countdown == 0) {
          isGuessingEnabled = true;
          _timer.cancel();
        }
      });
    });
  }

  Future _speakWord() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.speak(widget.word);
  }

  void _checkGuess() {
    hasGuessed = true;
    String guess = _textEditingController.text;
    _correctLetters = List.generate(widget.word.length,
        (index) => index < guess.length && guess[index] == widget.word[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    print(args);
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn a Word'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Learn Word',
              style: TextStyle(fontSize: 20.0),
            ),
            Visibility(
              visible: countdown > 0,
              child: Text(
                widget.word,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: !isGuessingEnabled,
              child: Text(
                '$countdown',
                style: TextStyle(fontSize: 48),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _speakWord,
              child: Text('Speak Word'),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: isGuessingEnabled,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  readOnly: hasGuessed,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Write the word to spell',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _checkGuess,
              child: Text('Check Spelling'),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: hasGuessed,
              child: Text(
                'Percentage correct: ${_correctLetters.isEmpty ? "0" : (_correctLetters.where((element) => element).length / _correctLetters.length * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 16.0),
            Visibility(
              visible: hasGuessed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.word.length; i++)
                    Text(
                      widget.word[i],
                      style: TextStyle(
                          fontWeight:
                              _correctLetters.length > i && _correctLetters[i]
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
