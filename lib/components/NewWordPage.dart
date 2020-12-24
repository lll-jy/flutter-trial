import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';

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
  Map<Category, bool> categories = {
    Category.CET4: false,
    Category.CET8: false,
    Category.GRE: false,
    Category.GMAT: false,
    Category.SAT: false,
    Category.TOEFL: false
  };

  List<Category> getCategories() {
    List<Category> res = [];
    categories.forEach((key, value) {
      if (value == true) {
        res.add(key);
      }
    });
    return res;
  }

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
              Text(''), // placeholder
              FractionallySizedBox(
                widthFactor: 1,
                alignment: Alignment.topLeft,
                child: Text(
                  'Categories:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
              ),
              CategoryCheckbox(
                label: 'CET4',
                value: categories[Category.CET4],
                onChanged: (v) {
                  setState(() {
                    categories[Category.CET4] = v;
                  });
                },
              ),
              CategoryCheckbox(
                label: 'CET8',
                value: categories[Category.CET8],
                onChanged: (v) {
                  setState(() {
                    categories[Category.CET8] = v;
                  });
                },
              ),
              CategoryCheckbox(
                label: 'GRE',
                value: categories[Category.GRE],
                onChanged: (v) {
                  setState(() {
                    categories[Category.GRE] = v;
                  });
                },
              ),
              CategoryCheckbox(
                label: 'SAT',
                value: categories[Category.SAT],
                onChanged: (v) {
                  setState(() {
                    categories[Category.SAT] = v;
                  });
                },
              ),
              CategoryCheckbox(
                label: 'TOEFL',
                value: categories[Category.TOEFL],
                onChanged: (v) {
                  setState(() {
                    categories[Category.TOEFL] = v;
                  });
                },
              ),
              CategoryCheckbox(
                label: 'GMAT',
                value: categories[Category.GMAT],
                onChanged: (v) {
                  setState(() {
                    categories[Category.GMAT] = v;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  List<Word> words = widget.words;
                  words.add(Word(
                    word: word,
                    speech: speech,
                    glossary: glossary,
                    example: example,
                    createdAt: DateTime.now(),
                    lastReviewAt: DateTime.now(),
                    expectedInterval: 1,
                    categories: getCategories()
                  ));
                  Storage.update(words);
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

// Adapted from https://api.flutter.dev/flutter/material/CheckboxListTile-class.html
class CategoryCheckbox extends StatelessWidget {
  const CategoryCheckbox({this.label, this.value, this.onChanged});

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
                onChanged: (val) {
                  onChanged(val);
                }
            )
          ],
        ),
      ),
    );
  }
}