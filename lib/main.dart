import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_flutter/features/create/services/create_service.dart';
import 'package:words_flutter/features/home/screens/home_screen.dart';
import 'package:words_flutter/features/home/services/home_services.dart';
import 'package:words_flutter/providers/word_provider.dart';
import 'package:words_flutter/router.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => WordProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    homeService.getWords(context: context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read Text',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeScreen(),
    );
  }
}
