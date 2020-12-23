import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Adapted from https://api.flutter.dev/flutter/material/DataTable-class.html
class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

// Adapted from https://api.flutter.dev/flutter/material/DataTable-class.html
class _WordListState extends State<WordList> {
  static const int num = 10;
  List<String> words = ['Apple', 'Banana', 'Cat', 'Dog', 'Eat', 'Frank',
    'Grape', 'Hello', 'I', 'Jacket'];
  List<bool> selected = List<bool>.generate(num, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Words'))
            ],
            rows: List<DataRow>.generate(
                num, (index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected))
                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                      if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
                      return null; // Use default value for other states and odd rows.
                    }),
                    cells: [DataCell(Text(words[index]))],
                    selected: selected[index],
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

enum Speech {
  n, v, adj, adv, article, pron, prep, conj, interj
}

enum Category {
  CET4, CET8, GRE, TOEFL, SAT, GMAT
}

Future<List<Word>> fetchWords(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/photos');
}

List<Word> parseWords(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Word>((json) => Word.fromJson(json)).toList();
}

class Word {
  final String word;
  final Speech speech;
  final String glossary;
  final String example;
  final DateTime createdAt;
  final DateTime lastReviewAt;
  //final List<Category> categories;

  Word({this.word, this.speech, this.glossary, this.example,
    this.createdAt, this.lastReviewAt, /*this.categories*/});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'] as String,
      speech: strToSpeech(json['speech'] as String),
      glossary: json['glossary'] as String,
      example: json['example'] as String,
      createdAt: json['createdAt'] as DateTime,
      lastReviewAt: json['lastReviewAt'] as DateTime,
      //categories: json['categories'] as List<Category>
    );
  }

  static Speech strToSpeech(String str) {
    switch (str) {
      case 'n.':
        return Speech.n;
      case 'v.':
        return Speech.v;
      case 'adj.':
        return Speech.adj;
      case 'adv.':
        return Speech.adv;
      case 'article':
        return Speech.article;
      case 'pron.':
        return Speech.pron;
      case 'prep.':
        return Speech.prep;
      case 'conj.':
        return Speech.conj;
      case 'interj.':
        return Speech.interj;
      default:
        throw Exception('Speech string stored in json file is invalid.');
    }
  }
}