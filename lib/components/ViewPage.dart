import 'package:flutter/cupertino%202.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'NewWordPage.dart';

class ViewPage extends StatefulWidget {
  final List<Word> words;
  final Word word;

  ViewPage({Key key, @required context, @required this.words, @required this.word}) : super(key: key);

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  void _deleteThis() {
    List<Word> words = widget.words;
    words.remove(widget.word);
    Storage.update(words);
    Navigator.pop(context, '${widget.word.word} deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.word),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(''), // placeholder
              Text(
                '${widget.word.word}   ${Word.speechToStr(widget.word.speech)}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(''), // placeholder
              Text('${widget.word.glossary}'),
              Text(''), // placeholder
              Text('e.g. ${widget.word.example}'),
              Text(''), // placeholder
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      openEditWordPage(context, widget.words, widget.word);
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