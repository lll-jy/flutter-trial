import 'package:flutter/cupertino%202.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../model/Word.dart';
import '../storage/Storage.dart';
import 'EditWordPage.dart';

class BluetoothPage extends StatefulWidget {
  final List<BluetoothDevice> devices;
  final FlutterBlue flutterBlue;

  BluetoothPage({Key key, @required context, @required this.devices,
    @required this.flutterBlue}) : super(key: key);

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  List<BluetoothDevice> connectedDevices;

  String dummy(BluetoothDevice device) {
    device.discoverServices().then((services) {
      services.forEach((service) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic c in characteristics) {
          c.read().then((value) {
            print('dummy print: $value');
          });
        }
      });
    });
    List<BluetoothService> services;
    return '';
  }

  ListView bluetoothListView() {
    List<Container> containers = [];
    for (BluetoothDevice device in widget.devices) {
      containers.add(Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(device.name == '' ? '(unknown device)' : device.name),
                      Text(device.id.toString()),
                    ],
                  )
              ),
              FlatButton(
                onPressed: () async {
                  connectedDevices = await widget.flutterBlue.connectedDevices;
                  if (connectedDevices.contains(device)) {
                    device.disconnect();
                  } else {
                    device.connect();
                  }
                  Navigator.pop(context);
                  openBluetoothPage(context, widget.devices, widget.flutterBlue);
                  print('print:: ' + connectedDevices.toString());
                },
                child: Text(
                  connectedDevices.contains(device) ? 'Disconnect' : 'Connect'
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

  //void getConnectedDevices() async {
  //  List<BluetoothDevice> temp = await widget.flutterBlue.connectedDevices;
  //  setState(() {
  //    connectedDevices = temp;
  //  });
  //}

  //@override
  void initState() {
    super.initState();
  //  getConnectedDevices();
    widget.flutterBlue.connectedDevices.then((value) => {
      setState(() {
        connectedDevices = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth devices'),
      ),
      body: Center(
        child: bluetoothListView()
      ),
    );
  }
}

void openBluetoothPage(BuildContext context, List<BluetoothDevice> devices,
    FlutterBlue flutterBlue) {
  Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return BluetoothPage(context: context, devices: devices,
          flutterBlue: flutterBlue,);
      }
  ));
}
