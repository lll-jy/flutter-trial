import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'components/WordList.dart';
import 'components/ToolkitDrawer.dart';
import 'storage/Storage.dart';
import 'model/Word.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devices = [];

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resBody = '';
  Function todayFilter = (e) => true;
  bool isTodayOnly = false;
  Function categoryFilter = (e) => true;
  Category shownCategory;
  void fetchWords() {
    Storage.read().then((value) => setState(() {
      resBody = value;
    }));
  }
  List<Word> allWords() => parseWords((() {fetchWords(); return resBody;})());
  List<Word> getSelectedWords() {
    Function checker = (e) => todayFilter(e) && categoryFilter(e);
    List<Word> res = [];
    allWords().forEach((element) {
      if (checker(element) == true) {
        res.add(element);
      }
    });
    return res;
  }
  _updateTodayFilter(Function checker, bool isTodayOnly) {
    setState(() {
      todayFilter = checker;
      this.isTodayOnly = isTodayOnly;
    });
  }
  _updateCategoryFilter(Function checker, Category category) {
    setState(() {
      categoryFilter = checker;
      shownCategory = category;
    });
  }
  _addDeviceToList(final BluetoothDevice device) {
    if (!widget.devices.contains(device)) {
      setState(() {
        widget.devices.add(device);
      });
    }
  }

  // Adapted from https://blog.kuzzle.io/communicate-through-ble-using-flutter
  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream().listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceToList(device);
      }
    });
    widget.flutterBlue.startScan(timeout: Duration(seconds: 4));
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceToList(result.device);
      }
    });
    widget.flutterBlue.stopScan();
    print('here:::');
    print(widget.devices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WordList(words: allWords(), selectedWords: getSelectedWords(),),
      drawer: ToolkitDrawer(
        words: allWords(),
        updateTodayFilter: _updateTodayFilter,
        isTodayOnly: isTodayOnly,
        updateCategoryFilter: _updateCategoryFilter,
        shownCategory: shownCategory,
        devices: widget.devices
      ),
    );
  }
}
