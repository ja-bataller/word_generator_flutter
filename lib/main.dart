import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Word = WordPair.random();
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Scaffold(
        appBar: AppBar(title: Center(
            child: Text("Word Generator"))),
        body: Center(
            child: Text(Word.asPascalCase)),
      )
    );
  }
}