import 'package:flutter/material.dart';

import 'components/WordList.dart';
import 'components/ToolkitDrawer.dart';
import 'storage/Storage.dart';
import 'model/Word.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resBody = '';
  void fetchWords() {
    Storage.read().then((value) => setState(() {
      resBody = value;
    }));
  }
  List<Word> allWords() => parseWords((() {fetchWords(); return resBody;})());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WordList(words: allWords()),
      drawer: toolkitDrawer(context, allWords()),
    );
  }
}
