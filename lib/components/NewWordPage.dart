import 'package:flutter/material.dart';

newWordPage(context) => Scaffold(
  appBar: AppBar(
      title: Text('Add new word')
  ),
  body: Center(
    child: Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, 'Test!!');
            },
            child: Text('test')
        )
      ],
    ),
  ),
);