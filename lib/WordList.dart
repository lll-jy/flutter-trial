import 'package:flutter/material.dart';

// Adapted from https://api.flutter.dev/flutter/material/DataTable-class.html

class WordList extends StatefulWidget {
  WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

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