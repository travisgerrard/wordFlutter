import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:words_flutter/common/loader.dart';
import 'package:words_flutter/constants/global_variables.dart';
import 'package:words_flutter/features/create/screens/create_screen.dart';
import 'package:words_flutter/features/home/services/home_services.dart';
import 'package:http/http.dart' as http;
import 'package:words_flutter/features/learn/screens/learn_screen.dart';
import 'package:words_flutter/models/word.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeService homeService = HomeService();

  List<Word>? savedWords;

  @override
  void initState() {
    super.initState();
    fetchAllWords();
  }

  fetchAllWords() async {
    savedWords = await homeService.fetchAllWords(context);
    setState(() {});
  }

  void navigateToAddWord() {
    Navigator.pushNamed(context, ReadTextFieldView.routeName);
  }

  void navigateToLearnWord(word) {
    print(word);
    Navigator.pushNamed(context, LearnWordView.routeName, arguments: word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace:
              Container(decoration: const BoxDecoration(color: Colors.amber)),
          title: Row(children: [
            Container(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: navigateToAddWord,
                  child: const Text("Add word"),
                )),
          ]),
        ),
      ),
      body: savedWords == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: savedWords!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final word = savedWords![index];

                      return Column(
                        children: [
                          // ListTile(
                          //   title: Text(word.word),
                          // ),
                          ElevatedButton(
                              onPressed: () => navigateToLearnWord(word.word),
                              child: Text(word.word))
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
