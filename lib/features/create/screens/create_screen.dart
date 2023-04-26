import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:words_flutter/features/create/services/create_service.dart';

class ReadTextFieldView extends StatefulWidget {
  static const String routeName = '/create-screen';

  const ReadTextFieldView({super.key});

  @override
  _ReadTextFieldViewState createState() => _ReadTextFieldViewState();
}

class _ReadTextFieldViewState extends State<ReadTextFieldView> {
  final TextEditingController _textEditingController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  final CreateService createService = CreateService();

  Future<void> _speak() async {
    await flutterTts.speak(_textEditingController.text);
  }

  void saveWord() async {
    createService.addWord(context: context, word: _textEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Text Field'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _speak,
              child: Text('Read Text'),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter text to read',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: saveWord,
              child: Text('Save Word'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}

class SaveTextFieldView extends StatefulWidget {
  @override
  _SaveTextFieldViewState createState() => _SaveTextFieldViewState();
}

class _SaveTextFieldViewState extends State<SaveTextFieldView> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<String> _savedWords = [];

  void _saveWord() {
    setState(() {
      _savedWords.add(_textEditingController.text);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Text Field'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter text to save',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveWord,
            child: Text('Save Word'),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: _savedWords.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_savedWords[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
