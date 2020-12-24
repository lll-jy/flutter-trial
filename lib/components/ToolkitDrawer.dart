import 'package:flutter/material.dart';

toolkitDrawer(context) => Drawer(
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
          title: Text('Button1'),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    )
);