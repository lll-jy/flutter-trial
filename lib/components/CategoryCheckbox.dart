import 'package:flutter/material.dart';

// Adapted from https://api.flutter.dev/flutter/material/CheckboxListTile-class.html
class CategoryCheckbox extends StatelessWidget {
  const CategoryCheckbox({this.label, this.value, this.onChanged});

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
                value: value,
                onChanged: (val) {
                  onChanged(val);
                }
            )
          ],
        ),
      ),
    );
  }
}