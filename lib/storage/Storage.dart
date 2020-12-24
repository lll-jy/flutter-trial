import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:async';

class Storage {
  static final String fileName = '/words.txt';
  static String data = '';

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    File file = File(path + fileName);
    try {
      await file.readAsString();
    } catch (e) {
      file.create(recursive: true);
    }
    return file;
  }

  static Future<File> write(String data) async {
    var file = await _localFile;
    return file.writeAsString(data);
  }

  static Future<String> read() async {
    try {
      final file = await _localFile;
      String res = await file.readAsString();
      if (res?.isEmpty ?? true) {
        final jsonPath = 'assets/words.json';
        await rootBundle.loadString(jsonPath).then((result) {
          if (result is String) {
            data = result;
          }
        });
        await write(data);
        res = await file.readAsString();
      }
      return res;
    } catch (e) {
      return e.toString();
    }
  }
}