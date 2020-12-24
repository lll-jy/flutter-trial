import 'package:first_trial/components/WordList.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'CategoryCheckbox.dart';

class EditWordPage extends StatefulWidget {
  final List<Word> words;
  final int index;

  EditWordPage({Key key, @required context, @required this.words, @required this.index}) : super(key: key);

  @override
  _EditWordPageState createState() => _EditWordPageState();
}

class _EditWordPageState extends State<EditWordPage> {
  String word;
  Speech speech = Speech.n;
  String glossary;
  String example;
  Map<Category, bool> categories;

  List<Category> getCategories() {
    List<Category> res = [];
    categories.forEach((key, value) {
      if (value == true) {
        res.add(key);
      }
    });
    return res;
  }

  Map<Category, bool> getCategoryMap(List<Category> categories) {
    Map<Category, bool> res = {
      Category.CET4: false,
      Category.CET8: false,
      Category.GRE: false,
      Category.GMAT: false,
      Category.SAT: false,
      Category.TOEFL: false
    };
    categories.forEach((element) {res[element] = true;});
    return res;
  }

  TextEditingController _wordController;
  TextEditingController _glossaryController;
  TextEditingController _exampleController;

  @override
  void initState() {
    super.initState();
    Word thisWord = widget.words[widget.index];
    word = thisWord.word;
    speech = thisWord.speech;
    glossary = thisWord.glossary;
    example = thisWord.example;
    categories = getCategoryMap(thisWord.categories);
    _wordController = new TextEditingController(
      text: widget.words[widget.index].word
    );
    _glossaryController = new TextEditingController(
      text: widget.words[widget.index].glossary
    );
    _exampleController = new TextEditingController(
      text: widget.words[widget.index].example
    );
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
                controller: _wordController,
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
                    child: Text(e),
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
                controller: _glossaryController,
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
                controller: _exampleController,
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
                  widget.words[widget.index].reset(word, speech,
                      glossary, example, getCategories());
                  Storage.update(words);
                  Navigator.pop(context, 'Updated!');
                  Navigator.pop(context, '');
                  openViewPage(context, words, widget.index);
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

void openEditWordPage(BuildContext context, List<Word> words, int index) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return EditWordPage(context: context, words: words, index: index,);
    }
  ));
}
