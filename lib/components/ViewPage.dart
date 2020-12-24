import 'package:flutter/cupertino%202.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'EditWordPage.dart';

class ViewPage extends StatefulWidget {
  final List<Word> words;
  final int index;

  ViewPage({Key key, @required context, @required this.words, @required this.index}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  Word getWord() {
    return widget.words[widget.index];
  }

  List<Word> getWords() {
    return widget.words;
  }

  void _deleteThis() {
    List<Word> words = getWords();
    words.remove(getWord());
    Storage.update(words);
    Navigator.pop(context, '${getWord().word} deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getWord().word),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(''), // placeholder
              Text(
                '${getWord().word}   ${Word.speechToStr(getWord().speech)}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(''), // placeholder
              Text('${getWord().glossary}'),
              Text(''), // placeholder
              Text('e.g. ${getWord().example}'),
              Text(''), // placeholder
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      openEditWordPage(context, getWords(), widget.index);
                    },
                    child: Text('Edit'),
                  ),
                  Text('   '), // placeholder
                  ElevatedButton(
                      onPressed: _deleteThis,
                      child: Text('Delete')
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}