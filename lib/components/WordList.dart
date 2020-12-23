import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/Word.dart';

class WordList extends StatefulWidget {
  final List<Word> words;

  WordList({Key key, @required this.words}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Words'))
            ],
            rows: List<DataRow>.generate(
                widget.words.length, (index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected))
                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                      if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
                      return null; // Use default value for other states and odd rows.
                    }),
                    // cells: [DataCell(Text(words[index]))],
                    cells: [DataCell(Text(widget.words[index].word))],
                    selected: checkSelected(index),
                    onSelectChanged: (bool value) {
                      setState(() {
                        selected[index] = value;
                      });
                    }
                ))
        )
    );
  }
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