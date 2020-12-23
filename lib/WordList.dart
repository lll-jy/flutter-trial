import 'package:flutter/material.dart';

class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  static const int num = 10;
  List<String> words = ['Apple', 'Banana', 'Cat', 'Dog', 'Eat', 'Frank',
    'Grape', 'Hello', 'I', 'Jacket'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Words'))
            ],
            rows: List<DataRow>.generate(
                num,
                    (index) => DataRow(
                    cells: [DataCell(Text(words[index]))],
                    selected: false,
                    onSelectChanged: (bool value) {

                    }
                ))
        )
    );
  }
}