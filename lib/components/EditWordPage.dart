import 'package:first_trial/components/WordList.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'CategoryCheckbox.dart';

class EditWordPage extends StatefulWidget {
  final List<Word> words;
  final Word word;

  EditWordPage({Key key, @required context, @required this.words,
    @required this.word}) : super(key: key);

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

  int getIndex() {
    int res = 0;
    while (res < widget.words.length) {
      if (widget.words[res].isSameWord(widget.word)) {
        return res;
      }
      res++;
    }
    return -1;
  }

  TextEditingController _wordController;
  TextEditingController _glossaryController;
  TextEditingController _exampleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Word thisWord = widget.word;
    word = thisWord.word;
    speech = thisWord.speech;
    glossary = thisWord.glossary;
    example = thisWord.example;
    categories = getCategoryMap(thisWord.categories);
    _wordController = new TextEditingController(
      text: word
    );
    _glossaryController = new TextEditingController(
      text: glossary
    );
    _exampleController = new TextEditingController(
      text: example
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(''), // Placeholder
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Word (original form)'
                  ),
                  onChanged: (String value) {
                    setState(() {
                      word = value;
                    });
                  },
                  controller: _wordController,
                  validator: (value) {
                    for (Word w in widget.words) {
                      if (w.word == value) {
                        return 'This word already exists in the list.';
                      }
                    }
                    return null;
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
                    if (_formKey.currentState.validate()) {
                      List<Word> words = widget.words;
                      int index = getIndex();
                      if (index < 0) {
                        throw Exception('index $index is invalid');
                      }
                      words[index].reset(word, speech, glossary,
                          example, getCategories());
                      Storage.update(words);
                      Navigator.pop(context, 'Updated!');
                      Navigator.pop(context, '');
                      openViewPage(context, words, words[index]);
                    }
                  },
                  child: Text('Submit')
                )
              ],
            )
          )
        ),
      ),
    );
  }
}

void openEditWordPage(BuildContext context, List<Word> words, Word word) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return EditWordPage(context: context, words: words, word: word);
    }
  ));
}
