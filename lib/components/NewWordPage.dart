import 'package:flutter/material.dart';

import '../model/Word.dart';

class NewWordPage extends StatefulWidget {
  final List<Word> words;

  NewWordPage({Key key, @required context, @required this.words}) : super(key: key);

  @override
  _NewWordPageState createState() => _NewWordPageState();
}

class _NewWordPageState extends State<NewWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add new word')
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              widget.words.map((e) => e.word).toString()
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'New word saved!');
                },
                child: Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}
