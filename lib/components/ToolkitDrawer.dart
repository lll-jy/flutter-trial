import 'package:flutter/material.dart';

import '../storage/Storage.dart';
import '../model/Word.dart';
import 'NewWordPage.dart';

class ToolkitDrawer extends StatefulWidget {
  final List<Word> words;
  final Function updateTodayFilter;
  final Function updateCategoryFilter;
  final Category shownCategory;

  ToolkitDrawer({Key key, @required this.words, @required this.updateTodayFilter,
    @required this.updateCategoryFilter, @required this.shownCategory}) : super(key: key);

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
                widget.updateCategoryFilter((e) => true, null);
                Navigator.pop(context);
              },
              selected: widget.shownCategory == null,
            ),
            categoryTile(Category.CET4, widget, context),
            categoryTile(Category.CET8, widget, context),
            categoryTile(Category.GRE, widget, context),
            categoryTile(Category.GMAT, widget, context),
            categoryTile(Category.SAT, widget, context),
            categoryTile(Category.TOEFL, widget, context)
          ],
        )
    );
  }
}

ListTile categoryTile(category, widget, context) => ListTile(
  title: Text(Word.categoryToStr(category)),
  onTap: () {
    widget.updateCategoryFilter(
      (Word e) => e.categories.contains(category), category
    );
    Navigator.pop(context);
  },
  selected: widget.shownCategory == category,
);

