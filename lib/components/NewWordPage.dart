import 'package:flutter/material.dart';

import '../model/Word.dart';

class NewWordPage extends StatefulWidget {
  final List<Word> words;

  NewWordPage({Key key, @required context, @required this.words}) : super(key: key);

  @override
  _NewWordPageState createState() => _NewWordPageState();
}

class _NewWordPageState extends State<NewWordPage> {
  String word;
  Speech speech = Speech.n;
  String glossary;
  String example;
  DateTime createdAt;
  DateTime lastReviewAt;
  List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Add new word')
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: <Widget>[
              Text(''), // Placeholder
              TextField(
                decoration: InputDecoration(
                  labelText: 'Word (original form)'
                ),
                onChanged: (String value) {
                  setState(() {
                    word = value;
                  });
                },
              ),
              FractionallySizedBox(
                widthFactor: 1,
                child: DropdownButton<String>(
                  value: Word.speechToStr(speech),
                  hint: Text('Select a speech of word'),
                  isExpanded: true,
                  onChanged: (String newSpeech) {
                    setState(() {
                      speech = Word.strToSpeech(newSpeech);
                    });
                  },
                  items: <String>['n.', 'v.', 'adj.', 'adv.', 'article', 'pron.',
                    'prep.', 'conj.', 'interj.']
                      .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e)
                  )).toList()
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Glossary'
                ),
                onChanged: (String value) {
                  setState(() {
                    glossary = value;
                  });
                },
                maxLines: 5,
                minLines: 1,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Example'
                ),
                onChanged: (String value) {
                  setState(() {
                    example = value;
                  });
                },
                maxLines: 5,
                minLines: 1,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'New word saved!');
                  },
                  child: Text('Submit')
              )
            ],
          )
        ),
      ),
    );
  }
}
