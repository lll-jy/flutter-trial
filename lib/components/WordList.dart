import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'ViewPage.dart';

class WordList extends StatefulWidget {
  final List<Word> words;
  final List<Word> selectedWords;

  WordList({Key key, @required this.words, @required this.selectedWords}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

// Adapted from https://api.flutter.dev/flutter/material/DataTable-class.html
class _WordListState extends State<WordList> {
  List<bool> selected = List<bool>.generate(1, (index) => false);

  bool checkSelected(int index) {
    if (index >= selected.length) {
      selected.add(false);
      return false;
    } else {
      return selected[index];
    }
  }

  void _doneSelected() {
    int i;
    List<Word> res = [];
    res.addAll(widget.words);
    for (i = 0; i < res.length; i++) {
      if (selected[i] == true) {
        res[i].review();
      }
    }
    Storage.update(res);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                    width: double.infinity,
                    child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Words')),
                          DataColumn(label: Text(''))
                        ],
                        rows: List<DataRow>.generate(
                          widget.selectedWords.length, (index) => DataRow(
                          color: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected))
                                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
                                return null; // Use default value for other states and odd rows.
                              }),
                          cells: [
                            DataCell(Text(widget.selectedWords[index].word)),
                            DataCell(RaisedButton(
                              onPressed: () {
                                openViewPage(context, widget.words,
                                    widget.selectedWords[index]);
                              },
                              child: Text('View'),
                            ))
                          ],
                          selected: checkSelected(index),
                          onSelectChanged: (bool value) {
                            setState(() {
                              selected[index] = value;
                            });
                            }
                        )
                        )
                    )
                ),
                Text(''), // placeholder
                RaisedButton(
                  onPressed: () {
                    _doneSelected();
                  },
                  child: Text('I\'ve reviewed selected words today'),
                ),
              ]
            )
          ),
        ]
      )
    );
  }
}

void openViewPage(BuildContext context, List<Word> words, Word word) {
  Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return ViewPage(context: context, words: words, word: word,);
      }
  ));
}

// Attempt
// Adapted from https://flutter.dev/docs/cookbook/networking/background-parsing
Future<List<Word>> fetchWords(http.Client client) async {
  final response = await client.get('/words.json');
  return compute(parseWords, response.body);
}

List<Word> parseWords(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Word>((json) => Word.fromJson(json)).toList();
}