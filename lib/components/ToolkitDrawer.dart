import 'package:flutter/material.dart';

import '../storage/Storage.dart';
import '../model/Word.dart';
import 'NewWordPage.dart';

class ToolkitDrawer extends StatefulWidget {
  final List<Word> words;
  final Function updateTodayFilter;
  final Function updateCategoryFilter;

  ToolkitDrawer({Key key, @required this.words, @required this.updateTodayFilter,
    @required this.updateCategoryFilter}) : super(key: key);

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
                Text(
                  '    Show words assigned today only',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: showTodayOnly,
                  onChanged: (val) {
                    setState(() {
                      showTodayOnly = val;
                    });
                    if (val) {
                      widget.updateTodayFilter((Word e) => e.isAssignedToday());
                    } else {
                      widget.updateTodayFilter((e) => true);
                    }
                  },
                )
              ],
            ),
            ListTile(
              title: Text('All categories'),
              onTap: () {
                widget.updateCategoryFilter((e) => true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('CET4'),
              onTap: () {
                widget.updateCategoryFilter(
                  (Word e) => e.categories.contains(Category.CET4)
                );
                Navigator.pop(context);
              },
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
