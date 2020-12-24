import 'package:flutter/material.dart';

import '../storage/Storage.dart';
import '../model/Word.dart';
import 'NewWordPage.dart';

class ToolkitDrawer extends StatefulWidget {
  final List<Word> words;

  ToolkitDrawer({Key key, @required this.words}) : super(key: key);

  @override
  _ToolkitDrawerState createState() => _ToolkitDrawerState();
}

class _ToolkitDrawerState extends State<ToolkitDrawer> {
  bool showTodayOnly = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80.0,
              child: DrawerHeader(
                child: Text(
                    '   Toolkit',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )
                ),
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
              ),
            ),
            ListTile(
                title: Text('') // placeholder
            ),
            ListTile(
              title: Text('Refresh with sample data'),
              onTap: () {
                Storage.useSample();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Add new words'),
              onTap: () {
                openNewWordPage(context, widget.words);
              },
            ),
            Row(
              children: <Widget>[
                Text('   Show words assigned today only'),
                Switch(
                  value: showTodayOnly,
                  onChanged: (val) {
                    setState(() {
                      showTodayOnly = val;
                    });
                  },
                )
              ],
            )
          ],
        )
    );
  }
}

toolkitDrawer(context, words) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 80.0,
          child: DrawerHeader(
            child: Text(
                '   Toolkit',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                )
            ),
            decoration: BoxDecoration(
                color: Colors.blue
            ),
            margin: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
          ),
        ),
        ListTile(
          title: Text('') // placeholder
        ),
        ListTile(
          title: Text('Refresh with sample data'),
          onTap: () {
            Storage.useSample();
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Add new words'),
          onTap: () {
            openNewWordPage(context, words);
          },
        ),
      ],
    )
);
