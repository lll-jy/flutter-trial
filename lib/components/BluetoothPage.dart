import 'package:flutter/cupertino%202.dart';
import 'package:flutter/material.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'EditWordPage.dart';

class BluetoothPage extends StatefulWidget {

  BluetoothPage({Key key, @required context}) : super(key: key);

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth devices'),
      ),
      body: Center(
        child: Text('test')
      ),
    );
  }
}

void openBluetoothPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return BluetoothPage(context: context);
      }
  ));
}
