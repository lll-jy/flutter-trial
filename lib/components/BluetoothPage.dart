import 'package:flutter/cupertino%202.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'EditWordPage.dart';

class BluetoothPage extends StatefulWidget {
  final List<BluetoothDevice> devices;

  BluetoothPage({Key key, @required context, @required this.devices}) : super(key: key);

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
        child: bluetoothListView(widget.devices)
      ),
    );
  }
}

void openBluetoothPage(BuildContext context, List<BluetoothDevice> devices) {
  Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return BluetoothPage(context: context, devices: devices,);
      }
  ));
}

ListView bluetoothListView(List<BluetoothDevice> devices) {
  List<Container> containers = [];
  for (BluetoothDevice device in devices) {
    containers.add(Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text(device.name == '' ? '(unknown device)' : device.name),
                Text(device.id.toString())
              ],
            )
          ),
          FlatButton(
            onPressed: () {}, 
            child: Text(
              'Connect',
            )
          )
        ],
      )
    ));
  }
  return ListView(
    padding: EdgeInsets.all(8),
    children: containers,
  );
}
