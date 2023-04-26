import 'package:flutter/material.dart';
import 'package:words_flutter/constants/error_handling.dart';
import 'package:words_flutter/constants/utils.dart';
import 'package:words_flutter/constants/global_variables.dart';
import 'package:words_flutter/models/word.dart';
import 'package:http/http.dart' as http;

class CreateService {
  void addWord({required BuildContext context, required String word}) async {
    try {
      Word newWord =
          Word(id: 'id', word: word, percentCorrect: 0.0, isLearning: true);

      http.Response res = await http.post(Uri.parse('$uri/api/addWord'),
          body: newWord.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, '$newWord.word added!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
