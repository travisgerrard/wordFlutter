import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:words_flutter/constants/error_handling.dart';
import 'package:words_flutter/constants/global_variables.dart';
import 'package:words_flutter/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:words_flutter/models/word.dart';

class HomeService {
  void getWords({required BuildContext context}) async {
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/words'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Word>> fetchAllWords(BuildContext context) async {
    List<Word> wordList = [];

    try {
      http.Response res = await http.get(Uri.parse('$uri/api/words'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              wordList.add(Word.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
    return wordList;
  }
}
